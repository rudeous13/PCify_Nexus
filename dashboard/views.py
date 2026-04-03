from django.contrib.auth import authenticate, login, logout
from .decorators import admin_required
from django.shortcuts import render, redirect
from django.http import HttpResponseRedirect, HttpResponse
from django.db.utils import DatabaseError
from django.db import transaction
from django.http import JsonResponse
from django.forms.models import model_to_dict
from django.db.models import Q
from django.core.paginator import Paginator
from accounts.models import *
from builds.models import *
from inventory.models import *
from locations.models import *
from products.models import *
from orders.models import Order

import csv

import re


def safe_int(val, default=0):
    try:
        return int(val) if val else default
    except (ValueError, TypeError):
        return default


def safe_float(val, default=0.0):
    try:
        return float(val) if val else default
    except (ValueError, TypeError):
        return default


def safe_bool(val):
    return str(val) == '1'

# Create your views here.


def is_admin(user):
    return user.is_authenticated and user.is_staff

# 👑 Admin login page
# ------------------------------------


def admin_login(request):
    if request.user.is_authenticated and request.user.is_staff:
        return HttpResponseRedirect("dashboard/")

    if request.method == "POST":
        username = request.POST["username"]
        password = request.POST["password"]

        user = authenticate(request, username=username, password=password)

        if user and user.is_staff:
            login(request, user)
            return HttpResponseRedirect("dashboard/")
        else:
            message = {"error": "Invalide name and password."}
            return render(request, "AdminPage/admin_login.html", message)

    return render(request, "AdminPage/admin_login.html")

# --------------------------------------
# Mainmenu Section
# 🏠 dashboard of admin
# --------------------------------------


@admin_required
def dashboard_home(request):
    return render(request, "AdminPage/admin_home.html")

# --------------------------------------
# 👤 Users Section
# 👥 customers
# --------------------------------------


@admin_required
def dashboard_customers(request):
    user_list = User.objects.filter(role="customer")
    return render(request, "AdminPage/admin_customer.html", {"user_list": user_list})


# --------------------------------------
# 👤 Users Section
# 👨‍💻 Employee
# --------------------------------------
@admin_required
def dashboard_employees(request):
    context = {
        "employees": User.objects.filter(role="employee").prefetch_related('addresses__pincode'),
    }
    if request.method == "POST":
        action = request.POST.get("action")
        data = {
            "f_name": request.POST.get("first_name"),
            "l_name": request.POST.get("last_name"),
            "Email": request.POST.get("employee_email"),
            "PhoneNo": request.POST.get("employee_phone_no"),
            "password": request.POST.get("employe_password"),
            "image": request.FILES.get("image"),
            "street_address": request.POST.get("street_address"),
            "area_name": request.POST.get("area_name"),
            "pincode": request.POST.get("pincode"),
        }
        if action == "insert":

            errors = {}

            # -------------------- NAME VALIDATION --------------------
            if not data["f_name"].isalpha():
                errors.setdefault(
                    "fnameissue", "First name must contain letters only.")
            if not data["l_name"].isalpha():
                errors.setdefault(
                    "lnameissue", "Last name must contain letters only.")

            # -------------------- EMAIL VALIDATION --------------------
            email_pattern = r'^[\w\.-]+@[\w\.-]+\.\w+$'
            if not re.match(email_pattern, data["Email"]):
                errors.setdefault("emailissue", "Enter a valid email address.")
            else:
                allowed_domains = [
                    "gmail.com",
                    "yahoo.com",
                    "outlook.com",
                    "hotmail.com",
                ]
                domain = data["Email"].split("@")[-1].lower()
                if domain not in allowed_domains:
                    errors.setdefault(
                        "emailissue", "Email domain not allowed.")

            # -------------------- PHONE VALIDATION --------------------
            phone_pattern = r'^[6-9]\d{9}$'
            if not re.match(phone_pattern, data["PhoneNo"]):
                errors.setdefault(
                    "phoneissue", "Enter a valid 10-digit phone number starting with 6-9.")
            elif User.objects.filter(phone_number=data["PhoneNo"]).exists():
                errors.setdefault(
                    "phoneissue", "Phone number is already used.")

            # -------------------- EMAIL UNIQUENESS --------------------
            if User.objects.filter(email=data["Email"]).exists():
                errors.setdefault(
                    "emailissue", "E-mail address is already used.")

            # ---------------- PINCODE VALIDATION ----------------
            if not re.match(r'^\d{6}$', data["pincode"]):
                errors["pincodeissue"] = "Pincode must be 6 digits."

            # ---------------- AREA NAME VALIDATION ----------------
            if not re.match(r'^[A-Za-z\s]+$', data["area_name"]):
                errors["areaissue"] = "Area name must contain alphabets only."

            # -------------------- RETURN ERRORS IF ANY --------------------
            if errors:
                context.setdefault("errors", errors)
                return render(request, "AdminPage/admin_employee.html", context)

            # -------------------- CREATE User --------------------
            try:
                user = User.objects.create_user(
                    email=data["Email"],
                    password=data["password"],
                    first_name=data["f_name"],
                    last_name=data["l_name"],
                    phone_number=data["PhoneNo"],
                    role="employee",
                    profile_image=data["image"]
                )

                # ---------------- PINCODE CHECK ----------------
                pincode_obj = Pincode.objects.filter(
                    pincode=data["pincode"]).first()

                if not pincode_obj:
                    pincode_obj = Pincode.objects.create(
                        pincode=data["pincode"],
                        area_name=data["area_name"],
                        city="Ahmedabad"
                    )

                # ---------------- CREATE ADDRESS ----------------
                Address.objects.create(
                    user=user,
                    address=data["street_address"],
                    pincode=pincode_obj,
                    is_primary=False
                )

                context.setdefault("successful", "account is added.")
                return render(request, "AdminPage/admin_employee.html", context)
            except DatabaseError:
                context.setdefault("errors", "account is not added.")
                return render(request, "AdminPage/admin_employee.html", context)

        elif action == "update":
            emp_id = request.POST.get("emp_id")

            try:
                user = User.objects.get(user_id=emp_id)

                user.first_name = data["f_name"] or user.first_name
                user.last_name = data["l_name"] or user.last_name
                user.email = data["Email"] or user.email
                user.phone_number = data["PhoneNo"] or user.phone_number

                if data["image"]:
                    user.profile_image = data["image"]

                user.save()

                pincode_obj = Pincode.objects.filter(
                    pincode=data["pincode"]).first()
                if not pincode_obj:
                    pincode_obj = Pincode.objects.create(
                        pincode=data["pincode"],
                        area_name=data["area_name"],
                        city="Ahmedabad"
                    )

                Address.objects.update_or_create(
                    user=user,
                    defaults={
                        'address': data['street_address'],
                        'pincode': pincode_obj,
                        'is_primary': False
                    }
                )
                context["successful"] = "Employee updated successfully."

            except Exception:
                context["errors"] = "Employee Update Failed."

            return render(request, "AdminPage/admin_employee.html", context)

        elif action == "delete":
            emp_id = request.POST.get("emp_id")
            if emp_id:
                User.objects.filter(user_id=emp_id).delete()
            context["errors"] = "Employee profile is deleted."
            return render(request, "AdminPage/admin_employee.html", context)

    return render(request, "AdminPage/admin_employee.html", context)


