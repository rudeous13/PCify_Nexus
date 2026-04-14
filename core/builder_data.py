import re

from django.db.models import Q

from products.models import CPU, Cabinet, Cooler, GPU, Motherboard, PSU, RAM, Storage, ProductVariant


BASE_SYSTEM_POWER_WATTS = 50


def _variant_display_name(variant):
    brand_name = variant.product.brand.brand_name if variant.product.brand_id else ""
    product_name = variant.product.product_name
    base_name = " ".join(part for part in [brand_name, product_name] if part).strip()
    if variant.variant_name:
        return f"{base_name} ({variant.variant_name})"
    return base_name


def _variant_image_url(variant):
    image = variant.primary_image
    if image and image.image:
        try:
            return image.image.url
        except ValueError:
            return None
    return None


def _money(value):
    return float(value or 0)


def _normalize_form_factor(value):
    text = (value or "").strip().upper()
    aliases = {
        "MICRO-ATX": "MATX",
        "MICRO ATX": "MATX",
        "MINI-ITX": "ITX",
        "MINI ITX": "ITX",
    }
    return aliases.get(text, text)


def _split_csv(value):
    return [part.strip() for part in (value or "").split(",") if part.strip()]


def _variant_search_text(variant):
    return " ".join(
        [
            variant.product.category.category_name if variant.product.category_id else "",
            variant.product.product_name or "",
            variant.variant_name or "",
            variant.product.brand.brand_name if variant.product.brand_id else "",
        ]
    ).lower()


def _infer_socket_from_text(text):
    upper_text = (text or "").upper()
    known_sockets = [
        "AM5",
        "AM4",
        "LGA1851",
        "LGA1700",
        "LGA1200",
        "LGA1151",
        "TR4",
        "STRX4",
    ]
    for socket in known_sockets:
        if socket in upper_text:
            return socket
    return ""


def _infer_ram_type_from_text(text):
    upper_text = (text or "").upper()
    if "DDR5" in upper_text:
        return "DDR5"
    if "DDR4" in upper_text:
        return "DDR4"
    return ""


def _infer_form_factor_from_text(text):
    upper_text = (text or "").upper()
    if "MICRO-ATX" in upper_text or "M-ATX" in upper_text or "MATX" in upper_text:
        return "MATX"
    if "MINI-ITX" in upper_text or "MITX" in upper_text or "ITX" in upper_text:
        return "ITX"
    if "ATX" in upper_text:
        return "ATX"
    return "ATX"


def _extract_number(text, pattern, default=0):
    match = re.search(pattern, text or "", re.IGNORECASE)
    if not match:
        return default
    try:
        return int(match.group(1))
    except (TypeError, ValueError):
        return default


def _cpu_score(spec):
    boost_clock = float(spec.boost_clock or 0)
    base_clock = float(spec.base_clock or 0)
    return int((spec.cores * 120) + (spec.threads * 35) + (boost_clock * 180) + (base_clock * 60))


def _gpu_score(spec):
    return int((spec.memory_size * 28) + ((spec.tdp or 0) * 2) + ((spec.length_mm or 0) * 0.2))


def _serialize_cpu(spec):
    return {
        "id": spec.variant.variant_id,
        "name": _variant_display_name(spec.variant),
        "price": _money(spec.variant.price),
        "image": _variant_image_url(spec.variant),
        "socket": spec.socket_type,
        "power_draw": spec.tdp or 0,
        "score": _cpu_score(spec),
        "cores": spec.cores,
        "threads": spec.threads,
        "boost_clock": float(spec.boost_clock or 0),
    }


def _serialize_motherboard(spec):
    return {
        "id": spec.variant.variant_id,
        "name": _variant_display_name(spec.variant),
        "price": _money(spec.variant.price),
        "image": _variant_image_url(spec.variant),
        "socket": spec.socket_type,
        "ram_type": spec.ram_type,
        "form_factor": _normalize_form_factor(spec.form_factor),
        "power_draw": spec.tdp or 0,
        "chipset": spec.chipset,
        "m2_slots": spec.m2_slots,
        "sata_ports": spec.sata_ports,
        "pcie_x1_slots": spec.pcie_x1_slots,
        "pcie_x16_slots": spec.pcie_x16_slots,
    }


