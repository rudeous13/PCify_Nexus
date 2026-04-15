const builderCatalog = JSON.parse(
  document.getElementById("builder-components-data").textContent,
);

const COMPONENTS = [
  {
    id: "cpu",
    label: "CPU",
    icon: "bi-cpu-fill",
    source: "cpus",
  },
  {
    id: "mobo",
    label: "Motherboard",
    icon: "bi-motherboard-fill",
    source: "motherboards",
  },
  {
    id: "gpu",
    label: "Graphics Card",
    icon: "bi-gpu-card",
    source: "gpus",
  },
  {
    id: "ram",
    label: "Memory (RAM)",
    icon: "bi-memory",
    source: "rams",
  },
  {
    id: "storage_m2",
    label: "Primary Storage (M.2)",
    icon: "bi-device-ssd-fill",
    source: "storage_m2",
  },
  {
    id: "storage_hdd",
    label: "Secondary Storage (SATA / HDD)",
    icon: "bi-device-hdd-fill",
    source: "storage_hdd",
    noneLabel: "None",
  },
  {
    id: "cooler_air",
    label: "CPU Air Cooler",
    icon: "bi-fan",
    source: "air_coolers",
    noneLabel: "None (Use AIO)",
  },
  {
    id: "cooler_aio",
    label: "AIO Liquid Cooler",
    icon: "bi-snow2",
    source: "aio_coolers",
    noneLabel: "None (Use Air)",
  },
  {
    id: "psu",
    label: "Power Supply",
    icon: "bi-lightning-charge-fill",
    source: "psus",
  },
  {
    id: "case",
    label: "PC Case",
    icon: "bi-pc-display",
    source: "pc_cases",
  },
];

const componentById = Object.fromEntries(
  COMPONENTS.map((component) => [component.id, component]),
);
const optionalSelections = new Set(["storage_hdd", "cooler_air", "cooler_aio"]);
const quantityComponents = new Set(["ram", "storage_m2", "storage_hdd"]);
const requiredComponents = [
  "cpu",
  "mobo",
  "gpu",
  "ram",
  "storage_m2",
  "psu",
  "case",
];
const state = {};
const selectionState = {
  storage_hdd: "none",
  cooler_air: "none",
  cooler_aio: "none",
};
const quantityState = {
  ram: 1,
  storage_m2: 1,
  storage_hdd: 1,
};
const catalogLookup = {};

Object.entries(builderCatalog).forEach(([key, value]) => {
  if (Array.isArray(value)) {
    catalogLookup[key] = Object.fromEntries(
      value.map((item) => [String(item.id), item]),
    );
  }
});

function escapeHtml(value) {
  return String(value ?? "")
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#39;");
}

function formatMoney(value) {
  return Number(value || 0).toLocaleString("en-IN", {
    minimumFractionDigits: 0,
    maximumFractionDigits: 2,
  });
}

function normalizeSocket(value) {
  return String(value || "").trim().toUpperCase();
}

function normalizeFormFactor(value) {
  return String(value || "").trim().toUpperCase();
}

function getAllOptions(componentId) {
  const component = componentById[componentId];
  return (builderCatalog[component.source] || []).slice();
}

function getQuantity(componentId) {
  return quantityState[componentId] || 1;
}

function getSelectedPart(componentId) {
  const component = componentById[componentId];
  const selectedValue = selectionState[componentId];

  if (!component || !selectedValue || selectedValue === "none") {
    return null;
  }

  return catalogLookup[component.source]?.[String(selectedValue)] || null;
}

function getSelectedParts() {
  const selectedParts = {};
  COMPONENTS.forEach((component) => {
    const part = getSelectedPart(component.id);
    if (part) {
      selectedParts[component.id] = part;
    }
  });
  return selectedParts;
}