# --------------------------------------
# 👤 Users Section
# 👨 Supplier
# --------------------------------------
@admin_required
def dashboard_suppliers(request):
    context = {
        "suppliers": Supplier.objects.all(),
    }

    if request.method == "POST":
        action = request.POST.get("action")

        data = {
            "sup_id": request.POST.get("sup_id"),
            "name": request.POST.get("owner_name"),
            "company": request.POST.get("company_name"),
            "phone": request.POST.get("sup_mobilenum"),
            "email": request.POST.get("sup_email"),
            "gst": request.POST.get("gst_number"),
            "addr1": request.POST.get("sup_addresh_primary"),
            "addr2": request.POST.get("sup_addresh_secondary"),
        }

        try:
            if action == "insert":
                Supplier.objects.create(
                    supplier_name=data["name"],
                    company_name=data["company"],
                    phone=data["phone"],
                    email=data["email"],
                    gst_no=data["gst"],
                    address_one=data["addr1"],
                    address_two=data["addr2"]
                )
                context["successful"] = "Supplier added successfully."

            elif action == "update":
                supplier = Supplier.objects.get(supplier_id=data['sup_id'])

                # Update fields using the "data or existing_value" pattern
                supplier.supplier_name = request.POST.get(
                    "owner_name") or supplier.supplier_name
                supplier.company_name = request.POST.get(
                    "company_name") or supplier.company_name
                supplier.email = request.POST.get(
                    "sup_email") or supplier.email
                supplier.phone = request.POST.get(
                    "sup_mobilenum") or supplier.phone
                supplier.gst_no = request.POST.get(
                    "gst_number") or supplier.gst_no
                supplier.address_one = request.POST.get(
                    "sup_addresh_primary") or supplier.address_one
                supplier.address_two = request.POST.get(
                    "sup_addresh_secondary") or supplier.address_two

                # Save the changes to the database
                supplier.save()

                context["successful"] = "Supplier updated successfully."

            elif action == "delete":
                Supplier.objects.filter(supplier_id=data["sup_id"]).delete()
                context["errors"] = "Supplier has been deleted."

        except Exception as e:
            context["errors"] = f"Operation failed: {str(e)}"

    return render(request, "AdminPage/admin_supplier.html", context)


