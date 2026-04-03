from django.db import models
from django.core.validators import MinValueValidator, MaxValueValidator

# Create your models here.


class Brand(models.Model):
    brand_id = models.AutoField(primary_key=True)
    brand_name = models.CharField(max_length=100, unique=True)

    def __str__(self):
        return self.brand_name


class Category(models.Model):
    category_id = models.AutoField(primary_key=True)
    category_name = models.CharField(max_length=100, unique=True)

    def __str__(self):
        return self.category_name


class Product(models.Model):
    product_id = models.AutoField(primary_key=True)
    product_name = models.CharField(max_length=255)
    brand = models.ForeignKey(
        Brand, on_delete=models.RESTRICT, related_name="products")
    category = models.ForeignKey(
        Category, on_delete=models.RESTRICT, related_name="products")
    warranty_months = models.PositiveIntegerField(default=0)
    description = models.CharField(max_length=512, null=True)
    is_trending = models.BooleanField(default=False, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.brand.brand_name} {self.product_name}"


class ProductVariant(models.Model):
    variant_id = models.AutoField(primary_key=True)
    product = models.ForeignKey(
        Product, on_delete=models.CASCADE, related_name="variants")
    variant_name = models.CharField(
        max_length=255, help_text="e.g., 850W 80+ Gold, 32GB White")
    sku = models.CharField(max_length=100, unique=True)
    price = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return f"{self.product.product_name} - {self.variant_name}"

    @property
    def primary_image(self):
        return self.images.filter(is_primary=True).first() or self.images.first()


class ProductImage(models.Model):
    image_id = models.AutoField(primary_key=True)
    variant = models.ForeignKey(
        ProductVariant, on_delete=models.CASCADE, related_name="images")
    image = models.ImageField(upload_to="product_variants_images")
    is_primary = models.BooleanField(
        default=False, help_text="Check this to make it the main thumbnail")

    def __str__(self):
        return f"Image for {self.variant.sku}"


class HardwareSpec(models.Model):
    variant = models.OneToOneField(
        ProductVariant, on_delete=models.CASCADE, related_name="%(class)s_specs")
    tdp = models.PositiveIntegerField(
        help_text="In Watts", null=True, blank=True)

    class Meta:
        abstract = True


class TechSpecs:
    RAM_TYPES = [('DDR4', 'DDR4'), ('DDR5', 'DDR5')]
    FORM_FACTORS = [('ATX', 'ATX'), ('MATX', 'Micro-ATX'), ('ITX', 'Mini-ITX')]
    STORAGE_TYPES = [('SSD', 'SSD'), ('HDD', 'HDD')]

    EFFICIENCY_RATINGS = [
        ('80+', '80 Plus'),
        ('BRONZE', '80+ Bronze'),
        ('SILVER', '80+ Silver'),
        ('GOLD', '80+ Gold'),
        ('PLATINUM', '80+ Platinum'),
        ('TITANIUM', '80+ Titanium'),
    ]

    MODULARITY_CHOICES = [
        ('NON', 'Non-Modular'),
        ('SEMI', 'Semi-Modular'),
        ('FULL', 'Fully-Modular'),
    ]


class CPU(HardwareSpec):
    socket_type = models.CharField(max_length=50)
    cores = models.IntegerField()
    threads = models.IntegerField()
    base_clock = models.DecimalField(max_digits=6, decimal_places=3)
    boost_clock = models.DecimalField(max_digits=6, decimal_places=3)
    integrated_graphics = models.BooleanField(default=False)


class RAM(HardwareSpec):
    ram_type = models.CharField(max_length=10, choices=TechSpecs.RAM_TYPES)
    capacity_gb = models.PositiveIntegerField()
    speed_mhz = models.PositiveIntegerField()
    module_count = models.PositiveSmallIntegerField()


class Storage(HardwareSpec):
    storage_type = models.CharField(max_length=50)
    capacity_gb = models.IntegerField()
    interface_type = models.CharField(max_length=50)
    form_factor = models.CharField(max_length=50)


class GPU(HardwareSpec):
    memory_size = models.IntegerField()
    pcie_version = models.CharField(max_length=50)
    length_mm = models.IntegerField()
    interface_type = models.CharField(max_length=50)
    power_8pin_count = models.IntegerField()
    power_6pin_count = models.IntegerField()
    power_12vhpwr = models.BooleanField(default=False)


class Cabinet(HardwareSpec):
    supported_form_factors = models.CharField(
        max_length=100, help_text="e.g. ATX, ITX")
    max_gpu_length_mm = models.PositiveIntegerField()
    max_psu_length_mm = models.PositiveIntegerField()
    max_cooler_height_mm = models.PositiveIntegerField()


class Motherboard(HardwareSpec):
    socket_type = models.CharField(max_length=50)
    ram_type = models.CharField(max_length=10, choices=TechSpecs.RAM_TYPES)
    form_factor = models.CharField(
        max_length=10, choices=TechSpecs.FORM_FACTORS)
    chipset = models.CharField(max_length=50)
    m2_slots = models.PositiveSmallIntegerField(default=0)
    sata_ports = models.PositiveSmallIntegerField(default=0)
    pcie_x1_slots = models.IntegerField()
    pcie_x16_slots = models.IntegerField()


class PSU(HardwareSpec):
    wattage = models.PositiveIntegerField(help_text="In Watts")
    form_factor = models.CharField(
        max_length=10, choices=TechSpecs.FORM_FACTORS)
    efficiency_rating = models.CharField(
        max_length=15, choices=TechSpecs.EFFICIENCY_RATINGS)
    modularity = models.CharField(
        max_length=10, choices=TechSpecs.MODULARITY_CHOICES, default='NON')
    length_mm = models.PositiveIntegerField()
    power_8pin_count = models.PositiveSmallIntegerField(
        default=0, help_text="CPU/PCIe 8-pin")
    power_6pin_count = models.PositiveSmallIntegerField(
        default=0, help_text="PCIe 6-pin")
    power_12vhpwr = models.BooleanField(
        default=False, help_text="16-pin connector for modern GPUs")


class ProductReview(models.Model):
    review_id = models.AutoField(primary_key=True)
    variant = models.ForeignKey(
        ProductVariant, on_delete=models.CASCADE, related_name='reviews')
    user = models.ForeignKey(
        'accounts.User', on_delete=models.CASCADE, related_name='reviews')
    rating = models.PositiveSmallIntegerField(
        validators=[MinValueValidator(1), MaxValueValidator(5)]
    )
    comment = models.TextField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = [('variant', 'user')]

    def __str__(self):
        return f"Review by {self.user} on {self.variant.sku} ({self.rating}/5)"
