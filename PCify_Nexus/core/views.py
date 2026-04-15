# Ensure you have your models imported!
from builds.models import PCBuild, PCBuildItem
import json
from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.db.models import Min, Max
from django.shortcuts import get_object_or_404
from django.http import JsonResponse
from decimal import Decimal
from orders.models import *
from products.models import *
from accounts.models import *
from builds.models import *
from locations.models import Address, Pincode
from accounts.models import User

# Create your views here.


# ─── helpers ────────────────────────────────────────────────────────────────

def _primary_image(variant):
    """Return the primary ProductImage for a variant, or None."""
    imgs = variant.images
    return imgs.filter(is_primary=True).first() or imgs.first()


# ─── public pages ───────────────────────────────────────────────────────────

def homepage(request):
    trending_products_qs = Product.objects.filter(
        is_trending=True).prefetch_related('variants__images')
    trending_products = []

    for product in trending_products_qs:
        variant = product.variants.first()
        if variant:
            image_obj = variant.images.filter(
                is_primary=True).first() or variant.images.first()
            trending_products.append({
                'name': product.product_name,
                'short_description': product.description,
                'price': variant.price,
                'image': image_obj.image if image_obj else None,
                'badge': 'Hot',
            })

    context = {
        'trending_products': trending_products
    }
    return render(request, "Home/home.html", context)


def prebuilt(request):
    # 1. Start with the base filter so customer builds are EXCLUDED immediately
    builds_qs = PCBuild.objects.filter(
        is_prebuilt=True).prefetch_related('items__variant__product')

    # 2. Apply further filters (Budget/Premium)
    filter_param = request.GET.get('filter', 'all')
    if filter_param == 'budget':
        builds_qs = builds_qs.filter(price__lt=100000)
    elif filter_param == 'premium':
        builds_qs = builds_qs.filter(price__gte=100000)

    # 3. Apply sorting
    sort_param = request.GET.get('sort', 'default')
    if sort_param == 'price-asc':
        builds_qs = builds_qs.order_by('price')
    elif sort_param == 'price-desc':
        builds_qs = builds_qs.order_by('-price')

    prebuilt_pcs = []
    for build in builds_qs:
        specs = []
        for item in build.items.all():
            c_type = item.component_type.lower()
            icon = 'bi-cpu'
            if 'gpu' in c_type or 'graphic' in c_type:
                icon = 'bi-gpu-card'
            elif 'ram' in c_type or 'memory' in c_type:
                icon = 'bi-memory'
            elif 'motherboard' in c_type or 'board' in c_type:
                icon = 'bi-motherboard'
            elif 'storage' in c_type or 'ssd' in c_type or 'hdd' in c_type:
                icon = 'bi-device-ssd'
            elif 'power' in c_type or 'psu' in c_type:
                icon = 'bi-plug'

            specs.append({
                'icon': icon,
                'label': item.component_type,
                'value': item.variant.product.product_name if hasattr(item.variant, 'product') else str(item.variant)
            })

        prebuilt_pcs.append({
            'id': build.build_id,
            'name': build.name,
            'price': build.price,
            'image': build.image_url,
            'badge': 'Premium' if build.price and build.price >= 100000 else 'Value',
            'specs': specs,
            'quick_specs': specs[:3],
        })

    context = {'prebuilt_pcs': prebuilt_pcs}
    return render(request, "Home/prebuilt.html", context)