# --------------------------------------
# 🧩 Managemet Section
# 💻💻 Product
# --------------------------------------
@admin_required
def dashboard_product(request):
    context = {
        "brand_list": Brand.objects.all(),
        "category_list": Category.objects.all(),
        "varint_list": ProductVariant.objects.select_related('product', 'product__brand', 'product__category', 'inventory').prefetch_related('images').all(),
        "image_list": ProductImage.objects.all().order_by("image_id"),
        "cup_list": CPU.objects.all(),
        "ram_list": RAM.objects.all(),
        "storage_list": Storage.objects.all(),
        "gpu_list": GPU.objects.all(),
        "cabinet_list": Cabinet.objects.all(),
        "motherboard_list": Motherboard.objects.all(),
        "psu_list": PSU.objects.all()
    }
    messages = {}

    if request.method == "POST":
        action = request.POST.get("action")
        if action == "insert":
            try:
                with transaction.atomic():  # 1. Guarantee Database Integrity
                    brand_obj = Brand.objects.get(
                        brand_id=request.POST.get('brand'))
                    category_obj = Category.objects.get(
                        category_id=request.POST.get('category'))

                    # 2. Get or Create Product
                    product, created = Product.objects.get_or_create(
                        product_name=request.POST.get("name", "").strip(),
                        brand=brand_obj,
                        category=category_obj,
                        defaults={
                            'warranty_months': safe_int(request.POST.get("warranty_month")),
                            'description': request.POST.get("description", "").strip(),
                        }
                    )

                    # 3. Create Variant
                    variant = ProductVariant.objects.create(
                        product=product,
                        variant_name=request.POST.get("v_name", "").strip(),
                        sku=request.POST.get("sku", "").strip(),
                        price=request.POST.get("price")
                    )

                    # Get stock, defaulting to 0 if empty or invalid
                    initial_stock = safe_int(request.POST.get("stock")) or 0

                    Inventory.objects.create(
                        variant=variant,
                        stock_quantity=initial_stock
                    )

                    # Only create a log if they actually added stock during creation
                    if initial_stock > 0:
                        InventoryLog.objects.create(
                            variant=variant,
                            quantity_change=initial_stock,
                            action='add',
                            reference_type='adjustment',  # Manual admin entry
                            reference_id=0  # 0 indicates it was a direct dashboard adjustment, not a PO
                        )

                    # 4. Insert Images
                    images = request.FILES.getlist("image_url")
                    for index, img in enumerate(images):
                        ProductImage.objects.create(
                            variant=variant,
                            image=img,
                            is_primary=(index == 0)
                        )

                    # 5. Insert Hardware Specific Data based on Category
                    cat_name = category_obj.category_name.lower()

                    if 'cpu' in cat_name:
                        CPU.objects.create(
                            variant=variant,
                            socket_type=request.POST.get('socket_type', ''),
                            cores=safe_int(request.POST.get('cores')),
                            threads=safe_int(request.POST.get('threads')),
                            base_clock=safe_float(
                                request.POST.get('base_clock')),
                            boost_clock=safe_float(
                                request.POST.get('boost_clock')),
                            integrated_graphics=safe_bool(
                                request.POST.get('integrated_graphics')),
                            tdp=safe_int(request.POST.get('tdp'))
                        )

                    elif 'ram' in cat_name:
                        RAM.objects.create(
                            variant=variant,
                            ram_type=request.POST.get('ram_type', 'DDR4'),
                            # Mapped from memory_size
                            capacity_gb=safe_int(
                                request.POST.get('memory_size')),
                            # Mapped from memory_speed
                            speed_mhz=safe_int(
                                request.POST.get('memory_speed')),
                            module_count=safe_int(
                                request.POST.get('module_count', 1)),
                            tdp=safe_int(request.POST.get('tdp'))
                        )

                    elif 'storage' in cat_name:
                        Storage.objects.create(
                            variant=variant,
                            storage_type=request.POST.get('storage_type', ''),
                            capacity_gb=safe_int(
                                request.POST.get('capacity_gb')),
                            interface_type=request.POST.get(
                                'interface_type', ''),
                            form_factor=request.POST.get('form_factor', ''),
                            tdp=safe_int(request.POST.get('tdp'))
                        )

                    elif 'gpu' in cat_name:
                        GPU.objects.create(
                            variant=variant,
                            memory_size=safe_int(
                                request.POST.get('memory_size')),
                            pcie_version=request.POST.get('pcie_version', ''),
                            length_mm=safe_int(request.POST.get('length_mm')),
                            interface_type=request.POST.get(
                                'interface_type', ''),
                            power_8pin_count=safe_int(
                                request.POST.get('power_8pin_count')),
                            power_6pin_count=safe_int(
                                request.POST.get('power_6pin_count')),
                            power_12vhpwr=safe_bool(
                                request.POST.get('power_12vhpwr')),
                            tdp=safe_int(request.POST.get('tdp'))
                        )

                    elif 'cabinet' in cat_name:
                        # Aggregate the checkboxes into a single string for the model
                        supported_ff = []
                        if request.POST.get('supported_atx'):
                            supported_ff.append("ATX")
                        if request.POST.get('supp_micro_atx'):
                            supported_ff.append("Micro-ATX")
                        if request.POST.get('supp_mini_itx'):
                            supported_ff.append("Mini-ITX")

                        Cabinet.objects.create(
                            variant=variant,
                            supported_form_factors=", ".join(supported_ff),
                            max_gpu_length_mm=safe_int(
                                request.POST.get('max_gpu_length')),
                            max_psu_length_mm=safe_int(
                                request.POST.get('max_psu_length')),
                            max_cooler_height_mm=safe_int(
                                request.POST.get('max_cooler_height'))
                        )

                    elif 'motherboard' in cat_name:
                        Motherboard.objects.create(
                            variant=variant,
                            socket_type=request.POST.get('socket_type', ''),
                            ram_type=request.POST.get('ram_type', 'DDR4'),
                            form_factor=request.POST.get('form_factor', 'ATX'),
                            # WARNING: You are missing this input in your HTML!
                            chipset=request.POST.get('chipset', 'Generic'),
                            m2_slots=safe_int(request.POST.get('m2_slots')),
                            sata_ports=safe_int(
                                request.POST.get('sata_ports')),
                            pcie_x1_slots=safe_int(
                                request.POST.get('pcie_x1_slots')),
                            pcie_x16_slots=safe_int(
                                request.POST.get('pcie_x16_slots')),
                            tdp=safe_int(request.POST.get('tdp'))
                        )

                    elif 'psu' in cat_name:
                        # Map your HTML 'is_modular' boolean to the Model's string choices
                        is_modular = request.POST.get('is_modular')
                        modularity_choice = 'FULL' if is_modular == '1' else 'NON'

                        PSU.objects.create(
                            variant=variant,
                            wattage=safe_int(request.POST.get('wattage')),
                            form_factor=request.POST.get('form_factor', 'ATX'),
                            efficiency_rating=request.POST.get(
                                'efficiency_rating', '80+ Bronze'),
                            modularity=modularity_choice,
                            length_mm=safe_int(request.POST.get('length_mm')),
                            power_8pin_count=safe_int(
                                request.POST.get('power_8pin_count')),
                            power_6pin_count=safe_int(
                                request.POST.get('power_6pin_count')),
                            power_12vhpwr=safe_bool(
                                request.POST.get('power_12vhpwr'))
                        )

                    messages["successful"] = "Product and specifications added successfully."
                    return redirect("dashboard:product")

            except Exception as e:
                messages["errors"] = f"Failed to add product: {str(e)}"
                context.update(messages)
                return render(request, "AdminPage/admin_products.html", context)

        elif action == "delete":
            variant_id = request.POST.get("variant_id")
            if variant_id:
                variant = ProductVariant.objects.filter(
                    variant_id=variant_id).first()
                if variant:
                    product = variant.product
                    variant.delete()

                    if not product.variants.exists():
                        product.delete()

            return redirect("dashboard:product")

        elif action == "update":
            try:
                with transaction.atomic():
                    variant_id = request.POST.get("variant_id")
                    product_id = request.POST.get("product_id")

                    # 1. Fetch Existing Records
                    variant = ProductVariant.objects.get(variant_id=variant_id)
                    product = Product.objects.get(product_id=product_id)

                    # 2. Update Product Level Data
                    product.product_name = request.POST.get(
                        "name", product.product_name).strip()
                    product.brand_id = request.POST.get("brand")

                    # Check if category changed
                    old_category_id = product.category_id
                    new_category_id = request.POST.get("category")
                    product.category_id = new_category_id

                    product.warranty_months = safe_int(request.POST.get(
                        "warranty_month", product.warranty_months))
                    product.description = request.POST.get(
                        "description", product.description).strip()
                    product.save()

                    # 3. Update Variant Level Data
                    variant.variant_name = request.POST.get(
                        "v_name", variant.variant_name).strip()
                    # Note: Only update SKU if you allow it to change, otherwise keep it static.
                    sku_input = request.POST.get("sku", "").strip()
                    if sku_input:
                        variant.sku = sku_input
                    variant.price = safe_float(
                        request.POST.get("price", variant.price))
                    # Note: If you add a stock field to ProductVariant later, update it here.
                    variant.save()

                    new_stock = safe_int(request.POST.get("stock")) or 0

                    # get_or_create just in case older products don't have an inventory record yet
                    inventory, inv_created = Inventory.objects.get_or_create(
                        variant=variant,
                        defaults={'stock_quantity': 0}
                    )

                    # Check if the stock actually changed
                    if inventory.stock_quantity != new_stock:
                        qty_diff = new_stock - inventory.stock_quantity

                        # Determine if we added or removed stock
                        action_type = 'add' if qty_diff > 0 else 'remove'

                        InventoryLog.objects.create(
                            variant=variant,
                            # Log always takes absolute value
                            quantity_change=abs(qty_diff),
                            action=action_type,
                            reference_type='adjustment',
                            reference_id=0
                        )

                        # Save the new total to the inventory
                        inventory.stock_quantity = new_stock
                        inventory.save()

                    # 4. Update Dynamic Hardware Specs
                    category_obj = Category.objects.get(
                        category_id=new_category_id)
                    cat_name = category_obj.category_name.lower()

                    # If the category was changed, ideally you should delete the old spec record here to prevent orphan data.
                    # For example: if 'cpu' in cat_name and old_category_id != new_category_id: ...

                    if 'cpu' in cat_name:
                        CPU.objects.update_or_create(variant=variant, defaults={
                            'socket_type': request.POST.get('socket_type', ''),
                            'cores': safe_int(request.POST.get('cores')),
                            'threads': safe_int(request.POST.get('threads')),
                            'base_clock': safe_float(request.POST.get('base_clock')),
                            'boost_clock': safe_float(request.POST.get('boost_clock')),
                            'integrated_graphics': safe_bool(request.POST.get('integrated_graphics')),
                            'tdp': safe_int(request.POST.get('tdp'))
                        })

                    elif 'ram' in cat_name:
                        RAM.objects.update_or_create(variant=variant, defaults={
                            'ram_type': request.POST.get('ram_type', 'DDR4'),
                            'capacity_gb': safe_int(request.POST.get('memory_size')),
                            'speed_mhz': safe_int(request.POST.get('memory_speed')),
                            'module_count': safe_int(request.POST.get('module_count', 1)),
                            'tdp': safe_int(request.POST.get('tdp'))
                        })

                    elif 'storage' in cat_name:
                        Storage.objects.update_or_create(variant=variant, defaults={
                            'storage_type': request.POST.get('storage_type', ''),
                            'capacity_gb': safe_int(request.POST.get('capacity_gb')),
                            'interface_type': request.POST.get('interface_type', ''),
                            'form_factor': request.POST.get('form_factor', ''),
                            'tdp': safe_int(request.POST.get('tdp'))
                        })

                    elif 'gpu' in cat_name:
                        GPU.objects.update_or_create(variant=variant, defaults={
                            'memory_size': safe_int(request.POST.get('memory_size')),
                            'pcie_version': request.POST.get('pcie_version', ''),
                            'length_mm': safe_int(request.POST.get('length_mm')),
                            'interface_type': request.POST.get('interface_type', ''),
                            'power_8pin_count': safe_int(request.POST.get('power_8pin_count')),
                            'power_6pin_count': safe_int(request.POST.get('power_6pin_count')),
                            'power_12vhpwr': safe_bool(request.POST.get('power_12vhpwr')),
                            'tdp': safe_int(request.POST.get('tdp'))
                        })

                    elif 'cabinet' in cat_name:
                        supported_ff = []
                        if request.POST.get('supported_atx'):
                            supported_ff.append("ATX")
                        if request.POST.get('supp_micro_atx'):
                            supported_ff.append("Micro-ATX")
                        if request.POST.get('supp_mini_itx'):
                            supported_ff.append("Mini-ITX")

                        Cabinet.objects.update_or_create(variant=variant, defaults={
                            'supported_form_factors': ", ".join(supported_ff),
                            'max_gpu_length_mm': safe_int(request.POST.get('max_gpu_length')),
                            'max_psu_length_mm': safe_int(request.POST.get('max_psu_length')),
                            'max_cooler_height_mm': safe_int(request.POST.get('max_cooler_height'))
                        })

                    elif 'motherboard' in cat_name:
                        Motherboard.objects.update_or_create(variant=variant, defaults={
                            'socket_type': request.POST.get('socket_type', ''),
                            'ram_type': request.POST.get('ram_type', 'DDR4'),
                            'form_factor': request.POST.get('form_factor', 'ATX'),
                            'chipset': request.POST.get('chipset', 'Generic'),
                            'm2_slots': safe_int(request.POST.get('m2_slots')),
                            'sata_ports': safe_int(request.POST.get('sata_ports')),
                            'pcie_x1_slots': safe_int(request.POST.get('pcie_x1_slots')),
                            'pcie_x16_slots': safe_int(request.POST.get('pcie_x16_slots')),
                            'tdp': safe_int(request.POST.get('tdp'))
                        })

                    elif 'psu' in cat_name:
                        is_modular = request.POST.get('is_modular')
                        modularity_choice = 'FULL' if str(
                            is_modular) == '1' else 'NON'

                        PSU.objects.update_or_create(variant=variant, defaults={
                            'wattage': safe_int(request.POST.get('wattage')),
                            'form_factor': request.POST.get('form_factor', 'ATX'),
                            'efficiency_rating': request.POST.get('efficiency_rating', '80+ Bronze'),
                            'modularity': modularity_choice,
                            'length_mm': safe_int(request.POST.get('length_mm')),
                            'power_8pin_count': safe_int(request.POST.get('power_8pin_count')),
                            'power_6pin_count': safe_int(request.POST.get('power_6pin_count')),
                            'power_12vhpwr': safe_bool(request.POST.get('power_12vhpwr'))
                        })

                    # 5. Handle Deleted Images
                    deleted_images = request.POST.get("deleted_images", "")
                    if deleted_images:
                        # Split the comma-separated string into a list of IDs and delete them
                        image_ids_to_delete = [
                            int(img_id) for img_id in deleted_images.split(',') if img_id.isdigit()]
                        ProductImage.objects.filter(
                            image_id__in=image_ids_to_delete, variant=variant).delete()

                    # 6. Handle New Images Uploaded during edit
                    new_images = request.FILES.getlist("new_images")
                    for img in new_images:
                        # By default, add new images as non-primary. You can add logic to make it primary if no images exist.
                        is_first = not ProductImage.objects.filter(
                            variant=variant).exists()
                        ProductImage.objects.create(
                            variant=variant,
                            image=img,
                            is_primary=is_first
                        )

                    messages["successful"] = "Product updated successfully."
                    return redirect("dashboard:product")

            except Exception as e:
                messages["errors"] = f"Update failed: {str(e)}"
                context.update(messages)
                return render(request, "AdminPage/admin_products.html", context)

    return render(request, "AdminPage/admin_products.html", context)


