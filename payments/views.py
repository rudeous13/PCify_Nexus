from decimal import Decimal, ROUND_HALF_UP
import json

from django.conf import settings
from django.db import transaction
from django.http import JsonResponse
from django.shortcuts import render, redirect
from django.urls import reverse
from django.utils import timezone
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_POST

from accounts.models import User
from locations.models import Address
from orders.models import Cart, Invoice, Order, OrderItem, Payment, CartItem
from products.models import ProductVariant

from .models import CashfreeOrder
from .utils import create_cashfree_order, fetch_cashfree_order, verify_cashfree_signature

TAX_RATE = Decimal("0.18")


def _get_user_from_session(request):
    user_id = request.session.get("user_id")
    if not user_id:
        return None
    try:
        return User.objects.get(user_id=user_id)
    except User.DoesNotExist:
        return None


def _calculate_cart_totals(cart):
    items = cart.items.select_related("variant", "variant__product").all()
    subtotal = sum(
        (item.variant.price * item.quantity for item in items), Decimal("0.00"))
    tax = (subtotal * TAX_RATE).quantize(Decimal("0.01"), rounding=ROUND_HALF_UP)
    total = subtotal + tax
    return items, subtotal, tax, total


def _normalize_cashfree_status(status):
    normalized = (status or "created").strip().lower()
    if normalized in {"paid", "success", "successful", "completed"}:
        return "paid"
    if normalized in {"failed", "failure"}:
        return "failed"
    if normalized in {"cancelled", "canceled", "expired", "terminated"}:
        return "cancelled"
    if normalized in {"active", "processing", "pending"}:
        return "active"
    return "created"


def _infer_payment_method(payload):
    serialized_payload = json.dumps(payload).lower()
    if "upi" in serialized_payload:
        return "upi"
    if "cod" in serialized_payload:
        return "cod"
    return "card"


def _get_address_for_user(user, address_id):
    if not address_id:
        return (
            user.addresses.select_related("pincode")
            .order_by("-is_primary", "address_id")
            .first()
        )

    try:
        return user.addresses.select_related("pincode").get(address_id=address_id)
    except (Address.DoesNotExist, ValueError, TypeError):
        return None


def _create_order_records(user, cart, address, total, items):
    with transaction.atomic():
        order = Order.objects.create(
            user=user,
            cart=cart,
            address=address,
            total_amount=total,
            shipping_method="standard",
            status="pending",
        )
        OrderItem.objects.bulk_create(
            [
                OrderItem(
                    order=order,
                    variant=item.variant,
                    quantity=item.quantity,
                    unit_price=item.variant.price,
                )
                for item in items
            ]
        )
        invoice = Invoice.objects.create(
            order=order,
            total_amount=total,
            paid_amount=Decimal("0.00"),
            status="unpaid",
            issued_at=timezone.now(),
        )
    return order, invoice


def _sync_cashfree_order(cashfree_order, status, payload, payment_id=None):
    normalized_status = _normalize_cashfree_status(status)

    with transaction.atomic():
        cashfree_order.status = normalized_status
        cashfree_order.cf_payment_id = payment_id or cashfree_order.cf_payment_id
        cashfree_order.raw_response = payload
        cashfree_order.save(
            update_fields=["status", "cf_payment_id", "raw_response", "updated_at"])

        if cashfree_order.order_id:
            if normalized_status == "paid":
                cashfree_order.order.status = "completed"
            elif normalized_status == "cancelled":
                cashfree_order.order.status = "cancelled"
            else:
                cashfree_order.order.status = "pending"
            cashfree_order.order.save(update_fields=["status"])

        if cashfree_order.invoice_id:
            if normalized_status == "paid":
                cashfree_order.invoice.status = "paid"
                cashfree_order.invoice.paid_amount = cashfree_order.amount
            else:
                cashfree_order.invoice.status = "unpaid"
                cashfree_order.invoice.paid_amount = Decimal("0.00")
            cashfree_order.invoice.save(
                update_fields=["status", "paid_amount"])

        if cashfree_order.invoice_id and cashfree_order.order_id and normalized_status == "paid":
            Payment.objects.update_or_create(
                invoice=cashfree_order.invoice,
                gateway_order_id=cashfree_order.cf_order_id,
                defaults={
                    "amount": cashfree_order.amount,
                    "reference_type": "order",
                    "reference_id": cashfree_order.order.order_id,
                    "payment_method": _infer_payment_method(payload),
                    "gateway": "cashfree",
                    "gateway_payment_id": payment_id or cashfree_order.cf_payment_id,
                    "raw_response": payload,
                    "payment_status": "completed",
                    "paid_at": timezone.now(),
                },
            )