function getPowerDraw(selectedParts) {
  let total = Number(builderCatalog.base_system_power || 50);

  Object.entries(selectedParts).forEach(([componentId, part]) => {
    if (componentId === "psu" || componentId === "case") {
      return;
    }

    const qty = quantityComponents.has(componentId) ? getQuantity(componentId) : 1;
    total += Number(part.power_draw || 0) * qty;
  });

  return Math.max(total, Number(builderCatalog.base_system_power || 50));
}

function getRecommendedPsuWattage(selectedParts) {
  if (!selectedParts.cpu && !selectedParts.gpu && !selectedParts.mobo) {
    return 0;
  }

  return Math.max(450, Math.ceil((getPowerDraw(selectedParts) * 1.25) / 50) * 50);
}

function supportsSocket(cooler, socket) {
  if (!socket) {
    return true;
  }

  const supportedSockets = Array.isArray(cooler.supported_sockets)
    ? cooler.supported_sockets.map(normalizeSocket)
    : [];
  return supportedSockets.length === 0 || supportedSockets.includes(normalizeSocket(socket));
}

function getFilteredOptions(componentId, selectedParts) {
  const allOptions = getAllOptions(componentId);

  return allOptions.filter((option) => {
    switch (componentId) {
      case "mobo":
        if (
          selectedParts.cpu &&
          normalizeSocket(option.socket) !== normalizeSocket(selectedParts.cpu.socket)
        ) {
          return false;
        }

        if (
          selectedParts.case &&
          Array.isArray(selectedParts.case.supported_form_factors) &&
          selectedParts.case.supported_form_factors.length > 0 &&
          !selectedParts.case.supported_form_factors.includes(
            normalizeFormFactor(option.form_factor),
          )
        ) {
          return false;
        }

        return true;

      case "ram":
        if (selectedParts.mobo && selectedParts.mobo.ram_type) {
          return option.ram_type === selectedParts.mobo.ram_type;
        }
        return true;

      case "gpu":
        if (selectedParts.mobo && Number(selectedParts.mobo.pcie_x16_slots || 0) < 1) {
          return false;
        }

        if (
          selectedParts.case &&
          Number(selectedParts.case.max_gpu_length_mm || 0) > 0 &&
          Number(option.length_mm || 0) > Number(selectedParts.case.max_gpu_length_mm)
        ) {
          return false;
        }

        return true;

      case "storage_m2":
        if (selectedParts.mobo && Number(selectedParts.mobo.m2_slots || 0) < 1) {
          return false;
        }
        return true;

      case "storage_hdd":
        if (selectedParts.mobo && Number(selectedParts.mobo.sata_ports || 0) < 1) {
          return false;
        }
        return true;

      case "cooler_air":
        if (selectedParts.cooler_aio) {
          return false;
        }

        if (selectedParts.mobo && !supportsSocket(option, selectedParts.mobo.socket)) {
          return false;
        }

        if (selectedParts.cpu && !supportsSocket(option, selectedParts.cpu.socket)) {
          return false;
        }

        if (
          selectedParts.cpu &&
          Number(option.cooling_tdp || 0) > 0 &&
          Number(option.cooling_tdp || 0) < Number(selectedParts.cpu.power_draw || 0)
        ) {
          return false;
        }

        if (
          selectedParts.case &&
          Number(selectedParts.case.max_cooler_height_mm || 0) > 0 &&
          Number(option.height_mm || 0) > Number(selectedParts.case.max_cooler_height_mm)
        ) {
          return false;
        }

        return true;

      case "cooler_aio":
        if (selectedParts.cooler_air) {
          return false;
        }

        if (selectedParts.mobo && !supportsSocket(option, selectedParts.mobo.socket)) {
          return false;
        }

        if (selectedParts.cpu && !supportsSocket(option, selectedParts.cpu.socket)) {
          return false;
        }

        if (
          selectedParts.cpu &&
          Number(option.cooling_tdp || 0) > 0 &&
          Number(option.cooling_tdp || 0) < Number(selectedParts.cpu.power_draw || 0)
        ) {
          return false;
        }

        return true;

      case "psu": {
        const recommendedWattage = getRecommendedPsuWattage(selectedParts);

        if (recommendedWattage && Number(option.wattage || 0) < recommendedWattage) {
          return false;
        }

        if (
          selectedParts.case &&
          Number(selectedParts.case.max_psu_length_mm || 0) > 0 &&
          Number(option.length_mm || 0) > Number(selectedParts.case.max_psu_length_mm)
        ) {
          return false;
        }

        if (selectedParts.gpu) {
          if (
            Number(option.power_8pin_count || 0) <
            Number(selectedParts.gpu.power_8pin_count || 0)
          ) {
            return false;
          }

          if (
            Number(option.power_6pin_count || 0) <
            Number(selectedParts.gpu.power_6pin_count || 0)
          ) {
            return false;
          }

          if (selectedParts.gpu.power_12vhpwr && !option.power_12vhpwr) {
            return false;
          }
        }

        return true;
      }

      case "case":
        if (
          selectedParts.mobo &&
          Array.isArray(option.supported_form_factors) &&
          option.supported_form_factors.length > 0 &&
          !option.supported_form_factors.includes(
            normalizeFormFactor(selectedParts.mobo.form_factor),
          )
        ) {
          return false;
        }

        if (
          selectedParts.gpu &&
          Number(option.max_gpu_length_mm || 0) > 0 &&
          Number(selectedParts.gpu.length_mm || 0) > Number(option.max_gpu_length_mm)
        ) {
          return false;
        }

        if (
          selectedParts.psu &&
          Number(option.max_psu_length_mm || 0) > 0 &&
          Number(selectedParts.psu.length_mm || 0) > Number(option.max_psu_length_mm)
        ) {
          return false;
        }

        if (
          selectedParts.cooler_air &&
          Number(option.max_cooler_height_mm || 0) > 0 &&
          Number(selectedParts.cooler_air.height_mm || 0) >
            Number(option.max_cooler_height_mm)
        ) {
          return false;
        }

        return true;

      default:
        return true;
    }
  });
}