# --------------------------------------
# 🧩 Managemet Section
# 🍎🍎 dashboard of brand
# --------------------------------------
@admin_required
def dashboard_brand(request):

    context = {
        "brand_list": Brand.objects.all(),
    }

    if request.method == "POST":
        action = request.POST.get("action")

        try:
            if action == "insert":
                brand_name = request.POST.get("brand_name")
                if brand_name:
                    Brand.objects.create(brand_name=brand_name)

            elif action == "delete":
                Brand.objects.filter(
                    brand_id=request.POST.get("brand_id")).delete()

            elif action == "update":
                brand_id = request.POST.get("brand_id")
                brand_name = request.POST.get("brand_name")

                Brand.objects.filter(brand_id=brand_id).update(
                    brand_name=brand_name)

        except Exception as e:
            context["errors"] = f"Operation failed: {str(e)}"

    return render(request, "AdminPage/admin_brand.html", context)


# --------------------------------------
# 🧩 Managemet Section
# 📄📄 Category
# --------------------------------------
@admin_required
def dashboard_category(request):

    context = {
        "category_list": Category.objects.all().order_by("category_id"),
    }

    if request.method == "POST":
        action = request.POST.get("action")

        try:
            if action == "insert":
                category_name = request.POST.get("category_name")
                if category_name:
                    Category.objects.create(category_name=category_name)
            elif action == "delete":
                Category.objects.filter(
                    category_id=request.POST.get("category_id")).delete()

            elif action == "update":
                category_id = request.POST.get("category_id")
                category_name = request.POST.get("category_name")

                Category.objects.filter(category_id=category_id).update(
                    category_name=category_name)

        except Exception as e:
            context["errors"] = f"Operation failed: {str(e)}"

    category_list = Category.objects.all().order_by("category_id")
    return render(request, "AdminPage/admin_category.html", {"category_list": category_list})