def _serialize_gpu(spec):
    return {
        "id": spec.variant.variant_id,
        "name": _variant_display_name(spec.variant),
        "price": _money(spec.variant.price),
        "image": _variant_image_url(spec.variant),
        "power_draw": spec.tdp or 0,
        "score": _gpu_score(spec),
        "length_mm": spec.length_mm,
        "power_8pin_count": spec.power_8pin_count,
        "power_6pin_count": spec.power_6pin_count,
        "power_12vhpwr": spec.power_12vhpwr,
    }


def _serialize_ram(spec):
    return {
        "id": spec.variant.variant_id,
        "name": _variant_display_name(spec.variant),
        "price": _money(spec.variant.price),
        "image": _variant_image_url(spec.variant),
        "ram_type": spec.ram_type,
        "power_draw": spec.tdp or 0,
        "capacity_gb": spec.capacity_gb,
        "speed_mhz": spec.speed_mhz,
        "module_count": spec.module_count,
    }


def _serialize_storage(spec):
    return {
        "id": spec.variant.variant_id,
        "name": _variant_display_name(spec.variant),
        "price": _money(spec.variant.price),
        "image": _variant_image_url(spec.variant),
        "power_draw": spec.tdp or 0,
        "storage_type": spec.storage_type,
        "capacity_gb": spec.capacity_gb,
        "interface_type": spec.interface_type,
        "form_factor": spec.form_factor,
    }


def _serialize_cooler(spec):
    return {
        "id": spec.variant.variant_id,
        "name": _variant_display_name(spec.variant),
        "price": _money(spec.variant.price),
        "image": _variant_image_url(spec.variant),
        "cooler_type": spec.cooler_type,
        "cooling_tdp": spec.tdp or 0,
        "supported_sockets": spec.supported_sockets or [],
        "height_mm": spec.height_mm,
        "radiator_size_mm": spec.radiator_size_mm,
    }


def _serialize_psu(spec):
    return {
        "id": spec.variant.variant_id,
        "name": _variant_display_name(spec.variant),
        "price": _money(spec.variant.price),
        "image": _variant_image_url(spec.variant),
        "wattage": spec.wattage,
        "length_mm": spec.length_mm,
        "form_factor": _normalize_form_factor(spec.form_factor),
        "power_8pin_count": spec.power_8pin_count,
        "power_6pin_count": spec.power_6pin_count,
        "power_12vhpwr": spec.power_12vhpwr,
    }


def _serialize_case(spec):
    return {
        "id": spec.variant.variant_id,
        "name": _variant_display_name(spec.variant),
        "price": _money(spec.variant.price),
        "image": _variant_image_url(spec.variant),
        "supported_form_factors": [_normalize_form_factor(value) for value in _split_csv(spec.supported_form_factors)],
        "max_gpu_length_mm": spec.max_gpu_length_mm,
        "max_psu_length_mm": spec.max_psu_length_mm,
        "max_cooler_height_mm": spec.max_cooler_height_mm,
    }


def _is_m2_storage(spec):
    haystack = " ".join(
        [
            spec.storage_type or "",
            spec.interface_type or "",
            spec.form_factor or "",
            spec.variant.product.product_name or "",
            spec.variant.variant_name or "",
            spec.variant.product.category.category_name or "",
        ]
    ).lower()
    return "m.2" in haystack or "nvme" in haystack


def _variant_queryset():
    return ProductVariant.objects.select_related(
        "product__brand",
        "product__category",
    ).prefetch_related("images")


def _variant_candidates(*keywords):
    query = Q()
    for keyword in keywords:
        query |= Q(product__category__category_name__icontains=keyword)
        query |= Q(product__product_name__icontains=keyword)
        query |= Q(variant_name__icontains=keyword)
    return _variant_queryset().filter(query).distinct()


def _fallback_cpu(variant):
    text = _variant_search_text(variant)
    return {
        "id": variant.variant_id,
        "name": _variant_display_name(variant),
        "price": _money(variant.price),
        "image": _variant_image_url(variant),
        "socket": _infer_socket_from_text(text),
        "power_draw": _extract_number(text, r"(\d+)\s*w(?:att)?\b", 0),
        "score": 0,
        "cores": _extract_number(text, r"(\d+)\s*core", 0),
        "threads": _extract_number(text, r"(\d+)\s*thread", 0),
        "boost_clock": 0,
    }