function buildOptionMarkup(option, isSelected) {
  const selectedAttr = isSelected ? " selected" : "";
  return `<option value="${escapeHtml(option.id)}"${selectedAttr}>${escapeHtml(option.name)}${Number(option.price || 0) > 0 ? ` - ₹${formatMoney(option.price)}` : ""}</option>`;
}

function renderComponents() {
  const container = document.getElementById("component-list-container");
  const selectedParts = getSelectedParts();
  let html = "";

  COMPONENTS.forEach((component) => {
    const filteredOptions = getFilteredOptions(component.id, selectedParts);
    const currentValue = selectionState[component.id] || "";
    const hasCurrentOption =
      currentValue === "none" ||
      filteredOptions.some((option) => String(option.id) === String(currentValue));
    const resolvedValue = hasCurrentOption
      ? currentValue
      : optionalSelections.has(component.id)
        ? "none"
        : "";

    selectionState[component.id] = resolvedValue;

    const placeholderText =
      filteredOptions.length === 0
        ? `No compatible ${component.label.toLowerCase()} found`
        : `Select ${component.label}`;
    const disabledAttr =
      filteredOptions.length === 0 && !optionalSelections.has(component.id)
        ? " disabled"
        : "";

    let optionsMarkup = `<option value=""${resolvedValue === "" ? " selected" : ""}>${escapeHtml(placeholderText)}</option>`;

    if (optionalSelections.has(component.id)) {
      optionsMarkup += `<option value="none"${resolvedValue === "none" ? " selected" : ""}>${escapeHtml(component.noneLabel)}</option>`;
    }

    filteredOptions.forEach((option) => {
      optionsMarkup += buildOptionMarkup(
        option,
        String(resolvedValue) === String(option.id),
      );
    });

    const qtyValue = getQuantity(component.id);
    const qtyControls = quantityComponents.has(component.id)
      ? `
        <div class="flex items-center gap-1 bg-slate-200 dark:bg-slate-800 rounded-lg p-1 shrink-0 mt-3 md:mt-0">
          <button type="button" class="w-10 h-10 md:w-8 md:h-8 flex items-center justify-center rounded bg-white dark:bg-slate-700 hover:text-brand-500 transition-colors shadow-sm" onclick="changeQty('${component.id}', -1)">
            <i class="bi bi-dash"></i>
          </button>
          <input type="hidden" name="qty_${component.id}" id="input-qty-${component.id}" value="${qtyValue}">
          <span id="qty-${component.id}" class="w-8 text-center text-sm font-bold font-mono">${qtyValue}</span>
          <button type="button" class="w-10 h-10 md:w-8 md:h-8 flex items-center justify-center rounded bg-white dark:bg-slate-700 hover:text-brand-500 transition-colors shadow-sm" onclick="changeQty('${component.id}', 1)">
            <i class="bi bi-plus"></i>
          </button>
        </div>
      `
      : `<input type="hidden" name="qty_${component.id}" id="input-qty-${component.id}" value="1">`;

    html += `
      <div class="component group relative pl-12" id="comp-${component.id}">
        <div class="circuit-line transition-all duration-300"></div>
        <div class="absolute left-[15px] top-10 w-4 h-4 rounded-full border-[2px] border-slate-300 dark:border-slate-600 bg-slate-100 dark:bg-dark-card group-hover:border-brand-400 group-hover:bg-brand-400 transition-all z-10 indicator-dot"></div>

        <div class="card-container bg-white dark:bg-white/5 backdrop-blur-sm border border-slate-200 dark:border-white/10 rounded-2xl p-1 transition-all duration-300 hover:shadow-neon hover:-translate-y-1">
          <div class="relative p-5 bg-gradient-to-b from-transparent to-slate-50/50 dark:to-black/20 rounded-xl">
            <div class="flex flex-col md:flex-row md:items-center gap-6">
              <div class="md:w-24 shrink-0 flex flex-col items-center gap-2">
                <div class="w-12 h-12 rounded-xl bg-gradient-to-br from-slate-100 to-slate-200 dark:from-white/5 dark:to-white/0 border border-white/10 flex items-center justify-center shadow-inner">
                  <i class="bi ${component.icon} text-2xl text-slate-400 dark:text-brand-400 group-hover:text-brand-300 transition-colors"></i>
                </div>
                <label class="text-[10px] font-black uppercase tracking-widest text-slate-400 group-hover:text-brand-400 transition-colors text-center">${escapeHtml(component.label)}</label>
              </div>
              <div class="flex-1 w-full flex flex-col md:flex-row gap-3">
                <div class="flex-1 relative">
                  <select name="${component.id}" id="${component.id}" class="peer w-full bg-slate-50 dark:bg-[#050a14] border border-slate-200 dark:border-slate-700 rounded-xl px-5 py-4 text-sm font-semibold text-slate-900 dark:text-slate-100 focus:ring-2 focus:ring-brand-500/50 outline-none transition-all cursor-pointer" onchange="handleComponentChange('${component.id}')"${disabledAttr}>
                    ${optionsMarkup}
                  </select>
                  <div id="warn-${component.id}" class="hidden mt-2 text-[11px] font-bold text-amber-500 flex items-center gap-1"><i class="bi bi-exclamation-triangle"></i> <span>Warning</span></div>
                </div>
                ${qtyControls}
              </div>
            </div>
          </div>
        </div>
      </div>
    `;
  });

  container.innerHTML = html;
}

