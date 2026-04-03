from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.db.models import Min, Max
from django.shortcuts import get_object_or_404
from django.http import JsonResponse
from decimal import Decimal
import json
from orders.models import *
from products.models import *
from accounts.models import *
from locations.models import Pincode, Address
# Create your views here.

# Default page for when first call


def homepage(request):
    trending_products_qs = Product.objects.filter(
        is_trending=True).prefetch_related('variants__images')
    trending_products = []

    for product in trending_products_qs:
        variant = product.variants.first()

        if variant:
            image_obj = variant.images.filter(
                is_primary=True).first() or variant.images.first()
            trending_products.append({
                'name': product.product_name,
                'short_description': product.description,
                'price': variant.price,
                'image': image_obj.image if image_obj else None,
                'badge': 'Hot',
            })

    context = {
        'trending_products': trending_products
    }

    return render(request, "Home/home.html", context)


def prebuilt(request):
    return render(request, "Home/prebuilt.html")


def built(request):
    return render(request, "Home/pc.html")


def accessories(request):
    # 1. Fetch the base queryset (added 'brand' to prefetch for optimization)
    products_qs = Product.objects.all().prefetch_related(
        'variants__images', 'category', 'brand')

    # 2. Handle Category Filtering
    category_param = request.GET.get('category')
    if category_param:
        if category_param.isdigit():
            products_qs = products_qs.filter(
                category__category_id=category_param)
        else:
            products_qs = products_qs.filter(
                category__category_name__icontains=category_param)

    # 3. Handle Search Query
    search_query = request.GET.get('q', '')
    if search_query:
        products_qs = products_qs.filter(product_name__icontains=search_query)

    # 4. Handle Brand Filtering (Captures multiple checkboxes)
    selected_brands = request.GET.getlist('brand')
    if selected_brands:
        products_qs = products_qs.filter(brand__brand_name__in=selected_brands)

    # 5. Handle Price Range Filtering
    # Find the absolute min and max prices across all accessories to set the slider bounds dynamically
    price_aggregates = ProductVariant.objects.aggregate(
        min_price=Min('price'), max_price=Max('price'))
    absolute_min = int(price_aggregates['min_price'] or 0)
    absolute_max = int(price_aggregates['max_price'] or 50000)

    # Get user's current slider positions (or default to absolute min/max)
    current_min = request.GET.get('min_price', absolute_min)
    current_max = request.GET.get('max_price', absolute_max)

    try:
        current_min = int(current_min)
        current_max = int(current_max)
    except ValueError:
        current_min = absolute_min
        current_max = absolute_max

    # Apply the price filter. We use .distinct() because filtering on a related model (variants) can cause duplicates.
    products_qs = products_qs.filter(
        variants__price__gte=current_min,
        variants__price__lte=current_max
    ).distinct()

   # 6. Map data for the template
    products_list = []
    for product in products_qs:
        variant = product.variants.first()
        if variant:
            # Grab all images for this variant
            all_imgs = variant.images.all()
            primary_image = all_imgs.filter(
                is_primary=True).first() or all_imgs.first()

            # Combine all image URLs into a comma-separated string
            img_urls = [img.image.url for img in all_imgs if img.image]
            all_images_str = ",".join(img_urls) if img_urls else ""

            # In views.py -> def accessories(request):
            products_list.append({
                'id': product.product_id,
                'variant_id': variant.variant_id,  # <-- ADD THIS
                'name': product.product_name,
                'category': product.category,
                'price': variant.price,
                'image': primary_image.image if primary_image else None,
                'all_images_str': all_images_str,
            })

    # 7. Handle Sorting
    sort_param = request.GET.get('sort', 'pop')
    if sort_param == 'low':
        products_list.sort(key=lambda x: x['price'])
    elif sort_param == 'high':
        products_list.sort(key=lambda x: x['price'], reverse=True)

    # Fetch all categories and brands for the sidebar
    categories = Category.objects.all()
    brands = Brand.objects.all()

    cart_count = 0
    user_id = request.session.get("user_id")
    if user_id:
        try:
            user = User.objects.get(user_id=user_id)
            cart_obj = Cart.objects.prefetch_related("items").get(user=user)
            cart_count = sum(item.quantity for item in cart_obj.items.all())
        except (User.DoesNotExist, Cart.DoesNotExist):
            cart_count = 0
    else:
        session_cart = request.session.get("guest_cart", [])
        cart_count = sum(item.get("quantity", 0) for item in session_cart)

    context = {
        'products': products_list,
        'categories': categories,
        'brands': brands,  # New
        'cart_count': cart_count,
        'search_query': search_query,
        'current_sort': sort_param,
        'selected_category': category_param,
        'selected_brands': selected_brands,  # New
        'absolute_min': absolute_min,  # New
        'absolute_max': absolute_max,  # New
        'current_min': current_min,  # New
        'current_max': current_max,  # New
    }

    return render(request, "Home/accessories.html", context)