# --------------------------------------
# 🧩 Managemet Section
# 📦📦 Order
# --------------------------------------
@admin_required
def dashboard_order(request):
    context = {}

    if request.method == "POST":
        action = request.POST.get("action")

        if action == "update_status":
            order_id = request.POST.get("order_id")
            new_status = (request.POST.get("status") or "").strip().lower()
            allowed_statuses = {"pending", "processing",
                                "shipped", "completed", "cancelled"}

            if order_id and new_status in allowed_statuses:
                updated = Order.objects.filter(
                    order_id=order_id).update(status=new_status)
                if updated:
                    context["successful"] = "Order status updated."
                else:
                    context["errors"] = "Order not found."
            else:
                context["errors"] = "Invalid status update."

        elif request.POST.get("apply_bulk_action") is not None:
            bulk_action = request.POST.get("bulk_action")
            order_ids = request.POST.getlist("order_ids")

            if order_ids:
                if bulk_action == "delete":
                    Order.objects.filter(order_id__in=order_ids).delete()
                    context["successful"] = "Selected orders deleted."
                elif bulk_action == "mark_completed":
                    Order.objects.filter(order_id__in=order_ids).update(
                        status="completed")
                    context["successful"] = "Selected orders marked completed."
                elif bulk_action == "mark_processing":
                    Order.objects.filter(order_id__in=order_ids).update(
                        status="processing")
                    context["successful"] = "Selected orders marked processing."
                else:
                    context["errors"] = "No bulk action selected."
            else:
                context["errors"] = "No orders selected."

    orders_qs = (
        Order.objects.select_related("user", "address", "address__pincode")
        .prefetch_related("items__variant__product")
        .all()
    )

    search_query = (request.GET.get("search") or "").strip()
    if search_query:
        if search_query.isdigit():
            orders_qs = orders_qs.filter(order_id=int(search_query))
        else:
            orders_qs = orders_qs.filter(
                Q(user__first_name__icontains=search_query)
                | Q(user__last_name__icontains=search_query)
                | Q(user__email__icontains=search_query)
            )

    status_filter = (request.GET.get("status") or "").strip()
    if status_filter and status_filter.lower() != "all":
        orders_qs = orders_qs.filter(status=status_filter.lower())

    sort_by = request.GET.get("sort")
    if sort_by == "oldest":
        orders_qs = orders_qs.order_by("created_at")
    elif sort_by == "amount_high":
        orders_qs = orders_qs.order_by("-total_amount")
    else:
        orders_qs = orders_qs.order_by("-created_at")

    if request.GET.get("export") == "csv":
        response = HttpResponse(content_type="text/csv")
        response["Content-Disposition"] = "attachment; filename=orders.csv"
        writer = csv.writer(response)
        writer.writerow(["Order ID", "Customer", "Email",
                        "Status", "Total", "Date"])
        for order in orders_qs:
            full_name = f"{order.user.first_name or ''} {order.user.last_name or ''}".strip(
            )
            writer.writerow([
                order.order_id,
                full_name or order.user.email,
                order.user.email,
                order.status,
                order.total_amount,
                order.created_at.strftime("%Y-%m-%d"),
            ])
        return response

    total_orders_count = Order.objects.count()
    pending_orders_count = Order.objects.filter(status="pending").count()
    completed_orders_count = Order.objects.filter(status="completed").count()
    cancelled_orders_count = Order.objects.filter(status="cancelled").count()

    paginator = Paginator(orders_qs, 10)
    page_number = request.GET.get("page")
    orders_page = paginator.get_page(page_number)

    for order in orders_page:
        full_name = f"{order.user.first_name or ''} {order.user.last_name or ''}".strip()
        order.customer_name = full_name or order.user.email
        order.customer_email = order.user.email

        address_parts = [order.address.address]
        if order.address.pincode:
            address_parts.append(order.address.pincode.area_name)
            address_parts.append(str(order.address.pincode.pincode))
        order.shipping_address = ", ".join([p for p in address_parts if p])
        order.tracking_number = ""

        display_status = order.status.capitalize()
        order.status = display_status

        for item in order.items.all():
            if item.variant and item.variant.product:
                item.product_name = item.variant.product.product_name
            item.price = item.unit_price

    context.update({
        "orders": orders_page,
        "total_orders_count": total_orders_count,
        "pending_orders_count": pending_orders_count,
        "completed_orders_count": completed_orders_count,
        "cancelled_orders_count": cancelled_orders_count,
    })

    return render(request, "AdminPage/admin_order.html", context)