function resetComponentState(componentId) {
  const compDiv = document.getElementById(`comp-${componentId}`);
  if (!compDiv) return;

  compDiv
    .querySelector(".indicator-dot")
    .classList.remove("bg-emerald-500", "border-emerald-500");
  compDiv
    .querySelector(".card-container")
    .classList.remove("status-ok", "status-warn", "status-err");

  const warningEl = document.getElementById(`warn-${componentId}`);
  if (warningEl) {
    warningEl.classList.add("hidden");
  }
}

function markError(id) {
  const div = document.getElementById(`comp-${id}`)?.querySelector(".card-container");
  if (!div) return;

  div.classList.remove("status-ok", "status-warn");
  div.classList.add("status-err");
}

function markWarning(id) {
  const div = document.getElementById(`comp-${id}`)?.querySelector(".card-container");
  if (!div) return;

  div.classList.remove("status-ok", "status-err");
  div.classList.add("status-warn");
}

function showWarning(id, message) {
  const el = document.getElementById(`warn-${id}`);
  if (!el) return;

  el.innerHTML = `<i class="bi bi-exclamation-triangle"></i> ${escapeHtml(message)}`;
  el.classList.remove("hidden");
}

function updateSystem() {
  const selectedParts = getSelectedParts();
  let subtotal = 0;
  let scoreCPU = 0;
  let scoreGPU = 0;

  Object.keys(state).forEach((key) => delete state[key]);
  COMPONENTS.forEach((component) => resetComponentState(component.id));

  COMPONENTS.forEach((component) => {
    const compDiv = document.getElementById(`comp-${component.id}`);
    if (!compDiv) return;

    const selectedPart = selectedParts[component.id];
    const qty = quantityComponents.has(component.id) ? getQuantity(component.id) : 1;

    if (selectedPart) {
      const price = Number(selectedPart.price || 0) * qty;
      state[component.id] = {
        name: selectedPart.name,
        price,
        qty,
        image: selectedPart.image,
      };

      subtotal += price;

      if (component.id === "cpu") scoreCPU = Number(selectedPart.score || 0);
      if (component.id === "gpu") scoreGPU = Number(selectedPart.score || 0);

      compDiv
        .querySelector(".indicator-dot")
        .classList.add("bg-emerald-500", "border-emerald-500");
      compDiv.querySelector(".card-container").classList.add("status-ok");
    } else if (selectionState[component.id] === "none") {
      compDiv
        .querySelector(".indicator-dot")
        .classList.add("bg-emerald-500", "border-emerald-500");
      compDiv.querySelector(".card-container").classList.add("status-ok");
    }
  });

  const warnings = [];
  const totalPowerDraw = getPowerDraw(selectedParts);
  const recommendedWattage = getRecommendedPsuWattage(selectedParts);

  if (
    selectedParts.cpu &&
    selectedParts.mobo &&
    normalizeSocket(selectedParts.cpu.socket) !== normalizeSocket(selectedParts.mobo.socket)
  ) {
    warnings.push("CPU and motherboard socket mismatch.");
    markError("cpu");
    markError("mobo");
    showWarning("mobo", `Requires ${selectedParts.cpu.socket} socket`);
  }

  if (
    selectedParts.ram &&
    selectedParts.mobo &&
    selectedParts.ram.ram_type !== selectedParts.mobo.ram_type
  ) {
    warnings.push("Selected RAM type does not match the motherboard memory standard.");
    markError("ram");
    showWarning("ram", `Motherboard requires ${selectedParts.mobo.ram_type}`);
  }

  if (
    selectedParts.gpu &&
    selectedParts.mobo &&
    Number(selectedParts.mobo.pcie_x16_slots || 0) < 1
  ) {
    warnings.push("The selected motherboard does not have a PCIe x16 slot for this GPU.");
    markError("gpu");
    markError("mobo");
    showWarning("gpu", "Requires a motherboard with at least one PCIe x16 slot");
  }

  if (
    selectedParts.storage_m2 &&
    selectedParts.mobo &&
    getQuantity("storage_m2") > Number(selectedParts.mobo.m2_slots || 0)
  ) {
    warnings.push("You selected more M.2 drives than the motherboard can support.");
    markWarning("storage_m2");
    showWarning("storage_m2", `${selectedParts.mobo.m2_slots} M.2 slot(s) available`);
  }

  if (
    selectedParts.storage_hdd &&
    selectedParts.mobo &&
    getQuantity("storage_hdd") > Number(selectedParts.mobo.sata_ports || 0)
  ) {
    warnings.push("You selected more SATA drives than the motherboard has SATA ports.");
    markWarning("storage_hdd");
    showWarning("storage_hdd", `${selectedParts.mobo.sata_ports} SATA port(s) available`);
  }

  if (
    selectedParts.cooler_air &&
    selectedParts.cpu &&
    Number(selectedParts.cooler_air.cooling_tdp || 0) > 0 &&
    Number(selectedParts.cooler_air.cooling_tdp || 0) <
      Number(selectedParts.cpu.power_draw || 0)
  ) {
    warnings.push("The selected air cooler may not handle the CPU TDP.");
    markWarning("cooler_air");
    showWarning("cooler_air", `CPU requires at least ${selectedParts.cpu.power_draw}W cooling support`);
  }

  if (
    selectedParts.cooler_aio &&
    selectedParts.cpu &&
    Number(selectedParts.cooler_aio.cooling_tdp || 0) > 0 &&
    Number(selectedParts.cooler_aio.cooling_tdp || 0) <
      Number(selectedParts.cpu.power_draw || 0)
  ) {
    warnings.push("The selected AIO cooler may not handle the CPU TDP.");
    markWarning("cooler_aio");
    showWarning("cooler_aio", `CPU requires at least ${selectedParts.cpu.power_draw}W cooling support`);
  }

  if (
    selectedParts.case &&
    selectedParts.mobo &&
    Array.isArray(selectedParts.case.supported_form_factors) &&
    selectedParts.case.supported_form_factors.length > 0 &&
    !selectedParts.case.supported_form_factors.includes(
      normalizeFormFactor(selectedParts.mobo.form_factor),
    )
  ) {
    warnings.push("The selected case does not support the motherboard form factor.");
    markError("case");
    markError("mobo");
    showWarning("case", `Case supports ${selectedParts.case.supported_form_factors.join(", ")}`);
  }

  if (
    selectedParts.case &&
    selectedParts.gpu &&
    Number(selectedParts.case.max_gpu_length_mm || 0) > 0 &&
    Number(selectedParts.gpu.length_mm || 0) >
      Number(selectedParts.case.max_gpu_length_mm)
  ) {
    warnings.push("The GPU is too long for the selected case.");
    markError("gpu");
    markError("case");
    showWarning("case", `GPU clearance: ${selectedParts.case.max_gpu_length_mm}mm`);
  }

  if (
    selectedParts.case &&
    selectedParts.cooler_air &&
    Number(selectedParts.case.max_cooler_height_mm || 0) > 0 &&
    Number(selectedParts.cooler_air.height_mm || 0) >
      Number(selectedParts.case.max_cooler_height_mm)
  ) {
    warnings.push("The air cooler is too tall for the selected case.");
    markError("cooler_air");
    markError("case");
    showWarning("case", `Cooler clearance: ${selectedParts.case.max_cooler_height_mm}mm`);
  }

  if (
    selectedParts.case &&
    selectedParts.psu &&
    Number(selectedParts.case.max_psu_length_mm || 0) > 0 &&
    Number(selectedParts.psu.length_mm || 0) >
      Number(selectedParts.case.max_psu_length_mm)
  ) {
    warnings.push("The PSU is too long for the selected case.");
    markError("psu");
    markError("case");
    showWarning("case", `PSU clearance: ${selectedParts.case.max_psu_length_mm}mm`);
  }

  if (selectedParts.psu) {
    document.getElementById("watts-max").innerText = `/ ${selectedParts.psu.wattage}W`;

    if (
      recommendedWattage &&
      Number(selectedParts.psu.wattage || 0) < Number(recommendedWattage)
    ) {
      warnings.push("The selected PSU does not provide enough headroom.");
      markWarning("psu");
      showWarning("psu", `Recommended: ${recommendedWattage}W or higher`);
    }

    if (
      selectedParts.gpu &&
      Number(selectedParts.psu.power_8pin_count || 0) <
        Number(selectedParts.gpu.power_8pin_count || 0)
    ) {
      warnings.push("The PSU does not have enough 8-pin connectors for the GPU.");
      markError("psu");
      showWarning("psu", `Needs ${selectedParts.gpu.power_8pin_count}x 8-pin connector(s)`);
    }

    if (
      selectedParts.gpu &&
      Number(selectedParts.psu.power_6pin_count || 0) <
        Number(selectedParts.gpu.power_6pin_count || 0)
    ) {
      warnings.push("The PSU does not have enough 6-pin connectors for the GPU.");
      markError("psu");
      showWarning("psu", `Needs ${selectedParts.gpu.power_6pin_count}x 6-pin connector(s)`);
    }

    if (
      selectedParts.gpu &&
      selectedParts.gpu.power_12vhpwr &&
      !selectedParts.psu.power_12vhpwr
    ) {
      warnings.push("The PSU does not support the GPU 12VHPWR connector.");
      markError("psu");
      showWarning("psu", "GPU requires a 12VHPWR connector");
    }
  } else {
    document.getElementById("watts-max").innerText = recommendedWattage
      ? `/ ${recommendedWattage}W recommended`
      : `/ --`;
  }

  const statusEl = document.getElementById("build-status");
  const requiredSelectedCount = requiredComponents.filter(
    (componentId) => !!selectedParts[componentId],
  ).length;

  if (warnings.length > 0) {
    statusEl.className =
      "w-full text-xs font-mono font-bold text-red-400 bg-red-950/30 border border-red-500/20 py-2 rounded-lg flex items-center justify-center gap-2 mb-3";
    statusEl.innerHTML = `<i class="bi bi-exclamation-triangle-fill"></i> ${escapeHtml(warnings[0])}`;
  } else if (requiredSelectedCount < requiredComponents.length) {
    statusEl.className =
      "w-full text-xs font-mono font-bold text-slate-400 bg-slate-800/50 border border-slate-500/20 py-2 rounded-lg flex items-center justify-center gap-2 mb-3";
    statusEl.innerText = "BUILD IN PROGRESS";
  } else {
    statusEl.className =
      "w-full text-xs font-mono font-bold text-emerald-400 bg-emerald-950/30 border border-emerald-500/20 py-2 rounded-lg flex items-center justify-center gap-2 mb-3";
    statusEl.innerHTML = '<i class="bi bi-check-circle-fill"></i> SYSTEM READY';
  }

  document.getElementById("watts-total").innerText = totalPowerDraw;

  const fps = (scoreCPU + scoreGPU) / 2;
  document.getElementById("fps-est").innerText = fps > 0 ? `${Math.round(fps)}+` : "--";

  const tax = Math.round(subtotal * 0.18);
  const total = subtotal + tax;

  document.getElementById("price-subtotal").innerText = formatMoney(subtotal);
  document.getElementById("price-tax").innerText = formatMoney(tax);
  document.getElementById("price-total").innerText = formatMoney(total);
  document.getElementById("total-price-mobile").innerText = formatMoney(total);

  const listContainer = document.getElementById("summary-list");
  const listItems = Object.values(state);

  if (listItems.length > 0) {
    listContainer.innerHTML = listItems
      .map((item) => {
        const thumbMarkup = item.image
          ? `<img src="${escapeHtml(item.image)}" alt="${escapeHtml(item.name)}" class="w-8 h-8 rounded bg-slate-800 border border-white/10 object-cover cursor-pointer hover:ring-2 hover:ring-brand-400 transition-all shrink-0" onclick='openImageModal(${JSON.stringify(item.image)}, ${JSON.stringify(item.name)})'>`
          : '<div class="w-8 h-8 rounded bg-slate-800 border border-white/10 shrink-0 flex items-center justify-center text-slate-500"><i class="bi bi-image"></i></div>';

        return `
          <li class="flex items-center justify-between text-xs border-b border-white/5 pb-2 pt-1 gap-2">
            <div class="flex items-center gap-3 overflow-hidden flex-1">
              ${thumbMarkup}
              <span class="text-slate-300 truncate">
                ${item.qty > 1 ? `<span class="text-brand-400 font-bold">${item.qty}x</span> ` : ""}${escapeHtml(item.name)}
              </span>
            </div>
            <span class="text-slate-500 font-mono shrink-0">₹${formatMoney(item.price)}</span>
          </li>
        `;
      })
      .join("");
  } else {
    listContainer.innerHTML =
      '<li class="text-center py-8 text-slate-400 text-xs italic">Components will appear here...</li>';
  }

  const percent = (requiredSelectedCount / requiredComponents.length) * 100;
  document.getElementById("progress-bar").style.width = `${percent}%`;
  document.getElementById("progress-text").innerText = `${Math.round(percent)}%`;
}