def cart(request):
    user_id = request.session.get('user_id')
    session_cart = request.session.get("guest_cart", [])

    # 1. HANDLE POST REQUESTS (Modifying the cart)
    if request.method == "POST":
        action = request.POST.get("action")

        try:
            if user_id:
                user = User.objects.get(user_id=user_id)
                cart_obj, _ = Cart.objects.get_or_create(user=user)

                if action == "add":
                    variant_id = request.POST.get("variant_id")
                    quantity = int(request.POST.get("quantity", 1))
                    variant = ProductVariant.objects.get(variant_id=variant_id)

                    cart_item, created = CartItem.objects.get_or_create(
                        cart=cart_obj,
                        variant=variant,
                        defaults={'quantity': quantity}
                    )
                    if not created:
                        cart_item.quantity += quantity
                        cart_item.save()

                elif action == "delete":
                    cart_item_id = request.POST.get("cart_item_id")
                    variant_id = request.POST.get("variant_id")
                    if cart_item_id:
                        CartItem.objects.filter(
                            cart_item_id=cart_item_id, cart=cart_obj).delete()
                    elif variant_id:
                        CartItem.objects.filter(
                            cart=cart_obj, variant_id=variant_id).delete()

                elif action == "update":
                    cart_item_id = request.POST.get("cart_item_id")
                    variant_id = request.POST.get("variant_id")
                    update_type = request.POST.get(
                        "update_type")  # 'increase' or 'decrease'

                    if cart_item_id:
                        cart_item = CartItem.objects.get(
                            cart_item_id=cart_item_id, cart=cart_obj)
                    else:
                        cart_item = CartItem.objects.get(
                            cart=cart_obj, variant_id=variant_id)

                    if update_type == "increase":
                        cart_item.quantity += 1
                        cart_item.save()
                    elif update_type == "decrease":
                        if cart_item.quantity > 1:
                            cart_item.quantity -= 1
                            cart_item.save()
                        else:
                            cart_item.delete()

                elif action == "clear":
                    CartItem.objects.filter(cart=cart_obj).delete()

            else:
                if not action:
                    return JsonResponse({'status': 'error', 'message': 'Invalid action.'})

                if action == "add":
                    variant_id = int(request.POST.get("variant_id", 0))
                    quantity = int(request.POST.get("quantity", 1))
                    ProductVariant.objects.get(variant_id=variant_id)

                    existing = next((item for item in session_cart if item.get(
                        "variant_id") == variant_id), None)
                    if existing:
                        existing["quantity"] += quantity
                    else:
                        session_cart.append(
                            {"variant_id": variant_id, "quantity": quantity})

                elif action == "delete":
                    variant_id = int(request.POST.get("variant_id", 0))
                    session_cart = [item for item in session_cart if item.get(
                        "variant_id") != variant_id]

                elif action == "update":
                    variant_id = int(request.POST.get("variant_id", 0))
                    update_type = request.POST.get("update_type")
                    for item in session_cart:
                        if item.get("variant_id") == variant_id:
                            if update_type == "increase":
                                item["quantity"] += 1
                            elif update_type == "decrease":
                                item["quantity"] -= 1
                            if item["quantity"] < 1:
                                session_cart = [i for i in session_cart if i.get(
                                    "variant_id") != variant_id]
                            break

                elif action == "clear":
                    session_cart = []

                request.session["guest_cart"] = session_cart
                request.session.modified = True

            if request.headers.get('x-requested-with') == 'XMLHttpRequest':
                return JsonResponse({'status': 'success'})

            return redirect('core:cart')

        except Exception as e:
            if request.headers.get('x-requested-with') == 'XMLHttpRequest':
                return JsonResponse({'status': 'error', 'message': str(e)})
            print(f"Cart Error: {e}")
            return redirect('core:cart')

    # 2. HANDLE GET REQUESTS (Displaying the cart)
    cart_items_data = []
    subtotal = Decimal('0.00')
    tax = Decimal('0.00')
    total = Decimal('0.00')
    cart_count = 0

    if user_id:
        try:
            user = User.objects.get(user_id=user_id)
            cart_obj = Cart.objects.prefetch_related(
                'items__variant__product', 'items__variant__images').get(user=user)
            items = cart_obj.items.all()
            cart_count = sum(item.quantity for item in items)

            for item in items:
                variant = item.variant
                product = variant.product
                item_total = variant.price * item.quantity
                subtotal += item_total

                primary_image = variant.images.filter(
                    is_primary=True).first() or variant.images.first()

                cart_items_data.append({
                    'cart_item_id': item.cart_item_id,
                    'variant_id': variant.variant_id,
                    'name': product.product_name,
                    'type': product.category.category_name,
                    'price': str(variant.price),
                    'quantity': item.quantity,
                    'item_total': str(item_total),
                    'image_url': primary_image.image.url if primary_image and primary_image.image else None
                })

            tax = round(subtotal * Decimal('0.18'), 2)
            total = subtotal + tax

        except Cart.DoesNotExist:
            pass
    elif session_cart:
        variant_ids = [item.get("variant_id") for item in session_cart]
        variants = ProductVariant.objects.select_related(
            "product", "product__category"
        ).prefetch_related("images").filter(variant_id__in=variant_ids)
        variants_by_id = {variant.variant_id: variant for variant in variants}

        for item in session_cart:
            variant = variants_by_id.get(item.get("variant_id"))
            if not variant:
                continue

            quantity = int(item.get("quantity", 1))
            product = variant.product
            item_total = variant.price * quantity
            subtotal += item_total

            primary_image = variant.images.filter(
                is_primary=True).first() or variant.images.first()
            cart_items_data.append({
                'cart_item_id': None,
                'variant_id': variant.variant_id,
                'name': product.product_name,
                'type': product.category.category_name,
                'price': str(variant.price),
                'quantity': quantity,
                'item_total': str(item_total),
                'image_url': primary_image.image.url if primary_image and primary_image.image else None
            })

        cart_count = sum(item.get("quantity", 0) for item in session_cart)
        tax = round(subtotal * Decimal('0.18'), 2)
        total = subtotal + tax

    context = {
        'cart_items': cart_items_data,
        'cart_items_json': json.dumps(cart_items_data),
        'subtotal': subtotal,
        'tax': tax,
        'total': total,
        'cart_count': cart_count
    }

    return render(request, "Home/cart.html", context)