def _fallback_motherboard(variant):
    text = _variant_search_text(variant)
    return {
        "id": variant.variant_id,
        "name": _variant_display_name(variant),
        "price": _money(variant.price),
        "image": _variant_image_url(variant),
        "socket": _infer_socket_from_text(text),
        "ram_type": _infer_ram_type_from_text(text),
        "form_factor": _infer_form_factor_from_text(text),
        "power_draw": 0,
        "chipset": "",
        "m2_slots": 1,
        "sata_ports": 4,
        "pcie_x1_slots": 1,
        "pcie_x16_slots": 1,
    }


def _fallback_gpu(variant):
    text = _variant_search_text(variant)
    return {
        "id": variant.variant_id,
        "name": _variant_display_name(variant),
        "price": _money(variant.price),
        "image": _variant_image_url(variant),
        "power_draw": _extract_number(text, r"(\d+)\s*w(?:att)?\b", 0),
        "score": 0,
        "length_mm": _extract_number(text, r"(\d+)\s*mm", 0),
        "power_8pin_count": 0,
        "power_6pin_count": 0,
        "power_12vhpwr": "12vhpwr" in text,
    }


def _fallback_ram(variant):
    text = _variant_search_text(variant)
    return {
        "id": variant.variant_id,
        "name": _variant_display_name(variant),
        "price": _money(variant.price),
        "image": _variant_image_url(variant),
        "ram_type": _infer_ram_type_from_text(text),
        "power_draw": 0,
        "capacity_gb": _extract_number(text, r"(\d+)\s*gb", 0),
        "speed_mhz": _extract_number(text, r"(\d+)\s*mhz", 0),
        "module_count": 1,
    }


def _fallback_storage(variant):
    text = _variant_search_text(variant)
    return {
        "id": variant.variant_id,
        "name": _variant_display_name(variant),
        "price": _money(variant.price),
        "image": _variant_image_url(variant),
        "power_draw": 0,
        "storage_type": "HDD" if "hdd" in text or "hard drive" in text else "SSD",
        "capacity_gb": _extract_number(text, r"(\d+)\s*gb", 0),
        "interface_type": "NVME" if "nvme" in text else ("SATA" if "sata" in text else ""),
        "form_factor": "M.2" if "m.2" in text or "nvme" in text else "",
    }


def _fallback_cooler(variant):
    text = _variant_search_text(variant)
    return {
        "id": variant.variant_id,
        "name": _variant_display_name(variant),
        "price": _money(variant.price),
        "image": _variant_image_url(variant),
        "cooler_type": "AIO" if "aio" in text or "liquid" in text else "AIR",
        "cooling_tdp": _extract_number(text, r"(\d+)\s*w(?:att)?\b", 0),
        "supported_sockets": [],
        "height_mm": _extract_number(text, r"(\d+)\s*mm", 0),
        "radiator_size_mm": _extract_number(text, r"(\d+)\s*mm", None),
    }


def _fallback_psu(variant):
    text = _variant_search_text(variant)
    return {
        "id": variant.variant_id,
        "name": _variant_display_name(variant),
        "price": _money(variant.price),
        "image": _variant_image_url(variant),
        "wattage": _extract_number(text, r"(\d+)\s*w(?:att)?\b", 650),
        "length_mm": _extract_number(text, r"(\d+)\s*mm", 160),
        "form_factor": _infer_form_factor_from_text(text),
        "power_8pin_count": 2,
        "power_6pin_count": 2,
        "power_12vhpwr": "12vhpwr" in text,
    }


def _fallback_case(variant):
    text = _variant_search_text(variant)
    return {
        "id": variant.variant_id,
        "name": _variant_display_name(variant),
        "price": _money(variant.price),
        "image": _variant_image_url(variant),
        "supported_form_factors": ["ATX", "MATX", "ITX"] if not any(
            token in text for token in ["atx", "matx", "itx", "micro-atx", "mini-itx"]
        ) else [_infer_form_factor_from_text(text)],
        "max_gpu_length_mm": 999,
        "max_psu_length_mm": 999,
        "max_cooler_height_mm": 999,
    }


def _append_fallbacks(items, variants, serializer):
    seen_ids = {item["id"] for item in items}
    for variant in variants:
        if variant.variant_id in seen_ids:
            continue
        items.append(serializer(variant))


