from django.db import models

# Create your models here.
class PCBuild(models.Model):
    """
    Represents a custom PC build configured by a user via the PC Builder.
    Components are stored as a JSON list of component names/details.
    """
    build_id = models.AutoField(primary_key=True)
    user = models.ForeignKey(
        'accounts.User',
        on_delete=models.CASCADE,
        related_name='pc_builds',
        null=True,
        blank=True,
    )
    name = models.CharField(max_length=255, default='My Custom Build')
    components = models.JSONField(
        default=list,
        help_text="List of component names/details selected in the builder."
    )
    total_price = models.DecimalField(
        max_digits=10, decimal_places=2, default=0.00
    )
    image_url = models.URLField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
 
    def __str__(self):
        return f"PCBuild-{self.build_id}: {self.name}"