def profile(request):
    return render(request, "Home/pro_overview.html")


def pro_builds(request):
    return render(request, "Home/pro_my_builds.html")


def pro_order(request):
    user_id = request.session.get("user_id")
    if not user_id:
        return redirect("accounts:signin")

    try:
        user = User.objects.get(user_id=user_id)
    except User.DoesNotExist:
        return redirect("accounts:signin")

    orders_qs = (
        Order.objects.filter(user=user)
        .prefetch_related("items__variant__product")
        .order_by("-created_at")
    )

    status_map = {
        "pending": "Processing",
        "processing": "Processing",
        "shipped": "Shipped",
        "completed": "Delivered",
        "cancelled": "Cancelled",
    }

    orders = []
    for order in orders_qs:
        items = list(order.items.all())
        first_item = items[0] if items else None
        product = first_item.variant.product if first_item else None

        total_qty = sum(item.quantity for item in items) if items else 0
        orders.append(
            {
                "order_number": order.order_id,
                "status": status_map.get(order.status, order.status),
                "created_at": order.created_at,
                "total_price": order.total_amount,
                "title": product.product_name if product else "Order",
                "description": product.description if product else "",
                "quantity": total_qty,
                "build_status": status_map.get(order.status, "Processing"),
            }
        )

    context = {
        "orders": orders,
    }

    return render(request, "Home/pro_order_history.html", context)


def pro_security(request):
    return render(request, "Home/pro_security.html")


