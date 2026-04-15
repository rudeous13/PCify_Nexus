-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 01, 2026 at 12:50 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `PCify_Nexus`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add user', 6, 'add_user'),
(22, 'Can change user', 6, 'change_user'),
(23, 'Can delete user', 6, 'delete_user'),
(24, 'Can view user', 6, 'view_user'),
(25, 'Can add address', 7, 'add_address'),
(26, 'Can change address', 7, 'change_address'),
(27, 'Can delete address', 7, 'delete_address'),
(28, 'Can view address', 7, 'view_address'),
(29, 'Can add pincode', 8, 'add_pincode'),
(30, 'Can change pincode', 8, 'change_pincode'),
(31, 'Can delete pincode', 8, 'delete_pincode'),
(32, 'Can view pincode', 8, 'view_pincode'),
(33, 'Can add supplier', 9, 'add_supplier'),
(34, 'Can change supplier', 9, 'change_supplier'),
(35, 'Can delete supplier', 9, 'delete_supplier'),
(36, 'Can view supplier', 9, 'view_supplier'),
(37, 'Can add brand', 10, 'add_brand'),
(38, 'Can change brand', 10, 'change_brand'),
(39, 'Can delete brand', 10, 'delete_brand'),
(40, 'Can view brand', 10, 'view_brand'),
(41, 'Can add category', 11, 'add_category'),
(42, 'Can change category', 11, 'change_category'),
(43, 'Can delete category', 11, 'delete_category'),
(44, 'Can view category', 11, 'view_category'),
(45, 'Can add brand', 12, 'add_brand'),
(46, 'Can change brand', 12, 'change_brand'),
(47, 'Can delete brand', 12, 'delete_brand'),
(48, 'Can view brand', 12, 'view_brand'),
(49, 'Can add category', 13, 'add_category'),
(50, 'Can change category', 13, 'change_category'),
(51, 'Can delete category', 13, 'delete_category'),
(52, 'Can view category', 13, 'view_category'),
(53, 'Can add product image', 14, 'add_productimage'),
(54, 'Can change product image', 14, 'change_productimage'),
(55, 'Can delete product image', 14, 'delete_productimage'),
(56, 'Can view product image', 14, 'view_productimage'),
(57, 'Can add product', 15, 'add_product'),
(58, 'Can change product', 15, 'change_product'),
(59, 'Can delete product', 15, 'delete_product'),
(60, 'Can view product', 15, 'view_product'),
(61, 'Can add product variant', 16, 'add_productvariant'),
(62, 'Can change product variant', 16, 'change_productvariant'),
(63, 'Can delete product variant', 16, 'delete_productvariant'),
(64, 'Can view product variant', 16, 'view_productvariant'),
(65, 'Can add gpu', 17, 'add_gpu'),
(66, 'Can change gpu', 17, 'change_gpu'),
(67, 'Can delete gpu', 17, 'delete_gpu'),
(68, 'Can view gpu', 17, 'view_gpu'),
(69, 'Can add storage', 18, 'add_storage'),
(70, 'Can change storage', 18, 'change_storage'),
(71, 'Can delete storage', 18, 'delete_storage'),
(72, 'Can view storage', 18, 'view_storage'),
(73, 'Can add motherboard', 19, 'add_motherboard'),
(74, 'Can change motherboard', 19, 'change_motherboard'),
(75, 'Can delete motherboard', 19, 'delete_motherboard'),
(76, 'Can view motherboard', 19, 'view_motherboard'),
(77, 'Can add cabinet', 20, 'add_cabinet'),
(78, 'Can change cabinet', 20, 'change_cabinet'),
(79, 'Can delete cabinet', 20, 'delete_cabinet'),
(80, 'Can view cabinet', 20, 'view_cabinet'),
(81, 'Can add ram', 21, 'add_ram'),
(82, 'Can change ram', 21, 'change_ram'),
(83, 'Can delete ram', 21, 'delete_ram'),
(84, 'Can view ram', 21, 'view_ram'),
(85, 'Can add cpu', 22, 'add_cpu'),
(86, 'Can change cpu', 22, 'change_cpu'),
(87, 'Can delete cpu', 22, 'delete_cpu'),
(88, 'Can view cpu', 22, 'view_cpu'),
(89, 'Can add psu', 23, 'add_psu'),
(90, 'Can change psu', 23, 'change_psu'),
(91, 'Can delete psu', 23, 'delete_psu'),
(92, 'Can view psu', 23, 'view_psu'),
(93, 'Can add inventory', 24, 'add_inventory'),
(94, 'Can change inventory', 24, 'change_inventory'),
(95, 'Can delete inventory', 24, 'delete_inventory'),
(96, 'Can view inventory', 24, 'view_inventory'),
(97, 'Can add purchase order', 25, 'add_purchaseorder'),
(98, 'Can change purchase order', 25, 'change_purchaseorder'),
(99, 'Can delete purchase order', 25, 'delete_purchaseorder'),
(100, 'Can view purchase order', 25, 'view_purchaseorder'),
(101, 'Can add inventory log', 26, 'add_inventorylog'),
(102, 'Can change inventory log', 26, 'change_inventorylog'),
(103, 'Can delete inventory log', 26, 'delete_inventorylog'),
(104, 'Can view inventory log', 26, 'view_inventorylog'),
(105, 'Can add purchase order item', 27, 'add_purchaseorderitem'),
(106, 'Can change purchase order item', 27, 'change_purchaseorderitem'),
(107, 'Can delete purchase order item', 27, 'delete_purchaseorderitem'),
(108, 'Can view purchase order item', 27, 'view_purchaseorderitem'),
(109, 'Can add product review', 28, 'add_productreview'),
(110, 'Can change product review', 28, 'change_productreview'),
(111, 'Can delete product review', 28, 'delete_productreview'),
(112, 'Can view product review', 28, 'view_productreview'),
(113, 'Can add cart', 29, 'add_cart'),
(114, 'Can change cart', 29, 'change_cart'),
(115, 'Can delete cart', 29, 'delete_cart'),
(116, 'Can view cart', 29, 'view_cart'),
(117, 'Can add invoice', 30, 'add_invoice'),
(118, 'Can change invoice', 30, 'change_invoice'),
(119, 'Can delete invoice', 30, 'delete_invoice'),
(120, 'Can view invoice', 30, 'view_invoice'),
(121, 'Can add order', 31, 'add_order'),
(122, 'Can change order', 31, 'change_order'),
(123, 'Can delete order', 31, 'delete_order'),
(124, 'Can view order', 31, 'view_order'),
(125, 'Can add order item', 32, 'add_orderitem'),
(126, 'Can change order item', 32, 'change_orderitem'),
(127, 'Can delete order item', 32, 'delete_orderitem'),
(128, 'Can view order item', 32, 'view_orderitem'),
(129, 'Can add payment', 33, 'add_payment'),
(130, 'Can change payment', 33, 'change_payment'),
(131, 'Can delete payment', 33, 'delete_payment'),
(132, 'Can view payment', 33, 'view_payment'),
(133, 'Can add tax', 34, 'add_tax'),
(134, 'Can change tax', 34, 'change_tax'),
(135, 'Can delete tax', 34, 'delete_tax'),
(136, 'Can view tax', 34, 'view_tax'),
(137, 'Can add return request', 35, 'add_returnrequest'),
(138, 'Can change return request', 35, 'change_returnrequest'),
(139, 'Can delete return request', 35, 'delete_returnrequest'),
(140, 'Can view return request', 35, 'view_returnrequest'),
(141, 'Can add refund', 36, 'add_refund'),
(142, 'Can change refund', 36, 'change_refund'),
(143, 'Can delete refund', 36, 'delete_refund'),
(144, 'Can view refund', 36, 'view_refund'),
(145, 'Can add return item', 37, 'add_returnitem'),
(146, 'Can change return item', 37, 'change_returnitem'),
(147, 'Can delete return item', 37, 'delete_returnitem'),
(148, 'Can view return item', 37, 'view_returnitem'),
(149, 'Can add order item tax', 38, 'add_orderitemtax'),
(150, 'Can change order item tax', 38, 'change_orderitemtax'),
(151, 'Can delete order item tax', 38, 'delete_orderitemtax'),
(152, 'Can view order item tax', 38, 'view_orderitemtax'),
(153, 'Can add cart item', 39, 'add_cartitem'),
(154, 'Can change cart item', 39, 'change_cartitem'),
(155, 'Can delete cart item', 39, 'delete_cartitem'),
(156, 'Can view cart item', 39, 'view_cartitem'),
(157, 'Can add service', 40, 'add_service'),
(158, 'Can change service', 40, 'change_service'),
(159, 'Can delete service', 40, 'delete_service'),
(160, 'Can view service', 40, 'view_service'),
(161, 'Can add service request', 41, 'add_servicerequest'),
(162, 'Can change service request', 41, 'change_servicerequest'),
(163, 'Can delete service request', 41, 'delete_servicerequest'),
(164, 'Can view service request', 41, 'view_servicerequest'),
(165, 'Can add pc build', 42, 'add_pcbuild'),
(166, 'Can change pc build', 42, 'change_pcbuild'),
(167, 'Can delete pc build', 42, 'delete_pcbuild'),
(168, 'Can view pc build', 42, 'view_pcbuild'),
(169, 'Can add pc build item', 43, 'add_pcbuilditem'),
(170, 'Can change pc build item', 43, 'change_pcbuilditem'),
(171, 'Can delete pc build item', 43, 'delete_pcbuilditem'),
(172, 'Can view pc build item', 43, 'view_pcbuilditem');

-- --------------------------------------------------------

--
-- Table structure for table `builds_pcbuild`
--

