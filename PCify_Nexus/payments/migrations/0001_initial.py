from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):
    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ("orders", "0001_initial"),
    ]

    operations = [
        migrations.CreateModel(
            name="CashfreeOrder",
            fields=[
                ("id", models.BigAutoField(auto_created=True,
                 primary_key=True, serialize=False, verbose_name="ID")),
                ("cf_order_id", models.CharField(max_length=100, unique=True)),
                ("payment_session_id", models.CharField(max_length=200)),
                ("amount", models.DecimalField(decimal_places=2, max_digits=10)),
                ("currency", models.CharField(default="INR", max_length=10)),
                (
                    "status",
                    models.CharField(
                        choices=[
                            ("created", "Created"),
                            ("active", "Active"),
                            ("paid", "Paid"),
                            ("failed", "Failed"),
                            ("cancelled", "Cancelled"),
                        ],
                        default="created",
                        max_length=20,
                    ),
                ),
                ("cf_payment_id", models.CharField(
                    blank=True, max_length=100, null=True)),
                ("customer_details", models.JSONField(blank=True, null=True)),
                ("order_meta", models.JSONField(blank=True, null=True)),
                ("raw_response", models.JSONField(blank=True, null=True)),
                ("created_at", models.DateTimeField(auto_now_add=True)),
                ("updated_at", models.DateTimeField(auto_now=True)),
                (
                    "cart",
                    models.ForeignKey(blank=True, null=True, on_delete=models.SET_NULL,
                                      related_name="cashfree_orders", to="orders.cart"),
                ),
                (
                    "invoice",
                    models.ForeignKey(blank=True, null=True, on_delete=models.SET_NULL,
                                      related_name="cashfree_orders", to="orders.invoice"),
                ),
                (
                    "order",
                    models.ForeignKey(blank=True, null=True, on_delete=models.SET_NULL,
                                      related_name="cashfree_orders", to="orders.order"),
                ),
                (
                    "user",
                    models.ForeignKey(
                        on_delete=models.CASCADE, related_name="cashfree_orders", to=settings.AUTH_USER_MODEL),
                ),
            ],
        ),
    ]
