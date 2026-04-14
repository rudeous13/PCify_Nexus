-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 14, 2026 at 01:34 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pcify_nexus`
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
(172, 'Can view pc build item', 43, 'view_pcbuilditem'),
(173, 'Can add cooler', 44, 'add_cooler'),
(174, 'Can change cooler', 44, 'change_cooler'),
(175, 'Can delete cooler', 44, 'delete_cooler'),
(176, 'Can view cooler', 44, 'view_cooler'),
(177, 'Can add pc build', 45, 'add_pcbuild'),
(178, 'Can change pc build', 45, 'change_pcbuild'),
(179, 'Can delete pc build', 45, 'delete_pcbuild'),
(180, 'Can view pc build', 45, 'view_pcbuild');

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
  `price` decimal(10,2) DEFAULT NULL,
  `is_custom` tinyint(1) NOT NULL,
  `is_prebuilt` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `builds_pcbuild`
--

INSERT INTO `builds_pcbuild` (`build_id`, `name`, `created_at`, `user_id`, `description`, `image_url`, `price`, `is_custom`, `is_prebuilt`) VALUES
(2, 'Nexus Builde', '2026-04-12 03:27:18.327438', 1, 'Nexus Builder', 'prebuilt_pcs/71sNDaoacfL._AC_SL1500__jujqGCp.jpg', 480000.00, 0, 1),
(3, 'Nexus Monster Builder', '2026-04-12 04:04:14.352404', 1, 'Monster For gaming', 'prebuilt_pcs/71sNDaoacfL._AC_SL1500__oaeED92.jpg', 500000.00, 0, 1),
(6, '4k Editing PC', '2026-04-12 08:11:06.267050', 1, '4k fully editing fully PC', 'prebuilt_pcs/81qNtnKNFL._SL1500__mHP5WeP.jpg', 15000.00, 0, 1),
(14, 'Custom Nexus Build', '2026-04-12 12:14:10.084960', 16, 'User created custom PC configuration.', '', 793152.00, 1, 0),
(15, 'Custom Nexus Build', '2026-04-14 09:15:12.035256', 16, 'User created custom PC configuration.', '', 55199.00, 1, 0),
(16, 'Custom Nexus Build', '2026-04-14 09:15:41.764807', 16, 'User created custom PC configuration.', '', 815851.00, 1, 0),
(17, 'Custom Nexus Build', '2026-04-14 10:25:48.633458', 16, 'User created custom PC configuration.', '', 56999.00, 1, 0),
(18, 'Custom Nexus Build', '2026-04-14 10:28:27.292157', 16, 'User created custom PC configuration.', '', 814997.00, 1, 0),
(19, 'Custom Nexus Build', '2026-04-14 10:28:36.742958', 16, 'User created custom PC configuration.', '', 814997.00, 1, 0),
(20, 'Custom Nexus Build', '2026-04-14 10:31:35.024706', 16, 'User created custom PC configuration.', '', 814997.00, 1, 0),
(21, 'Custom Nexus Build', '2026-04-14 10:40:31.802983', 16, 'User created custom PC configuration.', '', 55199.00, 1, 0),
(22, 'Custom Nexus Build', '2026-04-14 11:02:51.376573', 16, 'User created custom PC configuration.', '', 313332.00, 1, 0),
(23, 'Custom Nexus Build', '2026-04-14 11:23:46.583761', 16, 'User created custom PC configuration.', '', 55199.00, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `builds_pcbuilditem`
--

CREATE TABLE `builds_pcbuilditem` (
  `build_item_id` int(11) NOT NULL,
  `component_type` varchar(50) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `build_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL
) ;

--
-- Dumping data for table `builds_pcbuilditem`
--

INSERT INTO `builds_pcbuilditem` (`build_item_id`, `component_type`, `quantity`, `created_at`, `build_id`, `variant_id`) VALUES
(15, 'cpu', 1, '2026-04-12 03:27:18.359886', 2, 8),
(16, 'mobo', 1, '2026-04-12 03:27:18.366147', 2, 13),
(17, 'gpu', 1, '2026-04-12 03:27:18.372960', 2, 11),
(18, 'ram', 1, '2026-04-12 03:27:18.376828', 2, 15),
(19, 'm2', 1, '2026-04-12 03:27:18.377914', 2, 17),
(20, 'psu', 1, '2026-04-12 03:27:18.382681', 2, 20),
(21, 'cabinet', 1, '2026-04-12 03:27:18.385358', 2, 21),
(22, 'cpu', 1, '2026-04-12 04:04:14.369000', 3, 8),
(23, 'mobo', 1, '2026-04-12 04:04:14.370628', 3, 13),
(24, 'gpu', 1, '2026-04-12 04:04:14.373707', 3, 10),
(25, 'ram', 1, '2026-04-12 04:04:14.374733', 3, 15),
(26, 'm2', 1, '2026-04-12 04:04:14.375599', 3, 18),
(27, 'psu', 1, '2026-04-12 04:04:14.376530', 3, 19),
(28, 'cabinet', 1, '2026-04-12 04:04:14.377334', 3, 22),
(41, 'cpu', 1, '2026-04-12 08:11:06.271192', 6, 9),
(42, 'mobo', 1, '2026-04-12 08:11:06.272661', 6, 14),
(43, 'gpu', 1, '2026-04-12 08:11:06.278301', 6, 12),
(44, 'ram', 1, '2026-04-12 08:11:06.282084', 6, 15),
(45, 'm2', 1, '2026-04-12 08:11:06.284505', 6, 17),
(46, 'psu', 1, '2026-04-12 08:11:06.287012', 6, 19),
(47, 'cabinet', 1, '2026-04-12 08:11:06.295431', 6, 21),
(110, 'cpu', 1, '2026-04-12 12:14:10.128273', 14, 8),
(111, 'mobo', 1, '2026-04-12 12:14:10.131326', 14, 13),
(112, 'gpu', 1, '2026-04-12 12:14:10.134724', 14, 10),
(113, 'ram', 1, '2026-04-12 12:14:10.138138', 14, 15),
(114, 'storage_m2', 1, '2026-04-12 12:14:10.142447', 14, 33),
(115, 'storage_hdd', 1, '2026-04-12 12:14:10.145764', 14, 23),
(116, 'cooler_aio', 1, '2026-04-12 12:14:10.154156', 14, 32),
(117, 'psu', 1, '2026-04-12 12:14:10.157252', 14, 19),
(118, 'case', 1, '2026-04-12 12:14:10.161286', 14, 21),
(119, 'cpu', 1, '2026-04-14 09:15:12.083454', 15, 9),
(120, 'cpu', 1, '2026-04-14 09:15:41.811330', 16, 9),
(121, 'mobo', 1, '2026-04-14 09:15:41.814674', 16, 14),
(122, 'gpu', 1, '2026-04-14 09:15:41.818051', 16, 10),
(123, 'ram', 1, '2026-04-14 09:15:41.821227', 16, 15),
(124, 'storage_m2', 1, '2026-04-14 09:15:41.825128', 16, 33),
(125, 'storage_hdd', 1, '2026-04-14 09:15:41.834331', 16, 23),
(126, 'cooler_aio', 1, '2026-04-14 09:15:41.837394', 16, 32),
(127, 'psu', 1, '2026-04-14 09:15:41.839535', 16, 19),
(128, 'case', 1, '2026-04-14 09:15:41.843579', 16, 21),
(129, 'cpu', 1, '2026-04-14 10:25:48.637410', 17, 8),
(130, 'cpu', 1, '2026-04-14 10:28:27.338823', 18, 9),
(131, 'mobo', 1, '2026-04-14 10:28:27.342853', 18, 14),
(132, 'gpu', 1, '2026-04-14 10:28:27.347157', 18, 10),
(133, 'ram', 1, '2026-04-14 10:28:27.351497', 18, 15),
(134, 'storage_m2', 1, '2026-04-14 10:28:27.360520', 18, 35),
(135, 'storage_hdd', 1, '2026-04-14 10:28:27.365210', 18, 23),
(136, 'cooler_aio', 1, '2026-04-14 10:28:27.369576', 18, 32),
(137, 'psu', 1, '2026-04-14 10:28:27.374172', 18, 20),
(138, 'case', 1, '2026-04-14 10:28:27.376988', 18, 21),
(139, 'cpu', 1, '2026-04-14 10:28:36.786422', 19, 9),
(140, 'mobo', 1, '2026-04-14 10:28:36.790091', 19, 14),
(141, 'gpu', 1, '2026-04-14 10:28:36.793188', 19, 10),
(142, 'ram', 1, '2026-04-14 10:28:36.796967', 19, 15),
(143, 'storage_m2', 1, '2026-04-14 10:28:36.800842', 19, 35),
(144, 'storage_hdd', 1, '2026-04-14 10:28:36.804386', 19, 23),
(145, 'cooler_aio', 1, '2026-04-14 10:28:36.812526', 19, 32),
(146, 'psu', 1, '2026-04-14 10:28:36.815767', 19, 20),
(147, 'case', 1, '2026-04-14 10:28:36.819071', 19, 21),
(148, 'cpu', 1, '2026-04-14 10:31:35.028427', 20, 9),
(149, 'mobo', 1, '2026-04-14 10:31:35.031804', 20, 14),
(150, 'gpu', 1, '2026-04-14 10:31:35.035800', 20, 10),
(151, 'ram', 1, '2026-04-14 10:31:35.040265', 20, 15),
(152, 'storage_m2', 1, '2026-04-14 10:31:35.043977', 20, 35),
(153, 'storage_hdd', 1, '2026-04-14 10:31:35.047971', 20, 23),
(154, 'cooler_aio', 1, '2026-04-14 10:31:35.051015', 20, 32),
(155, 'psu', 1, '2026-04-14 10:31:35.054165', 20, 20),
(156, 'case', 1, '2026-04-14 10:31:35.058336', 20, 21),
(157, 'cpu', 1, '2026-04-14 10:40:31.849249', 21, 9),
(158, 'cpu', 1, '2026-04-14 11:02:51.380225', 22, 9),
(159, 'mobo', 1, '2026-04-14 11:02:51.384049', 22, 14),
(160, 'gpu', 1, '2026-04-14 11:02:51.387244', 22, 11),
(161, 'ram', 1, '2026-04-14 11:02:51.389534', 22, 16),
(162, 'storage_m2', 1, '2026-04-14 11:02:51.391616', 22, 35),
(163, 'storage_hdd', 1, '2026-04-14 11:02:51.393335', 22, 23),
(164, 'cooler_aio', 1, '2026-04-14 11:02:51.395311', 22, 32),
(165, 'psu', 1, '2026-04-14 11:02:51.397193', 22, 20),
(166, 'case', 1, '2026-04-14 11:02:51.399030', 22, 21),
(167, 'cpu', 1, '2026-04-14 11:23:46.629853', 23, 9);

-- --------------------------------------------------------

--
-- Table structure for table `core_pcbuild`
--

