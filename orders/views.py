from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from decimal import Decimal
from orders.models import Order
from builds.models import PCBuild, PCBuildItem


# Render an invoice/receipt page for an order. The template includes a
# client-side "Download Invoice" button (html2pdf) so users can download PDF.
def invoice_view(request, order_id):
    # Ensure user is signed in via session; if not, redirect to signin
    user_id = request.session.get("user_id")
    if not user_id:
        return redirect("accounts:signin")

    # Fetch the order and ensure it belongs to the signed-in user
    order = get_object_or_404(Order, order_id=order_id, user__user_id=user_id)

    # Build invoice-friendly data expected by templates/Home/receipt.html
    items = []
    subtotal = Decimal('0.00')
    for it in order.items.select_related('variant__product').all():
        name = it.variant.product.product_name if it.variant and it.variant.product else 'Item'
        price = it.unit_price
        qty = it.quantity
        total = price * qty
        subtotal += total
        items.append({
            'name': name,
            'qty': qty,
            'price': price,
            'total': total,
        })

    tax = round(subtotal * Decimal('0.18'), 2)
    grand_total = subtotal + tax

    ctx = {
        'order': {
            'id': order.order_id,
            'customer_name': f"{order.user.first_name or ''} {order.user.last_name or ''}".strip(),
            'customer_email': order.user.email or '',
            'date': order.created_at.strftime('%b %d, %Y'),
            'items': items,
            'subtotal': subtotal,
            'tax': tax,
            'grand_total': grand_total,
        }
    }

    return render(request, 'Home/receipt.html', ctx)