def pro_setting(request):
    # Prepare user and address context for template
    user = None
    user_id = request.session.get("user_id")
    if user_id:
        try:
            user = User.objects.get(user_id=user_id)
        except User.DoesNotExist:
            user = None

    # Helper to build context from existing user/address
    def build_context(user_obj, message=None):
        ctx = {}
        if user_obj:
            ctx["first_name"] = user_obj.first_name or ""
            ctx["last_name"] = user_obj.last_name or ""
            ctx["email"] = user_obj.email or ""
            # try to get primary address
            addr = Address.objects.filter(
                user=user_obj, is_primary=True).first()
            if addr:
                ctx["street_address"] = addr.address or ""
                ctx["area"] = addr.pincode.area_name if addr.pincode else ""
                ctx["pincode"] = str(
                    addr.pincode.pincode) if addr.pincode else ""
            else:
                ctx["street_address"] = ""
                ctx["area"] = ""
                ctx["pincode"] = ""
            # include all addresses for management (primary first)
            ctx["addresses"] = list(Address.objects.filter(
                user=user_obj).order_by('-is_primary').all())
        else:
            # fall back to session values if available
            ctx["first_name"] = request.session.get("user_name", "")
            ctx["last_name"] = request.session.get("user_lname", "")
            ctx["email"] = request.session.get("user_email", "")
            ctx["street_address"] = ""
            ctx["area"] = ""
            ctx["pincode"] = ""
        if message:
            ctx["message"] = message
        return ctx

    # Handle profile settings form submission
    if request.method == "POST":
        # Common user fields
        first_name = request.POST.get("first_name", "").strip()
        last_name = request.POST.get("last_name", "").strip()
        email = request.POST.get("email", "").strip()

        # Update basic user fields
        if user:
            if first_name:
                user.first_name = first_name
            if last_name:
                user.last_name = last_name
            if email:
                user.email = email
            user.save()
            request.session["user_name"] = user.first_name or ""
            request.session["user_lname"] = user.last_name or ""

        # Address management actions
        action = request.POST.get('action')
        if action and user:
            # add or edit address
            if action in ('add_address', 'edit_address'):
                street_address = request.POST.get("street_address", "").strip()
                area = request.POST.get("area", "").strip()
                pincode_val = request.POST.get("pincode", "").strip()
                make_primary = request.POST.get("make_primary") == 'on'

                pincode_obj = None
                if pincode_val:
                    try:
                        pincode_int = int(pincode_val)
                        pincode_obj = Pincode.objects.filter(
                            pincode=pincode_int).first()
                        if not pincode_obj:
                            pincode_obj = Pincode.objects.create(
                                pincode=pincode_int,
                                area_name=area or "",
                                city="Ahmedabad"
                            )
                        else:
                            # If an existing Pincode was found but the user provided
                            # a (possibly updated) area/locality, persist that change
                            # so edits to area take effect even when using an
                            # existing pincode row.
                            if area and area != (pincode_obj.area_name or ""):
                                pincode_obj.area_name = area
                                pincode_obj.save()
                    except ValueError:
                        pincode_obj = None

                if action == 'add_address' and street_address and pincode_obj:
                    if make_primary:
                        Address.objects.filter(
                            user=user).update(is_primary=False)
                    Address.objects.create(
                        user=user,
                        pincode=pincode_obj,
                        address=street_address,
                        is_primary=make_primary or not Address.objects.filter(
                            user=user).exists()
                    )

                if action == 'edit_address':
                    addr_id = request.POST.get('address_id')
                    if addr_id:
                        try:
                            addr_obj = Address.objects.get(
                                address_id=addr_id, user=user)
                            # If pincode wasn't provided, keep existing
                            if not pincode_obj:
                                pincode_obj = addr_obj.pincode

                            if street_address:
                                addr_obj.address = street_address
                            # Update associated pincode and its area when needed.
                            if pincode_obj:
                                addr_obj.pincode = pincode_obj
                            else:
                                # No new pincode provided: if user supplied an
                                # updated area, persist it to the existing pincode
                                # row so the locality reflects the edit.
                                if area and addr_obj.pincode and area != (addr_obj.pincode.area_name or ""):
                                    addr_obj.pincode.area_name = area
                                    addr_obj.pincode.save()
                            if make_primary:
                                Address.objects.filter(
                                    user=user).update(is_primary=False)
                                addr_obj.is_primary = True
                            addr_obj.save()
                        except Address.DoesNotExist:
                            pass

            elif action == 'delete_address':
                addr_id = request.POST.get('address_id')
                if addr_id:
                    try:
                        addr_obj = Address.objects.get(
                            address_id=addr_id, user=user)
                        was_primary = addr_obj.is_primary
                        # Keep a reference to the pincode so we can clean it up
                        # after the address is deleted.
                        pincode_ref = addr_obj.pincode
                        addr_obj.delete()

                        # If the deleted address was primary, promote another address to primary
                        if was_primary:
                            next_addr = Address.objects.filter(
                                user=user).first()
                            if next_addr:
                                next_addr.is_primary = True
                                next_addr.save()

                        # If the pincode row is now orphaned (no addresses reference it),
                        # remove it to avoid stale pincode/area entries.
                        try:
                            if pincode_ref and not Address.objects.filter(pincode=pincode_ref).exists():
                                pincode_ref.delete()
                        except Exception:
                            # Be conservative: ignore delete errors and continue.
                            pass
                    except Address.DoesNotExist:
                        pass

            elif action == 'set_primary':
                addr_id = request.POST.get('address_id')
                if addr_id:
                    Address.objects.filter(user=user).update(is_primary=False)
                    Address.objects.filter(
                        address_id=addr_id, user=user).update(is_primary=True)

        # Return JSON for AJAX or re-render the page with a success message
        from django.http import JsonResponse
        if request.headers.get('x-requested-with') == 'XMLHttpRequest':
            return JsonResponse({'status': 'success'})

        ctx = build_context(user, message="Saved successfully.")
        return render(request, "Home/pro_settings.html", ctx)

    # GET -> render with existing values
    ctx = build_context(user)
    return render(request, "Home/pro_settings.html", ctx)