function syncBuilder() {
  renderComponents();
  updateSystem();
}

function handleComponentChange(componentId) {
  const select = document.getElementById(componentId);
  selectionState[componentId] = select ? select.value : "";

  if (
    componentId === "cooler_air" &&
    selectionState[componentId] !== "none" &&
    selectionState[componentId] !== ""
  ) {
    selectionState.cooler_aio = "none";
  }

  if (
    componentId === "cooler_aio" &&
    selectionState[componentId] !== "none" &&
    selectionState[componentId] !== ""
  ) {
    selectionState.cooler_air = "none";
  }

  syncBuilder();
}

function changeQty(componentId, delta) {
  const currentValue = getQuantity(componentId);
  let nextValue = currentValue + delta;
  if (nextValue < 1) nextValue = 1;
  if (nextValue > 8) nextValue = 8;
  quantityState[componentId] = nextValue;
  syncBuilder();
}

function openImageModal(src, title) {
  const modal = document.getElementById("imageModal");
  document.getElementById("modalImageSrc").src = src;
  document.getElementById("modalImageTitle").innerText = title;
  modal.classList.remove("hidden");

  setTimeout(() => {
    modal.classList.remove("opacity-0");
    modal.classList.add("opacity-100");
  }, 10);
}

function closeImageModal() {
  const modal = document.getElementById("imageModal");
  modal.classList.remove("opacity-100");
  modal.classList.add("opacity-0");
  setTimeout(() => {
    modal.classList.add("hidden");
  }, 300);
}