def built(request):
    """
    PC Builder page.
    Fetches every hardware category from the DB and passes structured lists
    to the template. Each list item is a plain dict that the template's
    JavaScript renders into a <select> option with data-* attributes used
    for cascade-compatibility filtering.
    """

    # ── CPUs ────────────────────────────────────────────────────────────────
    cpus = []
    for spec in CPU.objects.select_related('variant__product').prefetch_related('variant__images'):
        v = spec.variant
        img = _primary_image(v)
        # Rough gaming-score: cores × boost_clock × 10
        score = round(float(spec.cores or 0) *
                      float(spec.boost_clock or 0) * 10)
        cpus.append({
            'id':     v.variant_id,
            'name':   str(v),
            'price':  int(v.price),
            'watts':  spec.tdp or 65,
            'socket': spec.socket_type,
            'score':  score,
            'image':  img,
        })

    # ── Motherboards ────────────────────────────────────────────────────────
    motherboards = []
    for spec in Motherboard.objects.select_related('variant__product').prefetch_related('variant__images'):
        v = spec.variant
        img = _primary_image(v)
        motherboards.append({
            'id':          v.variant_id,
            'name':        str(v),
            'price':       int(v.price),
            'socket':      spec.socket_type,
            'memory_type': spec.ram_type,
            'm2_slots':    spec.m2_slots,
            'sata_ports':  spec.sata_ports,
            'pcie_x16':    spec.pcie_x16_slots,
            'pcie_x1':     spec.pcie_x1_slots,
            'form_factor': spec.form_factor,
            'image':       img,
        })

    # ── GPUs ────────────────────────────────────────────────────────────────
    gpus = []
    for spec in GPU.objects.select_related('variant__product').prefetch_related('variant__images'):
        v = spec.variant
        img = _primary_image(v)
        score = (spec.memory_size or 0) * 15  # rough relative score
        gpus.append({
            'id':        v.variant_id,
            'name':      str(v),
            'price':     int(v.price),
            'watts':     spec.tdp or 150,
            'length_mm': spec.length_mm,
            'score':     score,
            'image':     img,
        })

    # ── RAM ─────────────────────────────────────────────────────────────────
    rams = []
    for spec in RAM.objects.select_related('variant__product').prefetch_related('variant__images'):
        v = spec.variant
        img = _primary_image(v)
        rams.append({
            'id':       v.variant_id,
            'name':     str(v),
            'price':    int(v.price),
            'watts':    spec.tdp or 5,
            'ram_type': spec.ram_type,
            'image':    img,
        })

# ── Storage — M.2 NVMe ──────────────────────────────────────────────────
    storage_m2 = []
    # FIX: Changed interface_type to form_factor here
    for spec in Storage.objects.filter(
        form_factor__icontains='M.2'
    ).select_related('variant__product').prefetch_related('variant__images'):
        v = spec.variant
        img = _primary_image(v)
        storage_m2.append({
            'id':    v.variant_id,
            'name':  str(v),
            'price': int(v.price),
            'watts': spec.tdp or 5,
            'image': img,
        })

    # ── Storage — HDD ────────────────────────────────────────────
    storage_hdd = []
    for spec in Storage.objects.filter(
        storage_type__iexact='hdd'
    ).select_related('variant__product').prefetch_related('variant__images'):
        v = spec.variant
        img = _primary_image(v)
        storage_hdd.append({
            'id':    v.variant_id,
            'name':  str(v),
            'price': int(v.price),
            'watts': spec.tdp or 5,
            'image': img,
        })

    # ----- Storage — SATA SSDs (Storage type is 'SSD' but Form Factor is NOT 'M.2') ----
    for spec in Storage.objects.filter(
        storage_type__iexact='ssd'
    ).exclude(
        form_factor__icontains='M.2'  # FIX: Changed interface_type to form_factor here too!
    ).select_related('variant__product').prefetch_related('variant__images'):
        v = spec.variant
        img = _primary_image(v)
        storage_hdd.append({
            'id':    v.variant_id,
            'name':  str(v),
            'price': int(v.price),
            'watts': spec.tdp or 5,
            'image': img,
        })

    # ── Air Coolers ─────────────────────────────────────────────────────────
    air_coolers = []
    for spec in Cooler.objects.filter(
        cooler_type='AIR'
    ).select_related('variant__product').prefetch_related('variant__images'):
        v = spec.variant
        img = _primary_image(v)
        air_coolers.append({
            'id':           v.variant_id,
            'name':         str(v),
            'price':        int(v.price),
            'watts':        spec.tdp or 5,
            'height_mm':    spec.height_mm,
            # sockets_json is a ready-to-embed JSON array string, e.g. '["AM5","LGA1700"]'
            'sockets_json': json.dumps(spec.supported_sockets),
            'image':        img,
        })

    # ── AIO Liquid Coolers ──────────────────────────────────────────────────
    aio_coolers = []
    for spec in Cooler.objects.filter(
        cooler_type='AIO'
    ).select_related('variant__product').prefetch_related('variant__images'):
        v = spec.variant
        img = _primary_image(v)
        aio_coolers.append({
            'id':              v.variant_id,
            'name':            str(v),
            'price':           int(v.price),
            'watts':           spec.tdp or 10,
            'radiator_mm':     spec.radiator_size_mm or 0,
            'sockets_json':    json.dumps(spec.supported_sockets),
            'image':           img,
        })

    # ── PSUs ────────────────────────────────────────────────────────────────
    psus = []
    for spec in PSU.objects.select_related('variant__product').prefetch_related('variant__images'):
        v = spec.variant
        img = _primary_image(v)
        psus.append({
            'id':    v.variant_id,
            'name':  str(v),
            'price': int(v.price),
            'watts': spec.wattage,
            'image': img,
        })

    # ── PC Cases / Cabinets ─────────────────────────────────────────────────
    pc_cases = []
    for spec in Cabinet.objects.select_related('variant__product').prefetch_related('variant__images'):
        v = spec.variant
        img = _primary_image(v)
        pc_cases.append({
            'id':               v.variant_id,
            'name':             str(v),
            'price':            int(v.price),
            'max_gpu_length':   spec.max_gpu_length_mm,
            'max_cooler_height': spec.max_cooler_height_mm,
            'max_psu_length':   spec.max_psu_length_mm,
            'image':            img,
        })

    context = {
        'cpus':        cpus,
        'motherboards': motherboards,
        'gpus':        gpus,
        'rams':        rams,
        'storage_m2':  storage_m2,
        'storage_hdd': storage_hdd,
        'air_coolers': air_coolers,
        'aio_coolers': aio_coolers,
        'psus':        psus,
        'pc_cases':    pc_cases,
    }
    return render(request, "Home/pc.html", context)