CREATE TABLE `core_pcbuild` (
  `build_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `components` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`components`)),
  `total_price` decimal(10,2) NOT NULL,
  `image_url` varchar(200) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` int(11) DEFAULT NULL
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
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ;

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
(45, 'core', 'pcbuild'),
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
(44, 'products', 'cooler'),
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
(52, 'builds', '0002_pcbuild_description_pcbuild_image_url_pcbuild_price', '2026-04-01 10:06:12.734657'),
(53, 'orders', '0002_order_cf_order_id_order_cf_payment_id_and_more', '2026-04-05 07:07:36.796787'),
(54, 'payments', '0001_initial', '2026-04-05 07:07:37.760973'),
(55, 'payments', '0002_add_payment_method', '2026-04-05 07:07:38.016846'),
(56, 'payments', '0003_delete_cashfreeorder', '2026-04-05 07:07:38.075538'),
(57, 'orders', '0003_alter_order_payment_method_and_more', '2026-04-05 10:09:46.036754'),
(58, 'products', '0008_cooler', '2026-04-12 05:52:09.216061'),
(59, 'products', '0009_alter_cooler_cooler_type_alter_cooler_height_mm_and_more', '2026-04-12 11:18:19.571406'),
(60, 'orders', '0004_alter_cartitem_unique_together_cartitem_build_and_more', '2026-04-12 11:18:20.451647'),
(61, 'builds', '0003_pcbuild_is_custom_pcbuild_is_prebuilt', '2026-04-12 12:13:16.349601'),
(62, 'core', '0001_initial', '2026-04-14 09:14:54.279249'),
(63, 'orders', '0005_orderitem_build_alter_cartitem_build_and_more', '2026-04-14 11:14:17.312148'),
(64, 'orders', '0006_alter_cartitem_build_alter_orderitem_build', '2026-04-14 11:14:22.824780');

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
('4lmtpsgz61rxv8p8dsh5aa9zy2eq0xii', '.eJxVjssOwiAQRf-FtSEFCrQu3TfxD5qBGWxtpUkfujD-uzRBo8s5996TebIWtrVrt4Xmtkd2ZIIdfpkDP1DcA7xCvEzcT3Gde8f3Cs_pwpsJaTzl7p-gg6VL61IF0qC9VAGtQQxU-NIKY4KWQas6lIi6sKSdBV27SoCTUqO3VaWswiJJvz8Kk48IN0ru80y3Tz5m1sDwgAgJg1_7e0LrvNHrDR0NTw0:1wBlhI:FpD6yixBaSZSnwNEKogHg9iFcu3BVbJhIoQxY8pm6eQ', '2026-04-26 03:41:20.018422'),
('mmi8ngbnpthw1yhyvkrkrxislrtdlj0x', '.eJxVjMsOwiAQRf-FtSG8BqhL934DGRiQqoGktCvjv2uTLnR7zzn3xQJuaw3byEuYiZ2ZZKffLWJ65LYDumO7dZ56W5c58l3hBx382ik_L4f7d1Bx1G9tdMmAkJQu5CxRySIZJ60toAroqRgiEC5DdAhT9BKjUkDJea-dJsHeH_gsOBE:1w7nHv:R4CBYrzl4Dm0tFiCqdxdRrjk9iCAuUHJVUuNRhWSnUA', '2026-04-15 04:34:43.702722'),
('st4szisy1rk0cbnnrb60wu4wewzozlww', '.eJxVjMsOwiAQRf-FtSG8BqhL934DGRiQqoGktCvjv2uTLnR7zzn3xQJuaw3byEuYiZ2ZZKffLWJ65LYDumO7dZ56W5c58l3hBx382ik_L4f7d1Bx1G9tdMmAkJQu5CxRySIZJ60toAroqRgiEC5DdAhT9BKjUkDJea-dJsHeH_gsOBE:1vztl8:oVhp4NK_WFg1MfD9dA1Bh0FlqnAlW29_1cb6dS4ACVw', '2026-03-24 09:52:14.291485'),
('vmwf8v5589j08m9qy3uq6bylg08mx80s', '.eJxVjk1PhDAQhv9Lz27pBwV2j3vxoCQkJq63ZminUBcKgaJR438XssRkj_O8z8y8P2SZcdLekhPPHm5DgB7JiVQT9mRH3c5KuH5CgBWDif5jRXFacJd8D80mJT1aD8k4Dc53eMNz8mImxDC3Q9SCiezA5IEzDVGnlAsqeVVqL_lz9X3R0LTj2-uTZhfvHuMXHUOzftSwxFb_1yX8ntVgrhi2wL5DaAZqhhAnX9NNoXs603Kw2J139-5AC3O7bqfSoQJlhHQ2z6x1yEya8yxzSjgljy61VrEcVZ2DOtYFh1oIZU1eFDKXlpHfP3XxcEg:1wCaH7:Pvg4MLJ9CFEN7IIuuCSEMG8wP8c7O3WjVENiWI7iz3I', '2026-04-28 09:41:41.118618');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_inventory`
--

CREATE TABLE `inventory_inventory` (
  `variant_id` int(11) NOT NULL,
  `stock_quantity` int(10) UNSIGNED NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ;

--
-- Dumping data for table `inventory_inventory`
--

INSERT INTO `inventory_inventory` (`variant_id`, `stock_quantity`, `updated_at`) VALUES
(8, 45, '2026-04-01 09:08:57.945504'),
(9, 55, '2026-04-01 08:53:31.388016'),
(10, 10, '2026-04-01 08:54:20.433516'),
(17, 0, '2026-04-12 04:22:40.868877'),
(23, 1, '2026-04-12 04:25:21.876815'),
(32, 0, '2026-04-12 10:08:51.598243'),
(33, 0, '2026-04-12 10:11:47.110887'),
(35, 0, '2026-04-12 10:27:59.388628');

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
(7, 5, 'remove', 'return', 14, '2026-04-01 09:08:57.946726', 8),
(8, 1, 'add', 'adjustment', 0, '2026-04-12 04:25:21.877489', 23);

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
  `quantity` int(10) UNSIGNED NOT NULL,
  `unit_cost` decimal(10,2) NOT NULL,
  `received_quantity` int(10) UNSIGNED NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `purchase_order_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL
) ;

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
(7, '99, Kelasha nager, ', 0, 4, 9),
(8, 'D-15 Gordhan Park', 1, 5, 3),
(9, 'D-15 Gordhan Park', 1, 5, 1),
(10, 'D-15 Gordhan Park, D-15 Gordhan Park', 1, 5, 16);

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
(4, 380054, 'Thaltej', 'Ahmedabad'),
(5, 380008, 'Ahmedabad', 'Ahmedabad');

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

--
-- Dumping data for table `orders_cart`
--

INSERT INTO `orders_cart` (`cart_id`, `created_at`, `updated_at`, `user_id`) VALUES
(1, '2026-04-05 09:57:17.496250', '2026-04-05 09:57:17.496271', 3),
(2, '2026-04-05 12:52:18.225075', '2026-04-05 12:52:18.225146', 1),
(3, '2026-04-12 03:47:42.820965', '2026-04-12 03:47:42.821003', 16);

-- --------------------------------------------------------

--
-- Table structure for table `orders_cartitem`
--

CREATE TABLE `orders_cartitem` (
  `cart_item_id` int(11) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `build_id` int(11) DEFAULT NULL
) ;

--
-- Dumping data for table `orders_cartitem`
--

INSERT INTO `orders_cartitem` (`cart_item_id`, `quantity`, `created_at`, `updated_at`, `cart_id`, `variant_id`, `build_id`) VALUES
(8, 1, '2026-04-05 12:52:18.341023', '2026-04-05 12:52:18.341112', 2, 8, NULL);

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

--
-- Dumping data for table `orders_invoice`
--