def checkout(request):
    user = _get_user_from_session(request)
    if not user:
        return redirect("accounts:signin")

    try:
        cart = Cart.objects.get(user=user)
    except Cart.DoesNotExist:
        cart = None

    cart_items = []
    subtotal = Decimal("0.00")
    tax = Decimal("0.00")
    total = Decimal("0.00")
    addresses = list(
        user.addresses.select_related("pincode").order_by(
            "-is_primary", "address_id")
    )

    if cart:
        items, subtotal, tax, total = _calculate_cart_totals(cart)
        for item in items:
            cart_items.append(
                {
                    "name": item.variant.product.product_name,
                    "quantity": item.quantity,
                    "price": item.variant.price,
                    "total": item.variant.price * item.quantity,
                }
            )

    context = {
        "cart_items": cart_items,
        "subtotal": subtotal,
        "tax": tax,
        "total": total,
        "addresses": addresses,
        "selected_address_id": addresses[0].address_id if addresses else None,
        "cashfree_mode": "production"
        if (settings.CASHFREE_ENV or "sandbox").lower() == "production"
        else "sandbox",
    }
    return render(request, "Home/checkout.html", context)


@require_POST
def create_order(request):
    user = _get_user_from_session(request)
    if not user:
        return JsonResponse({"error": "Login required."}, status=401)

    if not settings.CASHFREE_CLIENT_ID or not settings.CASHFREE_CLIENT_SECRET:
        return JsonResponse({"error": "Cashfree credentials are missing."}, status=500)

    if not user.phone_number:
        return JsonResponse({"error": "Please add a phone number to your profile."}, status=400)

    # Allow client to send a cart snapshot to avoid desync between localStorage and DB.
    cart_json = request.POST.get("cart_json")

    # Load server cart if present
    try:
        cart = Cart.objects.get(user=user)
    except Cart.DoesNotExist:
        cart = None

    address = _get_address_for_user(user, request.POST.get("address_id"))
    if not address:
        return JsonResponse({"error": "Please select a delivery address."}, status=400)

    # If the client provided a cart snapshot, prefer it and sync the DB cart.
    if cart_json:
        try:
            client_cart = json.loads(cart_json)
        except Exception:
            return JsonResponse({"error": "Invalid cart data."}, status=400)

        items = []
        subtotal = Decimal("0.00")

        for entry in client_cart:
            variant_id = entry.get("variant_id")
            qty = int(entry.get("quantity", 1) or 1)
            if not variant_id:
                continue
            variant = ProductVariant.objects.filter(
                variant_id=variant_id).first()
            if not variant:
                continue
            # Create a small item-like object to pass to order creation
            items.append(type("_", (), {"variant": variant, "quantity": qty}))
            subtotal += variant.price * qty

        tax = (subtotal * TAX_RATE).quantize(Decimal("0.01"),
                                             rounding=ROUND_HALF_UP)
        total = subtotal + tax

        # Sync DB cart to match client snapshot (wipe & recreate)
        if cart:
            cart.items.all().delete()
            for entry in client_cart:
                variant_id = entry.get("variant_id")
                qty = int(entry.get("quantity", 1) or 1)
                variant = ProductVariant.objects.filter(
                    variant_id=variant_id).first()
                if variant:
                    CartItem.objects.create(
                        cart=cart, variant=variant, quantity=qty)
        else:
            cart = Cart.objects.create(user=user)
            for entry in client_cart:
                variant_id = entry.get("variant_id")
                qty = int(entry.get("quantity", 1) or 1)
                variant = ProductVariant.objects.filter(
                    variant_id=variant_id).first()
                if variant:
                    CartItem.objects.create(
                        cart=cart, variant=variant, quantity=qty)

        if total <= 0:
            return JsonResponse({"error": "Your cart total is invalid."}, status=400)
    else:
        if not cart:
            return JsonResponse({"error": "Your cart is empty."}, status=400)
        items, subtotal, tax, total = _calculate_cart_totals(cart)
        if total <= 0:
            return JsonResponse({"error": "Your cart total is invalid."}, status=400)

    order, invoice = _create_order_records(user, cart, address, total, items)

    return_url = request.build_absolute_uri(reverse("payments:payment_return"))
    notify_url = request.build_absolute_uri(
        reverse("payments:payment_webhook"))

    customer_details = {
        "customer_id": str(user.user_id),
        "customer_phone": str(user.phone_number),
        "customer_email": user.email,
    }

    order_meta = {
        "return_url": return_url,
        "notify_url": notify_url,
    }

    try:
        order_data = create_cashfree_order(
            amount=float(total),
            currency="INR",
            customer_details=customer_details,
            order_meta=order_meta,
        )
    except Exception:
        order.delete()
        return JsonResponse({"error": "Cashfree order creation failed."}, status=502)

    if not order_data or not order_data.get("order_id"):
        order.delete()
        return JsonResponse({"error": "Cashfree did not return an order."}, status=502)

    cashfree_order = CashfreeOrder.objects.create(
        cf_order_id=order_data.get("order_id"),
        payment_session_id=order_data.get("payment_session_id"),
        user=user,
        cart=cart,
        order=order,
        invoice=invoice,
        amount=total,
        currency=order_data.get("order_currency", "INR"),
        status=_normalize_cashfree_status(
            order_data.get("order_status", "created")),
        customer_details=customer_details,
        order_meta=order_meta,
        raw_response=order_data,
    )

    return JsonResponse(
        {
            "order_id": cashfree_order.cf_order_id,
            "business_order_id": order.order_id,
            "invoice_id": invoice.invoice_id,
            "payment_session_id": cashfree_order.payment_session_id,
            "amount": str(cashfree_order.amount),
        }
    )


