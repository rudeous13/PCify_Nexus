from django.db import models


class PCBuild(models.Model):
    build_id = models.AutoField(primary_key=True)
    user = models.ForeignKey(
        'accounts.User',
        on_delete=models.CASCADE,
        related_name='builds'
    )
    name = models.CharField(max_length=150)
    created_at = models.DateTimeField(auto_now_add=True)
    price = models.DecimalField(max_digits=10, decimal_places=2, null=True)
    description = models.TextField(blank=True, null=True)
    image_url = models.ImageField(upload_to='prebuilt_pcs/', blank=True, null=True)
    def __str__(self):
        return f"{self.name} ({self.user})"


class PCBuildItem(models.Model):
    build_item_id = models.AutoField(primary_key=True)
    build = models.ForeignKey(
        PCBuild, on_delete=models.CASCADE, related_name='items')
    variant = models.ForeignKey(
        'products.ProductVariant',
        on_delete=models.CASCADE,
        related_name='build_items'
    )
    component_type = models.CharField(max_length=50)
    quantity = models.PositiveIntegerField(default=1)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = [('build', 'variant')]

    def __str__(self):
        return f"{self.component_type}: {self.variant.sku}"
