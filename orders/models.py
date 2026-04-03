from django.db import models


class Cart(models.Model):
    cart_id = models.AutoField(primary_key=True)
    user = models.OneToOneField(
        'accounts.User',
        on_delete=models.CASCADE,
        related_name='cart'
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Cart of {self.user}"


class CartItem(models.Model):
    cart_item_id = models.AutoField(primary_key=True)
    cart = models.ForeignKey(
        Cart, on_delete=models.CASCADE, related_name='items')
    variant = models.ForeignKey(
        'products.ProductVariant',
        on_delete=models.CASCADE,
        related_name='cart_items'
    )
    quantity = models.PositiveIntegerField(default=1)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        unique_together = [('cart', 'variant')]

    def __str__(self):
        return f"{self.variant.sku} × {self.quantity}"


class Order(models.Model):
    SHIPPING_METHODS = [
        ('standard', 'Standard'),
        ('express', 'Express'),
        ('pickup', 'Pickup'),
    ]
    STATUSES = [
        ('pending', 'Pending'),
        ('processing', 'Processing'),
        ('shipped', 'Shipped'),
        ('completed', 'Completed'),
        ('cancelled', 'Cancelled'),
    ]

    order_id = models.AutoField(primary_key=True)
    user = models.ForeignKey(
        'accounts.User',
        on_delete=models.RESTRICT,
        related_name='orders'
    )
    cart = models.ForeignKey(
        Cart,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='orders'
    )
    address = models.ForeignKey(
        'locations.Address',
        on_delete=models.RESTRICT,
        related_name='orders'
    )
    total_amount = models.DecimalField(
        max_digits=10, decimal_places=2, default=0.00)
    shipping_method = models.CharField(
        max_length=10, choices=SHIPPING_METHODS, default='standard'
    )
    status = models.CharField(
        max_length=15, choices=STATUSES, default='pending')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Order-{self.order_id} ({self.user})"


class OrderItem(models.Model):
    order_item_id = models.AutoField(primary_key=True)
    order = models.ForeignKey(
        Order, on_delete=models.CASCADE, related_name='items')
    variant = models.ForeignKey(
        'products.ProductVariant',
        on_delete=models.RESTRICT,
        related_name='order_items'
    )
    quantity = models.PositiveIntegerField(default=1)
    unit_price = models.DecimalField(
        max_digits=10, decimal_places=2, default=0.00)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = [('order', 'variant')]

    def __str__(self):
        return f"{self.variant.sku} × {self.quantity} (Order-{self.order_id})"


class Invoice(models.Model):
    STATUSES = [
        ('unpaid', 'Unpaid'),
        ('partial', 'Partial'),
        ('paid', 'Paid'),
    ]

    invoice_id = models.AutoField(primary_key=True)
    order = models.OneToOneField(
        Order, on_delete=models.CASCADE, related_name='invoice')
    total_amount = models.DecimalField(max_digits=10, decimal_places=2)
    paid_amount = models.DecimalField(
        max_digits=10, decimal_places=2, default=0.00)
    status = models.CharField(
        max_length=10, choices=STATUSES, default='unpaid')
    issued_at = models.DateTimeField(null=True, blank=True)
    due_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"Invoice-{self.invoice_id} ({self.status})"


class Payment(models.Model):
    REFERENCE_TYPES = [
        ('order', 'Order'),
        ('purchase_order', 'Purchase Order'),
        ('service', 'Service'),
    ]
    PAYMENT_METHODS = [
        ('card', 'Card'),
        ('upi', 'UPI'),
        ('cod', 'Cash on Delivery'),
    ]
    STATUSES = [
        ('pending', 'Pending'),
        ('authorized', 'Authorized'),
        ('captured', 'Captured'),
        ('completed', 'Completed'),
        ('failed', 'Failed'),
        ('refunded', 'Refunded'),
    ]

    payment_id = models.AutoField(primary_key=True)
    invoice = models.ForeignKey(
        Invoice, on_delete=models.CASCADE, related_name='payments')
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    reference_type = models.CharField(max_length=20, choices=REFERENCE_TYPES)
    reference_id = models.IntegerField()
    payment_method = models.CharField(max_length=10, choices=PAYMENT_METHODS)
    gateway = models.CharField(max_length=50, default='razorpay')
    gateway_payment_id = models.CharField(
        max_length=255, null=True, blank=True)
    gateway_order_id = models.CharField(max_length=255, null=True, blank=True)
    raw_response = models.JSONField(null=True, blank=True)
    payment_status = models.CharField(
        max_length=15, choices=STATUSES, default='pending')
    created_at = models.DateTimeField(auto_now_add=True)
    paid_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"Payment-{self.payment_id} ({self.payment_status})"


class Refund(models.Model):
    STATUSES = [
        ('pending', 'Pending'),
        ('completed', 'Completed'),
        ('failed', 'Failed'),
    ]

    refund_id = models.AutoField(primary_key=True)
    payment = models.ForeignKey(
        Payment, on_delete=models.CASCADE, related_name='refunds')
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    gateway_refund_id = models.CharField(max_length=255, null=True, blank=True)
    status = models.CharField(
        max_length=10, choices=STATUSES, default='pending')
    reason = models.TextField(null=True, blank=True)
    raw_response = models.JSONField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    processed_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"Refund-{self.refund_id} ({self.status})"


class Tax(models.Model):
    tax_id = models.AutoField(primary_key=True)
    tax_name = models.CharField(max_length=100, unique=True)
    tax_rate = models.DecimalField(max_digits=5, decimal_places=2)
    is_active = models.BooleanField(default=True)

    def __str__(self):
        return f"{self.tax_name} ({self.tax_rate}%)"


class OrderItemTax(models.Model):
    order_item_tax_id = models.AutoField(primary_key=True)
    order_item = models.ForeignKey(
        OrderItem, on_delete=models.CASCADE, related_name='taxes'
    )
    tax = models.ForeignKey(Tax, on_delete=models.RESTRICT,
                            related_name='order_item_taxes')
    tax_amount = models.DecimalField(
        max_digits=10, decimal_places=2, default=0.00)

    class Meta:
        unique_together = [('order_item', 'tax')]

    def __str__(self):
        return f"{self.tax.tax_name} on item-{self.order_item_id}"


class ReturnRequest(models.Model):
    STATUSES = [
        ('requested', 'Requested'),
        ('approved', 'Approved'),
        ('rejected', 'Rejected'),
        ('completed', 'Completed'),
    ]

    return_id = models.AutoField(primary_key=True)
    order = models.ForeignKey(
        Order, on_delete=models.CASCADE, related_name='returns')
    user = models.ForeignKey(
        'accounts.User',
        on_delete=models.CASCADE,
        related_name='return_requests'
    )
    status = models.CharField(
        max_length=15, choices=STATUSES, default='requested')
    reason = models.TextField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    approved_at = models.DateTimeField(null=True, blank=True)
    completed_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"Return-{self.return_id} ({self.status})"


class ReturnItem(models.Model):
    return_item_id = models.AutoField(primary_key=True)
    return_request = models.ForeignKey(
        ReturnRequest, on_delete=models.CASCADE, related_name='items'
    )
    order_item = models.ForeignKey(
        OrderItem, on_delete=models.RESTRICT, related_name='return_items'
    )
    quantity = models.PositiveIntegerField(default=1)
    refund_amount = models.DecimalField(
        max_digits=10, decimal_places=2, default=0.00)
    is_restocked = models.BooleanField(default=False)

    class Meta:
        unique_together = [('return_request', 'order_item')]

    def __str__(self):
        return f"ReturnItem-{self.return_item_id}"