INSERT INTO `orders_invoice` (`invoice_id`, `total_amount`, `paid_amount`, `status`, `issued_at`, `due_at`, `order_id`) VALUES
(1, 65134.82, 65134.82, 'paid', '2026-04-05 10:10:04.611436', NULL, 1),
(2, 651348.20, 651348.20, 'paid', '2026-04-05 12:05:07.593827', NULL, 2),
(3, 65134.82, 0.00, 'unpaid', '2026-04-05 12:54:16.748912', NULL, 3),
(4, 65134.82, 65134.82, 'paid', '2026-04-05 12:54:23.090044', NULL, 4),
(5, 67258.82, 67258.82, 'paid', '2026-04-12 08:04:58.531875', NULL, 5),
(6, 67258.82, 67258.82, 'paid', '2026-04-14 09:15:51.781730', NULL, 34),
(7, 155406.00, 155406.00, 'paid', '2026-04-14 09:17:11.272375', NULL, 35),
(8, 776370.38, 776370.38, 'paid', '2026-04-14 09:40:40.517822', NULL, 36),
(9, 67258.82, 67258.82, 'paid', '2026-04-14 11:02:04.321891', NULL, 38),
(10, 67258.82, 67258.82, 'paid', '2026-04-14 11:21:48.789305', NULL, 43);

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
  `user_id` int(11) NOT NULL,
  `cf_order_id` varchar(100) DEFAULT NULL,
  `cf_payment_id` varchar(100) DEFAULT NULL,
  `payment_method` varchar(20) DEFAULT NULL,
  `payment_raw` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payment_raw`)),
  `payment_session_id` varchar(200) DEFAULT NULL,
  `payment_status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders_order`
--

INSERT INTO `orders_order` (`order_id`, `total_amount`, `shipping_method`, `status`, `created_at`, `address_id`, `cart_id`, `user_id`, `cf_order_id`, `cf_payment_id`, `payment_method`, `payment_raw`, `payment_session_id`, `payment_status`) VALUES
(1, 65134.82, 'standard', 'completed', '2026-04-05 10:10:04.606923', 8, 1, 3, 'order_110358833BvyOIcW15E6EEjodgGYJ63Zupq', NULL, 'upi', '{\"cf_order_id\": \"2206616759\", \"order_id\": \"order_110358833BvyOIcW15E6EEjodgGYJ63Zupq\", \"entity\": \"order\", \"order_currency\": \"INR\", \"order_amount\": 65134.82, \"order_status\": \"PAID\", \"payment_session_id\": \"session_KxbsGo3dJ3gy8Nac6XzMzdQcIB7YqP04BAzAoxROUPouoGbBoQpDEEZL2-v5WsXhrji3sgBIqiucjJ6CkSDtHhvJpDN9feBKnJ6KDfhLC0hLxqRRaU0CIJEvERK-kQpaymentpayment\", \"order_expiry_time\": \"2026-05-05T15:40:05+05:30\", \"order_note\": null, \"created_at\": \"2026-04-05T15:40:05+05:30\", \"order_splits\": [], \"customer_details\": {\"customer_id\": \"user_3\", \"customer_email\": \"yashbariya9925@gmail.com\", \"customer_phone\": \"8140031718\", \"customer_name\": null, \"customer_bank_account_number\": null, \"customer_bank_ifsc\": null, \"customer_bank_code\": null, \"customer_uid\": null}, \"order_meta\": {\"return_url\": \"http://127.0.0.1:8000/payments/return/?business_order_id=1\", \"notify_url\": \"http://127.0.0.1:8000/payments/webhook/\", \"payment_methods\": null}, \"order_tags\": null, \"cart_details\": null, \"payment\": [{\"cf_payment_id\": \"5114926888234\", \"order_id\": \"order_110358833BvyOIcW15E6EEjodgGYJ63Zupq\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": true, \"order_amount\": 65134.82, \"payment_group\": \"upi\", \"payment_currency\": \"INR\", \"payment_amount\": 65134.82, \"payment_time\": \"2026-04-05T15:40:37+05:30\", \"payment_completion_time\": \"2026-04-05T15:40:56+05:30\", \"payment_status\": \"SUCCESS\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"1234567890\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"upi\": {\"channel\": \"collect\", \"upi_id\": \"testsuccess@gocash\"}}}, {\"cf_payment_id\": \"5114926888232\", \"order_id\": \"order_110358833BvyOIcW15E6EEjodgGYJ63Zupq\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": false, \"order_amount\": 65134.82, \"payment_group\": \"upi\", \"payment_currency\": \"INR\", \"payment_amount\": 65134.82, \"payment_time\": \"2026-04-05T15:40:19+05:30\", \"payment_completion_time\": \"2026-04-05T15:40:49+05:30\", \"payment_status\": \"PENDING\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"1234567890\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"upi\": {\"channel\": \"qrcode\", \"upi_id\": \"5114926888232\"}}}]}', 'session_gzl76RhM2BT6_6ZC6yTYse7y0b20gkYyYhDgbb3C2q1tJp5N41UyFqo60N1b80YdNpHaKDZlBFALALyagbM8gtaa6lsHC5ENWkTrsmKu5mxI0Qqjnia7cakMetrl2Qpaymentpayment', 'paid'),
(2, 651348.20, 'standard', 'cancelled', '2026-04-05 12:05:07.589523', 8, 1, 3, 'order_110358833BwCNmg7aZxuxQWzgWcFgAlKFav', NULL, 'wallet', '{\"cf_order_id\": \"2206617809\", \"order_id\": \"order_110358833BwCNmg7aZxuxQWzgWcFgAlKFav\", \"entity\": \"order\", \"order_currency\": \"INR\", \"order_amount\": 651348.2, \"order_status\": \"PAID\", \"payment_session_id\": \"session_7sOUuuUA7ZOaR6s-nGGbj7qgGCV8J5tNfLu55qcUXTFkOCpjeoacNkutxKG8YNzUBkKNa-3sZAoUbrz-mMtPVFjDVDKjq8_T4Lc2f51o07M3FaXhM8sHRdyVtU-F0gpaymentpayment\", \"order_expiry_time\": \"2026-05-05T17:35:08+05:30\", \"order_note\": null, \"created_at\": \"2026-04-05T17:35:08+05:30\", \"order_splits\": [], \"customer_details\": {\"customer_id\": \"user_3\", \"customer_email\": \"yashbariya9925@gmail.com\", \"customer_phone\": \"8140031718\", \"customer_name\": null, \"customer_bank_account_number\": null, \"customer_bank_ifsc\": null, \"customer_bank_code\": null, \"customer_uid\": null}, \"order_meta\": {\"return_url\": \"http://127.0.0.1:8000/payments/return/?business_order_id=2\", \"notify_url\": \"http://127.0.0.1:8000/payments/webhook/\", \"payment_methods\": null}, \"order_tags\": null, \"cart_details\": null, \"payment\": [{\"cf_payment_id\": \"5114926888827\", \"order_id\": \"order_110358833BwCNmg7aZxuxQWzgWcFgAlKFav\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": true, \"order_amount\": 651348.2, \"payment_group\": \"wallet\", \"payment_currency\": \"INR\", \"payment_amount\": 651348.2, \"payment_time\": \"2026-04-05T17:36:08+05:30\", \"payment_completion_time\": \"2026-04-05T17:36:28+05:30\", \"payment_status\": \"SUCCESS\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"5114926888827\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"app\": {\"channel\": \"link\", \"phone\": \"\", \"provider\": \"phonepe\"}}}]}', 'session_hrKqJh-DkXikk80deJklKlqjg4yjCPexju_FiKqS1tJd7XEb0K_VUDT8qqymP1BNSK4LkOfd0DgmdfbP6czVZAGnhjX_aC1rwdI9Zh_wYkB26P6JWlJlQC8_6l1t9Apaymentpayment', 'paid'),
(3, 65134.82, 'standard', 'pending', '2026-04-05 12:54:16.704480', 8, 1, 3, 'order_110358833BwIMNdBiNqCE8M3lfU1I0pUwOi', NULL, NULL, '{\"cf_order_id\": \"2206618252\", \"order_id\": \"order_110358833BwIMNdBiNqCE8M3lfU1I0pUwOi\", \"entity\": \"order\", \"order_currency\": \"INR\", \"order_amount\": 65134.82, \"order_status\": \"ACTIVE\", \"payment_session_id\": \"session_OInVX9HexNrvi1mC5aK3E9uHwHeIgJDSyWH4dzdGNkINCGkoHhgMoNhdCISEUyRP9Wad0_sqpBw9e9HCkBaWV0kjhPJK4llnSvxi4p0JuAAiFreuwhN_9PB5Zf_32Apaymentpayment\", \"order_expiry_time\": \"2026-05-05T18:24:16+05:30\", \"order_note\": null, \"created_at\": \"2026-04-05T18:24:16+05:30\", \"order_splits\": [], \"customer_details\": {\"customer_id\": \"user_3\", \"customer_email\": \"yashbariya9925@gmail.com\", \"customer_phone\": \"8140031718\", \"customer_name\": null, \"customer_bank_account_number\": null, \"customer_bank_ifsc\": null, \"customer_bank_code\": null, \"customer_uid\": null}, \"order_meta\": {\"return_url\": \"http://127.0.0.1:8000/payments/return/?business_order_id=3\", \"notify_url\": \"http://127.0.0.1:8000/payments/webhook/\", \"payment_methods\": null}, \"order_tags\": null, \"cart_details\": null}', 'session_OInVX9HexNrvi1mC5aK3E9uHwHeIgJDSyWH4dzdGNkINCGkoHhgMoNhdCISEUyRP9Wad0_sqpBw9e9HCkBaWV0kjhPJK4llnSvxi4p0JuAAiFreuwhN_9PB5Zf_32Apaymentpayment', 'active'),
(4, 65134.82, 'standard', 'processing', '2026-04-05 12:54:23.087718', 8, 1, 3, 'order_110358833BwIN3fytRjF6V2QFFaErYLyfdd', NULL, 'wallet', '{\"cf_order_id\": \"2206618253\", \"order_id\": \"order_110358833BwIN3fytRjF6V2QFFaErYLyfdd\", \"entity\": \"order\", \"order_currency\": \"INR\", \"order_amount\": 65134.82, \"order_status\": \"PAID\", \"payment_session_id\": \"session_OPLej228dIm14Za8yqLtJG6VVRKaurAcQyM1bpEp9Y9DYz3G8OgGxJCRGyb5zgaHx83hdYKu4hxDF8KZlC1ITn36__TZoczSSjeEOFZP8fW_R1JKK1Xlc9U9xjVTXApaymentpayment\", \"order_expiry_time\": \"2026-05-05T18:24:23+05:30\", \"order_note\": null, \"created_at\": \"2026-04-05T18:24:23+05:30\", \"order_splits\": [], \"customer_details\": {\"customer_id\": \"user_3\", \"customer_email\": \"yashbariya9925@gmail.com\", \"customer_phone\": \"8140031718\", \"customer_name\": null, \"customer_bank_account_number\": null, \"customer_bank_ifsc\": null, \"customer_bank_code\": null, \"customer_uid\": null}, \"order_meta\": {\"return_url\": \"http://127.0.0.1:8000/payments/return/?business_order_id=4\", \"notify_url\": \"http://127.0.0.1:8000/payments/webhook/\", \"payment_methods\": null}, \"order_tags\": null, \"cart_details\": null, \"payment\": [{\"cf_payment_id\": \"5114926889147\", \"order_id\": \"order_110358833BwIN3fytRjF6V2QFFaErYLyfdd\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": true, \"order_amount\": 65134.82, \"payment_group\": \"wallet\", \"payment_currency\": \"INR\", \"payment_amount\": 65134.82, \"payment_time\": \"2026-04-05T18:24:31+05:30\", \"payment_completion_time\": \"2026-04-05T18:24:40+05:30\", \"payment_status\": \"SUCCESS\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"5114926889147\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"app\": {\"channel\": \"link\", \"phone\": \"\", \"provider\": \"phonepe\"}}}]}', 'session_UNQCEOdyq3eI8nr_mcZ4cdMliWCjJDE4VAD-GYs6jr4iAOwijFyEVjTPrNllx3kNXvfDLyjsJCQv9SqG5me7E7UDIZXFW9uuX2bRnoaylgHxnNyjKMpk12PlWQHvewpaymentpayment', 'paid'),
(5, 67258.82, 'standard', 'completed', '2026-04-12 08:04:58.523762', 8, 1, 3, 'order_110358833CFV2hjYWkEJGsOylyYFwhVG6af', NULL, 'wallet', '{\"cf_order_id\": \"2206919131\", \"order_id\": \"order_110358833CFV2hjYWkEJGsOylyYFwhVG6af\", \"entity\": \"order\", \"order_currency\": \"INR\", \"order_amount\": 67258.82, \"order_status\": \"PAID\", \"payment_session_id\": \"session_94S-r1jxThoEobtNoMAXe9QdLaQbWTZcG43kdUfWG_gaYeotI_SaL3KHPmHUP5RkBQME0n76G9g9pzECci15_NOYKN6oo6jhg1z5BxSv16hL4v56P6ePNiSgPA5m1Qpaymentpayment\", \"order_expiry_time\": \"2026-05-12T13:35:00+05:30\", \"order_note\": null, \"created_at\": \"2026-04-12T13:35:00+05:30\", \"order_splits\": [], \"customer_details\": {\"customer_id\": \"user_3\", \"customer_email\": \"yashbariya9925@gmail.com\", \"customer_phone\": \"8140031718\", \"customer_name\": null, \"customer_bank_account_number\": null, \"customer_bank_ifsc\": null, \"customer_bank_code\": null, \"customer_uid\": null}, \"order_meta\": {\"return_url\": \"http://127.0.0.1:8000/payments/return/?business_order_id=5\", \"notify_url\": \"http://127.0.0.1:8000/payments/webhook/\", \"payment_methods\": null}, \"order_tags\": null, \"cart_details\": null, \"payment\": [{\"cf_payment_id\": \"5114927107377\", \"order_id\": \"order_110358833CFV2hjYWkEJGsOylyYFwhVG6af\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": true, \"order_amount\": 67258.82, \"payment_group\": \"wallet\", \"payment_currency\": \"INR\", \"payment_amount\": 67258.82, \"payment_time\": \"2026-04-12T13:35:03+05:30\", \"payment_completion_time\": \"2026-04-12T13:35:10+05:30\", \"payment_status\": \"SUCCESS\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"5114927107377\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"app\": {\"channel\": \"link\", \"phone\": \"\", \"provider\": \"phonepe\"}}}]}', 'session_S68wYdlZzKwke_YbLpDvXkF12f1FIWwPNAtEAdSx-1wVlT73qosC-QtMYJ8LzF4T7QhLZLwRF_K3ZN3f3rtS2NOH9yacQp1YRUFAC1TLf1vPfjXyLy8dCeqdb0kqUgpaymentpayment', 'paid'),
(34, 67258.82, 'standard', 'completed', '2026-04-14 09:15:51.778839', 10, 3, 16, 'order_110358833CLHukQHB0ZluVBYi7Ykfdf4hG4', NULL, 'netbanking', '{\"cf_order_id\": \"2207001065\", \"order_id\": \"order_110358833CLHukQHB0ZluVBYi7Ykfdf4hG4\", \"entity\": \"order\", \"order_currency\": \"INR\", \"order_amount\": 67258.82, \"order_status\": \"PAID\", \"payment_session_id\": \"session_XO5MPYVaD6dY6BiG5lvzpvWiLUIyxe8ZWtjVG80NrK30j3ob0wxEBq0sS7KwnbB1j9KIL4G5ZhWOvPj32HHlEf9qhOFNVINX9P14p6BOVV1ShETfo6nW5RRxGO8Fngpaymentpayment\", \"order_expiry_time\": \"2026-05-14T14:45:54+05:30\", \"order_note\": null, \"created_at\": \"2026-04-14T14:45:54+05:30\", \"order_splits\": [], \"customer_details\": {\"customer_id\": \"user_16\", \"customer_email\": \"mpremv2990@gmail.com\", \"customer_phone\": \"9925385511\", \"customer_name\": null, \"customer_bank_account_number\": null, \"customer_bank_ifsc\": null, \"customer_bank_code\": null, \"customer_uid\": null}, \"order_meta\": {\"return_url\": \"http://127.0.0.1:8000/payments/return/?business_order_id=34\", \"notify_url\": \"http://127.0.0.1:8000/payments/webhook/\", \"payment_methods\": null}, \"order_tags\": null, \"cart_details\": null, \"payment\": [{\"cf_payment_id\": \"5114927167951\", \"order_id\": \"order_110358833CLHukQHB0ZluVBYi7Ykfdf4hG4\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": true, \"order_amount\": 67258.82, \"payment_group\": \"net_banking\", \"payment_currency\": \"INR\", \"payment_amount\": 67258.82, \"payment_time\": \"2026-04-14T14:46:33+05:30\", \"payment_completion_time\": \"2026-04-14T14:46:39+05:30\", \"payment_status\": \"SUCCESS\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"5114927167951\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"netbanking\": {\"channel\": \"link\", \"netbanking_bank_code\": 3044, \"netbanking_bank_name\": \"State Bank Of India\", \"netbanking_ifsc\": \"\", \"netbanking_account_number\": \"\"}}}, {\"cf_payment_id\": \"5114927167944\", \"order_id\": \"order_110358833CLHukQHB0ZluVBYi7Ykfdf4hG4\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": false, \"order_amount\": 67258.82, \"payment_group\": \"upi\", \"payment_currency\": \"INR\", \"payment_amount\": 67258.82, \"payment_time\": \"2026-04-14T14:45:57+05:30\", \"payment_completion_time\": \"2026-04-14T14:46:27+05:30\", \"payment_status\": \"PENDING\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"1234567890\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"upi\": {\"channel\": \"qrcode\", \"upi_id\": \"5114927167944\"}}}]}', 'session_4sNcMvNppUvXCPtJh5a-mIVAEN8Lv64R1gdJZNqIMxsyLuURy-JxZlNUUW1lAFe_WM61E1qdZ8LZMyKzfsiIzyQDHrzTN2CB9_b68NkfAUWEtzn66EMiUlYj_Pypzgpaymentpayment', 'paid'),
(35, 155406.00, 'standard', 'completed', '2026-04-14 09:17:11.229242', 10, 3, 16, 'order_110358833CLI4jKnwE1MPCS3Lxx1im1PJz0', NULL, 'netbanking', '{\"cf_order_id\": \"2207001120\", \"order_id\": \"order_110358833CLI4jKnwE1MPCS3Lxx1im1PJz0\", \"entity\": \"order\", \"order_currency\": \"INR\", \"order_amount\": 155406.0, \"order_status\": \"PAID\", \"payment_session_id\": \"session_4DaMt289dniTLkCPhcv2NcbfUKmlQgTUVT3frs1JyZuNFdP9fl6W1XuD7dfGuFqa1R50xeq8i3UQTbV4lBdcE93I1QW5VV013gtaemCBiegWDaYP5GBnuZglRUO35Qpaymentpayment\", \"order_expiry_time\": \"2026-05-14T14:47:14+05:30\", \"order_note\": null, \"created_at\": \"2026-04-14T14:47:14+05:30\", \"order_splits\": [], \"customer_details\": {\"customer_id\": \"user_16\", \"customer_email\": \"mpremv2990@gmail.com\", \"customer_phone\": \"9925385511\", \"customer_name\": null, \"customer_bank_account_number\": null, \"customer_bank_ifsc\": null, \"customer_bank_code\": null, \"customer_uid\": null}, \"order_meta\": {\"return_url\": \"http://127.0.0.1:8000/payments/return/?business_order_id=35\", \"notify_url\": \"http://127.0.0.1:8000/payments/webhook/\", \"payment_methods\": null}, \"order_tags\": null, \"cart_details\": null, \"payment\": [{\"cf_payment_id\": \"5114927167994\", \"order_id\": \"order_110358833CLI4jKnwE1MPCS3Lxx1im1PJz0\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": true, \"order_amount\": 155406.0, \"payment_group\": \"net_banking\", \"payment_currency\": \"INR\", \"payment_amount\": 155406.0, \"payment_time\": \"2026-04-14T14:47:17+05:30\", \"payment_completion_time\": \"2026-04-14T14:47:22+05:30\", \"payment_status\": \"SUCCESS\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"5114927167994\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"netbanking\": {\"channel\": \"link\", \"netbanking_bank_code\": 3044, \"netbanking_bank_name\": \"State Bank Of India\", \"netbanking_ifsc\": \"\", \"netbanking_account_number\": \"\"}}}]}', 'session_5nYIsu0hI0H85aNQ_dNe-lAsuK_D4TsdqhuOTooNoezBYMFzBhBQ6HJMChj_I1pghw4pCiMCjGa93SEMEAprdIKyZx0OTxsAwypUcbt9B2-Dm9gKtom3BUtqFazj-Apaymentpayment', 'paid'),
(36, 776370.38, 'standard', 'completed', '2026-04-14 09:40:40.512041', 10, 3, 16, 'order_110358833CLKvmCoZPbWT30PJRWXyFE6AAF', NULL, 'netbanking', '{\"cf_order_id\": \"2207002050\", \"order_id\": \"order_110358833CLKvmCoZPbWT30PJRWXyFE6AAF\", \"entity\": \"order\", \"order_currency\": \"INR\", \"order_amount\": 776370.38, \"order_status\": \"PAID\", \"payment_session_id\": \"session_sacHfVWDGAonYDynvT-uL7HLTLFqBaWpz_rbuGlviNDx7Y5hSZ-lIo601QwXGT2ybHqRE6YrWKSMT_G0-0tet4xSEBGpYE6y1BM2KL1y8dLtvUI4Egl4tXHTnQFHuApaymentpayment\", \"order_expiry_time\": \"2026-05-14T15:10:43+05:30\", \"order_note\": null, \"created_at\": \"2026-04-14T15:10:43+05:30\", \"order_splits\": [], \"customer_details\": {\"customer_id\": \"user_16\", \"customer_email\": \"mpremv2990@gmail.com\", \"customer_phone\": \"9925385511\", \"customer_name\": null, \"customer_bank_account_number\": null, \"customer_bank_ifsc\": null, \"customer_bank_code\": null, \"customer_uid\": null}, \"order_meta\": {\"return_url\": \"http://127.0.0.1:8000/payments/return/?business_order_id=36\", \"notify_url\": \"http://127.0.0.1:8000/payments/webhook/\", \"payment_methods\": null}, \"order_tags\": null, \"cart_details\": null, \"payment\": [{\"cf_payment_id\": \"5114927168620\", \"order_id\": \"order_110358833CLKvmCoZPbWT30PJRWXyFE6AAF\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": true, \"order_amount\": 776370.38, \"payment_group\": \"net_banking\", \"payment_currency\": \"INR\", \"payment_amount\": 776370.38, \"payment_time\": \"2026-04-14T15:10:46+05:30\", \"payment_completion_time\": \"2026-04-14T15:10:53+05:30\", \"payment_status\": \"SUCCESS\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"5114927168620\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"netbanking\": {\"channel\": \"link\", \"netbanking_bank_code\": 3044, \"netbanking_bank_name\": \"State Bank Of India\", \"netbanking_ifsc\": \"\", \"netbanking_account_number\": \"\"}}}]}', 'session_UjrdIx5Sqat5VZwERADWtAX7SdVCg4p84gIXeUK9O9hDSVKycuQNUEwNC3HFj3gAUyXONV2x-tWxC4u3Tgo1wnwzgqRxqugUUteCIsiZDh809-FpH6uYME4nZlytagpaymentpayment', 'paid'),
(38, 67258.82, 'standard', 'pending', '2026-04-14 11:02:04.317476', 10, 3, 16, 'order_110358833CLUpdx4Qp4A6wpO9xBSW5Zef2U', NULL, 'netbanking', '{\"cf_order_id\": \"2207005743\", \"order_id\": \"order_110358833CLUpdx4Qp4A6wpO9xBSW5Zef2U\", \"entity\": \"order\", \"order_currency\": \"INR\", \"order_amount\": 67258.82, \"order_status\": \"PAID\", \"payment_session_id\": \"session_D1VTuzO3d8y91YDlcSA_D4ciY2rRjrNjTy1bvFv8usiTmLUzYw9uhryLsNB7AoGqRCD_JtsnK6BphF5I5_l624zWtF5UyEkK4t6Ls6vOLvFLyqEn4wLj2l2xkgOq8wpaymentpayment\", \"order_expiry_time\": \"2026-05-14T16:32:07+05:30\", \"order_note\": null, \"created_at\": \"2026-04-14T16:32:07+05:30\", \"order_splits\": [], \"customer_details\": {\"customer_id\": \"user_16\", \"customer_email\": \"mpremv2990@gmail.com\", \"customer_phone\": \"9925385511\", \"customer_name\": null, \"customer_bank_account_number\": null, \"customer_bank_ifsc\": null, \"customer_bank_code\": null, \"customer_uid\": null}, \"order_meta\": {\"return_url\": \"http://127.0.0.1:8000/payments/return/?business_order_id=38\", \"notify_url\": \"http://127.0.0.1:8000/payments/webhook/\", \"payment_methods\": null}, \"order_tags\": null, \"cart_details\": null, \"payment\": [{\"cf_payment_id\": \"5114927172039\", \"order_id\": \"order_110358833CLUpdx4Qp4A6wpO9xBSW5Zef2U\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": true, \"order_amount\": 67258.82, \"payment_group\": \"net_banking\", \"payment_currency\": \"INR\", \"payment_amount\": 67258.82, \"payment_time\": \"2026-04-14T16:32:10+05:30\", \"payment_completion_time\": \"2026-04-14T16:32:18+05:30\", \"payment_status\": \"SUCCESS\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"5114927172039\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"netbanking\": {\"channel\": \"link\", \"netbanking_bank_code\": 3044, \"netbanking_bank_name\": \"State Bank Of India\", \"netbanking_ifsc\": \"\", \"netbanking_account_number\": \"\"}}}]}', 'session_0zA7v0Bbq3TVowguaLW-xAYx1LqeLJVm5kBgR9sieaQOx_9rjFJauxgyLHwLkMtny4xDO8C9k8B3A363Adpk4u7IgkawKfu17OwFLx5KOcil6kOAj3iYF8fELnBotgpaymentpayment', 'paid'),
(43, 67258.82, 'standard', 'pending', '2026-04-14 11:21:48.788286', 10, 3, 16, 'order_110358833CLXEPWBti4pUEHq2JYAZhQwzAp', NULL, 'upi', '{\"cf_order_id\": \"2207006259\", \"order_id\": \"order_110358833CLXEPWBti4pUEHq2JYAZhQwzAp\", \"entity\": \"order\", \"order_currency\": \"INR\", \"order_amount\": 67258.82, \"order_status\": \"PAID\", \"payment_session_id\": \"session_Sx5g-sUsMTZExGI6c83ie1-emfvYwOQ6KOc8sP_BDqVfG8qpYAtRcKLK8H9vOH7Cz6nTHZy0cpj9eVOC-6Ww4Iq4_EFi919f-OmWg4cZTGfPP59WBAAg44RUdZK3Rgpaymentpayment\", \"order_expiry_time\": \"2026-05-14T16:51:52+05:30\", \"order_note\": null, \"created_at\": \"2026-04-14T16:51:52+05:30\", \"order_splits\": [], \"customer_details\": {\"customer_id\": \"user_16\", \"customer_email\": \"mpremv2990@gmail.com\", \"customer_phone\": \"9925385511\", \"customer_name\": null, \"customer_bank_account_number\": null, \"customer_bank_ifsc\": null, \"customer_bank_code\": null, \"customer_uid\": null}, \"order_meta\": {\"return_url\": \"http://127.0.0.1:8000/payments/return/?business_order_id=43\", \"notify_url\": \"http://127.0.0.1:8000/payments/webhook/\", \"payment_methods\": null}, \"order_tags\": null, \"cart_details\": null, \"payment\": [{\"cf_payment_id\": \"5114927172346\", \"order_id\": \"order_110358833CLXEPWBti4pUEHq2JYAZhQwzAp\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": true, \"order_amount\": 67258.82, \"payment_group\": \"upi\", \"payment_currency\": \"INR\", \"payment_amount\": 67258.82, \"payment_time\": \"2026-04-14T16:51:54+05:30\", \"payment_completion_time\": \"2026-04-14T16:52:23+05:30\", \"payment_status\": \"SUCCESS\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"1234567890\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"upi\": {\"channel\": \"qrcode\"}}}]}', 'session_4fs512WTLCClRPCV1ry4131dVYgPfbDK1CrqYeqrrYy8AE_2wfGTBtZnuimMhQlced7dNh7nOKbntRUB2ttJWc9DG-_N7D5eY4PBoqcy4TnCGHnAwjzEkNBw9nEwZApaymentpayment', 'paid');

-- --------------------------------------------------------

--
-- Table structure for table `orders_orderitem`
--

CREATE TABLE `orders_orderitem` (
  `order_item_id` int(11) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `order_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL,
  `build_id` int(11) DEFAULT NULL
) ;

