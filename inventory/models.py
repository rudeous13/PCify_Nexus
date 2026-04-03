from django.db import models


class Supplier(models.Model):
    supplier_id = models.AutoField(primary_key=True)
    supplier_name = models.CharField(max_length=50)
    company_name = models.CharField(max_length=100)
    email = models.EmailField(max_length=100, unique=True)
    phone = models.CharField(max_length=15)
    gst_no = models.CharField(
        max_length=15, unique=True, null=True, blank=True)
    address_one = models.CharField(max_length=300)
    address_two = models.CharField(max_length=300, blank=True, null=True)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.company_name


class Inventory(models.Model):
    variant = models.OneToOneField(
        'products.ProductVariant',
        on_delete=models.CASCADE,
        primary_key=True,
        related_name='inventory'
    )
    stock_quantity = models.PositiveIntegerField(default=0)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name_plural = 'Inventories'

    def __str__(self):
        return f"{self.variant.sku} — stock: {self.stock_quantity}"


class InventoryLog(models.Model):
    ACTIONS = [('add', 'Add'), ('remove', 'Remove')]
    REFERENCE_TYPES = [
        ('order', 'Order'),
        ('purchase_order', 'Purchase Order'),
        ('adjustment', 'Adjustment'),
        ('return', 'Return'),
        ('service', 'Service'),
    ]

    inventory_log_id = models.AutoField(primary_key=True)
    variant = models.ForeignKey(
        'products.ProductVariant',
        on_delete=models.CASCADE,
        related_name='inventory_logs'
    )
    quantity_change = models.IntegerField()
    action = models.CharField(max_length=10, choices=ACTIONS)
    reference_type = models.CharField(max_length=20, choices=REFERENCE_TYPES)
    reference_id = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.action} {self.quantity_change} × {self.variant.sku}"


class PurchaseOrder(models.Model):
    STATUSES = [
        ('pending', 'Pending'),
        ('received', 'Received'),
        ('cancelled', 'Cancelled'),
    ]

    purchase_order_id = models.AutoField(primary_key=True)
    supplier = models.ForeignKey(
        Supplier,
        on_delete=models.RESTRICT,
        related_name='purchase_orders'
    )
    status = models.CharField(
        max_length=15, choices=STATUSES, default='pending')
    order_date = models.DateTimeField(null=True, blank=True)
    expected_delivery = models.DateTimeField(null=True, blank=True)
    remarks = models.TextField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"PO-{self.purchase_order_id} ({self.supplier})"


class PurchaseOrderItem(models.Model):
    purchase_order_item_id = models.AutoField(primary_key=True)
    purchase_order = models.ForeignKey(
        PurchaseOrder,
        on_delete=models.CASCADE,
        related_name='items'
    )
    variant = models.ForeignKey(
        'products.ProductVariant',
        on_delete=models.RESTRICT,
        related_name='purchase_order_items'
    )
    quantity = models.PositiveIntegerField(default=0)
    unit_cost = models.DecimalField(
        max_digits=10, decimal_places=2, default=0.00)
    received_quantity = models.PositiveIntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = [('purchase_order', 'variant')]

    def __str__(self):
        return f"{self.variant.sku} × {self.quantity} (PO-{self.purchase_order_id})"