# --------------------------------------
# 🧩 Managemet Section
# 🗄️🗄️ Task management
# --------------------------------------
@admin_required
def dashboard_task(request):
    return render(request, "AdminPage/admin_emp_management.html")


# --------------------------------------
# 🧩 Managemet Section
# 📥📥  Inventory management
# --------------------------------------
@admin_required
def dashboard_inventory(request):
    context = {}

    # --- 1. HANDLE POST (STOCK UPDATE) ---
    if request.method == "POST":
        variant_id = request.POST.get("product_id")
        adj_type = request.POST.get("adjustment_type")
        qty = safe_int(request.POST.get("quantity"))
        # Grab the new supplier field
        supplier_id = request.POST.get("supplier_id")

        try:
            with transaction.atomic():
                variant = ProductVariant.objects.get(variant_id=variant_id)
                inventory, created = Inventory.objects.get_or_create(
                    variant=variant, defaults={'stock_quantity': 0})

                if adj_type == 'add':
                    inventory.stock_quantity += qty
                elif adj_type == 'remove':
                    if inventory.stock_quantity < qty:
                        raise ValueError(
                            "Cannot remove more stock than currently available.")
                    inventory.stock_quantity -= qty

                inventory.save()

                # --- SMART REFERENCE LOGIC ---
                ref_type = 'adjustment'
                ref_id = 0

                if supplier_id:
                    # If a supplier is selected, map it to your model's REFERENCE_TYPES
                    if adj_type == 'add':
                        ref_type = 'purchase_order'
                        ref_id = safe_int(supplier_id)
                    elif adj_type == 'remove':
                        ref_type = 'return'  # Logically returning stock to a supplier
                        ref_id = safe_int(supplier_id)

                InventoryLog.objects.create(
                    variant=variant,
                    quantity_change=qty,
                    action=adj_type,
                    reference_type=ref_type,
                    reference_id=ref_id
                )
                context["successful"] = f"Stock updated for {variant.product.product_name}."

        except ProductVariant.DoesNotExist:
            context["errors"] = "Product Variant not found."
        except ValueError as e:
            context["errors"] = str(e)
        except Exception as e:
            context["errors"] = f"Failed to update stock: {str(e)}"

    # --- 2. FETCH DATA (GET) ---
    # Fetch active suppliers to populate the dropdown
    context["suppliers"] = Supplier.objects.filter(is_active=True)

    inventory_items = Inventory.objects.select_related(
        'variant',
        'variant__product',
        'variant__product__brand',
        'variant__product__category'
    ).all()

    inventory_data = []
    for inv in inventory_items:
        latest_log = InventoryLog.objects.filter(
            variant=inv.variant).order_by('-created_at').first()
        img_obj = inv.variant.images.filter(
            is_primary=True).first() or inv.variant.images.first()

        inventory_data.append({
            'variant_id': inv.variant.variant_id,
            'product_name': f"{inv.variant.product.product_name} ({inv.variant.variant_name})",
            'brand_name': inv.variant.product.brand.brand_name if inv.variant.product.brand else "N/A",
            'category_name': inv.variant.product.category.category_name if inv.variant.product.category else "N/A",
            'stock': inv.stock_quantity,
            'last_action_type': latest_log.action if latest_log else 'setup',
            'last_action_qty': latest_log.quantity_change if latest_log else 0,
            'last_action_date': latest_log.created_at if latest_log else None,
            'image_url': img_obj.image.url if (img_obj and img_obj.image) else None
        })

    context["inventory_data"] = inventory_data
    return render(request, "AdminPage/admin_inventory.html", context)