--
-- Dumping data for table `orders_orderitem`
--

INSERT INTO `orders_orderitem` (`order_item_id`, `quantity`, `unit_price`, `created_at`, `order_id`, `variant_id`, `build_id`) VALUES
(1, 1, 55199.00, '2026-04-05 10:10:04.608748', 1, 9, NULL),
(2, 10, 55199.00, '2026-04-05 12:05:07.591042', 2, 9, NULL),
(3, 1, 55199.00, '2026-04-05 12:54:16.747793', 3, 9, NULL),
(4, 1, 55199.00, '2026-04-05 12:54:23.088405', 4, 9, NULL),
(5, 1, 56999.00, '2026-04-12 08:04:58.529219', 5, 8, NULL),
(6, 1, 56999.00, '2026-04-14 09:15:51.781281', 34, 8, NULL),
(7, 1, 56999.00, '2026-04-14 09:17:11.270463', 35, 8, NULL),
(8, 1, 55199.00, '2026-04-14 09:17:11.270500', 35, 9, NULL),
(9, 1, 19502.00, '2026-04-14 09:17:11.270513', 35, 15, NULL),
(10, 1, 56999.00, '2026-04-14 09:40:40.514090', 36, 8, NULL),
(11, 1, 600942.00, '2026-04-14 09:40:40.514166', 36, 10, NULL),
(13, 1, 56999.00, '2026-04-14 11:02:04.320101', 38, 8, NULL),
(14, 1, 56999.00, '2026-04-14 11:21:48.789035', 43, 8, NULL);

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
  `payment_method` varchar(20) NOT NULL,
  `gateway` varchar(50) NOT NULL,
  `gateway_payment_id` varchar(255) DEFAULT NULL,
  `gateway_order_id` varchar(255) DEFAULT NULL,
  `raw_response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `payment_status` varchar(15) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `paid_at` datetime(6) DEFAULT NULL,
  `invoice_id` int(11) NOT NULL
) ;

--
-- Dumping data for table `orders_payment`
--

INSERT INTO `orders_payment` (`payment_id`, `amount`, `reference_type`, `reference_id`, `payment_method`, `gateway`, `gateway_payment_id`, `gateway_order_id`, `raw_response`, `payment_status`, `created_at`, `paid_at`, `invoice_id`) VALUES
(1, 65134.82, 'order', 1, 'upi', 'cashfree', NULL, 'order_110358833BvyOIcW15E6EEjodgGYJ63Zupq', '{\"cf_order_id\": \"2206616759\", \"order_id\": \"order_110358833BvyOIcW15E6EEjodgGYJ63Zupq\", \"entity\": \"order\", \"order_currency\": \"INR\", \"order_amount\": 65134.82, \"order_status\": \"PAID\", \"payment_session_id\": \"session_KxbsGo3dJ3gy8Nac6XzMzdQcIB7YqP04BAzAoxROUPouoGbBoQpDEEZL2-v5WsXhrji3sgBIqiucjJ6CkSDtHhvJpDN9feBKnJ6KDfhLC0hLxqRRaU0CIJEvERK-kQpaymentpayment\", \"order_expiry_time\": \"2026-05-05T15:40:05+05:30\", \"order_note\": null, \"created_at\": \"2026-04-05T15:40:05+05:30\", \"order_splits\": [], \"customer_details\": {\"customer_id\": \"user_3\", \"customer_email\": \"yashbariya9925@gmail.com\", \"customer_phone\": \"8140031718\", \"customer_name\": null, \"customer_bank_account_number\": null, \"customer_bank_ifsc\": null, \"customer_bank_code\": null, \"customer_uid\": null}, \"order_meta\": {\"return_url\": \"http://127.0.0.1:8000/payments/return/?business_order_id=1\", \"notify_url\": \"http://127.0.0.1:8000/payments/webhook/\", \"payment_methods\": null}, \"order_tags\": null, \"cart_details\": null, \"payment\": [{\"cf_payment_id\": \"5114926888234\", \"order_id\": \"order_110358833BvyOIcW15E6EEjodgGYJ63Zupq\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": true, \"order_amount\": 65134.82, \"payment_group\": \"upi\", \"payment_currency\": \"INR\", \"payment_amount\": 65134.82, \"payment_time\": \"2026-04-05T15:40:37+05:30\", \"payment_completion_time\": \"2026-04-05T15:40:56+05:30\", \"payment_status\": \"SUCCESS\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"1234567890\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"upi\": {\"channel\": \"collect\", \"upi_id\": \"testsuccess@gocash\"}}}, {\"cf_payment_id\": \"5114926888232\", \"order_id\": \"order_110358833BvyOIcW15E6EEjodgGYJ63Zupq\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": false, \"order_amount\": 65134.82, \"payment_group\": \"upi\", \"payment_currency\": \"INR\", \"payment_amount\": 65134.82, \"payment_time\": \"2026-04-05T15:40:19+05:30\", \"payment_completion_time\": \"2026-04-05T15:40:49+05:30\", \"payment_status\": \"PENDING\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"1234567890\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"upi\": {\"channel\": \"qrcode\", \"upi_id\": \"5114926888232\"}}}]}', 'completed', '2026-04-05 10:11:04.354496', '2026-04-05 10:11:04.352973', 1),
(2, 651348.20, 'order', 2, 'wallet', 'cashfree', NULL, 'order_110358833BwCNmg7aZxuxQWzgWcFgAlKFav', '{\"cf_order_id\": \"2206617809\", \"order_id\": \"order_110358833BwCNmg7aZxuxQWzgWcFgAlKFav\", \"entity\": \"order\", \"order_currency\": \"INR\", \"order_amount\": 651348.2, \"order_status\": \"PAID\", \"payment_session_id\": \"session_7sOUuuUA7ZOaR6s-nGGbj7qgGCV8J5tNfLu55qcUXTFkOCpjeoacNkutxKG8YNzUBkKNa-3sZAoUbrz-mMtPVFjDVDKjq8_T4Lc2f51o07M3FaXhM8sHRdyVtU-F0gpaymentpayment\", \"order_expiry_time\": \"2026-05-05T17:35:08+05:30\", \"order_note\": null, \"created_at\": \"2026-04-05T17:35:08+05:30\", \"order_splits\": [], \"customer_details\": {\"customer_id\": \"user_3\", \"customer_email\": \"yashbariya9925@gmail.com\", \"customer_phone\": \"8140031718\", \"customer_name\": null, \"customer_bank_account_number\": null, \"customer_bank_ifsc\": null, \"customer_bank_code\": null, \"customer_uid\": null}, \"order_meta\": {\"return_url\": \"http://127.0.0.1:8000/payments/return/?business_order_id=2\", \"notify_url\": \"http://127.0.0.1:8000/payments/webhook/\", \"payment_methods\": null}, \"order_tags\": null, \"cart_details\": null, \"payment\": [{\"cf_payment_id\": \"5114926888827\", \"order_id\": \"order_110358833BwCNmg7aZxuxQWzgWcFgAlKFav\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": true, \"order_amount\": 651348.2, \"payment_group\": \"wallet\", \"payment_currency\": \"INR\", \"payment_amount\": 651348.2, \"payment_time\": \"2026-04-05T17:36:08+05:30\", \"payment_completion_time\": \"2026-04-05T17:36:28+05:30\", \"payment_status\": \"SUCCESS\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"5114926888827\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"app\": {\"channel\": \"link\", \"phone\": \"\", \"provider\": \"phonepe\"}}}]}', 'completed', '2026-04-05 12:06:29.477434', '2026-04-05 12:06:29.475420', 2),
(3, 65134.82, 'order', 4, 'wallet', 'cashfree', NULL, 'order_110358833BwIN3fytRjF6V2QFFaErYLyfdd', '{\"cf_order_id\": \"2206618253\", \"order_id\": \"order_110358833BwIN3fytRjF6V2QFFaErYLyfdd\", \"entity\": \"order\", \"order_currency\": \"INR\", \"order_amount\": 65134.82, \"order_status\": \"PAID\", \"payment_session_id\": \"session_OPLej228dIm14Za8yqLtJG6VVRKaurAcQyM1bpEp9Y9DYz3G8OgGxJCRGyb5zgaHx83hdYKu4hxDF8KZlC1ITn36__TZoczSSjeEOFZP8fW_R1JKK1Xlc9U9xjVTXApaymentpayment\", \"order_expiry_time\": \"2026-05-05T18:24:23+05:30\", \"order_note\": null, \"created_at\": \"2026-04-05T18:24:23+05:30\", \"order_splits\": [], \"customer_details\": {\"customer_id\": \"user_3\", \"customer_email\": \"yashbariya9925@gmail.com\", \"customer_phone\": \"8140031718\", \"customer_name\": null, \"customer_bank_account_number\": null, \"customer_bank_ifsc\": null, \"customer_bank_code\": null, \"customer_uid\": null}, \"order_meta\": {\"return_url\": \"http://127.0.0.1:8000/payments/return/?business_order_id=4\", \"notify_url\": \"http://127.0.0.1:8000/payments/webhook/\", \"payment_methods\": null}, \"order_tags\": null, \"cart_details\": null, \"payment\": [{\"cf_payment_id\": \"5114926889147\", \"order_id\": \"order_110358833BwIN3fytRjF6V2QFFaErYLyfdd\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": true, \"order_amount\": 65134.82, \"payment_group\": \"wallet\", \"payment_currency\": \"INR\", \"payment_amount\": 65134.82, \"payment_time\": \"2026-04-05T18:24:31+05:30\", \"payment_completion_time\": \"2026-04-05T18:24:40+05:30\", \"payment_status\": \"SUCCESS\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"5114926889147\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"app\": {\"channel\": \"link\", \"phone\": \"\", \"provider\": \"phonepe\"}}}]}', 'completed', '2026-04-05 12:54:42.432990', '2026-04-05 12:54:42.429835', 4),
(4, 67258.82, 'order', 5, 'wallet', 'cashfree', NULL, 'order_110358833CFV2hjYWkEJGsOylyYFwhVG6af', '{\"cf_order_id\": \"2206919131\", \"order_id\": \"order_110358833CFV2hjYWkEJGsOylyYFwhVG6af\", \"entity\": \"order\", \"order_currency\": \"INR\", \"order_amount\": 67258.82, \"order_status\": \"PAID\", \"payment_session_id\": \"session_94S-r1jxThoEobtNoMAXe9QdLaQbWTZcG43kdUfWG_gaYeotI_SaL3KHPmHUP5RkBQME0n76G9g9pzECci15_NOYKN6oo6jhg1z5BxSv16hL4v56P6ePNiSgPA5m1Qpaymentpayment\", \"order_expiry_time\": \"2026-05-12T13:35:00+05:30\", \"order_note\": null, \"created_at\": \"2026-04-12T13:35:00+05:30\", \"order_splits\": [], \"customer_details\": {\"customer_id\": \"user_3\", \"customer_email\": \"yashbariya9925@gmail.com\", \"customer_phone\": \"8140031718\", \"customer_name\": null, \"customer_bank_account_number\": null, \"customer_bank_ifsc\": null, \"customer_bank_code\": null, \"customer_uid\": null}, \"order_meta\": {\"return_url\": \"http://127.0.0.1:8000/payments/return/?business_order_id=5\", \"notify_url\": \"http://127.0.0.1:8000/payments/webhook/\", \"payment_methods\": null}, \"order_tags\": null, \"cart_details\": null, \"payment\": [{\"cf_payment_id\": \"5114927107377\", \"order_id\": \"order_110358833CFV2hjYWkEJGsOylyYFwhVG6af\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": true, \"order_amount\": 67258.82, \"payment_group\": \"wallet\", \"payment_currency\": \"INR\", \"payment_amount\": 67258.82, \"payment_time\": \"2026-04-12T13:35:03+05:30\", \"payment_completion_time\": \"2026-04-12T13:35:10+05:30\", \"payment_status\": \"SUCCESS\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"5114927107377\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"app\": {\"channel\": \"link\", \"phone\": \"\", \"provider\": \"phonepe\"}}}]}', 'completed', '2026-04-12 08:05:10.326036', '2026-04-12 08:05:10.323269', 5),
(5, 67258.82, 'order', 34, 'netbanking', 'cashfree', NULL, 'order_110358833CLHukQHB0ZluVBYi7Ykfdf4hG4', '{\"cf_order_id\": \"2207001065\", \"order_id\": \"order_110358833CLHukQHB0ZluVBYi7Ykfdf4hG4\", \"entity\": \"order\", \"order_currency\": \"INR\", \"order_amount\": 67258.82, \"order_status\": \"PAID\", \"payment_session_id\": \"session_XO5MPYVaD6dY6BiG5lvzpvWiLUIyxe8ZWtjVG80NrK30j3ob0wxEBq0sS7KwnbB1j9KIL4G5ZhWOvPj32HHlEf9qhOFNVINX9P14p6BOVV1ShETfo6nW5RRxGO8Fngpaymentpayment\", \"order_expiry_time\": \"2026-05-14T14:45:54+05:30\", \"order_note\": null, \"created_at\": \"2026-04-14T14:45:54+05:30\", \"order_splits\": [], \"customer_details\": {\"customer_id\": \"user_16\", \"customer_email\": \"mpremv2990@gmail.com\", \"customer_phone\": \"9925385511\", \"customer_name\": null, \"customer_bank_account_number\": null, \"customer_bank_ifsc\": null, \"customer_bank_code\": null, \"customer_uid\": null}, \"order_meta\": {\"return_url\": \"http://127.0.0.1:8000/payments/return/?business_order_id=34\", \"notify_url\": \"http://127.0.0.1:8000/payments/webhook/\", \"payment_methods\": null}, \"order_tags\": null, \"cart_details\": null, \"payment\": [{\"cf_payment_id\": \"5114927167951\", \"order_id\": \"order_110358833CLHukQHB0ZluVBYi7Ykfdf4hG4\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": true, \"order_amount\": 67258.82, \"payment_group\": \"net_banking\", \"payment_currency\": \"INR\", \"payment_amount\": 67258.82, \"payment_time\": \"2026-04-14T14:46:33+05:30\", \"payment_completion_time\": \"2026-04-14T14:46:39+05:30\", \"payment_status\": \"SUCCESS\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"5114927167951\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"netbanking\": {\"channel\": \"link\", \"netbanking_bank_code\": 3044, \"netbanking_bank_name\": \"State Bank Of India\", \"netbanking_ifsc\": \"\", \"netbanking_account_number\": \"\"}}}, {\"cf_payment_id\": \"5114927167944\", \"order_id\": \"order_110358833CLHukQHB0ZluVBYi7Ykfdf4hG4\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": false, \"order_amount\": 67258.82, \"payment_group\": \"upi\", \"payment_currency\": \"INR\", \"payment_amount\": 67258.82, \"payment_time\": \"2026-04-14T14:45:57+05:30\", \"payment_completion_time\": \"2026-04-14T14:46:27+05:30\", \"payment_status\": \"PENDING\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"1234567890\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"upi\": {\"channel\": \"qrcode\", \"upi_id\": \"5114927167944\"}}}]}', 'completed', '2026-04-14 09:16:38.519548', '2026-04-14 09:16:38.517309', 6),
(6, 155406.00, 'order', 35, 'netbanking', 'cashfree', NULL, 'order_110358833CLI4jKnwE1MPCS3Lxx1im1PJz0', '{\"cf_order_id\": \"2207001120\", \"order_id\": \"order_110358833CLI4jKnwE1MPCS3Lxx1im1PJz0\", \"entity\": \"order\", \"order_currency\": \"INR\", \"order_amount\": 155406.0, \"order_status\": \"PAID\", \"payment_session_id\": \"session_4DaMt289dniTLkCPhcv2NcbfUKmlQgTUVT3frs1JyZuNFdP9fl6W1XuD7dfGuFqa1R50xeq8i3UQTbV4lBdcE93I1QW5VV013gtaemCBiegWDaYP5GBnuZglRUO35Qpaymentpayment\", \"order_expiry_time\": \"2026-05-14T14:47:14+05:30\", \"order_note\": null, \"created_at\": \"2026-04-14T14:47:14+05:30\", \"order_splits\": [], \"customer_details\": {\"customer_id\": \"user_16\", \"customer_email\": \"mpremv2990@gmail.com\", \"customer_phone\": \"9925385511\", \"customer_name\": null, \"customer_bank_account_number\": null, \"customer_bank_ifsc\": null, \"customer_bank_code\": null, \"customer_uid\": null}, \"order_meta\": {\"return_url\": \"http://127.0.0.1:8000/payments/return/?business_order_id=35\", \"notify_url\": \"http://127.0.0.1:8000/payments/webhook/\", \"payment_methods\": null}, \"order_tags\": null, \"cart_details\": null, \"payment\": [{\"cf_payment_id\": \"5114927167994\", \"order_id\": \"order_110358833CLI4jKnwE1MPCS3Lxx1im1PJz0\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": true, \"order_amount\": 155406.0, \"payment_group\": \"net_banking\", \"payment_currency\": \"INR\", \"payment_amount\": 155406.0, \"payment_time\": \"2026-04-14T14:47:17+05:30\", \"payment_completion_time\": \"2026-04-14T14:47:22+05:30\", \"payment_status\": \"SUCCESS\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"5114927167994\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"netbanking\": {\"channel\": \"link\", \"netbanking_bank_code\": 3044, \"netbanking_bank_name\": \"State Bank Of India\", \"netbanking_ifsc\": \"\", \"netbanking_account_number\": \"\"}}}]}', 'completed', '2026-04-14 09:17:21.210626', '2026-04-14 09:17:21.209584', 7),
(7, 776370.38, 'order', 36, 'netbanking', 'cashfree', NULL, 'order_110358833CLKvmCoZPbWT30PJRWXyFE6AAF', '{\"cf_order_id\": \"2207002050\", \"order_id\": \"order_110358833CLKvmCoZPbWT30PJRWXyFE6AAF\", \"entity\": \"order\", \"order_currency\": \"INR\", \"order_amount\": 776370.38, \"order_status\": \"PAID\", \"payment_session_id\": \"session_sacHfVWDGAonYDynvT-uL7HLTLFqBaWpz_rbuGlviNDx7Y5hSZ-lIo601QwXGT2ybHqRE6YrWKSMT_G0-0tet4xSEBGpYE6y1BM2KL1y8dLtvUI4Egl4tXHTnQFHuApaymentpayment\", \"order_expiry_time\": \"2026-05-14T15:10:43+05:30\", \"order_note\": null, \"created_at\": \"2026-04-14T15:10:43+05:30\", \"order_splits\": [], \"customer_details\": {\"customer_id\": \"user_16\", \"customer_email\": \"mpremv2990@gmail.com\", \"customer_phone\": \"9925385511\", \"customer_name\": null, \"customer_bank_account_number\": null, \"customer_bank_ifsc\": null, \"customer_bank_code\": null, \"customer_uid\": null}, \"order_meta\": {\"return_url\": \"http://127.0.0.1:8000/payments/return/?business_order_id=36\", \"notify_url\": \"http://127.0.0.1:8000/payments/webhook/\", \"payment_methods\": null}, \"order_tags\": null, \"cart_details\": null, \"payment\": [{\"cf_payment_id\": \"5114927168620\", \"order_id\": \"order_110358833CLKvmCoZPbWT30PJRWXyFE6AAF\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": true, \"order_amount\": 776370.38, \"payment_group\": \"net_banking\", \"payment_currency\": \"INR\", \"payment_amount\": 776370.38, \"payment_time\": \"2026-04-14T15:10:46+05:30\", \"payment_completion_time\": \"2026-04-14T15:10:53+05:30\", \"payment_status\": \"SUCCESS\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"5114927168620\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"netbanking\": {\"channel\": \"link\", \"netbanking_bank_code\": 3044, \"netbanking_bank_name\": \"State Bank Of India\", \"netbanking_ifsc\": \"\", \"netbanking_account_number\": \"\"}}}]}', 'completed', '2026-04-14 09:40:52.421214', '2026-04-14 09:40:52.419677', 8),
(8, 67258.82, 'order', 38, 'netbanking', 'cashfree', NULL, 'order_110358833CLUpdx4Qp4A6wpO9xBSW5Zef2U', '{\"cf_order_id\": \"2207005743\", \"order_id\": \"order_110358833CLUpdx4Qp4A6wpO9xBSW5Zef2U\", \"entity\": \"order\", \"order_currency\": \"INR\", \"order_amount\": 67258.82, \"order_status\": \"PAID\", \"payment_session_id\": \"session_D1VTuzO3d8y91YDlcSA_D4ciY2rRjrNjTy1bvFv8usiTmLUzYw9uhryLsNB7AoGqRCD_JtsnK6BphF5I5_l624zWtF5UyEkK4t6Ls6vOLvFLyqEn4wLj2l2xkgOq8wpaymentpayment\", \"order_expiry_time\": \"2026-05-14T16:32:07+05:30\", \"order_note\": null, \"created_at\": \"2026-04-14T16:32:07+05:30\", \"order_splits\": [], \"customer_details\": {\"customer_id\": \"user_16\", \"customer_email\": \"mpremv2990@gmail.com\", \"customer_phone\": \"9925385511\", \"customer_name\": null, \"customer_bank_account_number\": null, \"customer_bank_ifsc\": null, \"customer_bank_code\": null, \"customer_uid\": null}, \"order_meta\": {\"return_url\": \"http://127.0.0.1:8000/payments/return/?business_order_id=38\", \"notify_url\": \"http://127.0.0.1:8000/payments/webhook/\", \"payment_methods\": null}, \"order_tags\": null, \"cart_details\": null, \"payment\": [{\"cf_payment_id\": \"5114927172039\", \"order_id\": \"order_110358833CLUpdx4Qp4A6wpO9xBSW5Zef2U\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": true, \"order_amount\": 67258.82, \"payment_group\": \"net_banking\", \"payment_currency\": \"INR\", \"payment_amount\": 67258.82, \"payment_time\": \"2026-04-14T16:32:10+05:30\", \"payment_completion_time\": \"2026-04-14T16:32:18+05:30\", \"payment_status\": \"SUCCESS\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"5114927172039\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"netbanking\": {\"channel\": \"link\", \"netbanking_bank_code\": 3044, \"netbanking_bank_name\": \"State Bank Of India\", \"netbanking_ifsc\": \"\", \"netbanking_account_number\": \"\"}}}]}', 'completed', '2026-04-14 11:02:16.814937', '2026-04-14 11:02:16.811766', 9),
(9, 67258.82, 'order', 43, 'upi', 'cashfree', NULL, 'order_110358833CLXEPWBti4pUEHq2JYAZhQwzAp', '{\"cf_order_id\": \"2207006259\", \"order_id\": \"order_110358833CLXEPWBti4pUEHq2JYAZhQwzAp\", \"entity\": \"order\", \"order_currency\": \"INR\", \"order_amount\": 67258.82, \"order_status\": \"PAID\", \"payment_session_id\": \"session_Sx5g-sUsMTZExGI6c83ie1-emfvYwOQ6KOc8sP_BDqVfG8qpYAtRcKLK8H9vOH7Cz6nTHZy0cpj9eVOC-6Ww4Iq4_EFi919f-OmWg4cZTGfPP59WBAAg44RUdZK3Rgpaymentpayment\", \"order_expiry_time\": \"2026-05-14T16:51:52+05:30\", \"order_note\": null, \"created_at\": \"2026-04-14T16:51:52+05:30\", \"order_splits\": [], \"customer_details\": {\"customer_id\": \"user_16\", \"customer_email\": \"mpremv2990@gmail.com\", \"customer_phone\": \"9925385511\", \"customer_name\": null, \"customer_bank_account_number\": null, \"customer_bank_ifsc\": null, \"customer_bank_code\": null, \"customer_uid\": null}, \"order_meta\": {\"return_url\": \"http://127.0.0.1:8000/payments/return/?business_order_id=43\", \"notify_url\": \"http://127.0.0.1:8000/payments/webhook/\", \"payment_methods\": null}, \"order_tags\": null, \"cart_details\": null, \"payment\": [{\"cf_payment_id\": \"5114927172346\", \"order_id\": \"order_110358833CLXEPWBti4pUEHq2JYAZhQwzAp\", \"entity\": \"payment\", \"error_details\": null, \"is_captured\": true, \"order_amount\": 67258.82, \"payment_group\": \"upi\", \"payment_currency\": \"INR\", \"payment_amount\": 67258.82, \"payment_time\": \"2026-04-14T16:51:54+05:30\", \"payment_completion_time\": \"2026-04-14T16:52:23+05:30\", \"payment_status\": \"SUCCESS\", \"payment_message\": \"Simulated response message\", \"bank_reference\": \"1234567890\", \"auth_id\": null, \"authorization\": null, \"payment_method\": {\"upi\": {\"channel\": \"qrcode\"}}}]}', 'completed', '2026-04-14 11:22:27.967426', '2026-04-14 11:22:27.965111', 10);

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
  `raw_response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `processed_at` datetime(6) DEFAULT NULL,
  `payment_id` int(11) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `orders_returnitem`
