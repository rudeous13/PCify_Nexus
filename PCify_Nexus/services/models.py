from django.db import models


class Service(models.Model):
    service_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=150, unique=True)
    description = models.TextField(null=True, blank=True)
    base_price = models.DecimalField(
        max_digits=10, decimal_places=2, default=0.00)
    is_active = models.BooleanField(default=True)

    def __str__(self):
        return self.name


class ServiceRequest(models.Model):
    STATUSES = [
        ('open', 'Open'),
        ('in_progress', 'In Progress'),
        ('resolved', 'Resolved'),
        ('cancelled', 'Cancelled'),
    ]

    service_request_id = models.AutoField(primary_key=True)
    service = models.ForeignKey(
        Service, on_delete=models.RESTRICT, related_name='requests')
    user = models.ForeignKey(
        'accounts.User',
        on_delete=models.CASCADE,
        related_name='service_requests'
    )
    order = models.ForeignKey(
        'orders.Order',
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='service_requests'
    )
    variant = models.ForeignKey(
        'products.ProductVariant',
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='service_requests'
    )
    status = models.CharField(max_length=15, choices=STATUSES, default='open')
    issue_description = models.TextField(null=True, blank=True)
    total_amount = models.DecimalField(
        max_digits=10, decimal_places=2, default=0.00)
    created_at = models.DateTimeField(auto_now_add=True)
    completed_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"ServiceRequest-{self.service_request_id} ({self.status})"