def accessories(request):
    products_qs = Product.objects.all().prefetch_related(
        'variants__images', 'category', 'brand')

    category_param = request.GET.get('category')
    if category_param:
        if category_param.isdigit():
            products_qs = products_qs.filter(
                category__category_id=category_param)
        else:
            products_qs = products_qs.filter(
                category__category_name__icontains=category_param)

    search_query = request.GET.get('q', '')
    if search_query:
        products_qs = products_qs.filter(product_name__icontains=search_query)

    selected_brands = request.GET.getlist('brand')
    if selected_brands:
        products_qs = products_qs.filter(brand__brand_name__in=selected_brands)

    price_aggregates = ProductVariant.objects.aggregate(
        min_price=Min('price'), max_price=Max('price'))
    absolute_min = int(price_aggregates['min_price'] or 0)
    absolute_max = int(price_aggregates['max_price'] or 50000)

    current_min = request.GET.get('min_price', absolute_min)
    current_max = request.GET.get('max_price', absolute_max)
    try:
        current_min = int(current_min)
        current_max = int(current_max)
    except ValueError:
        current_min = absolute_min
        current_max = absolute_max

    products_qs = products_qs.filter(
        variants__price__gte=current_min,
        variants__price__lte=current_max
    ).distinct()

    def _is_low_quality_image(image_path):
        """Check if image filename indicates low quality (small dimensions)"""
        if not image_path:
            return True
        low_quality_indicators = [
            '_SS40_', '_AC_US40_', '_SX38_', '_SY50_', '_CR00',
            '_SL40_', '_US40_', '_SX40_', '_SY40_'
        ]
        return any(indicator in str(image_path) for indicator in low_quality_indicators)

    def _get_best_image(images):
        """Get the best quality image from a list of images"""
        if not images:
            return None

        # First try to find a high quality image
        for img in images:
            if img.image and not _is_low_quality_image(img.image.name):
                return img

        # If no high quality found, return the first available
        return images[0] if images else None

    products_list = []
    for product in products_qs:
        variant = product.variants.first()
        if variant:
            all_imgs = variant.images.all()
            # Get the best quality image instead of just primary/first
            best_image = _get_best_image(list(all_imgs))
            primary_image = best_image or all_imgs.first()
            img_urls = [img.image.url for img in all_imgs if img.image]
            all_images_str = ",".join(img_urls) if img_urls else ""

            products_list.append({
                'id':             product.product_id,
                'variant_id':     variant.variant_id,
                'name':           product.product_name,
                'category':       product.category,
                'price':          variant.price,
                'image':          primary_image.image if primary_image and primary_image.image else None,
                'all_images_str': all_images_str,
            })

    sort_param = request.GET.get('sort', 'pop')
    if sort_param == 'low':
        products_list.sort(key=lambda x: x['price'])
    elif sort_param == 'high':
        products_list.sort(key=lambda x: x['price'], reverse=True)

    categories = Category.objects.all()
    brands = Brand.objects.all()

    context = {
        'products':          products_list,
        'categories':        categories,
        'brands':            brands,
        'search_query':      search_query,
        'current_sort':      sort_param,
        'selected_category': category_param,
        'selected_brands':   selected_brands,
        'absolute_min':      absolute_min,
        'absolute_max':      absolute_max,
        'current_min':       current_min,
        'current_max':       current_max,
    }
    return render(request, "Home/accessories.html", context)