# --------------------------------------
# 🧩 Managemet Section
# 💹💹 Trenging
# --------------------------------------


@admin_required
def dashboard_trending(request):
    context = {}

    # 1. Handle Add/Remove POST Requests
    if request.method == "POST":
        product_id = request.POST.get("product_id")
        # Convert the string "true"/"false" from your hidden input to a Python boolean
        is_trending_flag = request.POST.get("is_trending") == "true"

        try:
            product = Product.objects.get(product_id=product_id)
            product.is_trending = is_trending_flag
            product.save()

            if is_trending_flag:
                context["successful"] = f"Successfully added {product.product_name} to Trending."
            else:
                context["errors"] = f"Removed {product.product_name} from Trending."
        except Product.DoesNotExist:
            context["errors"] = "Product not found."
        except Exception as e:
            context["errors"] = f"An error occurred: {str(e)}"

    # 2. Fetch Data for the Template Dropdowns and Tables
    context["brand_list"] = Brand.objects.all()
    context["category_list"] = Category.objects.all()

    # Prefetch variants and their images to prevent N+1 database query lag
    context["product_data"] = Product.objects.select_related(
        'brand', 'category'
    ).prefetch_related('variants__images').all()

    return render(request, "AdminPage/admin_trending.html", context)


# --------------------------------------
# 🧩 Managemet Section
# ⚒️⚒️ per_built
# --------------------------------------
@admin_required
def dashboard_per_built(request):
    context = {}

    if request.method == "POST":
        action = request.POST.get("action")

        try:
            with transaction.atomic():
                if action == "insert":
                    build = PCBuild.objects.create(
                        user=request.user,
                        name=request.POST.get("name"),
                        price=safe_float(request.POST.get("price")),
                        description=request.POST.get("description", "").strip()
                    )

                    if request.FILES.get("image_url"):
                        build.image_url = request.FILES.get("image_url")
                        build.save()

                    # Map the HTML select names to the component_type stored in DB
                    components = {
                        'cpu': request.POST.get('cpu_id'),
                        'mobo': request.POST.get('mobo_id'),
                        'gpu': request.POST.get('gpu_id'),
                        'ram': request.POST.get('ram_id'),
                        'm2': request.POST.get('m2_id'),
                        'ssd': request.POST.get('ssd_id'),
                        'hdd': request.POST.get('hdd_id'),
                        'psu': request.POST.get('psu_id'),
                        'cabinet': request.POST.get('cabinet_id'),
                    }

                    for comp_type, variant_id in components.items():
                        if variant_id:  # Only save if a component was actually selected
                            PCBuildItem.objects.create(
                                build=build,
                                variant=ProductVariant.objects.get(
                                    variant_id=variant_id),
                                component_type=comp_type
                            )

                    context["successful"] = "Pre-Built PC created successfully."

                elif action == "update":
                    pc_id = request.POST.get("pc_id")
                    build = PCBuild.objects.get(build_id=pc_id)

                    build.name = request.POST.get("name", build.name).strip()
                    build.price = safe_float(
                        request.POST.get("price", build.price))
                    build.description = request.POST.get(
                        "description", build.description).strip()

                    if request.FILES.get("image_url"):
                        build.image_url = request.FILES.get("image_url")

                    build.save()

                    # Wipe existing items and recreate them to ensure a clean update state
                    build.items.all().delete()

                    components = {
                        'cpu': request.POST.get('cpu_id'),
                        'mobo': request.POST.get('mobo_id'),
                        'gpu': request.POST.get('gpu_id'),
                        'ram': request.POST.get('ram_id'),
                        'm2': request.POST.get('m2_id'),
                        'ssd': request.POST.get('ssd_id'),
                        'hdd': request.POST.get('hdd_id'),
                        'psu': request.POST.get('psu_id'),
                        'cabinet': request.POST.get('cabinet_id'),
                    }

                    for comp_type, variant_id in components.items():
                        if variant_id:
                            PCBuildItem.objects.create(
                                build=build,
                                variant=ProductVariant.objects.get(
                                    variant_id=variant_id),
                                component_type=comp_type
                            )

                    context["successful"] = "Pre-Built PC updated successfully."

                elif action == "delete":
                    pc_id = request.POST.get("pc_id")
                    PCBuild.objects.filter(build_id=pc_id).delete()
                    context["successful"] = "Pre-Built PC deleted successfully."

        except Exception as e:
            context["errors"] = f"Operation failed: {str(e)}"

    # -------------------------------------------------------------------
    # GET REQUEST: PREPARE CONTEXT DATA
    # -------------------------------------------------------------------

    # Helper function to match the exact variable structure your HTML expects
    # Your HTML uses {{ item.product_id }} and {{ item.product_name }}
    def format_variants(queryset):
        return [{'product_id': v.variant_id, 'product_name': f"{v.product.product_name} ({v.variant_name})"} for v in queryset]

    context['cpu_list'] = format_variants(ProductVariant.objects.filter(
        product__category__category_name__icontains='cpu'))
    context['mobo_list'] = format_variants(ProductVariant.objects.filter(
        product__category__category_name__icontains='motherboard'))
    context['gpu_list'] = format_variants(ProductVariant.objects.filter(
        product__category__category_name__icontains='gpu'))
    context['ram_list'] = format_variants(ProductVariant.objects.filter(
        product__category__category_name__icontains='ram'))

    # Advanced Storage Splitting:

    # ---------------------------------------------------------
    # BULLETPROOF STORAGE SPLITTING
    # ---------------------------------------------------------

    # 1. Find M.2 NVMe Drives
    m2_variants = ProductVariant.objects.filter(
        Q(storage_specs__form_factor__icontains='m.2') |
        Q(storage_specs__form_factor__icontains='nvme') |
        Q(product__product_name__icontains='m.2') |
        Q(product__product_name__icontains='nvme') |
        Q(variant_name__icontains='m.2') |
        Q(variant_name__icontains='nvme') |
        Q(product__category__category_name__icontains='m.2') |
        Q(product__category__category_name__icontains='nvme')
    ).distinct()
    context['m2_list'] = format_variants(m2_variants)

    # 2. Find Hard Drives (HDDs)
    hdd_variants = ProductVariant.objects.filter(
        Q(storage_specs__storage_type__icontains='hdd') |
        Q(storage_specs__storage_type__icontains='hard drive') |
        Q(product__product_name__icontains='hdd') |
        Q(product__product_name__icontains='hard drive') |
        Q(variant_name__icontains='hdd') |
        Q(product__category__category_name__icontains='hdd') |
        Q(product__category__category_name__icontains='hard drive')
    ).distinct()
    context['hdd_list'] = format_variants(hdd_variants)

    # 3. Find SATA SSDs (Anything labeled SSD/Storage that is NOT already caught as M.2 or HDD)
    # Grab the IDs of what we already found so we don't duplicate them
    m2_ids = list(m2_variants.values_list('variant_id', flat=True))
    hdd_ids = list(hdd_variants.values_list('variant_id', flat=True))

    ssd_variants = ProductVariant.objects.filter(
        Q(storage_specs__storage_type__icontains='ssd') |
        Q(storage_specs__storage_type__icontains='sata') |
        Q(product__product_name__icontains='ssd') |
        Q(variant_name__icontains='ssd') |
        Q(product__category__category_name__icontains='ssd') |
        Q(product__category__category_name__icontains='storage')
    ).exclude(
        # Safely exclude the M.2 and HDD items
        variant_id__in=(m2_ids + hdd_ids)
    ).distinct()

    context['ssd_list'] = format_variants(ssd_variants)

    context['psu_list'] = format_variants(ProductVariant.objects.filter(
        product__category__category_name__icontains='psu'))
    context['cabinet_list'] = format_variants(ProductVariant.objects.filter(
        product__category__category_name__icontains='cabinet'))

    # Fetch active Pre-Built PCs and structure them for the frontend table
    builds = PCBuild.objects.prefetch_related('items__variant__product').all()
    prebuilt_pcs = []

    for build in builds:
        pc_data = {
            'id': build.build_id,
            'name': build.name,
            'price': build.price,
            'description': build.description,
            'image_url': build.image_url,
        }

        # Map the relational items to flat keys so the template can easily access `pc.cpu.product_name`, `pc.gpu_id`, etc.
        for item in build.items.all():
            comp = item.component_type
            pc_data[f'{comp}_id'] = item.variant.variant_id
            pc_data[f'{comp}'] = {
                'product_name': f"{item.variant.product.product_name} ({item.variant.variant_name})"
            }

        prebuilt_pcs.append(pc_data)

    context['prebuilt_pcs'] = prebuilt_pcs

    return render(request, "AdminPage/admin_prebuiltpc.html", context)