--

CREATE TABLE `orders_returnitem` (
  `return_item_id` int(11) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `refund_amount` decimal(10,2) NOT NULL,
  `is_restocked` tinyint(1) NOT NULL,
  `order_item_id` int(11) NOT NULL,
  `return_request_id` int(11) NOT NULL
) ;

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
  `tdp` int(10) UNSIGNED DEFAULT NULL,
  `supported_form_factors` varchar(100) NOT NULL,
  `max_gpu_length_mm` int(10) UNSIGNED NOT NULL,
  `max_psu_length_mm` int(10) UNSIGNED NOT NULL,
  `max_cooler_height_mm` int(10) UNSIGNED NOT NULL,
  `variant_id` int(11) NOT NULL
) ;

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
-- Table structure for table `products_cooler`
--

CREATE TABLE `products_cooler` (
  `id` bigint(20) NOT NULL,
  `tdp` int(10) UNSIGNED DEFAULT NULL CHECK (`tdp` >= 0),
  `cooler_type` varchar(10) NOT NULL,
  `supported_sockets` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`supported_sockets`)),
  `height_mm` int(10) UNSIGNED NOT NULL CHECK (`height_mm` >= 0),
  `radiator_size_mm` int(10) UNSIGNED DEFAULT NULL CHECK (`radiator_size_mm` >= 0),
  `variant_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products_cooler`