def cart(request):
    user_id = request.session.get('user_id')

    # Clean up: Remove any existing build items from all carts (one-time safety)
    from orders.models import CartItem
    build_items = CartItem.objects.filter(build__isnull=False)
    if build_items.exists():
        build_items.delete()

    if request.method == "POST":
        if not user_id:
            return JsonResponse({'status': 'error', 'message': 'Please login to add items.'})

        action = request.POST.get("action")
        try:
            user = User.objects.get(user_id=user_id)
            cart_obj, _ = Cart.objects.get_or_create(user=user)

            if action == "add":
                variant_id = request.POST.get("variant_id")
                pc_id = request.POST.get("pc_id")
                quantity = int(request.POST.get("quantity", 1))

                # 1. If it's a Prebuilt PC: decompose into variants
                if pc_id:
                    build = PCBuild.objects.get(build_id=pc_id)
                    for build_item in build.items.all():
                        variant = build_item.variant
                        # Check if this variant is already in the cart
                        cart_item, created = CartItem.objects.get_or_create(
                            cart=cart_obj,
                            variant=variant,
                            build_source=build,  # Track the source build
                            defaults={
                                'quantity': build_item.quantity * quantity}
                        )
                        if not created:
                            cart_item.quantity += build_item.quantity * quantity
                            cart_item.save()
                # 2. If it's an Accessory/Component
                elif variant_id:
                    variant = ProductVariant.objects.get(variant_id=variant_id)
                    cart_item, created = CartItem.objects.get_or_create(
                        cart=cart_obj,
                        variant=variant,
                        defaults={'quantity': quantity}
                    )
                    if not created:
                        cart_item.quantity += quantity
                        cart_item.save()
                else:
                    raise Exception("No valid product or PC ID provided.")

            elif action == "delete":
                cart_item_id = request.POST.get("cart_item_id")
                CartItem.objects.filter(
                    cart_item_id=cart_item_id, cart=cart_obj).delete()

            elif action == "update":
                cart_item_id = request.POST.get("cart_item_id")
                update_type = request.POST.get("update_type")
                cart_item = CartItem.objects.get(
                    cart_item_id=cart_item_id, cart=cart_obj)
                if update_type == "increase":
                    cart_item.quantity += 1
                    cart_item.save()
                elif update_type == "decrease":
                    if cart_item.quantity > 1:
                        cart_item.quantity -= 1
                        cart_item.save()
                    else:
                        cart_item.delete()

            elif action == "clear":
                CartItem.objects.filter(cart=cart_obj).delete()

            elif action == 'add_custom_build':
                components_json = request.POST.get('components')
                build_price = request.POST.get('build_price', 0)

                if components_json:
                    components_data = json.loads(components_json)

                    new_build = PCBuild.objects.create(
                        user=user,
                        name="Custom Nexus Build",
                        price=build_price,
                        description="User created custom PC configuration.",
                        is_prebuilt=False,
                        is_custom=True,
                    )

                    for comp in components_data:
                        variant_id = comp.get('variant_id')
                        comp_type = comp.get('component_type')
                        variant = ProductVariant.objects.filter(
                            variant_id=variant_id).first()
                        if variant:
                            PCBuildItem.objects.create(
                                build=new_build,
                                variant=variant,
                                component_type=comp_type
                            )

                    CartItem.objects.create(
                        cart=cart_obj,
                        build=new_build,
                        quantity=1
                    )
                    return JsonResponse({'status': 'success', 'message': 'Build packaged successfully'})

            if request.headers.get('x-requested-with') == 'XMLHttpRequest':
                return JsonResponse({'status': 'success'})
            return redirect('core:cart')

        except Exception as e:
            if request.headers.get('x-requested-with') == 'XMLHttpRequest':
                return JsonResponse({'status': 'error', 'message': str(e)})
            return redirect('core:cart')

    # GET — display cart on the cart.html page
    cart_items_data = []
    subtotal = Decimal('0.00')
    tax = Decimal('0.00')
    total = Decimal('0.00')
    cart_count = 0

    if user_id:
        try:
            user = User.objects.get(user_id=user_id)
            cart_obj = Cart.objects.prefetch_related(
                'items__variant__product', 'items__variant__images', 'items__build'
            ).get(user=user)
            items = cart_obj.items.all()
            cart_count = items.count()

            for item in items:
                # 1. Send Accessories to the HTML
                if getattr(item, 'variant', None):
                    variant = item.variant
                    product = variant.product
                    item_total = variant.price * item.quantity
                    subtotal += item_total

                    primary_image = variant.images.filter(
                        is_primary=True).first() or variant.images.first()
                    cart_items_data.append({
                        'cart_item_id': item.cart_item_id,
                        'variant_id':   variant.variant_id,
                        'name':         product.product_name,
                        'type':         product.category.category_name,
                        'price':        variant.price,
                        'quantity':     item.quantity,
                        'item_total':   item_total,
                        'image_url':    primary_image.image.url if primary_image and primary_image.image else None,
                    })

                # 2. Send Prebuilt PCs to the HTML
                elif getattr(item, 'build', None):
                    build = item.build
                    item_total = build.price * item.quantity
                    subtotal += item_total

                    component_list = [
                        b_item.variant.product.product_name for b_item in build.items.all()]

                    cart_items_data.append({
                        'cart_item_id': item.cart_item_id,
                        'build_id':     build.build_id,
                        'name':         build.name,
                        'type':         "Prebuilt PC" if build.is_prebuilt else "Custom PC Build",
                        'price':        build.price,
                        'quantity':     item.quantity,
                        'item_total':   item_total,
                        'image_url':    build.image_url.url if build.image_url else None,
                        'build_items':  component_list,
                    })

            tax = round(subtotal * Decimal('0.18'), 2)
            total = subtotal + tax

        except Cart.DoesNotExist:
            pass

    context = {
        'cart_items': cart_items_data,
        'subtotal':   subtotal,
        'tax':        tax,
        'total':      total,
        'cart_count': cart_count,
    }
    return render(request, "Home/cart.html", context)


