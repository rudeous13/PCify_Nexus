from django.contrib import admin
from .models import Cart, CartItem, Order, OrderItem, Invoice, Payment


@admin.register(CartItem)
class CartItemAdmin(admin.ModelAdmin):
    list_display = ['cart_item_id', 'cart', 'variant',
                    'build_source', 'quantity', 'created_at']
    list_filter = ['build_source', 'created_at']
    search_fields = ['variant__sku',
                     'variant__product__product_name', 'build_source__name']
    readonly_fields = ['created_at', 'updated_at']


@admin.register(Cart)
class CartAdmin(admin.ModelAdmin):
    list_display = ['cart_id', 'user', 'created_at', 'updated_at']
    readonly_fields = ['created_at', 'updated_at']


@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ['order_id', 'user', 'total_amount',
                    'status', 'payment_status', 'created_at']
    list_filter = ['status', 'payment_status', 'created_at']
    readonly_fields = ['created_at']


@admin.register(OrderItem)
class OrderItemAdmin(admin.ModelAdmin):
    list_display = ['order_item_id', 'order',
                    'variant', 'build', 'build_source', 'quantity', 'unit_price']
    list_filter = ['build', 'build_source', 'created_at']
    search_fields = ['variant__sku',
                     'variant__product__product_name', 'build__name', 'build_source__name']


@admin.register(Invoice)
class InvoiceAdmin(admin.ModelAdmin):
    list_display = ['invoice_id', 'order',
                    'total_amount', 'status', 'issued_at']
    list_filter = ['status', 'issued_at']
    readonly_fields = ['issued_at']


@admin.register(Payment)
class PaymentAdmin(admin.ModelAdmin):
    list_display = ['payment_id', 'invoice', 'amount',
                    'payment_method', 'payment_status', 'paid_at']
    list_filter = ['payment_method', 'payment_status', 'paid_at']
    readonly_fields = ['paid_at']