def payment_return(request):
    cf_order_id = (
        request.GET.get("order_id")
        or request.GET.get("cf_order_id")
        or request.GET.get("orderId")
    )

    status = "unknown"
    if cf_order_id:
        try:
            order_data = fetch_cashfree_order(cf_order_id)
            status = _normalize_cashfree_status(
                order_data.get("order_status", status))
            cashfree_order = CashfreeOrder.objects.select_related("order", "invoice").filter(
                cf_order_id=cf_order_id
            ).first()
            if cashfree_order:
                _sync_cashfree_order(
                    cashfree_order,
                    status=status,
                    payload=order_data,
                    payment_id=order_data.get(
                        "cf_payment_id") or order_data.get("payment_id"),
                )
        except Exception:
            status = "unknown"

    context = {
        "order_id": cf_order_id,
        "status": status,
    }
    return render(request, "Home/payment_status.html", context)


@csrf_exempt
@require_POST
def payment_webhook(request):
    signature = request.headers.get("x-webhook-signature")
    secret = settings.CASHFREE_WEBHOOK_SECRET
    if secret:
        if not verify_cashfree_signature(request.body, signature, secret):
            return JsonResponse({"error": "Invalid signature."}, status=400)

    payload = None
    if request.body:
        try:
            payload = json.loads(request.body.decode("utf-8"))
        except json.JSONDecodeError:
            payload = None

    if payload is None:
        payload = request.POST.dict() if request.POST else None

    if not payload:
        return JsonResponse({"status": "ignored"})

    data = payload.get("data", {}) if isinstance(payload, dict) else {}
    order_data = data.get("order", {}) if isinstance(data, dict) else {}
    payment_data = data.get("payment", {}) if isinstance(data, dict) else {}

    cf_order_id = (
        payload.get("order_id")
        or data.get("order_id")
        or order_data.get("order_id")
    )
    order_status = (
        payload.get("order_status")
        or data.get("order_status")
        or order_data.get("order_status")
    )
    payment_id = (
        payload.get("payment_id")
        or data.get("payment_id")
        or payment_data.get("cf_payment_id")
        or payment_data.get("payment_id")
    )

    if cf_order_id and order_status:
        cashfree_order = CashfreeOrder.objects.select_related("order", "invoice").filter(
            cf_order_id=cf_order_id
        ).first()
        if cashfree_order:
            _sync_cashfree_order(
                cashfree_order,
                status=order_status,
                payload=payload if isinstance(payload, dict) else {},
                payment_id=payment_id,
            )

    return JsonResponse({"status": "ok"})