def profile(request):
    return render(request, "Home/pro_overview.html")


def pro_builds(request):
    """Display user's saved PC builds"""
    user_id = request.session.get('user_id')
    if not user_id:
        return redirect('accounts:signin')

    user = User.objects.get(user_id=user_id)
    builds = PCBuild.objects.filter(
        user=user, is_custom=True).order_by('-created_at')

    # Prepare build data for template
    build_data = []
    for build in builds:
        components = {}
        for item in build.items.all():
            components[item.component_type] = str(item.variant)

        build_data.append({
            'id': build.build_id,
            'name': build.name,
            'price': build.price,
            'created_at': build.created_at,
            'processor': components.get('cpu', 'Not selected'),
            'motherboard': components.get('mobo', 'Not selected'),
            'graphics': components.get('gpu', 'Not selected'),
            'memory': components.get('ram', 'Not selected'),
            'ssd': components.get('storage_m2', 'Not selected'),
            'hdd': components.get('storage_hdd', 'Not selected'),
            'm2': components.get('storage_m2', 'Not selected'),
            'total_price': build.price
        })

    return render(request, "Home/pro_my_builds.html", {'builds': build_data})


def save_pc_build(request):
    """Save a custom PC build configuration"""
    if request.method != 'POST':
        return JsonResponse({'status': 'error', 'message': 'Invalid request method'})

    user_id = request.session.get('user_id')
    if not user_id:
        return JsonResponse({'status': 'error', 'message': 'Please login to save builds'})

    try:
        user = User.objects.get(user_id=user_id)
        build_name = request.POST.get('build_name', '').strip()

        # Validate build name
        if not build_name:
            return JsonResponse({'status': 'error', 'message': 'Build name is required'})

        if len(build_name) > 100:
            return JsonResponse({'status': 'error', 'message': 'Build name too long (max 100 characters)'})

        # Parse components from form data
        components = {}
        component_types = ['cpu', 'mobo', 'gpu', 'ram', 'storage_m2',
                           'storage_hdd', 'cooler_air', 'cooler_aio', 'psu', 'case']

        total_price = 0
        for comp_type in component_types:
            variant_id = request.POST.get(comp_type)
            quantity = int(request.POST.get(f'qty_{comp_type}', 1))

            if variant_id and variant_id != 'none':
                try:
                    variant = ProductVariant.objects.get(variant_id=variant_id)
                    components[comp_type] = {
                        'variant': variant, 'quantity': quantity}
                    total_price += variant.price * quantity
                except ProductVariant.DoesNotExist:
                    pass

        # Create or update build
        build_id = request.POST.get('build_id')
        if build_id:
            # Update existing build
            build = PCBuild.objects.get(build_id=build_id, user=user)
            build.name = build_name
            build.price = total_price
            build.save()

            # Clear existing items
            build.items.all().delete()
        else:
            # Create new build
            build = PCBuild.objects.create(
                user=user,
                name=build_name,
                price=total_price,
                description=f"Custom build: {build_name}",
                is_prebuilt=False,
                is_custom=True
            )

        # Add components to build
        for comp_type, comp_data in components.items():
            PCBuildItem.objects.create(
                build=build,
                variant=comp_data['variant'],
                component_type=comp_type,
                quantity=comp_data['quantity']
            )

        return JsonResponse({
            'status': 'success',
            'message': 'Build saved successfully',
            'build_id': build.build_id
        })

    except Exception as e:
        return JsonResponse({'status': 'error', 'message': f'Error saving build: {str(e)}'})