# --------------------------------------
# 🧩 System Section
# 📊 Analytic
# --------------------------------------
@admin_required
def admin_analytic(request):
    return render(request, "AdminPage/admin_analytic.html")


# --------------------------------------
# 🧩 System Section
# ⚙️ Setting
# --------------------------------------
@admin_required
def admin_setting(request):
    return render(request, "AdminPage/admin_setting.html")


# --------------------------------------
# 🧩 System Section
# 📵 Admin logout view
# --------------------------------------
@admin_required
def admin_logout(request):
    logout(request)
    return render(request, "AdminPage/admin_login.html")


# AJAX
@admin_required
def get_variant_specs(request, variant_id):
    """
    AJAX endpoint to fetch the specific hardware specs for a given variant.
    Used to populate the 'Edit Product' modal.
    """
    variant = ProductVariant.objects.select_related(
        'product__category').filter(variant_id=variant_id).first()

    if not variant:
        return JsonResponse({'error': 'Variant not found'}, status=404)

    cat_name = variant.product.category.category_name.lower()
    spec_data = {}

    # Fetch the correct related spec model based on category
    try:
        if 'cpu' in cat_name and hasattr(variant, 'cpu_specs'):
            spec_data = model_to_dict(variant.cpu_specs)
        elif 'ram' in cat_name and hasattr(variant, 'ram_specs'):
            spec_data = model_to_dict(variant.ram_specs)
        elif 'storage' in cat_name and hasattr(variant, 'storage_specs'):
            spec_data = model_to_dict(variant.storage_specs)
        elif 'gpu' in cat_name and hasattr(variant, 'gpu_specs'):
            spec_data = model_to_dict(variant.gpu_specs)
        elif 'motherboard' in cat_name and hasattr(variant, 'motherboard_specs'):
            spec_data = model_to_dict(variant.motherboard_specs)
        elif 'psu' in cat_name and hasattr(variant, 'psu_specs'):
            spec_data = model_to_dict(variant.psu_specs)
        elif 'cabinet' in cat_name and hasattr(variant, 'cabinet_specs'):
            spec_data = model_to_dict(variant.cabinet_specs)

            # Special handling for Cabinet checkboxes
            if 'supported_form_factors' in spec_data:
                ff = spec_data['supported_form_factors']
                spec_data['supported_atx'] = "1" if "ATX" in ff else "0"
                spec_data['supp_micro_atx'] = "1" if "Micro-ATX" in ff else "0"
                spec_data['supp_mini_itx'] = "1" if "Mini-ITX" in ff else "0"
    except Exception as e:
        print(f"Error fetching specs: {e}")

    # Clean up internal Django fields before sending
    spec_data.pop('id', None)
    spec_data.pop('variant', None)

    return JsonResponse(spec_data)