def get_builder_page_context():
    cpu_specs = CPU.objects.select_related(
        "variant__product__brand"
    ).prefetch_related("variant__images")
    motherboard_specs = Motherboard.objects.select_related(
        "variant__product__brand"
    ).prefetch_related("variant__images")
    gpu_specs = GPU.objects.select_related(
        "variant__product__brand"
    ).prefetch_related("variant__images")
    ram_specs = RAM.objects.select_related(
        "variant__product__brand"
    ).prefetch_related("variant__images")
    storage_specs = Storage.objects.select_related(
        "variant__product__brand",
        "variant__product__category",
    ).prefetch_related("variant__images")
    cooler_specs = Cooler.objects.select_related(
        "variant__product__brand"
    ).prefetch_related("variant__images")
    psu_specs = PSU.objects.select_related(
        "variant__product__brand"
    ).prefetch_related("variant__images")
    case_specs = Cabinet.objects.select_related(
        "variant__product__brand"
    ).prefetch_related("variant__images")

    builder_components = {
        "base_system_power": BASE_SYSTEM_POWER_WATTS,
        "cpus": [_serialize_cpu(spec) for spec in cpu_specs],
        "motherboards": [_serialize_motherboard(spec) for spec in motherboard_specs],
        "gpus": [_serialize_gpu(spec) for spec in gpu_specs],
        "rams": [_serialize_ram(spec) for spec in ram_specs],
        "storage_m2": [],
        "storage_hdd": [],
        "air_coolers": [],
        "aio_coolers": [],
        "psus": [_serialize_psu(spec) for spec in psu_specs],
        "pc_cases": [_serialize_case(spec) for spec in case_specs],
    }

    for spec in storage_specs:
        target_bucket = "storage_m2" if _is_m2_storage(spec) else "storage_hdd"
        builder_components[target_bucket].append(_serialize_storage(spec))

    for spec in cooler_specs:
        target_bucket = "air_coolers" if spec.cooler_type == "AIR" else "aio_coolers"
        builder_components[target_bucket].append(_serialize_cooler(spec))

    _append_fallbacks(
        builder_components["cpus"],
        _variant_candidates("cpu", "processor"),
        _fallback_cpu,
    )
    _append_fallbacks(
        builder_components["motherboards"],
        _variant_candidates("motherboard", "mainboard"),
        _fallback_motherboard,
    )
    _append_fallbacks(
        builder_components["gpus"],
        _variant_candidates("gpu", "graphics", "graphic card", "vga"),
        _fallback_gpu,
    )
    _append_fallbacks(
        builder_components["rams"],
        _variant_candidates("ram", "memory"),
        _fallback_ram,
    )

    storage_candidates = _variant_candidates("storage", "ssd", "hdd", "hard disk", "nvme", "m.2")
    m2_seen_ids = {item["id"] for item in builder_components["storage_m2"]}
    hdd_seen_ids = {item["id"] for item in builder_components["storage_hdd"]}
    for variant in storage_candidates:
        if variant.variant_id in m2_seen_ids or variant.variant_id in hdd_seen_ids:
            continue
        storage_item = _fallback_storage(variant)
        is_m2 = "m.2" in (storage_item["form_factor"] or "").lower() or "nvme" in (storage_item["interface_type"] or "").lower()
        target_bucket = "storage_m2" if is_m2 else "storage_hdd"
        builder_components[target_bucket].append(storage_item)
        if target_bucket == "storage_m2":
            m2_seen_ids.add(variant.variant_id)
        else:
            hdd_seen_ids.add(variant.variant_id)

    cooler_candidates = _variant_candidates("cooler", "cooling", "aio", "liquid", "fan")
    air_seen_ids = {item["id"] for item in builder_components["air_coolers"]}
    aio_seen_ids = {item["id"] for item in builder_components["aio_coolers"]}
    for variant in cooler_candidates:
        if variant.variant_id in air_seen_ids or variant.variant_id in aio_seen_ids:
            continue
        cooler_item = _fallback_cooler(variant)
        target_bucket = "aio_coolers" if cooler_item["cooler_type"] == "AIO" else "air_coolers"
        builder_components[target_bucket].append(cooler_item)
        if target_bucket == "aio_coolers":
            aio_seen_ids.add(variant.variant_id)
        else:
            air_seen_ids.add(variant.variant_id)

    _append_fallbacks(
        builder_components["psus"],
        _variant_candidates("psu", "power supply", "smps", "power"),
        _fallback_psu,
    )
    _append_fallbacks(
        builder_components["pc_cases"],
        _variant_candidates("cabinet", "case", "chassis"),
        _fallback_case,
    )

    return {"builder_components": builder_components}