def delete_pc_build(request, build_id):
    """Delete a saved PC build"""
    if request.method != 'POST':
        return JsonResponse({'status': 'error', 'message': 'Invalid request method'})

    user_id = request.session.get('user_id')
    if not user_id:
        return JsonResponse({'status': 'error', 'message': 'Please login to delete builds'})

    try:
        user = User.objects.get(user_id=user_id)
        build = PCBuild.objects.get(build_id=build_id, user=user)
        build.delete()

        return JsonResponse({'status': 'success', 'message': 'Build deleted successfully'})

    except PCBuild.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'Build not found'})
    except Exception as e:
        return JsonResponse({'status': 'error', 'message': f'Error deleting build: {str(e)}'})


def load_pc_build(request, build_id):
    """Load a saved build configuration for editing"""
    user_id = request.session.get('user_id')
    if not user_id:
        return JsonResponse({'status': 'error', 'message': 'Please login to load builds'})

    try:
        user = User.objects.get(user_id=user_id)
        build = PCBuild.objects.get(build_id=build_id, user=user)

        # Prepare build configuration
        config = {'build_id': build.build_id, 'build_name': build.name}
        for item in build.items.all():
            config[item.component_type] = item.variant.variant_id
            config[f'qty_{item.component_type}'] = item.quantity

        return JsonResponse({'status': 'success', 'config': config})

    except PCBuild.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'Build not found'})
    except Exception as e:
        return JsonResponse({'status': 'error', 'message': f'Error loading build: {str(e)}'})


def load_prebuilt_config(request, build_id):
    """Load a prebuilt PC configuration for customization"""
    try:
        build = PCBuild.objects.get(build_id=build_id, is_prebuilt=True)

        # Prepare build configuration
        config = {'build_id': build.build_id, 'build_name': build.name}
        # Component type mapping from database to frontend
        component_map = {
            'm2': 'storage_m2',
            'cabinet': 'case'
        }

        for item in build.items.all():
            # Map database component types to frontend expected types
            frontend_type = component_map.get(
                item.component_type, item.component_type)
            config[frontend_type] = item.variant.variant_id
            config[f'qty_{frontend_type}'] = item.quantity

        return JsonResponse({'status': 'success', 'config': config})

    except PCBuild.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'Prebuilt configuration not found'})
    except Exception as e:
        return JsonResponse({'status': 'error', 'message': f'Error loading prebuilt: {str(e)}'})


def pro_order(request):
    user_id = request.session.get("user_id")
    if not user_id:
        return redirect("accounts:signin")

    user = User.objects.get(user_id=user_id)
    orders_qs = Order.objects.filter(user=user).order_by(
        '-created_at').prefetch_related('items__variant__product')
    orders = []
    for order in orders_qs:
        # Compose a summary for each order
        order_items = order.items.all()
        # Show the first item as the main title, summarize the rest
        if order_items:
            first_item = order_items[0]
            title = str(first_item.variant.product.product_name) if first_item.variant and first_item.variant.product else str(
                first_item.variant or first_item.build or "Item")
            description = f"{len(order_items)} item(s)"
            quantity = sum([it.quantity for it in order_items])
        else:
            title = "No items"
            description = "-"
            quantity = 0
        orders.append({
            'order_number': order.order_id,
            'status': order.status.title(),
            'created_at': order.created_at,
            'total_price': order.total_amount,
            'title': title,
            'description': description,
            'quantity': quantity,
            'build_status': order.status.title(),
        })
    return render(request, "Home/pro_order_history.html", {'orders': orders})