--

INSERT INTO `products_cooler` (`id`, `tdp`, `cooler_type`, `supported_sockets`, `height_mm`, `radiator_size_mm`, `variant_id`) VALUES
(1, 250, 'AIO', '[\"AM3\", \"AM4\", \"AM5\", \"LGA1200\", \"LGA2011\", \"LGA1700\"]', 155, 0, 32);

-- --------------------------------------------------------

--
-- Table structure for table `products_cpu`
--

CREATE TABLE `products_cpu` (
  `id` bigint(20) NOT NULL,
  `tdp` int(10) UNSIGNED DEFAULT NULL,
  `socket_type` varchar(50) NOT NULL,
  `cores` int(11) NOT NULL,
  `threads` int(11) NOT NULL,
  `base_clock` decimal(6,3) NOT NULL,
  `boost_clock` decimal(6,3) NOT NULL,
  `integrated_graphics` tinyint(1) NOT NULL,
  `variant_id` int(11) NOT NULL
) ;

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
  `tdp` int(10) UNSIGNED DEFAULT NULL,
  `memory_size` int(11) NOT NULL,
  `pcie_version` varchar(50) NOT NULL,
  `length_mm` int(11) NOT NULL,
  `interface_type` varchar(50) NOT NULL,
  `power_8pin_count` int(11) NOT NULL,
  `power_6pin_count` int(11) NOT NULL,
  `power_12vhpwr` tinyint(1) NOT NULL,
  `variant_id` int(11) NOT NULL
) ;

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
  `tdp` int(10) UNSIGNED DEFAULT NULL,
  `socket_type` varchar(50) NOT NULL,
  `ram_type` varchar(10) NOT NULL,
  `form_factor` varchar(10) NOT NULL,
  `chipset` varchar(50) NOT NULL,
  `m2_slots` smallint(5) UNSIGNED NOT NULL,
  `sata_ports` smallint(5) UNSIGNED NOT NULL,
  `pcie_x1_slots` int(11) NOT NULL,
  `pcie_x16_slots` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL
) ;

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
  `warranty_months` int(10) UNSIGNED NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `is_trending` tinyint(1) DEFAULT NULL
) ;

