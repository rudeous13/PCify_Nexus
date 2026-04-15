from django.db import models
from django.utils import timezone


class EmployeeTask(models.Model):
    TASK_TYPES = [
        ('diagnostics', 'Diagnostics'),
        ('assembly', 'Assembly'),
        ('repair', 'Repair'),
        ('delivery', 'Delivery'),
        ('admin', 'Admin Task'),
    ]

    STATUSES = [
        ('pending', 'Pending'),
        ('in_progress', 'In Progress'),
        ('completed', 'Completed'),
        ('cancelled', 'Cancelled'),
    ]

    DELIVERY_TYPES = [
        ('pickup', 'Customer Pickup'),
        ('delivery', 'Home Delivery'),
        ('in_shop', 'In-Shop Service'),
    ]

    task_id = models.CharField(max_length=20, unique=True, primary_key=True)
    title = models.CharField(max_length=200)
    description = models.TextField(blank=True, null=True)
    task_type = models.CharField(max_length=20, choices=TASK_TYPES)
    status = models.CharField(
        max_length=20, choices=STATUSES, default='pending')

    # Employee assignment
    assigned_to = models.ForeignKey(
        'accounts.User',
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='assigned_tasks',
        limit_choices_to={'role__in': ['employee', 'admin']}
    )

    # Customer information
    customer = models.ForeignKey(
        'accounts.User',
        on_delete=models.CASCADE,
        related_name='customer_tasks',
        limit_choices_to={'role': 'customer'}
    )

    # Related orders or services
    order = models.ForeignKey(
        'orders.Order',
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='tasks'
    )

    service_request = models.ForeignKey(
        'services.ServiceRequest',
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='tasks'
    )

    # Delivery information
    delivery_type = models.CharField(
        max_length=20, choices=DELIVERY_TYPES, blank=True, null=True)
    customer_address = models.TextField(blank=True, null=True)
    customer_phone = models.CharField(max_length=20, blank=True, null=True)

    # Timestamps
    created_at = models.DateTimeField(auto_now_add=True)
    assigned_at = models.DateTimeField(null=True, blank=True)
    started_at = models.DateTimeField(null=True, blank=True)
    completed_at = models.DateTimeField(null=True, blank=True)

    # Priority and notes
    priority = models.PositiveSmallIntegerField(
        default=1)  # 1-5, 1 being highest
    notes = models.TextField(blank=True, null=True)

    class Meta:
        ordering = ['-priority', 'created_at']

    def __str__(self):
        return f"{self.task_id} - {self.title}"

    def save(self, *args, **kwargs):
        if not self.task_id:
            # Generate task ID: TSK-YYYYMMDD-XXXX
            date_part = timezone.now().strftime('%Y%m%d')
            last_task = EmployeeTask.objects.filter(
                task_id__startswith=f'TSK-{date_part}'
            ).order_by('-task_id').first()

            if last_task:
                last_num = int(last_task.task_id.split('-')[-1])
                new_num = last_num + 1
            else:
                new_num = 1

            self.task_id = f'TSK-{date_part}-{new_num:04d}'

        # Update timestamps based on status changes
        if self.status == 'in_progress' and not self.started_at:
            self.started_at = timezone.now()
        elif self.status == 'completed' and not self.completed_at:
            self.completed_at = timezone.now()

        super().save(*args, **kwargs)

    @property
    def customer_name(self):
        return f"{self.customer.first_name} {self.customer.last_name}".strip()

    @property
    def parts_html(self):
        """Generate HTML for parts list based on order or service"""
        parts = []

        if self.order:
            for item in self.order.items.all():
                parts.append(
                    f'\u003cli class="py-2"\u003e\u003ci class="bi bi-cpu text-brand-400 mr-2"\u003e\u003c/i\u003e {item.variant.product.name} - {item.variant.name}\u003c/li\u003e')

        if self.service_request and self.service_request.variant:
            parts.append(
                f'\u003cli class="py-2"\u003e\u003ci class="bi bi-tools text-brand-400 mr-2"\u003e\u003c/i\u003e {self.service_request.variant.product.name} - Service\u003c/li\u003e')

        return '\n'.join(parts) if parts else '\u003cli class="py-2 text-slate-400"\u003eNo parts specified\u003c/li\u003e'


class TaskAssignment(models.Model):
    """Track task assignments and completions"""
    task = models.ForeignKey(
        EmployeeTask, on_delete=models.CASCADE, related_name='assignments')
    employee = models.ForeignKey(
        'accounts.User', on_delete=models.CASCADE, related_name='task_assignments')
    assigned_by = models.ForeignKey(
        'accounts.User', on_delete=models.CASCADE, related_name='given_assignments')
    assigned_at = models.DateTimeField(auto_now_add=True)
    completed_at = models.DateTimeField(null=True, blank=True)
    notes = models.TextField(blank=True, null=True)

    class Meta:
        ordering = ['-assigned_at']

    def __str__(self):
        return f"{self.task.task_id} - {self.employee.email}"