def pro_security(request):
    return render(request, "Home/pro_security.html")

# Make sure the function name matches your actual view name (e.g., pro_setting)


def pro_setting(request):
    # Ensure user is logged in
    user_id = request.session.get("user_id")
    if not user_id:
        return redirect("accounts:signin")

    user = User.objects.get(user_id=user_id)

    if request.method == "POST":
        action = request.POST.get("action")

        # 0. UPDATE PERSONAL INFORMATION & PROFILE IMAGE
        if action == "update_profile":
            user.first_name = request.POST.get("first_name", user.first_name)
            user.last_name = request.POST.get("last_name", user.last_name)
            user.email = request.POST.get("email", user.email)

            # Check if a new image was uploaded
            if "profile_image" in request.FILES:
                user.profile_image = request.FILES.get("profile_image")

            user.save()

            # Update the session variables so the new name/image appear in the header immediately
            request.session["user_name"] = user.first_name
            request.session["user_lname"] = user.last_name

            # Safely update the image session URL if it exists
            if hasattr(user, 'profile_image') and user.profile_image:
                request.session["user_image"] = user.profile_image.url

        # 1. ADD NEW ADDRESS
        elif action == "add_address":
            street = request.POST.get("street_address")
            area = request.POST.get("area")
            pin = request.POST.get("pincode")
            make_primary = request.POST.get("make_primary") == "on"

            if street and pin:
                # Get or create the Pincode object
                pincode_obj, _ = Pincode.objects.get_or_create(
                    pincode=pin,
                    defaults={'area_name': area, 'city': 'Ahmedabad'}
                )

                # If this is their first address, or they checked the box, make it primary
                if make_primary or not Address.objects.filter(user=user).exists():
                    Address.objects.filter(user=user).update(is_primary=False)
                    make_primary = True

                # Save the new address to the database
                Address.objects.create(
                    user=user,
                    address=street,
                    pincode=pincode_obj,
                    is_primary=make_primary
                )

        # 2. EDIT EXISTING ADDRESS
        elif action == "edit_address":
            addr_id = request.POST.get("address_id")
            street = request.POST.get("street_address")
            area = request.POST.get("area")
            pin = request.POST.get("pincode")
            make_primary = request.POST.get("make_primary") == "on"

            if addr_id and street and pin:
                pincode_obj, _ = Pincode.objects.get_or_create(
                    pincode=pin,
                    defaults={'area_name': area, 'city': 'Ahmedabad'}
                )
                if make_primary:
                    Address.objects.filter(user=user).update(is_primary=False)

                Address.objects.filter(address_id=addr_id, user=user).update(
                    address=street,
                    pincode=pincode_obj,
                    is_primary=make_primary
                )

        # 3. DELETE ADDRESS
        elif action == "delete_address":
            addr_id = request.POST.get("address_id")
            if addr_id:
                Address.objects.filter(address_id=addr_id, user=user).delete()
                # If they deleted their primary address, make the next one primary automatically
                if not Address.objects.filter(user=user, is_primary=True).exists():
                    first_addr = Address.objects.filter(user=user).first()
                    if first_addr:
                        first_addr.is_primary = True
                        first_addr.save()

        # 4. SET AS PRIMARY
        elif action == "set_primary":
            addr_id = request.POST.get("address_id")
            if addr_id:
                Address.objects.filter(user=user).update(is_primary=False)
                Address.objects.filter(
                    address_id=addr_id, user=user).update(is_primary=True)

        # Refresh the page to show the new data
        return redirect("core:pro_setting")

    # --- YOUR EXISTING GET LOGIC GOES HERE ---
    addresses = Address.objects.filter(user=user).select_related(
        'pincode').order_by('-is_primary')

    context = {
        'first_name': user.first_name,
        'last_name': user.last_name,
        'email': user.email,
        'street_address': "",  # Default blank for form
        'area': "",            # Default blank for form
        'pincode': "",         # Default blank for form
        'addresses': addresses,
    }
    return render(request, "Home/pro_settings.html", context)
