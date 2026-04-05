-- =========================
-- CORE TABLES
-- =========================

CREATE TABLE category (
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) UNIQUE
);

CREATE TABLE brand (
  brand_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) UNIQUE
);

CREATE TABLE product (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150),
  category_id INT,
  brand_id INT,
  FOREIGN KEY (category_id) REFERENCES category(category_id),
  FOREIGN KEY (brand_id) REFERENCES brand(brand_id)
);

CREATE TABLE product_variant (
  variant_id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT,
  name VARCHAR(150),
  sku VARCHAR(100) UNIQUE,
  warranty_months INT DEFAULT 0 CHECK (warranty_months >= 0),
  price DECIMAL(10,2) DEFAULT 0.00 CHECK (price >= 0),
  attributes JSON,
  FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- =========================
-- USER & ADDRESS
-- =========================

CREATE TABLE user (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(150) UNIQUE,
  phone_number VARCHAR(20),
  password_hash VARCHAR(255),
  role ENUM('admin','customer','employee') DEFAULT 'customer',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE address (
  address_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  street_address VARCHAR(255),
  pincode VARCHAR(6),
  area VARCHAR(150),
  city VARCHAR(150) DEFAULT 'ahmedabad',
  state VARCHAR(150) DEFAULT 'gujarat',
  FOREIGN KEY (user_id) REFERENCES user(user_id)
);

-- =========================
-- PRODUCT MEDIA & REVIEWS
-- =========================

CREATE TABLE product_variant_images (
  variant_image_id INT AUTO_INCREMENT PRIMARY KEY,
  variant_id INT,
  image_url VARCHAR(255),
  is_primary TINYINT DEFAULT 0,
  display_order INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (variant_id) REFERENCES product_variant(variant_id)
);

CREATE TABLE product_reviews (
  review_id INT AUTO_INCREMENT PRIMARY KEY,
  variant_id INT,
  user_id INT,
  rating INT CHECK (rating BETWEEN 1 AND 5),
  comment TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (variant_id, user_id),
  FOREIGN KEY (variant_id) REFERENCES product_variant(variant_id),
  FOREIGN KEY (user_id) REFERENCES user(user_id)
);

-- =========================
-- CART
-- =========================

CREATE TABLE cart (
  cart_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE cart_item (
  cart_item_id INT AUTO_INCREMENT PRIMARY KEY,
  cart_id INT,
  variant_id INT,
  quantity INT DEFAULT 1 CHECK (quantity >= 0),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE (cart_id, variant_id),
  FOREIGN KEY (cart_id) REFERENCES cart(cart_id),
  FOREIGN KEY (variant_id) REFERENCES product_variant(variant_id)
);

-- =========================
-- ORDERS
-- =========================

CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  cart_id INT,
  address_id INT,
  total_amount DECIMAL(10,2) DEFAULT 0.00 CHECK (total_amount >= 0),
  shipping_method ENUM('standard','express','pickup') DEFAULT 'standard',
  status ENUM('pending','completed','cancelled') DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES user(user_id),
  FOREIGN KEY (cart_id) REFERENCES cart(cart_id),
  FOREIGN KEY (address_id) REFERENCES address(address_id)
);

CREATE TABLE order_item (
  order_item_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  variant_id INT,
  quantity INT DEFAULT 1 CHECK (quantity >= 0),
  unit_price DECIMAL(10,2) DEFAULT 0.00 CHECK (unit_price >= 0),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (order_id, variant_id),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (variant_id) REFERENCES product_variant(variant_id)
);

-- =========================
-- INVOICE & PAYMENT
-- =========================

CREATE TABLE invoice (
  invoice_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  total_amount DECIMAL(10,2),
  paid_amount DECIMAL(10,2),
  status ENUM('unpaid','partial','paid'),
  issued_at TIMESTAMP,
  due_at TIMESTAMP,
  FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE payment (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  invoice_id INT,
  amount DECIMAL(10,2) CHECK (amount >= 0),
  reference_type ENUM('order','purchase_order','service'),
  reference_id INT,
  payment_method ENUM('card','upi','cod'),
  gateway VARCHAR(50) DEFAULT 'razorpay',
  gateway_payment_id VARCHAR(255),
  gateway_order_id VARCHAR(255),
  raw_response JSON,
  payment_status ENUM('pending','authorized','captured','completed','failed','refunded') DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  paid_at TIMESTAMP,
  FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id)
);

CREATE TABLE refund (
  refund_id INT AUTO_INCREMENT PRIMARY KEY,
  payment_id INT,
  amount DECIMAL(10,2),
  gateway_refund_id VARCHAR(255),
  status ENUM('pending','completed','failed') DEFAULT 'pending',
  reason TEXT,
  raw_response JSON,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  processed_at TIMESTAMP,
  FOREIGN KEY (payment_id) REFERENCES payment(payment_id)
);

-- =========================
-- INVENTORY
-- =========================

CREATE TABLE inventory (
  variant_id INT PRIMARY KEY,
  stock_quantity INT DEFAULT 0 CHECK (stock_quantity >= 0),
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (variant_id) REFERENCES product_variant(variant_id)
);

CREATE TABLE inventory_log (
  inventory_log_id INT AUTO_INCREMENT PRIMARY KEY,
  variant_id INT,
  quantity_change INT,
  action ENUM('add','remove'),
  reference_type ENUM('order','purchase_order','adjustment','return','service'),
  reference_id INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (variant_id) REFERENCES product_variant(variant_id)
);

-- =========================
-- SUPPLIER & PURCHASE
-- =========================

CREATE TABLE supplier (
  supplier_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) UNIQUE,
  contact_email VARCHAR(150),
  contact_phone VARCHAR(20),
  address VARCHAR(255),
  is_active TINYINT DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE purchase_order (
  purchase_order_id INT AUTO_INCREMENT PRIMARY KEY,
  supplier_id INT,
  status ENUM('pending','received','cancelled') DEFAULT 'pending',
  order_date TIMESTAMP,
  expected_delivery TIMESTAMP,
  remarks TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id)
);

CREATE TABLE purchase_order_item (
  purchase_order_item_id INT AUTO_INCREMENT PRIMARY KEY,
  purchase_order_id INT,
  variant_id INT,
  quantity INT DEFAULT 0,
  unit_cost DECIMAL(10,2) DEFAULT 0.00,
  received_quantity INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (purchase_order_id, variant_id),
  FOREIGN KEY (purchase_order_id) REFERENCES purchase_order(purchase_order_id),
  FOREIGN KEY (variant_id) REFERENCES product_variant(variant_id)
);

-- =========================
-- PC BUILD
-- =========================

CREATE TABLE pc_build (
  build_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  name VARCHAR(150),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE pc_build_item (
  build_item_id INT AUTO_INCREMENT PRIMARY KEY,
  build_id INT,
  variant_id INT,
  component_type VARCHAR(50),
  quantity INT DEFAULT 1 CHECK (quantity >= 0),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (build_id, variant_id),
  FOREIGN KEY (build_id) REFERENCES pc_build(build_id),
  FOREIGN KEY (variant_id) REFERENCES product_variant(variant_id)
);

-- =========================
-- COMPONENT TABLES
-- =========================

CREATE TABLE cpu (
  cpu_id INT AUTO_INCREMENT PRIMARY KEY,
  variant_id INT UNIQUE,
  socket_type ENUM('AM4','AM5','LGA1200','LGA1700'),
  cores INT,
  threads INT,
  base_clock DECIMAL(6,3),
  boost_clock DECIMAL(6,3),
  tdp INT,
  integrated_graphics TINYINT DEFAULT 0,
  FOREIGN KEY (variant_id) REFERENCES product_variant(variant_id)
);

CREATE TABLE ram (
  ram_id INT AUTO_INCREMENT PRIMARY KEY,
  variant_id INT UNIQUE,
  ram_type ENUM('DDR3','DDR4','DDR5'),
  memory_size INT,
  memory_speed INT,
  module_count INT,
  tdp INT,
  FOREIGN KEY (variant_id) REFERENCES product_variant(variant_id)
);

CREATE TABLE storage (
  storage_id INT AUTO_INCREMENT PRIMARY KEY,
  variant_id INT UNIQUE,
  storage_type ENUM('HDD','SSD'),
  capacity_gb INT,
  interface_type ENUM('SATA','PCIe'),
  form_factor ENUM('2.5','3.5','M.2'),
  FOREIGN KEY (variant_id) REFERENCES product_variant(variant_id)
);

CREATE TABLE gpu (
  gpu_id INT AUTO_INCREMENT PRIMARY KEY,
  variant_id INT UNIQUE,
  memory_size INT,
  pcie_version ENUM('PCIe3','PCIe4','PCIe5'),
  length_mm INT,
  interface_type ENUM('PCIe'),
  power_8pin_count INT,
  power_6pin_count INT,
  power_12vhpwr TINYINT DEFAULT 0,
  tdp INT,
  FOREIGN KEY (variant_id) REFERENCES product_variant(variant_id)
);

CREATE TABLE psu (
  psu_id INT AUTO_INCREMENT PRIMARY KEY,
  variant_id INT UNIQUE,
  wattage INT,
  form_factor ENUM('ATX','SFX','SFX-L'),
  length_mm INT,
  is_modular TINYINT DEFAULT 0,
  power_8pin_count INT,
  power_6pin_count INT,
  power_12vhpwr TINYINT DEFAULT 0,
  efficiency_rating ENUM('80+','80+ Bronze','80+ Silver','80+ Gold','80+ Platinum'),
  FOREIGN KEY (variant_id) REFERENCES product_variant(variant_id)
);

CREATE TABLE cabinet (
  cabinet_id INT AUTO_INCREMENT PRIMARY KEY,
  variant_id INT UNIQUE,
  max_gpu_length INT,
  max_psu_length INT,
  supported_atx TINYINT DEFAULT 0,
  supported_micro_atx TINYINT DEFAULT 0,
  supported_mini_itx TINYINT DEFAULT 0,
  max_cooler_height INT,
  FOREIGN KEY (variant_id) REFERENCES product_variant(variant_id)
);

CREATE TABLE motherboard (
  motherboard_id INT AUTO_INCREMENT PRIMARY KEY,
  variant_id INT UNIQUE,
  socket_type ENUM('AM4','AM5','LGA1200','LGA1700'),
  ram_type ENUM('DDR3','DDR4','DDR5'),
  form_factor ENUM('ATX','Micro-ATX','Mini-ITX'),
  chipset_type ENUM('B450','B550','X570','Z690','Z790'),
  m2_slots INT,
  sata_ports INT,
  pcie_x1_slots INT,
  pcie_x16_slots INT,
  tdp INT,
  max_ram_slots INT,
  max_ram_capacity INT,
  FOREIGN KEY (variant_id) REFERENCES product_variant(variant_id)
);

-- =========================
-- TAX & RETURNS
-- =========================

CREATE TABLE tax (
  tax_id INT AUTO_INCREMENT PRIMARY KEY,
  tax_name VARCHAR(100) UNIQUE,
  tax_rate DECIMAL(5,2) CHECK (tax_rate BETWEEN 0 AND 100),
  is_active TINYINT DEFAULT 1
);

CREATE TABLE order_item_tax (
  order_item_tax_id INT AUTO_INCREMENT PRIMARY KEY,
  order_item_id INT,
  tax_id INT,
  tax_amount DECIMAL(10,2) DEFAULT 0.00,
  UNIQUE (order_item_id, tax_id),
  FOREIGN KEY (order_item_id) REFERENCES order_item(order_item_id),
  FOREIGN KEY (tax_id) REFERENCES tax(tax_id)
);

CREATE TABLE return_request (
  return_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  user_id INT,
  status ENUM('requested','approved','rejected','completed') DEFAULT 'requested',
  reason TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  approved_at TIMESTAMP,
  completed_at TIMESTAMP,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE return_item (
  return_item_id INT AUTO_INCREMENT PRIMARY KEY,
  return_id INT,
  order_item_id INT,
  quantity INT DEFAULT 1 CHECK (quantity >= 0),
  refund_amount DECIMAL(10,2) DEFAULT 0.00 CHECK (refund_amount >= 0),
  is_restocked TINYINT DEFAULT 0,
  UNIQUE (return_id, order_item_id),
  FOREIGN KEY (return_id) REFERENCES return_request(return_id),
  FOREIGN KEY (order_item_id) REFERENCES order_item(order_item_id)
);

-- =========================
-- SERVICES
-- =========================

CREATE TABLE service (
  service_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) UNIQUE,
  description TEXT,
  base_price DECIMAL(10,2) DEFAULT 0.00,
  is_active TINYINT DEFAULT 1
);

CREATE TABLE service_request (
  service_request_id INT AUTO_INCREMENT PRIMARY KEY,
  service_id INT,
  user_id INT,
  order_id INT,
  variant_id INT,
  status ENUM('open','in_progress','resolved','cancelled') DEFAULT 'open',
  issue_description TEXT,
  total_amount DECIMAL(10,2) DEFAULT 0.00,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  completed_at TIMESTAMP,
  FOREIGN KEY (service_id) REFERENCES service(service_id),
  FOREIGN KEY (user_id) REFERENCES user(user_id),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (variant_id) REFERENCES product_variant(variant_id)
);