document.addEventListener("keydown", (event) => {
  if (event.key === "Escape") {
    closeImageModal();
  }
});

function showToast(message) {
  const toast = document.getElementById("toast");
  toast.querySelector("span").innerText = message;
  toast.classList.remove("opacity-0", "-translate-y-10");
  setTimeout(() => {
    toast.classList.add("opacity-0", "-translate-y-10");
  }, 2500);
}

function saveBuild() {
  if (navigator.clipboard?.writeText) {
    navigator.clipboard.writeText(window.location.href);
  }
  showToast("Builder link copied to clipboard!");
}

function copyList() {
  const listItems = Object.values(state);
  const output = listItems.length
    ? listItems
        .map((item) => `${item.qty > 1 ? `${item.qty}x ` : ""}${item.name} - ₹${formatMoney(item.price)}`)
        .join("\n")
    : "No components selected yet.";

  if (navigator.clipboard?.writeText) {
    navigator.clipboard.writeText(output);
  }

  showToast("Build list copied!");
}

syncBuilder();

const toggleBtn = document.getElementById("themeToggle");
const html = document.documentElement;
const icon = toggleBtn.querySelector("i");

function initTheme() {
  const savedTheme = localStorage.getItem("theme") || "dark";
  html.setAttribute("data-theme", savedTheme);
  icon.classList.toggle("bi-sun-fill", savedTheme === "light");
  icon.classList.toggle("bi-moon-stars-fill", savedTheme === "dark");
}

toggleBtn.addEventListener("click", () => {
  const current = html.getAttribute("data-theme");
  const next = current === "dark" ? "light" : "dark";
  html.setAttribute("data-theme", next);
  localStorage.setItem("theme", next);
  icon.classList.toggle("bi-sun-fill");
  icon.classList.toggle("bi-moon-stars-fill");
});

initTheme();