--
-- Dumping data for table `products_product`
--

INSERT INTO `products_product` (`product_id`, `product_name`, `warranty_months`, `created_at`, `updated_at`, `brand_id`, `category_id`, `description`, `is_trending`) VALUES
(6, 'i9 14k', 36, '2026-03-31 09:40:30.071158', '2026-04-12 03:23:57.959827', 2, 2, '', 0),
(11, 'AMD Ryzen 7000 Series', 36, '2026-04-01 05:04:03.666713', '2026-04-12 09:39:57.274554', 3, 2, 'User12 (5/5) - \"Absolute beast for multi-threaded workloads.\"', 1),
(12, 'Intel Core 14th Gen', 36, '2026-04-01 05:09:48.741765', '2026-04-01 08:44:41.260224', 2, 2, 'Incredibly fast, but runs extremely hot. Get a good AIO.', 0),
(13, 'NVIDIA GeForce RTX 40 Series', 36, '2026-04-01 05:13:09.868073', '2026-04-12 03:35:40.962063', 4, 4, 'Destroys 4K gaming, but it is massive. Check your case dimensions', 1),
(14, 'AMD Radeon RX 7000 Series', 24, '2026-04-01 05:33:03.557628', '2026-04-01 05:33:03.557667', 27, 4, 'Best value for rasterization performance right now.', 0),
(15, 'NVIDIA GeForce RTX 40 Series', 36, '2026-04-01 05:40:24.777160', '2026-04-01 05:40:24.777191', 9, 4, 'Great 1440p card, very quiet.', 0),
(16, 'MAG Series AMD Motherboards', 36, '2026-04-01 05:46:51.526167', '2026-04-12 08:07:19.792688', 8, 5, 'Solid VRMs and great IO for the price.', 1),
(17, 'ROG Strix Intel Motherboards', 38, '2026-04-01 05:50:44.823365', '2026-04-12 08:07:03.878475', 4, 5, 'Premium features, but the Asus Armoury Crate software is terrible.', 1),
(18, 'Trident Z5 Neo Series', 120, '2026-04-01 05:54:45.917757', '2026-04-12 08:07:13.771761', 20, 6, 'EXPO profile worked out of the box. Zero stability issues.', 1),
(19, 'Vengeance RGB Series', 120, '2026-04-01 05:59:47.108482', '2026-04-01 05:59:47.108539', 5, 6, 'Sweet spot for AMD Ryzen 7000 series.', 0),
(20, '990 PRO Series SSD', 60, '2026-04-01 06:03:35.687960', '2026-04-12 04:26:20.291825', 6, 14, 'Blazing fast read/write speeds. Essential for DirectStorage games.', 1),
(21, 'WD_BLACK SN850X Series', 60, '2026-04-01 06:07:36.635579', '2026-04-01 06:07:36.635615', 21, 14, 'Great drive, runs a bit warm so use the motherboard heatsink.', 0),
(22, 'RMx Shift Series', 120, '2026-04-01 06:12:15.477265', '2026-04-01 06:12:15.477317', 5, 7, 'The side-mounted cables made building in my case incredibly easy.', 0),
(23, 'Vertex GX Series', 120, '2026-04-01 06:16:23.926457', '2026-04-01 06:16:23.926508', 11, 7, 'Tier A power supply. Dead silent even under heavy gaming load.', 0),
(24, 'O11 Series Cases', 12, '2026-04-01 06:20:08.626181', '2026-04-01 06:20:08.626229', 25, 9, 'Beautiful showcase case. Cable management in the dual chamber is a breeze.', 0),
(25, 'North Series', 24, '2026-04-01 06:25:28.502298', '2026-04-01 06:25:28.502359', 28, 9, 'Finally, a PC case that looks like actual furniture and not a spaceship.', 0),
(33, 'Thermalright Trofeo Vision 360', 72, '2026-04-12 10:08:51.596609', '2026-04-12 10:29:17.496240', 8, 10, 'All', 0),
(34, '990 PRO Series', 75, '2026-04-12 10:11:47.105032', '2026-04-12 10:20:32.538584', 6, 14, 'All', 0),
(36, '990 PRO Series M.2 NVMe SDD', 70, '2026-04-12 10:27:59.385131', '2026-04-12 10:27:59.385153', 6, 14, 'ASdawd', 0);

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
(130, 'product_variants_images/6110y1NIrdL._AC_SL1500_.jpg', 0, 22),
(131, 'product_variants_images/71XHEQZZWL._SX679__PpwXTGd.jpg', 1, 23),
(132, 'product_variants_images/81amViqJ5LL._SL1500__Lf2uvW7.jpg', 0, 23),
(133, 'product_variants_images/81rxocaalcL._SL1500__BghXJjB.jpg', 0, 23),
(176, 'product_variants_images/61ROP4ulCRL._SL1500__pjjuWwd.jpg', 1, 32),
(177, 'product_variants_images/71bwwZ3a8EL._SL1500__hmmVkG7.jpg', 0, 32),
(178, 'product_variants_images/71hJOyftOL._SL1500__t3GjVl7.jpg', 0, 32),
(179, 'product_variants_images/71Hk8HaD8xL._SL1500__Qg04fuk.jpg', 0, 32),
(180, 'product_variants_images/71qCphEYfOL._SL1500__EbHLrwQ.jpg', 0, 32),
(181, 'product_variants_images/615KCFwd88L._SL1500__w6foXtC.jpg', 0, 32),
(182, 'product_variants_images/71XHEQZZWL._SX679__IXUcwZ5.jpg', 1, 33),
(183, 'product_variants_images/71XHEQZZWL._SX679__PpwXTGd_V5LeTrG.jpg', 0, 33),
(184, 'product_variants_images/81amViqJ5LL._SL1500__HXYsXWx.jpg', 0, 33),
(185, 'product_variants_images/81amViqJ5LL._SL1500__Lf2uvW7_oF7bTcu.jpg', 0, 33);

-- --------------------------------------------------------

--
-- Table structure for table `products_productreview`
--

CREATE TABLE `products_productreview` (
  `review_id` int(11) NOT NULL,
  `rating` smallint(5) UNSIGNED NOT NULL,
  `comment` longtext DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL
) ;

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
(22, 'North Charcoal Black with Walnut Wood Front', 'FD-NORTH-BLK-TG', 11643.00, 25),
(23, '1TB PCIe 4.0 NVMe M.2', '1TB-990-PRO-SAMSUNG', 26600.00, 20),
(32, 'Vision 360 Black', 'Trofeo Vision 360 ARGB Black', 19500.00, 33),
(33, '2TB PCIe 4.0 NVMe M.2', '2TB-990-PRO-SAMSUNG', 20000.00, 34),
(35, '1TB PCIe 4.0 M.2 NVMe', '1TB-990-PRO-SAMSUNG-M.2', 19000.00, 36);

-- --------------------------------------------------------

--
-- Table structure for table `products_psu`
--