CREATE TABLE `builds_pcbuild` (
  `build_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  `description` longtext DEFAULT NULL,
  `image_url` varchar(100) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `builds_pcbuilditem`
--

CREATE TABLE `builds_pcbuilditem` (
  `build_item_id` int(11) NOT NULL,
  `component_type` varchar(50) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL CHECK (`quantity` >= 0),
  `created_at` datetime(6) NOT NULL,
  `build_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2026-03-09 11:16:21.191599', '2', 'ranaomdevshih2005@gmail.com', 1, '[{\"added\": {}}]', 6, 1),
(2, '2026-03-09 11:51:53.943573', '3', 'yashbariya9925@gmail.com', 1, '[{\"added\": {}}]', 6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(6, 'accounts', 'user'),
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(42, 'builds', 'pcbuild'),
(43, 'builds', 'pcbuilditem'),
(4, 'contenttypes', 'contenttype'),
(10, 'dashboard', 'brand'),
(11, 'dashboard', 'category'),
(24, 'inventory', 'inventory'),
(26, 'inventory', 'inventorylog'),
(25, 'inventory', 'purchaseorder'),
(27, 'inventory', 'purchaseorderitem'),
(9, 'inventory', 'supplier'),
(7, 'locations', 'address'),
(8, 'locations', 'pincode'),
(29, 'orders', 'cart'),
(39, 'orders', 'cartitem'),
(30, 'orders', 'invoice'),
(31, 'orders', 'order'),
(32, 'orders', 'orderitem'),
(38, 'orders', 'orderitemtax'),
(33, 'orders', 'payment'),
(36, 'orders', 'refund'),
(37, 'orders', 'returnitem'),
(35, 'orders', 'returnrequest'),
(34, 'orders', 'tax'),
(12, 'products', 'brand'),
(20, 'products', 'cabinet'),
(13, 'products', 'category'),
(22, 'products', 'cpu'),
(17, 'products', 'gpu'),
(19, 'products', 'motherboard'),
(15, 'products', 'product'),
(14, 'products', 'productimage'),
(28, 'products', 'productreview'),
(16, 'products', 'productvariant'),
(23, 'products', 'psu'),
(21, 'products', 'ram'),
(18, 'products', 'storage'),
(40, 'services', 'service'),
(41, 'services', 'servicerequest'),
(5, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'locations', '0001_initial', '2026-03-09 11:06:45.535511'),
(2, 'accounts', '0001_initial', '2026-03-09 11:06:45.574528'),
(3, 'accounts', '0002_customer', '2026-03-09 11:06:45.615195'),
(4, 'accounts', '0003_staff', '2026-03-09 11:06:45.649470'),
(5, 'accounts', '0004_remove_staff_profile_image_user_profile_image', '2026-03-09 11:06:45.672768'),
(6, 'accounts', '0005_staffaddress_customeraddress', '2026-03-09 11:06:45.832564'),
(7, 'accounts', '0006_alter_customeraddress_unique_together_and_more', '2026-03-09 11:06:46.573683'),
(8, 'accounts', '0007_initial', '2026-03-09 11:06:46.589628'),
(9, 'accounts', '0008_alter_user_managers_alter_user_first_name_and_more', '2026-03-09 11:06:46.623539'),
(10, 'contenttypes', '0001_initial', '2026-03-09 11:06:46.644951'),
(11, 'admin', '0001_initial', '2026-03-09 11:06:46.699419'),
(12, 'admin', '0002_logentry_remove_auto_add', '2026-03-09 11:06:46.707744'),
(13, 'admin', '0003_logentry_add_action_flag_choices', '2026-03-09 11:06:46.713870'),
(14, 'contenttypes', '0002_remove_content_type_name', '2026-03-09 11:06:46.746171'),
(15, 'auth', '0001_initial', '2026-03-09 11:06:46.857996'),
(16, 'auth', '0002_alter_permission_name_max_length', '2026-03-09 11:06:46.884760'),
(17, 'auth', '0003_alter_user_email_max_length', '2026-03-09 11:06:46.890457'),
(18, 'auth', '0004_alter_user_username_opts', '2026-03-09 11:06:46.898014'),
(19, 'auth', '0005_alter_user_last_login_null', '2026-03-09 11:06:46.903926'),
(20, 'auth', '0006_require_contenttypes_0002', '2026-03-09 11:06:46.906080'),
(21, 'auth', '0007_alter_validators_add_error_messages', '2026-03-09 11:06:46.911624'),
(22, 'auth', '0008_alter_user_username_max_length', '2026-03-09 11:06:46.916439'),
(23, 'auth', '0009_alter_user_last_name_max_length', '2026-03-09 11:06:46.921045'),
(24, 'auth', '0010_alter_group_name_max_length', '2026-03-09 11:06:46.933927'),
(25, 'auth', '0011_update_proxy_permissions', '2026-03-09 11:06:46.943758'),
(26, 'auth', '0012_alter_user_first_name_max_length', '2026-03-09 11:06:46.948553'),
(27, 'dashboard', '0001_initial', '2026-03-09 11:06:46.970365'),
(28, 'dashboard', '0002_suppliers', '2026-03-09 11:06:46.981440'),
(29, 'dashboard', '0003_alter_suppliers_gst_number', '2026-03-09 11:06:46.993173'),
(30, 'dashboard', '0004_alter_suppliers_phone_number', '2026-03-09 11:06:47.003429'),
(31, 'dashboard', '0005_supplieraddress', '2026-03-09 11:06:47.090718'),
(32, 'dashboard', '0006_delete_brand_delete_category_delete_supplieraddress_and_more', '2026-03-09 11:06:47.103085'),
(33, 'locations', '0002_remove_address_pincode_delete_addresstype_and_more', '2026-03-09 11:06:47.349338'),
(34, 'sessions', '0001_initial', '2026-03-09 11:06:47.371159'),
(35, 'accounts', '0009_alter_user_profile_image', '2026-03-10 10:12:51.637584'),
(36, 'locations', '0003_initial', '2026-03-10 11:14:15.410516'),
(37, 'inventory', '0001_initial', '2026-03-15 11:33:41.313423'),
(38, 'dashboard', '0007_initial', '2026-03-29 09:52:57.898519'),
(39, 'dashboard', '0008_delete_brand_delete_category', '2026-03-29 10:02:25.547822'),
(40, 'dashboard', '0009_delete_brand_delete_category', '2026-03-29 10:21:22.630170'),
(41, 'products', '0001_initial', '2026-03-29 10:23:13.814759'),
(42, 'products', '0002_product_productvariant_productimage', '2026-03-30 07:53:10.890882'),
(43, 'products', '0003_product_description', '2026-03-31 05:19:48.333391'),
(44, 'products', '0004_storage_ram_motherboard_gpu_cpu_cabinet', '2026-03-31 11:31:33.129742'),
(45, 'products', '0005_psu', '2026-03-31 11:35:52.224385'),
(46, 'products', '0006_productreview', '2026-04-01 04:32:23.468682'),
(47, 'builds', '0001_initial', '2026-04-01 04:32:23.541954'),
(48, 'inventory', '0002_inventory_supplier_is_active_purchaseorder_and_more', '2026-04-01 04:32:23.699291'),
(49, 'orders', '0001_initial', '2026-04-01 04:32:24.187119'),
(50, 'services', '0001_initial', '2026-04-01 04:32:24.295453'),
(51, 'products', '0007_product_is_trending', '2026-04-01 09:26:23.452768'),
(52, 'builds', '0002_pcbuild_description_pcbuild_image_url_pcbuild_price', '2026-04-01 10:06:12.734657');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('mmi8ngbnpthw1yhyvkrkrxislrtdlj0x', '.eJxVjMsOwiAQRf-FtSG8BqhL934DGRiQqoGktCvjv2uTLnR7zzn3xQJuaw3byEuYiZ2ZZKffLWJ65LYDumO7dZ56W5c58l3hBx382ik_L4f7d1Bx1G9tdMmAkJQu5CxRySIZJ60toAroqRgiEC5DdAhT9BKjUkDJea-dJsHeH_gsOBE:1w7nHv:R4CBYrzl4Dm0tFiCqdxdRrjk9iCAuUHJVUuNRhWSnUA', '2026-04-15 04:34:43.702722'),
('st4szisy1rk0cbnnrb60wu4wewzozlww', '.eJxVjMsOwiAQRf-FtSG8BqhL934DGRiQqoGktCvjv2uTLnR7zzn3xQJuaw3byEuYiZ2ZZKffLWJ65LYDumO7dZ56W5c58l3hBx382ik_L4f7d1Bx1G9tdMmAkJQu5CxRySIZJ60toAroqRgiEC5DdAhT9BKjUkDJea-dJsHeH_gsOBE:1vztl8:oVhp4NK_WFg1MfD9dA1Bh0FlqnAlW29_1cb6dS4ACVw', '2026-03-24 09:52:14.291485');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_inventory`
--

CREATE TABLE `inventory_inventory` (
  `variant_id` int(11) NOT NULL,
  `stock_quantity` int(10) UNSIGNED NOT NULL CHECK (`stock_quantity` >= 0),
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory_inventory`
--

INSERT INTO `inventory_inventory` (`variant_id`, `stock_quantity`, `updated_at`) VALUES
(8, 45, '2026-04-01 09:08:57.945504'),
(9, 55, '2026-04-01 08:53:31.388016'),
(10, 10, '2026-04-01 08:54:20.433516');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_inventorylog`
--

CREATE TABLE `inventory_inventorylog` (
  `inventory_log_id` int(11) NOT NULL,
  `quantity_change` int(11) NOT NULL,
  `action` varchar(10) NOT NULL,
  `reference_type` varchar(20) NOT NULL,
  `reference_id` int(11) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `variant_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory_inventorylog`
--

INSERT INTO `inventory_inventorylog` (`inventory_log_id`, `quantity_change`, `action`, `reference_type`, `reference_id`, `created_at`, `variant_id`) VALUES
(2, 5, 'remove', 'adjustment', 0, '2026-04-01 08:44:41.265352', 9),
(3, 50, 'add', 'adjustment', 0, '2026-04-01 08:53:31.389967', 9),
(4, 45, 'add', 'adjustment', 0, '2026-04-01 08:54:13.170074', 8),
(5, 10, 'add', 'adjustment', 0, '2026-04-01 08:54:20.433023', 10),
(6, 5, 'add', 'purchase_order', 14, '2026-04-01 09:08:03.879937', 8),
(7, 5, 'remove', 'return', 14, '2026-04-01 09:08:57.946726', 8);

-- --------------------------------------------------------

--
-- Table structure for table `inventory_purchaseorder`
--

CREATE TABLE `inventory_purchaseorder` (
  `purchase_order_id` int(11) NOT NULL,
  `status` varchar(15) NOT NULL,
  `order_date` datetime(6) DEFAULT NULL,
  `expected_delivery` datetime(6) DEFAULT NULL,
  `remarks` longtext DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `supplier_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_purchaseorderitem`
--

CREATE TABLE `inventory_purchaseorderitem` (
  `purchase_order_item_id` int(11) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL CHECK (`quantity` >= 0),
  `unit_cost` decimal(10,2) NOT NULL,
  `received_quantity` int(10) UNSIGNED NOT NULL CHECK (`received_quantity` >= 0),
  `created_at` datetime(6) NOT NULL,
  `purchase_order_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_supplier`
--

CREATE TABLE `inventory_supplier` (
  `supplier_id` int(11) NOT NULL,
  `supplier_name` varchar(50) NOT NULL,
  `company_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `gst_no` varchar(15) DEFAULT NULL,
  `address_one` varchar(300) NOT NULL,
  `address_two` varchar(300) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory_supplier`
--

INSERT INTO `inventory_supplier` (`supplier_id`, `supplier_name`, `company_name`, `email`, `phone`, `gst_no`, `address_one`, `address_two`, `created_at`, `updated_at`, `is_active`) VALUES
(10, 'Rajesh Khanna', 'Apex Steel Works', 'sales@apexsteel.com', '9820012345', '27AAACA1234A1Z5', 'Plot 42, MIDC, Andheri, Mumbai', 'Warehouse 5, Thane', '2026-03-29 11:05:34.954848', '2026-03-29 11:05:34.954878', 1),
(11, 'Sarah Jenkins', 'CloudNine Solutions', 'info@cloudnine.in', '9910054321', '07AAIFC5678B1Z2', '12th Floor, Tech Park, Delhi', '', '2026-03-29 11:07:04.965643', '2026-03-29 11:07:04.965673', 1),
(12, 'Amit Shah', 'Global Logistics Co.', 'ops@globallog.com', '9712398765', '24AABCG9012C1Z9', '101 Marine Drive, Surat, GJ', 'Port Terminal Office', '2026-03-29 11:07:42.518386', '2026-03-29 11:07:42.518425', 1),
(13, 'Priya Nair', 'EcoPrint Media', 'print@ecoprint.co', '9447011223', '32AADCE3456D1Z1', '55 Green St, Kochi, KL', '', '2026-03-29 11:08:59.599452', '2026-03-29 11:08:59.599483', 1),
(14, 'Michael Chen', 'Vertex Hardware', 'admin@vertex.com', '8122334455', '33AAHFV7890E1Z4', '89 Industrial Estate, Chennai', 'Retail Branch, Anna Nagar', '2026-03-29 11:10:09.665974', '2026-03-29 11:10:39.982185', 1),
(15, 'Fatima Sheikh', 'Zion Textiles', 'fatima@ziontex.in', '7055566778', '09AAJPZ2345F1Z7', 'Weaver’s Row, Kanpur, UP', 'Old Mill Rd, Kanpur', '2026-03-29 11:11:21.067527', '2026-03-29 11:11:21.067560', 1),
(16, 'David Miller', 'Heritage Foods', 'supply@heritage.com', '9830044556', '19AAKPH6789G1Z0', '14 Park Street, Kolkata, WB', '', '2026-03-29 11:12:11.617569', '2026-03-29 11:12:11.617605', 1),
(17, 'Kevin Parker', 'Nova Electronics', 'support@novaelec.in', '9108877665', '29AALPN0123H1Z3', 'Tech City, Bangalore, KA', 'Service Hub, Indiranagar', '2026-03-29 11:12:58.014876', '2026-03-29 11:12:58.014927', 1);

-- --------------------------------------------------------

--
-- Table structure for table `locations_address`
--

CREATE TABLE `locations_address` (
  `address_id` int(11) NOT NULL,
  `address` varchar(300) NOT NULL,
  `is_primary` tinyint(1) NOT NULL,
  `pincode_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `locations_address`
--

INSERT INTO `locations_address` (`address_id`, `address`, `is_primary`, `pincode_id`, `user_id`) VALUES
(3, '32, Umanager socity, rabariconly charrashta', 0, 1, 10),
(4, '33, Umanager Socity, Rabariy colony, charrasata', 0, 1, 12),
(5, '48, Ranchode sosayti, ', 0, 2, 11),
(6, '129, Ajay tenal mente, labha road', 0, 3, 8),
(7, '99, Kelasha nager, ', 0, 4, 9);

-- --------------------------------------------------------

--
-- Table structure for table `locations_pincode`
--

CREATE TABLE `locations_pincode` (
  `pincode_id` int(11) NOT NULL,
  `pincode` int(11) NOT NULL,
  `area_name` varchar(30) NOT NULL,
  `city` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `locations_pincode`
--

INSERT INTO `locations_pincode` (`pincode_id`, `pincode`, `area_name`, `city`) VALUES
(1, 380026, 'Amraiwadi', 'Ahmedabad'),
(2, 382440, 'Vatva', 'Ahmedabad'),
(3, 380009, 'Navrangpura', 'Ahmedabad'),
(4, 380054, 'Thaltej', 'Ahmedabad');

-- --------------------------------------------------------

--
-- Table structure for table `orders_cart`
--

CREATE TABLE `orders_cart` (
  `cart_id` int(11) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders_cartitem`
--

CREATE TABLE `orders_cartitem` (
  `cart_item_id` int(11) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL CHECK (`quantity` >= 0),
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders_invoice`
--

CREATE TABLE `orders_invoice` (
  `invoice_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `paid_amount` decimal(10,2) NOT NULL,
  `status` varchar(10) NOT NULL,
  `issued_at` datetime(6) DEFAULT NULL,
  `due_at` datetime(6) DEFAULT NULL,
  `order_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders_order`
--

CREATE TABLE `orders_order` (
  `order_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `shipping_method` varchar(10) NOT NULL,
  `status` varchar(15) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `address_id` int(11) NOT NULL,
  `cart_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders_orderitem`
--

CREATE TABLE `orders_orderitem` (
  `order_item_id` int(11) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL CHECK (`quantity` >= 0),
  `unit_price` decimal(10,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `order_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders_orderitemtax`
--

CREATE TABLE `orders_orderitemtax` (
  `order_item_tax_id` int(11) NOT NULL,
  `tax_amount` decimal(10,2) NOT NULL,
  `order_item_id` int(11) NOT NULL,
  `tax_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders_payment`
--

CREATE TABLE `orders_payment` (
  `payment_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `reference_type` varchar(20) NOT NULL,
  `reference_id` int(11) NOT NULL,
  `payment_method` varchar(10) NOT NULL,
  `gateway` varchar(50) NOT NULL,
  `gateway_payment_id` varchar(255) DEFAULT NULL,
  `gateway_order_id` varchar(255) DEFAULT NULL,
  `raw_response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`raw_response`)),
  `payment_status` varchar(15) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `paid_at` datetime(6) DEFAULT NULL,
  `invoice_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders_refund`
--

CREATE TABLE `orders_refund` (
  `refund_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `gateway_refund_id` varchar(255) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `reason` longtext DEFAULT NULL,
  `raw_response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`raw_response`)),
  `created_at` datetime(6) NOT NULL,
  `processed_at` datetime(6) DEFAULT NULL,
  `payment_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders_returnitem`
--

CREATE TABLE `orders_returnitem` (
  `return_item_id` int(11) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL CHECK (`quantity` >= 0),
  `refund_amount` decimal(10,2) NOT NULL,
  `is_restocked` tinyint(1) NOT NULL,
  `order_item_id` int(11) NOT NULL,
  `return_request_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders_returnrequest`
--

CREATE TABLE `orders_returnrequest` (
  `return_id` int(11) NOT NULL,
  `status` varchar(15) NOT NULL,
  `reason` longtext DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `approved_at` datetime(6) DEFAULT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders_tax`
--

CREATE TABLE `orders_tax` (
  `tax_id` int(11) NOT NULL,
  `tax_name` varchar(100) NOT NULL,
  `tax_rate` decimal(5,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products_brand`
--

CREATE TABLE `products_brand` (
  `brand_id` int(11) NOT NULL,
  `brand_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products_brand`
--

INSERT INTO `products_brand` (`brand_id`, `brand_name`) VALUES
(3, 'AMD'),
(18, 'ANT Esports'),
(4, 'ASUS'),
(5, 'Corsair'),
(13, 'DeepCool'),
(10, 'EVGA'),
(28, 'Fractal Design'),
(20, 'G.Skill'),
(9, 'Gigabyte'),
(2, 'Intel'),
(25, 'Lian Li'),
(8, 'MSI'),
(14, 'Noctua'),
(7, 'NVIDIA'),
(12, 'NZXT'),
(6, 'Samsung'),
(27, 'Sapphire'),
(11, 'Seasonic'),
(21, 'Western Digital');

-- --------------------------------------------------------

--
-- Table structure for table `products_cabinet`
--

CREATE TABLE `products_cabinet` (
  `id` bigint(20) NOT NULL,
  `tdp` int(10) UNSIGNED DEFAULT NULL CHECK (`tdp` >= 0),
  `supported_form_factors` varchar(100) NOT NULL,
  `max_gpu_length_mm` int(10) UNSIGNED NOT NULL CHECK (`max_gpu_length_mm` >= 0),
  `max_psu_length_mm` int(10) UNSIGNED NOT NULL CHECK (`max_psu_length_mm` >= 0),
  `max_cooler_height_mm` int(10) UNSIGNED NOT NULL CHECK (`max_cooler_height_mm` >= 0),
  `variant_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products_cabinet`
--

INSERT INTO `products_cabinet` (`id`, `tdp`, `supported_form_factors`, `max_gpu_length_mm`, `max_psu_length_mm`, `max_cooler_height_mm`, `variant_id`) VALUES
(1, NULL, 'ATX', 426, 220, 167, 21),
(2, NULL, 'ATX', 355, 255, 167, 22);

-- --------------------------------------------------------

--
-- Table structure for table `products_category`
--

CREATE TABLE `products_category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products_category`
--

INSERT INTO `products_category` (`category_id`, `category_name`) VALUES
(9, 'Cabinet'),
(10, 'Cooler'),
(2, 'CPU'),
(4, 'GPU'),
(12, 'HDD'),
(18, 'Headset'),
(16, 'Keyboard'),
(14, 'M.2'),
(15, 'Moniter'),
(5, 'Motherboard'),
(17, 'Mouse'),
(7, 'PSU'),
(6, 'RAM'),
(11, 'SSD'),
(19, 'UPS');

-- --------------------------------------------------------

--
-- Table structure for table `products_cpu`
--

CREATE TABLE `products_cpu` (
  `id` bigint(20) NOT NULL,
  `tdp` int(10) UNSIGNED DEFAULT NULL CHECK (`tdp` >= 0),
  `socket_type` varchar(50) NOT NULL,
  `cores` int(11) NOT NULL,
  `threads` int(11) NOT NULL,
  `base_clock` decimal(6,3) NOT NULL,
  `boost_clock` decimal(6,3) NOT NULL,
  `integrated_graphics` tinyint(1) NOT NULL,
  `variant_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products_cpu`
--

INSERT INTO `products_cpu` (`id`, `tdp`, `socket_type`, `cores`, `threads`, `base_clock`, `boost_clock`, `integrated_graphics`, `variant_id`) VALUES
(3, 170, 'AM4', 16, 32, 4.500, 5.700, 1, 8),
(4, 125, 'LGA1700', 24, 32, 3.200, 5.700, 1, 9);

-- --------------------------------------------------------

--
-- Table structure for table `products_gpu`
--

CREATE TABLE `products_gpu` (
  `id` bigint(20) NOT NULL,
  `tdp` int(10) UNSIGNED DEFAULT NULL CHECK (`tdp` >= 0),
  `memory_size` int(11) NOT NULL,
  `pcie_version` varchar(50) NOT NULL,
  `length_mm` int(11) NOT NULL,
  `interface_type` varchar(50) NOT NULL,
  `power_8pin_count` int(11) NOT NULL,
  `power_6pin_count` int(11) NOT NULL,
  `power_12vhpwr` tinyint(1) NOT NULL,
  `variant_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products_gpu`
--

INSERT INTO `products_gpu` (`id`, `tdp`, `memory_size`, `pcie_version`, `length_mm`, `interface_type`, `power_8pin_count`, `power_6pin_count`, `power_12vhpwr`, `variant_id`) VALUES
(1, 450, 24, 'PCIe 4.0 x16', 357, 'DVI/HDMI/DP', 1, 1, 0, 10),
(2, 355, 24, 'PCIe 4.0 x16', 320, 'DVI/HDMI/DP', 3, 0, 0, 11),
(3, 220, 12, 'PCIe 4.0 x16', 261, 'HDMI/DP', 0, 0, 0, 12);

-- --------------------------------------------------------

--
-- Table structure for table `products_motherboard`
--

CREATE TABLE `products_motherboard` (
  `id` bigint(20) NOT NULL,
  `tdp` int(10) UNSIGNED DEFAULT NULL CHECK (`tdp` >= 0),
  `socket_type` varchar(50) NOT NULL,
  `ram_type` varchar(10) NOT NULL,
  `form_factor` varchar(10) NOT NULL,
  `chipset` varchar(50) NOT NULL,
  `m2_slots` smallint(5) UNSIGNED NOT NULL CHECK (`m2_slots` >= 0),
  `sata_ports` smallint(5) UNSIGNED NOT NULL CHECK (`sata_ports` >= 0),
  `pcie_x1_slots` int(11) NOT NULL,
  `pcie_x16_slots` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products_motherboard`
--

INSERT INTO `products_motherboard` (`id`, `tdp`, `socket_type`, `ram_type`, `form_factor`, `chipset`, `m2_slots`, `sata_ports`, `pcie_x1_slots`, `pcie_x16_slots`, `variant_id`) VALUES
(1, 0, 'AM4', 'DDR5', 'ATX', 'B650', 3, 6, -2, 2, 13),
(2, 50, 'LGA1700', 'DDR5', 'ATX', 'Z790', 4, 4, -3, 1, 14);

-- --------------------------------------------------------

--
-- Table structure for table `products_product`
--

CREATE TABLE `products_product` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `warranty_months` int(10) UNSIGNED NOT NULL CHECK (`warranty_months` >= 0),
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `is_trending` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products_product`
--

INSERT INTO `products_product` (`product_id`, `product_name`, `warranty_months`, `created_at`, `updated_at`, `brand_id`, `category_id`, `description`, `is_trending`) VALUES
(6, 'i9 14k', 36, '2026-03-31 09:40:30.071158', '2026-04-01 09:31:58.388103', 2, 2, '', 1),
(11, 'AMD Ryzen 7000 Series', 36, '2026-04-01 05:04:03.666713', '2026-04-01 08:54:13.162876', 3, 2, 'User12 (5/5) - \"Absolute beast for multi-threaded workloads.\"', 0),
(12, 'Intel Core 14th Gen', 36, '2026-04-01 05:09:48.741765', '2026-04-01 08:44:41.260224', 2, 2, 'Incredibly fast, but runs extremely hot. Get a good AIO.', 0),
(13, 'NVIDIA GeForce RTX 40 Series', 36, '2026-04-01 05:13:09.868073', '2026-04-01 08:54:20.428589', 4, 4, 'Destroys 4K gaming, but it is massive. Check your case dimensions', 0),
(14, 'AMD Radeon RX 7000 Series', 24, '2026-04-01 05:33:03.557628', '2026-04-01 05:33:03.557667', 27, 4, 'Best value for rasterization performance right now.', 0),
(15, 'NVIDIA GeForce RTX 40 Series', 36, '2026-04-01 05:40:24.777160', '2026-04-01 05:40:24.777191', 9, 4, 'Great 1440p card, very quiet.', 0),
(16, 'MAG Series AMD Motherboards', 36, '2026-04-01 05:46:51.526167', '2026-04-01 05:46:51.526217', 8, 5, 'Solid VRMs and great IO for the price.', 0),
(17, 'ROG Strix Intel Motherboards', 38, '2026-04-01 05:50:44.823365', '2026-04-01 05:50:44.823409', 4, 5, 'Premium features, but the Asus Armoury Crate software is terrible.', 0),
(18, 'Trident Z5 Neo Series', 120, '2026-04-01 05:54:45.917757', '2026-04-01 05:54:45.917826', 20, 6, 'EXPO profile worked out of the box. Zero stability issues.', 0),
(19, 'Vengeance RGB Series', 120, '2026-04-01 05:59:47.108482', '2026-04-01 05:59:47.108539', 5, 6, 'Sweet spot for AMD Ryzen 7000 series.', 0),
(20, '990 PRO Series SSD', 60, '2026-04-01 06:03:35.687960', '2026-04-01 06:03:35.688015', 6, 14, 'Blazing fast read/write speeds. Essential for DirectStorage games.', 0),
(21, 'WD_BLACK SN850X Series', 60, '2026-04-01 06:07:36.635579', '2026-04-01 06:07:36.635615', 21, 14, 'Great drive, runs a bit warm so use the motherboard heatsink.', 0),
(22, 'RMx Shift Series', 120, '2026-04-01 06:12:15.477265', '2026-04-01 06:12:15.477317', 5, 7, 'The side-mounted cables made building in my case incredibly easy.', 0),
(23, 'Vertex GX Series', 120, '2026-04-01 06:16:23.926457', '2026-04-01 06:16:23.926508', 11, 7, 'Tier A power supply. Dead silent even under heavy gaming load.', 0),
(24, 'O11 Series Cases', 12, '2026-04-01 06:20:08.626181', '2026-04-01 06:20:08.626229', 25, 9, 'Beautiful showcase case. Cable management in the dual chamber is a breeze.', 0),
(25, 'North Series', 24, '2026-04-01 06:25:28.502298', '2026-04-01 06:25:28.502359', 28, 9, 'Finally, a PC case that looks like actual furniture and not a spaceship.', 0);

-- --------------------------------------------------------

--
-- Table structure for table `products_productimage`
--

CREATE TABLE `products_productimage` (
  `image_id` int(11) NOT NULL,
  `image` varchar(100) NOT NULL,
  `is_primary` tinyint(1) NOT NULL,
  `variant_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products_productimage`
--

INSERT INTO `products_productimage` (`image_id`, `image`, `is_primary`, `variant_id`) VALUES
(21, 'product_variants_images/51jNS8epPeL._SL1500_.jpg', 1, 8),
(22, 'product_variants_images/51qA89Dg6UL._SL1500_.jpg', 0, 8),
(23, 'product_variants_images/51wD3-OAv0L._SL1500_.jpg', 0, 8),
(24, 'product_variants_images/61rKeM-2DpL._SL1500_.jpg', 0, 8),
(25, 'product_variants_images/619ytLAytAL._SX679_.jpg', 1, 9),
(26, 'product_variants_images/61f8hqeg-dL._SX679_.jpg', 0, 9),
(27, 'product_variants_images/61x6XuKeEGL._SX679_.jpg', 0, 9),
(28, 'product_variants_images/61ujd7RN-3L._SX679_.jpg', 0, 9),
(29, 'product_variants_images/51Biv-FVi0L._SS40_.jpg', 1, 10),
(30, 'product_variants_images/41G3K1QLjdL._SS40_.jpg', 0, 10),
(31, 'product_variants_images/41cjI51AxQL._SS40_.jpg', 0, 10),
(32, 'product_variants_images/41BYaHgXDL._SS40_.jpg', 0, 10),
(33, 'product_variants_images/71rUjuE0qoL._SL1469_.jpg', 0, 10),
(34, 'product_variants_images/71zH2icVUsL._SL1500_.jpg', 0, 10),
(35, 'product_variants_images/414QUz0rAWL._SS40_.jpg', 0, 10),
(36, 'product_variants_images/617BMtpqmNL._SL1406_.jpg', 0, 10),
(37, 'product_variants_images/513-G9LMbOL._SS40_.jpg', 1, 11),
(38, 'product_variants_images/51DeZ6FOg5L._SS40_.jpg', 0, 11),
(39, 'product_variants_images/51Biv-FVi0L._SS40__N5so4nl.jpg', 1, 12),
(40, 'product_variants_images/31E6vxfzvpL._SS40_.jpg', 0, 12),
(41, 'product_variants_images/31idann8TdL._SS40_.jpg', 0, 12),
(42, 'product_variants_images/41EMMyLoVXL._SS40_.jpg', 0, 12),
(43, 'product_variants_images/41pR1Y6X2cL._SS40_.jpg', 0, 12),
(44, 'product_variants_images/61goxBF5bfL._SL1500_.jpg', 0, 12),
(45, 'product_variants_images/71OEy7TwhUL._SL1500_.jpg', 0, 12),
(46, 'product_variants_images/41XpW2Sp79L._SS40_.jpg', 1, 13),
(47, 'product_variants_images/41zQrWdmq9L._SS40_.jpg', 0, 13),
(48, 'product_variants_images/51uh0FPtGL._SS40_.jpg', 0, 13),
(49, 'product_variants_images/51q0xKMzy6L._SS40_.jpg', 0, 13),
(50, 'product_variants_images/51qvy2k54yL._SS40_.jpg', 0, 13),
(51, 'product_variants_images/71mbLOr5UhL._SL1500_.jpg', 0, 13),
(52, 'product_variants_images/715u9a1XOuL._SL1500_.jpg', 0, 13),
(53, 'product_variants_images/41cSJavJ3QL._SS40_.jpg', 1, 14),
(54, 'product_variants_images/51bT1YzSRjL._SS40_.jpg', 0, 14),
(55, 'product_variants_images/51e7nHopFL._SS40_.jpg', 0, 14),
(56, 'product_variants_images/51ku6zoHspL._SS40_.jpg', 0, 14),
(57, 'product_variants_images/51SwOH2ihL._SS40_.jpg', 0, 14),
(58, 'product_variants_images/510hcdhq7dL._SS40_.jpg', 0, 14),
(59, 'product_variants_images/61XlVUhmP_L._SL1200.webp', 1, 15),
(60, 'product_variants_images/31IEEONNmL._SS40_.jpg', 1, 16),
(61, 'product_variants_images/31-zmIkd0BL._SS40_.jpg', 0, 16),
(62, 'product_variants_images/51fLN1HwhL._SS40_.jpg', 0, 16),
(63, 'product_variants_images/51hMYMbYI7L._SS40_.jpg', 0, 16),
(64, 'product_variants_images/51MBfeMNJuL._SS40_.jpg', 0, 16),
(65, 'product_variants_images/418MnX0bKZL._SS40_.jpg', 0, 16),
(66, 'product_variants_images/31zlOP3YoL._SS40_.jpg', 1, 17),
(67, 'product_variants_images/41ApSoewVL._SS40_.jpg', 0, 17),
(68, 'product_variants_images/41IWzc1mUwL._SS40_.jpg', 0, 17),
(69, 'product_variants_images/41SOSO0Q3L._SS40_.jpg', 0, 17),
(70, 'product_variants_images/61oUXUCnzL._SL1200_.jpg', 0, 17),
(71, 'product_variants_images/71RHSRTUzL._SL1500_.jpg', 0, 17),
(72, 'product_variants_images/71XHEQZZWL._SX679_.jpg', 0, 17),
(73, 'product_variants_images/81rxocaalcL._SL1500_.jpg', 0, 17),
(74, 'product_variants_images/619A8I81-gL._SL1200_.jpg', 0, 17),
(75, 'product_variants_images/811HMbbmDaL._SL1500_.jpg', 0, 17),
(76, 'product_variants_images/310khwHZjtL._SS40_.jpg', 1, 18),
(77, 'product_variants_images/91aQPAqVAAL._SL1500_.jpg', 0, 18),
(78, 'product_variants_images/31zG5wzjNaL._SS40_.jpg', 0, 18),
(79, 'product_variants_images/41y1ElPe57L._SS40_.jpg', 0, 18),
(80, 'product_variants_images/51mhEgW7kEL._SS40_.jpg', 0, 18),
(81, 'product_variants_images/81amViqJ5LL._SL1500_.jpg', 0, 18),
(82, 'product_variants_images/81luU-6OFDL._SL1500_.jpg', 0, 18),
(83, 'product_variants_images/81qNtnKNFL._SL1500_.jpg', 0, 18),
(84, 'product_variants_images/41WKmC1jO5L._AC_US40_.jpg', 1, 19),
(85, 'product_variants_images/51BMivUUGlL._AC_US40_.jpg', 0, 19),
(86, 'product_variants_images/51okh5daAVL._AC_US40_.jpg', 0, 19),
(87, 'product_variants_images/51TkgW11ylL._AC_US40_.jpg', 0, 19),
(88, 'product_variants_images/51ZRs5vUZ2L._AC_US40_.jpg', 0, 19),
(89, 'product_variants_images/81cohE975dL._AC_SL1500_.jpg', 0, 19),
(90, 'product_variants_images/81qb0HipCL._AC_SL1500_.jpg', 0, 19),
(91, 'product_variants_images/41YlZdQtUZL._SX38_SY50_CR003850_.jpg', 1, 20),
(92, 'product_variants_images/41G7uzIQfL._SX38_SY50_CR003850_.jpg', 0, 20),
(93, 'product_variants_images/81vaTOziBOL._SL1500_.jpg', 0, 20),
(94, 'product_variants_images/81Y922LAg4L._SL1500_.jpg', 0, 20),
(95, 'product_variants_images/41gzz82yoPL._SX38_SY50_CR003850_.jpg', 0, 20),
(96, 'product_variants_images/41StTuduluL._SX38_SY50_CR003850_.jpg', 0, 20),
(97, 'product_variants_images/416bxwtyauL._SX38_SY50_CR003850_.jpg', 0, 20),
(98, 'product_variants_images/817IibC24L._SL1500_.jpg', 0, 20),
(99, 'product_variants_images/81jMOzwZ08L._SL1500_.jpg', 0, 20),
(100, 'product_variants_images/41iw9MjiqL._AC_US40_.jpg', 1, 21),
(101, 'product_variants_images/31HpWr21KYL._AC_US40_.jpg', 0, 21),
(102, 'product_variants_images/41mQELQfhtL._AC_US40_.jpg', 0, 21),
(103, 'product_variants_images/61KWhUxRJJL._AC_SL1200_.jpg', 0, 21),
(104, 'product_variants_images/61XuvzdlxhL._AC_SL1372_.jpg', 0, 21),
(105, 'product_variants_images/71HXFl35SGL._AC_SL1200_.jpg', 0, 21),
(106, 'product_variants_images/416lADiCWoL._AC_US40_.jpg', 0, 21),
(107, 'product_variants_images/417GEZWYenL._AC_US40_.jpg', 0, 21),
(108, 'product_variants_images/616CIe906L._AC_SL1200_.jpg', 0, 21),
(109, 'product_variants_images/6141sOuWBaL._AC_SL1200_.jpg', 0, 21),
(110, 'product_variants_images/81j6lE2tKyL._AC_SL1500_.jpg', 1, 22),
(111, 'product_variants_images/417KIaaHKWL._AC_US40_.jpg', 0, 22),
(112, 'product_variants_images/318o4rjhmjL._AC_US40_.jpg', 0, 22),
(113, 'product_variants_images/81kbao0byYL._AC_SL1500_.jpg', 0, 22),
(114, 'product_variants_images/71WUSDzuEjL._AC_SL1500_.jpg', 0, 22),
(115, 'product_variants_images/71sNDaoacfL._AC_SL1500_.jpg', 0, 22),
(116, 'product_variants_images/71hlfxZ5eRL._AC_SL1500_.jpg', 0, 22),
(117, 'product_variants_images/71jP7FjrSVL._AC_SL1500_.jpg', 0, 22),
(118, 'product_variants_images/71JzLfSRB1L._AC_SL1500_.jpg', 0, 22),
(119, 'product_variants_images/71MspiRUuL._AC_SL1500_.jpg', 0, 22),
(120, 'product_variants_images/71P20Fmk9VL._AC_SL1500_.jpg', 0, 22),
(121, 'product_variants_images/71qGthDIL2L._AC_SL1500_.jpg', 0, 22),
(122, 'product_variants_images/71ESOREig2L._AC_SL1500_.jpg', 0, 22),
(123, 'product_variants_images/71b0Lvpc9gL._AC_SL1500_.jpg', 0, 22),
(124, 'product_variants_images/51yC6aCp90L._AC_SL1500_.jpg', 0, 22),
(125, 'product_variants_images/41LAVpTm40L._AC_US40_.jpg', 0, 22),
(126, 'product_variants_images/41F6SdjBE2L._AC_US40_.jpg', 0, 22),
(127, 'product_variants_images/41BBuj1iyuL._AC_US40_.jpg', 0, 22),
(128, 'product_variants_images/611sGianmaL._AC_SL1500_.jpg', 0, 22),
(129, 'product_variants_images/711tbgDYsoL._AC_SL1500_.jpg', 0, 22),
(130, 'product_variants_images/6110y1NIrdL._AC_SL1500_.jpg', 0, 22);

-- --------------------------------------------------------

--
-- Table structure for table `products_productreview`
--

CREATE TABLE `products_productreview` (
  `review_id` int(11) NOT NULL,
  `rating` smallint(5) UNSIGNED NOT NULL CHECK (`rating` >= 0),
  `comment` longtext DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products_productvariant`
--

CREATE TABLE `products_productvariant` (
  `variant_id` int(11) NOT NULL,
  `variant_name` varchar(255) NOT NULL,
  `sku` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products_productvariant`
--

INSERT INTO `products_productvariant` (`variant_id`, `variant_name`, `sku`, `price`, `product_id`) VALUES
(8, 'Ryzen 9 7950X Boxed', 'SKU: AMD-R9-7950X', 56999.00, 11),
(9, 'Core i9-14900K Unlocked', 'INT-I9-14900K', 55199.00, 12),
(10, 'ROG Strix GeForce RTX 4090 OC Edition', 'ASUS-ROG-4090-OC', 600942.00, 13),
(11, 'Nitro+ AMD Radeon RX 7900 XTX Vapor-X', 'SKU: SAP-NITRO-7900XTX', 94000.00, 14),
(12, 'Windforce OC 12G', 'GIG-WF-4070S', 56299.00, 15),
(13, 'MAG B650 TOMAHAWK WIFI AM5', 'MSI-MAG-B650-TOM', 20500.00, 16),
(14, 'Z790-E Gaming WIFI II LGA1700', 'ASUS-STRIX-Z790E2', 44999.00, 17),
(15, '64GB (2x32GB) DDR5 6000MHz C30', 'GSK-TZ5N-64G-6000', 19502.00, 18),
(16, '32GB (2x16GB) DDR5 6000MHz C30 Black', 'COR-VEN-32G-6000', 24779.00, 19),
(17, '2TB PCIe 4.0 NVMe M.2', 'SAM-990P-2TB', 26649.00, 20),
(18, '4TB PCIe 4.0 NVMe M.2', 'WD-SN850X-4TB', 59000.00, 21),
(19, 'RM850x Shift 80 PLUS Gold Fully Modular', 'COR-RM850X-SHIFT', 13146.00, 22),
(20, '1000W 80+ Gold ATX 3.0', 'SEA-VGX-1000', 13292.00, 23),
(21, 'O11 Dynamic EVO Mid-Tower White', 'LL-O11D-EVO-WHT', 15963.00, 24),
(22, 'North Charcoal Black with Walnut Wood Front', 'FD-NORTH-BLK-TG', 11643.00, 25);

-- --------------------------------------------------------

--
-- Table structure for table `products_psu`
--

CREATE TABLE `products_psu` (
  `id` bigint(20) NOT NULL,
  `tdp` int(10) UNSIGNED DEFAULT NULL CHECK (`tdp` >= 0),
  `wattage` int(10) UNSIGNED NOT NULL CHECK (`wattage` >= 0),
  `form_factor` varchar(10) NOT NULL,
  `efficiency_rating` varchar(15) NOT NULL,
  `modularity` varchar(10) NOT NULL,
  `length_mm` int(10) UNSIGNED NOT NULL CHECK (`length_mm` >= 0),
  `power_8pin_count` smallint(5) UNSIGNED NOT NULL CHECK (`power_8pin_count` >= 0),
  `power_6pin_count` smallint(5) UNSIGNED NOT NULL CHECK (`power_6pin_count` >= 0),
  `power_12vhpwr` tinyint(1) NOT NULL,
  `variant_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products_psu`
--

INSERT INTO `products_psu` (`id`, `tdp`, `wattage`, `form_factor`, `efficiency_rating`, `modularity`, `length_mm`, `power_8pin_count`, `power_6pin_count`, `power_12vhpwr`, `variant_id`) VALUES
(1, NULL, 850, 'ATX', '80+ Gold', 'FULL', 160, 0, 0, 1, 19),
(2, NULL, 1000, 'ATX', '80+ Gold', 'FULL', 160, 0, 0, 1, 20);

-- --------------------------------------------------------

--
-- Table structure for table `products_ram`
--

CREATE TABLE `products_ram` (
  `id` bigint(20) NOT NULL,
  `tdp` int(10) UNSIGNED DEFAULT NULL CHECK (`tdp` >= 0),
  `ram_type` varchar(10) NOT NULL,
  `capacity_gb` int(10) UNSIGNED NOT NULL CHECK (`capacity_gb` >= 0),
  `speed_mhz` int(10) UNSIGNED NOT NULL CHECK (`speed_mhz` >= 0),
  `module_count` smallint(5) UNSIGNED NOT NULL CHECK (`module_count` >= 0),
  `variant_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products_ram`
--

INSERT INTO `products_ram` (`id`, `tdp`, `ram_type`, `capacity_gb`, `speed_mhz`, `module_count`, `variant_id`) VALUES
(1, 0, 'DDR5', 64, 6000, 2, 15),
(2, 5, 'DDR5', 16, 6000, 2, 16);

-- --------------------------------------------------------

--
-- Table structure for table `products_storage`
--

CREATE TABLE `products_storage` (
  `id` bigint(20) NOT NULL,
  `tdp` int(10) UNSIGNED DEFAULT NULL CHECK (`tdp` >= 0),
  `storage_type` varchar(50) NOT NULL,
  `capacity_gb` int(11) NOT NULL,
  `interface_type` varchar(50) NOT NULL,
  `form_factor` varchar(50) NOT NULL,
  `variant_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `services_service`
--

CREATE TABLE `services_service` (
  `service_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` longtext DEFAULT NULL,
  `base_price` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `services_servicerequest`
--

CREATE TABLE `services_servicerequest` (
  `service_request_id` int(11) NOT NULL,
  `status` varchar(15) NOT NULL,
  `issue_description` longtext DEFAULT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `service_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `variant_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `last_login` datetime(6) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(150) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `profile_image` varchar(100) DEFAULT NULL,
  `role` varchar(20) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`last_login`, `user_id`, `first_name`, `last_name`, `email`, `phone_number`, `password_hash`, `profile_image`, `role`, `is_active`, `created_at`, `updated_at`) VALUES
('2026-04-01 04:34:43.701801', 1, 'ashok', 'bariya', 'asohkbariya1982@gmail.com', NULL, 'pbkdf2_sha256$600000$B278IHZeeaxKMIfJKUbiif$Ec3i7Kd7CdQPfJTkOpDVUsLi4BkTQT5jiwywb/1VzWw=', NULL, 'admin', 1, '2026-03-09 11:07:55.147040', '2026-03-09 11:07:55.147294'),
('2026-03-09 11:51:32.000000', 3, 'Yash', 'Bariya', 'yashbariya9925@gmail.com', '8140031718', 'pbkdf2_sha256$600000$BzjzqHXIiVzDY7I4e7s15P$uLdhMzAk7glQIM98VO3tosnoNBN0CW+8VCamtCX6VPA=', NULL, 'customer', 1, '2026-03-09 11:51:53.934914', '2026-03-09 11:51:53.934923'),
(NULL, 4, 'Prem', 'Makawan', 'gamingxyz981@gmail.com', '7016455514', 'pbkdf2_sha256$600000$9tpcXhWFoaC5J6gS1BN1NC$vXpBdoKbvmVsn2j/1hjPux0zhMX9+VZmqM2s9aP4xE8=', NULL, 'customer', 1, '2026-03-10 05:02:57.458394', '2026-03-10 05:02:57.458622'),
(NULL, 5, 'Prince', 'Jain', 'princejain200595@gmail.com', '6352674484', 'pbkdf2_sha256$600000$yV2V5BZfvG7Jw2JgFTWTdf$c8h74pfIn4UufWIL4l7vmRb38jL4KX3OtPgOJF2SRiU=', NULL, 'customer', 1, '2026-03-10 05:25:42.551391', '2026-03-10 05:25:42.551420'),
(NULL, 6, 'Manish', 'Zala', 'manish2005@gmail.com', '9737682783', 'pbkdf2_sha256$600000$JWaLCIDM3icPPUhBVb682q$c7YGLUHVjR9f4Z3JD5CiPCWlvVNrfBhzpNhGru0RmNA=', NULL, 'customer', 1, '2026-03-10 05:29:57.115967', '2026-03-10 05:29:57.115987'),
(NULL, 7, 'Omdevshih', 'Rana', 'omdevshih82@gmail.com', '6355504818', 'pbkdf2_sha256$600000$QyuTh7kfbjbVnF4yOHaixD$EkFsaxm3j9tddWsyQfjadd9ADW3tI18tacF/JCMABik=', NULL, 'customer', 1, '2026-03-10 05:34:41.347327', '2026-03-10 05:34:41.347464'),
(NULL, 8, 'Vicky', 'Patel', 'vickypatel2000@gmail.com', '8469836615', 'pbkdf2_sha256$600000$Wjh5iD2m3XkcULKaxrbssk$n9RhHG6tDx6hCg4QFPjvhFyFGSwawZflX+DaO8lWpKQ=', 'profile_images/Screenshot_2026-03-10_at_3.50.19PM.png', 'employee', 1, '2026-03-10 10:22:58.647144', '2026-03-30 05:02:07.420313'),
(NULL, 9, 'Sumit', 'Mishara', 'sumitmishara2726@gmail.com', '9054513290', 'pbkdf2_sha256$600000$3bsRn4TRAmaQxszqE2iwXt$Xl70kgEsWlF0UPkr4Htpm0cn1h20eyU2Sedhe7LjOnc=', 'profile_images/Screenshot_2026-03-10_at_4.03.35PM.png', 'employee', 1, '2026-03-10 10:35:14.434415', '2026-03-30 05:02:44.572294'),
(NULL, 10, 'Harsh', 'Upadhaya', 'harshupadhaya2005@gmail.com', '9426966021', 'pbkdf2_sha256$600000$MzgRL5dQrwsMR9n7ibffXS$4R68TSSucL+aYTQTlOhATVKDWbdforeGKstb+RtpThU=', 'profile_images/DK.jpeg', 'employee', 1, '2026-03-10 10:38:03.657343', '2026-03-16 05:16:01.741591'),
(NULL, 11, 'Vikash', 'Gupata', 'vikashgupata2019@gmail.com', '8320882919', 'pbkdf2_sha256$600000$nZYZarnUvHgsc2FS5G4keg$EKfuO0r3cJh6PZEXGd/8Q7NNJ34PVhgUymmVdmcH6VY=', 'profile_images/Screenshot_2026-03-10_at_4.09.06PM.png', 'employee', 1, '2026-03-10 10:40:32.185119', '2026-03-30 05:01:04.114024'),
(NULL, 12, 'Sunil', 'Bariya', 'sunilbariya1516@gmail.com', '8866361516', 'pbkdf2_sha256$600000$jNY1IEFIW7Oni3YnCYxsjh$DK6JvGEEaFK2Y9ub5J4EcqwwQP7LlQapMdmPH+6U9jg=', 'profile_images/Screenshot_2026-03-10_at_4.12.31PM.png', 'employee', 1, '2026-03-10 10:43:25.224441', '2026-03-15 06:25:46.154122');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `builds_pcbuild`
--
ALTER TABLE `builds_pcbuild`
  ADD PRIMARY KEY (`build_id`),
  ADD KEY `builds_pcbuild_user_id_4ebb9ca1_fk_Users_user_id` (`user_id`);

--
-- Indexes for table `builds_pcbuilditem`
--
ALTER TABLE `builds_pcbuilditem`
  ADD PRIMARY KEY (`build_item_id`),
  ADD UNIQUE KEY `builds_pcbuilditem_build_id_variant_id_464e6beb_uniq` (`build_id`,`variant_id`),
  ADD KEY `builds_pcbuilditem_variant_id_4739bb90_fk_products_` (`variant_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_Users_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `inventory_inventory`
--
ALTER TABLE `inventory_inventory`
  ADD PRIMARY KEY (`variant_id`);

--
-- Indexes for table `inventory_inventorylog`
--
ALTER TABLE `inventory_inventorylog`
  ADD PRIMARY KEY (`inventory_log_id`),
  ADD KEY `inventory_inventoryl_variant_id_7fed3f72_fk_products_` (`variant_id`);

--
-- Indexes for table `inventory_purchaseorder`
--
ALTER TABLE `inventory_purchaseorder`
  ADD PRIMARY KEY (`purchase_order_id`),
  ADD KEY `inventory_purchaseor_supplier_id_c6bc28e9_fk_inventory` (`supplier_id`);

--
-- Indexes for table `inventory_purchaseorderitem`
--
ALTER TABLE `inventory_purchaseorderitem`
  ADD PRIMARY KEY (`purchase_order_item_id`),
  ADD UNIQUE KEY `inventory_purchaseorderi_purchase_order_id_varian_e418c12c_uniq` (`purchase_order_id`,`variant_id`),
  ADD KEY `inventory_purchaseor_variant_id_a4f807cf_fk_products_` (`variant_id`);

--
-- Indexes for table `inventory_supplier`
--
ALTER TABLE `inventory_supplier`
  ADD PRIMARY KEY (`supplier_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `gst_no` (`gst_no`);

--
-- Indexes for table `locations_address`
--
ALTER TABLE `locations_address`
  ADD PRIMARY KEY (`address_id`),
  ADD KEY `locations_address_pincode_id_5df9fee2_fk_locations` (`pincode_id`),
  ADD KEY `locations_address_user_id_49501546_fk_Users_user_id` (`user_id`);

--
-- Indexes for table `locations_pincode`
--
ALTER TABLE `locations_pincode`
  ADD PRIMARY KEY (`pincode_id`);

--
-- Indexes for table `orders_cart`
--
ALTER TABLE `orders_cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `orders_cartitem`
--
ALTER TABLE `orders_cartitem`
  ADD PRIMARY KEY (`cart_item_id`),
  ADD UNIQUE KEY `orders_cartitem_cart_id_variant_id_3af2015d_uniq` (`cart_id`,`variant_id`),
  ADD KEY `orders_cartitem_variant_id_a3661000_fk_products_` (`variant_id`);

--
-- Indexes for table `orders_invoice`
--
ALTER TABLE `orders_invoice`
  ADD PRIMARY KEY (`invoice_id`),
  ADD UNIQUE KEY `order_id` (`order_id`);

--
-- Indexes for table `orders_order`
--
ALTER TABLE `orders_order`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `orders_order_address_id_0daf897b_fk_locations_address_address_id` (`address_id`),
  ADD KEY `orders_order_cart_id_7e0252e3_fk_orders_cart_cart_id` (`cart_id`),
  ADD KEY `orders_order_user_id_e9b59eb1_fk_Users_user_id` (`user_id`);

--
-- Indexes for table `orders_orderitem`
--
ALTER TABLE `orders_orderitem`
  ADD PRIMARY KEY (`order_item_id`),
  ADD UNIQUE KEY `orders_orderitem_order_id_variant_id_09cb22b2_uniq` (`order_id`,`variant_id`),
  ADD KEY `orders_orderitem_variant_id_5d350ded_fk_products_` (`variant_id`);

--
-- Indexes for table `orders_orderitemtax`
--
ALTER TABLE `orders_orderitemtax`
  ADD PRIMARY KEY (`order_item_tax_id`),
  ADD UNIQUE KEY `orders_orderitemtax_order_item_id_tax_id_ea1018e6_uniq` (`order_item_id`,`tax_id`),
  ADD KEY `orders_orderitemtax_tax_id_bd07012e_fk_orders_tax_tax_id` (`tax_id`);

--
-- Indexes for table `orders_payment`
--
ALTER TABLE `orders_payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `orders_payment_invoice_id_157ae570_fk_orders_invoice_invoice_id` (`invoice_id`);

--
-- Indexes for table `orders_refund`
--
ALTER TABLE `orders_refund`
  ADD PRIMARY KEY (`refund_id`),
  ADD KEY `orders_refund_payment_id_a6b07753_fk_orders_payment_payment_id` (`payment_id`);

--
-- Indexes for table `orders_returnitem`
--
ALTER TABLE `orders_returnitem`
  ADD PRIMARY KEY (`return_item_id`),
  ADD UNIQUE KEY `orders_returnitem_return_request_id_order_item_id_99a4290b_uniq` (`return_request_id`,`order_item_id`),
  ADD KEY `orders_returnitem_order_item_id_670df9dc_fk_orders_or` (`order_item_id`);

--
-- Indexes for table `orders_returnrequest`
--
ALTER TABLE `orders_returnrequest`
  ADD PRIMARY KEY (`return_id`),
  ADD KEY `orders_returnrequest_order_id_176addea_fk_orders_order_order_id` (`order_id`),
  ADD KEY `orders_returnrequest_user_id_38896318_fk_Users_user_id` (`user_id`);

--
-- Indexes for table `orders_tax`
--
ALTER TABLE `orders_tax`
  ADD PRIMARY KEY (`tax_id`),
  ADD UNIQUE KEY `tax_name` (`tax_name`);

--
-- Indexes for table `products_brand`
--
ALTER TABLE `products_brand`
  ADD PRIMARY KEY (`brand_id`),
  ADD UNIQUE KEY `brand_name` (`brand_name`);

--
-- Indexes for table `products_cabinet`
--
ALTER TABLE `products_cabinet`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `variant_id` (`variant_id`);

--
-- Indexes for table `products_category`
--
ALTER TABLE `products_category`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_name` (`category_name`);

--
-- Indexes for table `products_cpu`
--
ALTER TABLE `products_cpu`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `variant_id` (`variant_id`);

--
-- Indexes for table `products_gpu`
--
ALTER TABLE `products_gpu`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `variant_id` (`variant_id`);

--
-- Indexes for table `products_motherboard`
--
ALTER TABLE `products_motherboard`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `variant_id` (`variant_id`);

--
-- Indexes for table `products_product`
--
ALTER TABLE `products_product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `products_product_brand_id_3e2e8fd1_fk_products_brand_brand_id` (`brand_id`),
  ADD KEY `products_product_category_id_9b594869_fk_products_` (`category_id`);

--
-- Indexes for table `products_productimage`
--
ALTER TABLE `products_productimage`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `products_productimag_variant_id_bf70ade8_fk_products_` (`variant_id`);

--
-- Indexes for table `products_productreview`
--
ALTER TABLE `products_productreview`
  ADD PRIMARY KEY (`review_id`),
  ADD UNIQUE KEY `products_productreview_variant_id_user_id_7a654704_uniq` (`variant_id`,`user_id`),
  ADD KEY `products_productreview_user_id_5c551aaa_fk_Users_user_id` (`user_id`);

--
-- Indexes for table `products_productvariant`
--
ALTER TABLE `products_productvariant`
  ADD PRIMARY KEY (`variant_id`),
  ADD UNIQUE KEY `sku` (`sku`),
  ADD KEY `products_productvari_product_id_d9c22902_fk_products_` (`product_id`);

--
-- Indexes for table `products_psu`
--
ALTER TABLE `products_psu`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `variant_id` (`variant_id`);

--
-- Indexes for table `products_ram`
--
ALTER TABLE `products_ram`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `variant_id` (`variant_id`);

--
-- Indexes for table `products_storage`
--
ALTER TABLE `products_storage`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `variant_id` (`variant_id`);

--
-- Indexes for table `services_service`
--
ALTER TABLE `services_service`
  ADD PRIMARY KEY (`service_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `services_servicerequest`
--
ALTER TABLE `services_servicerequest`
  ADD PRIMARY KEY (`service_request_id`),
  ADD KEY `services_servicerequ_order_id_8394a2a7_fk_orders_or` (`order_id`),
  ADD KEY `services_servicerequ_service_id_b9613175_fk_services_` (`service_id`),
  ADD KEY `services_servicerequest_user_id_5ba6e88c_fk_Users_user_id` (`user_id`),
  ADD KEY `services_servicerequ_variant_id_ddfc13cd_fk_products_` (`variant_id`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=173;

--
-- AUTO_INCREMENT for table `builds_pcbuild`
--
ALTER TABLE `builds_pcbuild`
  MODIFY `build_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `builds_pcbuilditem`
--
ALTER TABLE `builds_pcbuilditem`
  MODIFY `build_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `inventory_inventorylog`
--
ALTER TABLE `inventory_inventorylog`
  MODIFY `inventory_log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `inventory_purchaseorder`
--
ALTER TABLE `inventory_purchaseorder`
  MODIFY `purchase_order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory_purchaseorderitem`
--
ALTER TABLE `inventory_purchaseorderitem`
  MODIFY `purchase_order_item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory_supplier`
--
ALTER TABLE `inventory_supplier`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `locations_address`
--
ALTER TABLE `locations_address`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `locations_pincode`
--
ALTER TABLE `locations_pincode`
  MODIFY `pincode_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orders_cart`
--
ALTER TABLE `orders_cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders_cartitem`
--
ALTER TABLE `orders_cartitem`
  MODIFY `cart_item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders_invoice`
--
ALTER TABLE `orders_invoice`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders_order`
--
ALTER TABLE `orders_order`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders_orderitem`
--
ALTER TABLE `orders_orderitem`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders_orderitemtax`
--
ALTER TABLE `orders_orderitemtax`
  MODIFY `order_item_tax_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders_payment`
--
ALTER TABLE `orders_payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders_refund`
--
ALTER TABLE `orders_refund`
  MODIFY `refund_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders_returnitem`
--
ALTER TABLE `orders_returnitem`
  MODIFY `return_item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders_returnrequest`
--
ALTER TABLE `orders_returnrequest`
  MODIFY `return_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders_tax`
--
ALTER TABLE `orders_tax`
  MODIFY `tax_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products_brand`
--
ALTER TABLE `products_brand`
  MODIFY `brand_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `products_cabinet`
--
ALTER TABLE `products_cabinet`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products_category`
--
ALTER TABLE `products_category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `products_cpu`
--
ALTER TABLE `products_cpu`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products_gpu`
--
ALTER TABLE `products_gpu`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `products_motherboard`
--
ALTER TABLE `products_motherboard`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products_product`
--
ALTER TABLE `products_product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `products_productimage`
--
ALTER TABLE `products_productimage`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- AUTO_INCREMENT for table `products_productreview`
--
ALTER TABLE `products_productreview`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products_productvariant`
--
ALTER TABLE `products_productvariant`
  MODIFY `variant_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `products_psu`
--
ALTER TABLE `products_psu`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products_ram`
--
ALTER TABLE `products_ram`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products_storage`
--
ALTER TABLE `products_storage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services_service`
--
ALTER TABLE `services_service`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services_servicerequest`
--
ALTER TABLE `services_servicerequest`
  MODIFY `service_request_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `builds_pcbuild`
--
ALTER TABLE `builds_pcbuild`
  ADD CONSTRAINT `builds_pcbuild_user_id_4ebb9ca1_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

--
-- Constraints for table `builds_pcbuilditem`
--
ALTER TABLE `builds_pcbuilditem`
  ADD CONSTRAINT `builds_pcbuilditem_build_id_cf3146b1_fk_builds_pcbuild_build_id` FOREIGN KEY (`build_id`) REFERENCES `builds_pcbuild` (`build_id`),
  ADD CONSTRAINT `builds_pcbuilditem_variant_id_4739bb90_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

--
-- Constraints for table `inventory_inventory`
--
ALTER TABLE `inventory_inventory`
  ADD CONSTRAINT `inventory_inventory_variant_id_e5a3203f_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`);

--
-- Constraints for table `inventory_inventorylog`
--
ALTER TABLE `inventory_inventorylog`
  ADD CONSTRAINT `inventory_inventoryl_variant_id_7fed3f72_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`);

--
-- Constraints for table `inventory_purchaseorder`
--
ALTER TABLE `inventory_purchaseorder`
  ADD CONSTRAINT `inventory_purchaseor_supplier_id_c6bc28e9_fk_inventory` FOREIGN KEY (`supplier_id`) REFERENCES `inventory_supplier` (`supplier_id`);

--
-- Constraints for table `inventory_purchaseorderitem`
--
ALTER TABLE `inventory_purchaseorderitem`
  ADD CONSTRAINT `inventory_purchaseor_purchase_order_id_af9dd3c5_fk_inventory` FOREIGN KEY (`purchase_order_id`) REFERENCES `inventory_purchaseorder` (`purchase_order_id`),
  ADD CONSTRAINT `inventory_purchaseor_variant_id_a4f807cf_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`);

--
-- Constraints for table `locations_address`
--
ALTER TABLE `locations_address`
  ADD CONSTRAINT `locations_address_pincode_id_5df9fee2_fk_locations` FOREIGN KEY (`pincode_id`) REFERENCES `locations_pincode` (`pincode_id`),
  ADD CONSTRAINT `locations_address_user_id_49501546_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

--
-- Constraints for table `orders_cart`
--
ALTER TABLE `orders_cart`
  ADD CONSTRAINT `orders_cart_user_id_121a069e_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

--
-- Constraints for table `orders_cartitem`
--
ALTER TABLE `orders_cartitem`
  ADD CONSTRAINT `orders_cartitem_cart_id_529df5fa_fk_orders_cart_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `orders_cart` (`cart_id`),
  ADD CONSTRAINT `orders_cartitem_variant_id_a3661000_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`);

--
-- Constraints for table `orders_invoice`
--
ALTER TABLE `orders_invoice`
  ADD CONSTRAINT `orders_invoice_order_id_bc372e79_fk_orders_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`order_id`);

--
-- Constraints for table `orders_order`
--
ALTER TABLE `orders_order`
  ADD CONSTRAINT `orders_order_address_id_0daf897b_fk_locations_address_address_id` FOREIGN KEY (`address_id`) REFERENCES `locations_address` (`address_id`),
  ADD CONSTRAINT `orders_order_cart_id_7e0252e3_fk_orders_cart_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `orders_cart` (`cart_id`),
  ADD CONSTRAINT `orders_order_user_id_e9b59eb1_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

--
-- Constraints for table `orders_orderitem`
--
ALTER TABLE `orders_orderitem`
  ADD CONSTRAINT `orders_orderitem_order_id_fe61a34d_fk_orders_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`order_id`),
  ADD CONSTRAINT `orders_orderitem_variant_id_5d350ded_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`);

--
-- Constraints for table `orders_orderitemtax`
--
ALTER TABLE `orders_orderitemtax`
  ADD CONSTRAINT `orders_orderitemtax_order_item_id_7078bd83_fk_orders_or` FOREIGN KEY (`order_item_id`) REFERENCES `orders_orderitem` (`order_item_id`),
  ADD CONSTRAINT `orders_orderitemtax_tax_id_bd07012e_fk_orders_tax_tax_id` FOREIGN KEY (`tax_id`) REFERENCES `orders_tax` (`tax_id`);

--
-- Constraints for table `orders_payment`
--
ALTER TABLE `orders_payment`
  ADD CONSTRAINT `orders_payment_invoice_id_157ae570_fk_orders_invoice_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `orders_invoice` (`invoice_id`);

--
-- Constraints for table `orders_refund`
--
ALTER TABLE `orders_refund`
  ADD CONSTRAINT `orders_refund_payment_id_a6b07753_fk_orders_payment_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `orders_payment` (`payment_id`);

--
-- Constraints for table `orders_returnitem`
--
ALTER TABLE `orders_returnitem`
  ADD CONSTRAINT `orders_returnitem_order_item_id_670df9dc_fk_orders_or` FOREIGN KEY (`order_item_id`) REFERENCES `orders_orderitem` (`order_item_id`),
  ADD CONSTRAINT `orders_returnitem_return_request_id_a8d9d4ce_fk_orders_re` FOREIGN KEY (`return_request_id`) REFERENCES `orders_returnrequest` (`return_id`);

--
-- Constraints for table `orders_returnrequest`
--
ALTER TABLE `orders_returnrequest`
  ADD CONSTRAINT `orders_returnrequest_order_id_176addea_fk_orders_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`order_id`),
  ADD CONSTRAINT `orders_returnrequest_user_id_38896318_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

--
-- Constraints for table `products_cabinet`
--
ALTER TABLE `products_cabinet`
  ADD CONSTRAINT `products_cabinet_variant_id_7b2987c7_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`);

--
-- Constraints for table `products_cpu`
--
ALTER TABLE `products_cpu`
  ADD CONSTRAINT `products_cpu_variant_id_90a132e3_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`);

--
-- Constraints for table `products_gpu`
--
ALTER TABLE `products_gpu`
  ADD CONSTRAINT `products_gpu_variant_id_407ee883_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`);

--
-- Constraints for table `products_motherboard`
--
ALTER TABLE `products_motherboard`
  ADD CONSTRAINT `products_motherboard_variant_id_86f94d17_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`);

--
-- Constraints for table `products_product`
--
ALTER TABLE `products_product`
  ADD CONSTRAINT `products_product_brand_id_3e2e8fd1_fk_products_brand_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `products_brand` (`brand_id`),
  ADD CONSTRAINT `products_product_category_id_9b594869_fk_products_` FOREIGN KEY (`category_id`) REFERENCES `products_category` (`category_id`);

--
-- Constraints for table `products_productimage`
--
ALTER TABLE `products_productimage`
  ADD CONSTRAINT `products_productimag_variant_id_bf70ade8_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`);

--
-- Constraints for table `products_productreview`
--
ALTER TABLE `products_productreview`
  ADD CONSTRAINT `products_productrevi_variant_id_2b1dba36_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`),
  ADD CONSTRAINT `products_productreview_user_id_5c551aaa_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);

--
-- Constraints for table `products_productvariant`
--
ALTER TABLE `products_productvariant`
  ADD CONSTRAINT `products_productvari_product_id_d9c22902_fk_products_` FOREIGN KEY (`product_id`) REFERENCES `products_product` (`product_id`);

--
-- Constraints for table `products_psu`
--
ALTER TABLE `products_psu`
  ADD CONSTRAINT `products_psu_variant_id_83555a69_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`);

--
-- Constraints for table `products_ram`
--
ALTER TABLE `products_ram`
  ADD CONSTRAINT `products_ram_variant_id_d4f5a0de_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`);

--
-- Constraints for table `products_storage`
--
ALTER TABLE `products_storage`
  ADD CONSTRAINT `products_storage_variant_id_4b2204f0_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`);

--
-- Constraints for table `services_servicerequest`
--
ALTER TABLE `services_servicerequest`
  ADD CONSTRAINT `services_servicerequ_order_id_8394a2a7_fk_orders_or` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`order_id`),
  ADD CONSTRAINT `services_servicerequ_service_id_b9613175_fk_services_` FOREIGN KEY (`service_id`) REFERENCES `services_service` (`service_id`),
  ADD CONSTRAINT `services_servicerequ_variant_id_ddfc13cd_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`),
  ADD CONSTRAINT `services_servicerequest_user_id_5ba6e88c_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
