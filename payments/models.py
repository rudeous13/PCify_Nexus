from django.db import models


class CashfreeOrder(models.Model):
    STATUS_CHOICES = [
        ("created", "Created"),
        ("active", "Active"),
        ("paid", "Paid"),
        ("failed", "Failed"),
        ("cancelled", "Cancelled"),
    ]

    cf_order_id = models.CharField(max_length=100, unique=True)
    payment_session_id = models.CharField(max_length=200)
    user = models.ForeignKey(
        "accounts.User", on_delete=models.CASCADE, related_name="cashfree_orders"
    )
    cart = models.ForeignKey(
        "orders.Cart",
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="cashfree_orders",
    )
    order = models.ForeignKey(
        "orders.Order",
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="cashfree_orders",
    )
    invoice = models.ForeignKey(
        "orders.Invoice",
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="cashfree_orders",
    )
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    currency = models.CharField(max_length=10, default="INR")
    status = models.CharField(
        max_length=20, choices=STATUS_CHOICES, default="created"
    )
    cf_payment_id = models.CharField(max_length=100, null=True, blank=True)
    customer_details = models.JSONField(null=True, blank=True)
    order_meta = models.JSONField(null=True, blank=True)
    raw_response = models.JSONField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"CashfreeOrder-{self.cf_order_id} ({self.status})"