CREATE TABLE `products_psu` (
  `id` bigint(20) NOT NULL,
  `tdp` int(10) UNSIGNED DEFAULT NULL,
  `wattage` int(10) UNSIGNED NOT NULL,
  `form_factor` varchar(10) NOT NULL,
  `efficiency_rating` varchar(15) NOT NULL,
  `modularity` varchar(10) NOT NULL,
  `length_mm` int(10) UNSIGNED NOT NULL,
  `power_8pin_count` smallint(5) UNSIGNED NOT NULL,
  `power_6pin_count` smallint(5) UNSIGNED NOT NULL,
  `power_12vhpwr` tinyint(1) NOT NULL,
  `variant_id` int(11) NOT NULL
) ;

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
  `tdp` int(10) UNSIGNED DEFAULT NULL,
  `ram_type` varchar(10) NOT NULL,
  `capacity_gb` int(10) UNSIGNED NOT NULL,
  `speed_mhz` int(10) UNSIGNED NOT NULL,
  `module_count` smallint(5) UNSIGNED NOT NULL,
  `variant_id` int(11) NOT NULL
) ;

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
  `tdp` int(10) UNSIGNED DEFAULT NULL,
  `storage_type` varchar(50) NOT NULL,
  `capacity_gb` int(11) NOT NULL,
  `interface_type` varchar(50) NOT NULL,
  `form_factor` varchar(50) NOT NULL,
  `variant_id` int(11) NOT NULL
) ;

--
-- Dumping data for table `products_storage`
--

INSERT INTO `products_storage` (`id`, `tdp`, `storage_type`, `capacity_gb`, `interface_type`, `form_factor`, `variant_id`) VALUES
(1, 0, 'HDD', 1000, 'SATA', '2.5 inch', 23),
(2, 8, 'M.2', 2000, 'PCIe 4.0', 'M.2 2280', 33),
(3, 8, 'M.2', 1000, 'PCIe 4.0', 'M.2 2280', 35);

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
-- Table structure for table `users`
--

CREATE TABLE `users` (
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
-- Dumping data for table `users`
--

INSERT INTO `users` (`last_login`, `user_id`, `first_name`, `last_name`, `email`, `phone_number`, `password_hash`, `profile_image`, `role`, `is_active`, `created_at`, `updated_at`) VALUES
('2026-04-14 09:41:41.117320', 1, 'ashok', 'bariya', 'asohkbariya1982@gmail.com', NULL, 'pbkdf2_sha256$600000$B278IHZeeaxKMIfJKUbiif$Ec3i7Kd7CdQPfJTkOpDVUsLi4BkTQT5jiwywb/1VzWw=', '', 'admin', 1, '2026-03-09 11:07:55.147040', '2026-04-05 12:52:44.779482'),
('2026-03-09 11:51:32.000000', 3, 'Yash', 'Bariya', 'yashbariya9925@gmail.com', '8140031718', 'pbkdf2_sha256$600000$BzjzqHXIiVzDY7I4e7s15P$uLdhMzAk7glQIM98VO3tosnoNBN0CW+8VCamtCX6VPA=', '', 'customer', 1, '2026-03-09 11:51:53.934914', '2026-04-05 09:57:42.467927'),
(NULL, 4, 'Prem', 'Makawan', 'gamingxyz981@gmail.com', '7016455514', 'pbkdf2_sha256$600000$9tpcXhWFoaC5J6gS1BN1NC$vXpBdoKbvmVsn2j/1hjPux0zhMX9+VZmqM2s9aP4xE8=', NULL, 'customer', 1, '2026-03-10 05:02:57.458394', '2026-03-10 05:02:57.458622'),
(NULL, 5, 'Prince', 'Jain', 'princejain200595@gmail.com', '6352674484', 'pbkdf2_sha256$600000$yV2V5BZfvG7Jw2JgFTWTdf$c8h74pfIn4UufWIL4l7vmRb38jL4KX3OtPgOJF2SRiU=', NULL, 'customer', 1, '2026-03-10 05:25:42.551391', '2026-03-10 05:25:42.551420'),
(NULL, 6, 'Manish', 'Zala', 'manish2005@gmail.com', '9737682783', 'pbkdf2_sha256$600000$JWaLCIDM3icPPUhBVb682q$c7YGLUHVjR9f4Z3JD5CiPCWlvVNrfBhzpNhGru0RmNA=', NULL, 'customer', 1, '2026-03-10 05:29:57.115967', '2026-03-10 05:29:57.115987'),
(NULL, 7, 'Omdevshih', 'Rana', 'omdevshih82@gmail.com', '6355504818', 'pbkdf2_sha256$600000$QyuTh7kfbjbVnF4yOHaixD$EkFsaxm3j9tddWsyQfjadd9ADW3tI18tacF/JCMABik=', NULL, 'customer', 1, '2026-03-10 05:34:41.347327', '2026-03-10 05:34:41.347464'),
(NULL, 8, 'Vicky', 'Patel', 'vickypatel2000@gmail.com', '8469836615', 'pbkdf2_sha256$600000$Wjh5iD2m3XkcULKaxrbssk$n9RhHG6tDx6hCg4QFPjvhFyFGSwawZflX+DaO8lWpKQ=', 'profile_images/Screenshot_2026-03-10_at_3.50.19PM.png', 'employee', 1, '2026-03-10 10:22:58.647144', '2026-03-30 05:02:07.420313'),
('2026-04-12 09:32:50.813508', 9, 'Sumit', 'Mishara', 'sumitmishara2726@gmail.com', '9054513290', 'pbkdf2_sha256$600000$3bsRn4TRAmaQxszqE2iwXt$Xl70kgEsWlF0UPkr4Htpm0cn1h20eyU2Sedhe7LjOnc=', 'profile_images/Screenshot_2026-03-10_at_4.03.35PM.png', 'employee', 1, '2026-03-10 10:35:14.434415', '2026-03-30 05:02:44.572294'),
(NULL, 10, 'Harsh', 'Upadhaya', 'harshupadhaya2005@gmail.com', '9426966021', 'pbkdf2_sha256$600000$MzgRL5dQrwsMR9n7ibffXS$4R68TSSucL+aYTQTlOhATVKDWbdforeGKstb+RtpThU=', 'profile_images/DK.jpeg', 'employee', 1, '2026-03-10 10:38:03.657343', '2026-03-16 05:16:01.741591'),
(NULL, 11, 'Vikash', 'Gupata', 'vikashgupata2019@gmail.com', '8320882919', 'pbkdf2_sha256$600000$nZYZarnUvHgsc2FS5G4keg$EKfuO0r3cJh6PZEXGd/8Q7NNJ34PVhgUymmVdmcH6VY=', 'profile_images/Screenshot_2026-03-10_at_4.09.06PM.png', 'employee', 1, '2026-03-10 10:40:32.185119', '2026-03-30 05:01:04.114024'),
(NULL, 12, 'Sunil', 'Bariya', 'sunilbariya1516@gmail.com', '8866361516', 'pbkdf2_sha256$600000$jNY1IEFIW7Oni3YnCYxsjh$DK6JvGEEaFK2Y9ub5J4EcqwwQP7LlQapMdmPH+6U9jg=', 'profile_images/Screenshot_2026-03-10_at_4.12.31PM.png', 'employee', 1, '2026-03-10 10:43:25.224441', '2026-03-15 06:25:46.154122'),
(NULL, 16, 'Prem', 'Makwana', 'mpremv2990@gmail.com', '9925385511', 'pbkdf2_sha256$600000$HNGScgbl4jxS6Hm5vgCqnF$3iKvJFeA7s17p5LySZcqyu1d58FlSjQR091ETbukgSM=', 'profile_images/Screenshot_2026-03-10_at_4.12.31PM_i31LPzW_aghpXVK_0WifGty.png', 'customer', 1, '2026-04-12 03:40:12.046963', '2026-04-14 09:22:06.267463');

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
-- Indexes for table `core_pcbuild`
--
ALTER TABLE `core_pcbuild`
  ADD PRIMARY KEY (`build_id`),
  ADD KEY `core_pcbuild_user_id_f5407c46_fk_Users_user_id` (`user_id`);

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
  ADD KEY `orders_cartitem_variant_id_a3661000_fk_products_` (`variant_id`),
  ADD KEY `orders_cartitem_cart_id_529df5fa` (`cart_id`),
  ADD KEY `orders_cartitem_build_id_c7a2171c_fk_builds_pcbuild_build_id` (`build_id`);

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
  ADD KEY `orders_orderitem_variant_id_5d350ded_fk_products_` (`variant_id`),
  ADD KEY `orders_orderitem_build_id_8350ad2a_fk_builds_pcbuild_build_id` (`build_id`);

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
-- Indexes for table `products_cooler`
--
ALTER TABLE `products_cooler`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `variant_id` (`variant_id`);

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
-- Indexes for table `users`
--
ALTER TABLE `users`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=181;

--
-- AUTO_INCREMENT for table `builds_pcbuild`
--
ALTER TABLE `builds_pcbuild`
  MODIFY `build_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `builds_pcbuilditem`
--
ALTER TABLE `builds_pcbuilditem`
  MODIFY `build_item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `core_pcbuild`
--
ALTER TABLE `core_pcbuild`
  MODIFY `build_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `inventory_inventorylog`
--
ALTER TABLE `inventory_inventorylog`
  MODIFY `inventory_log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `locations_pincode`
--
ALTER TABLE `locations_pincode`
  MODIFY `pincode_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders_cart`
--
ALTER TABLE `orders_cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `orders_cartitem`
--
ALTER TABLE `orders_cartitem`
  MODIFY `cart_item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders_invoice`
--
ALTER TABLE `orders_invoice`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `orders_order`
--
ALTER TABLE `orders_order`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products_category`
--
ALTER TABLE `products_category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `products_cooler`
--
ALTER TABLE `products_cooler`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products_cpu`
--
ALTER TABLE `products_cpu`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products_gpu`
--
ALTER TABLE `products_gpu`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products_motherboard`
--
ALTER TABLE `products_motherboard`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products_product`
--
ALTER TABLE `products_product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products_productimage`
--
ALTER TABLE `products_productimage`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;

--
-- AUTO_INCREMENT for table `products_productreview`
--
ALTER TABLE `products_productreview`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products_productvariant`
--
ALTER TABLE `products_productvariant`
  MODIFY `variant_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `products_psu`
--
ALTER TABLE `products_psu`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products_ram`
--
ALTER TABLE `products_ram`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

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
  ADD CONSTRAINT `builds_pcbuild_user_id_4ebb9ca1_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `builds_pcbuilditem`
--
ALTER TABLE `builds_pcbuilditem`
  ADD CONSTRAINT `builds_pcbuilditem_build_id_cf3146b1_fk_builds_pcbuild_build_id` FOREIGN KEY (`build_id`) REFERENCES `builds_pcbuild` (`build_id`),
  ADD CONSTRAINT `builds_pcbuilditem_variant_id_4739bb90_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`);

--
-- Constraints for table `core_pcbuild`
--
ALTER TABLE `core_pcbuild`
  ADD CONSTRAINT `core_pcbuild_user_id_f5407c46_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

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
  ADD CONSTRAINT `locations_address_user_id_49501546_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `orders_cart`
--
ALTER TABLE `orders_cart`
  ADD CONSTRAINT `orders_cart_user_id_121a069e_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

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
  ADD CONSTRAINT `orders_order_user_id_e9b59eb1_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `orders_orderitem`
--
ALTER TABLE `orders_orderitem`
  ADD CONSTRAINT `orders_orderitem_build_id_8350ad2a_fk_builds_pcbuild_build_id` FOREIGN KEY (`build_id`) REFERENCES `builds_pcbuild` (`build_id`),
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
  ADD CONSTRAINT `orders_returnrequest_user_id_38896318_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `products_cabinet`
--
ALTER TABLE `products_cabinet`
  ADD CONSTRAINT `products_cabinet_variant_id_7b2987c7_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`);

--
-- Constraints for table `products_cooler`
--
ALTER TABLE `products_cooler`
  ADD CONSTRAINT `products_cooler_variant_id_f34cd1d9_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`);

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
  ADD CONSTRAINT `products_productreview_user_id_5c551aaa_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

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
  ADD CONSTRAINT `services_servicerequest_user_id_5ba6e88c_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
