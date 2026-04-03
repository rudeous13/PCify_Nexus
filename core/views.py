from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.db.models import Min, Max
from django.shortcuts import get_object_or_404
from django.http import JsonResponse
from decimal import Decimal
from orders.models import *
from products.models import *
from accounts.models import *
# Create your views here.

# Default page for when first call
def homepage(request):
  trending_products_qs = Product.objects.filter(is_trending=True).prefetch_related('variants__images')
  trending_products = []

  for product in trending_products_qs:
    variant = product.variants.first()

    if variant:
      image_obj = variant.images.filter(is_primary=True).first() or variant.images.first()    
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
  return render(request, "Home/prebuilt.html")

def built(request):
  return render(request, "Home/pc.html")

def accessories(request):
    # 1. Fetch the base queryset (added 'brand' to prefetch for optimization)
    products_qs = Product.objects.all().prefetch_related('variants__images', 'category', 'brand')
    
    # 2. Handle Category Filtering
    category_param = request.GET.get('category')
    if category_param:
        if category_param.isdigit():
            products_qs = products_qs.filter(category__category_id=category_param)
        else:
            products_qs = products_qs.filter(category__category_name__icontains=category_param)

    # 3. Handle Search Query
    search_query = request.GET.get('q', '')
    if search_query:
        products_qs = products_qs.filter(product_name__icontains=search_query)

    # 4. Handle Brand Filtering (Captures multiple checkboxes)
    selected_brands = request.GET.getlist('brand')
    if selected_brands:
        products_qs = products_qs.filter(brand__brand_name__in=selected_brands)

    # 5. Handle Price Range Filtering
    # Find the absolute min and max prices across all accessories to set the slider bounds dynamically
    price_aggregates = ProductVariant.objects.aggregate(min_price=Min('price'), max_price=Max('price'))
    absolute_min = int(price_aggregates['min_price'] or 0)
    absolute_max = int(price_aggregates['max_price'] or 50000)

    # Get user's current slider positions (or default to absolute min/max)
    current_min = request.GET.get('min_price', absolute_min)
    current_max = request.GET.get('max_price', absolute_max)
    
    try:
        current_min = int(current_min)
        current_max = int(current_max)
    except ValueError:
        current_min = absolute_min
        current_max = absolute_max

    # Apply the price filter. We use .distinct() because filtering on a related model (variants) can cause duplicates.
    products_qs = products_qs.filter(
        variants__price__gte=current_min,
        variants__price__lte=current_max
    ).distinct()

   # 6. Map data for the template
    products_list = []
    for product in products_qs:
        variant = product.variants.first()
        if variant:
            # Grab all images for this variant
            all_imgs = variant.images.all()
            primary_image = all_imgs.filter(is_primary=True).first() or all_imgs.first()
            
            # Combine all image URLs into a comma-separated string
            img_urls = [img.image.url for img in all_imgs if img.image]
            all_images_str = ",".join(img_urls) if img_urls else ""

            # In views.py -> def accessories(request):
            products_list.append({
                'id': product.product_id,
                'variant_id': variant.variant_id,  # <-- ADD THIS
                'name': product.product_name,
                'category': product.category, 
                'price': variant.price,
                'image': primary_image.image if primary_image else None,
                'all_images_str': all_images_str,
            })

    # 7. Handle Sorting
    sort_param = request.GET.get('sort', 'pop')
    if sort_param == 'low':
        products_list.sort(key=lambda x: x['price'])
    elif sort_param == 'high':
        products_list.sort(key=lambda x: x['price'], reverse=True)

    # Fetch all categories and brands for the sidebar
    categories = Category.objects.all()
    brands = Brand.objects.all()

    context = {
        'products': products_list,
        'categories': categories,
        'brands': brands, # New
        'search_query': search_query,
        'current_sort': sort_param,
        'selected_category': category_param,
        'selected_brands': selected_brands, # New
        'absolute_min': absolute_min, # New
        'absolute_max': absolute_max, # New
        'current_min': current_min, # New
        'current_max': current_max, # New
    }
    
    return render(request, "Home/accessories.html", context)

def cart(request):
  user_id = request.session.get('user_id')

  # 1. HANDLE POST REQUESTS (Modifying the cart)
  if request.method == "POST":
      if not user_id:
          return JsonResponse({'status': 'error', 'message': 'Please login to add items.'})

      action = request.POST.get("action")
      
      try:
          user = User.objects.get(user_id=user_id)
          cart_obj, _ = Cart.objects.get_or_create(user=user)

          if action == "add":
              variant_id = request.POST.get("variant_id")
              quantity = int(request.POST.get("quantity", 1))
              variant = ProductVariant.objects.get(variant_id=variant_id)
              
              cart_item, created = CartItem.objects.get_or_create(
                  cart=cart_obj, 
                  variant=variant,
                  defaults={'quantity': quantity}
              )
              if not created:
                  cart_item.quantity += quantity
                  cart_item.save()

          elif action == "delete":
              cart_item_id = request.POST.get("cart_item_id")
              CartItem.objects.filter(cart_item_id=cart_item_id, cart=cart_obj).delete()

          elif action == "update":
              cart_item_id = request.POST.get("cart_item_id")
              update_type = request.POST.get("update_type") # 'increase' or 'decrease'
              
              cart_item = CartItem.objects.get(cart_item_id=cart_item_id, cart=cart_obj)
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

          # If it's an AJAX request (background JS), return JSON
          if request.headers.get('x-requested-with') == 'XMLHttpRequest':
              return JsonResponse({'status': 'success'})
          
          # If it's a standard HTML form, reload the cart page
          return redirect('core:cart')

      except Exception as e:
          if request.headers.get('x-requested-with') == 'XMLHttpRequest':
              return JsonResponse({'status': 'error', 'message': str(e)})
          print(f"Cart Error: {e}") 
          return redirect('core:cart')


  # 2. HANDLE GET REQUESTS (Displaying the cart)
  cart_items_data = []
  subtotal = Decimal('0.00')
  tax = Decimal('0.00')
  total = Decimal('0.00')
  cart_count = 0

  if user_id:
      try:
          user = User.objects.get(user_id=user_id)
          # Use prefetch_related to stop the database from screaming for mercy
          cart_obj = Cart.objects.prefetch_related('items__variant__product', 'items__variant__images').get(user=user)
          items = cart_obj.items.all()
          cart_count = items.count()
          
          for item in items:
              variant = item.variant
              product = variant.product
              item_total = variant.price * item.quantity
              subtotal += item_total
              
              primary_image = variant.images.filter(is_primary=True).first() or variant.images.first()
              
              cart_items_data.append({
                  'cart_item_id': item.cart_item_id,
                  'name': product.product_name,
                  'type': product.category.category_name,
                  'price': variant.price,
                  'quantity': item.quantity,
                  'item_total': item_total,
                  'image_url': primary_image.image.url if primary_image and primary_image.image else None
              })
              
          tax = round(subtotal * Decimal('0.18'), 2)
          total = subtotal + tax
          
      except Cart.DoesNotExist:
          pass # Empty cart

  context = {
      'cart_items': cart_items_data,
      'subtotal': subtotal,
      'tax': tax,
      'total': total,
      'cart_count': cart_count
  }
  
  return render(request, "Home/cart.html", context)

def profile(request):
  return render(request, "Home/pro_overview.html")

def pro_builds(request):
  return render(request, "Home/pro_my_builds.html")

def pro_order(request):
  return render(request, "Home/pro_order_history.html")

def pro_security(request):
  return render(request, "Home/pro_security.html")

def pro_setting(request):
  return render(request, "Home/pro_settings.html")

