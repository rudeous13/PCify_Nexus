-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: pcify_nexus
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_user'),(22,'Can change user',6,'change_user'),(23,'Can delete user',6,'delete_user'),(24,'Can view user',6,'view_user'),(25,'Can add address',7,'add_address'),(26,'Can change address',7,'change_address'),(27,'Can delete address',7,'delete_address'),(28,'Can view address',7,'view_address'),(29,'Can add pincode',8,'add_pincode'),(30,'Can change pincode',8,'change_pincode'),(31,'Can delete pincode',8,'delete_pincode'),(32,'Can view pincode',8,'view_pincode'),(33,'Can add supplier',9,'add_supplier'),(34,'Can change supplier',9,'change_supplier'),(35,'Can delete supplier',9,'delete_supplier'),(36,'Can view supplier',9,'view_supplier'),(37,'Can add brand',10,'add_brand'),(38,'Can change brand',10,'change_brand'),(39,'Can delete brand',10,'delete_brand'),(40,'Can view brand',10,'view_brand'),(41,'Can add category',11,'add_category'),(42,'Can change category',11,'change_category'),(43,'Can delete category',11,'delete_category'),(44,'Can view category',11,'view_category'),(45,'Can add brand',12,'add_brand'),(46,'Can change brand',12,'change_brand'),(47,'Can delete brand',12,'delete_brand'),(48,'Can view brand',12,'view_brand'),(49,'Can add category',13,'add_category'),(50,'Can change category',13,'change_category'),(51,'Can delete category',13,'delete_category'),(52,'Can view category',13,'view_category'),(53,'Can add product image',14,'add_productimage'),(54,'Can change product image',14,'change_productimage'),(55,'Can delete product image',14,'delete_productimage'),(56,'Can view product image',14,'view_productimage'),(57,'Can add product',15,'add_product'),(58,'Can change product',15,'change_product'),(59,'Can delete product',15,'delete_product'),(60,'Can view product',15,'view_product'),(61,'Can add product variant',16,'add_productvariant'),(62,'Can change product variant',16,'change_productvariant'),(63,'Can delete product variant',16,'delete_productvariant'),(64,'Can view product variant',16,'view_productvariant'),(65,'Can add gpu',17,'add_gpu'),(66,'Can change gpu',17,'change_gpu'),(67,'Can delete gpu',17,'delete_gpu'),(68,'Can view gpu',17,'view_gpu'),(69,'Can add storage',18,'add_storage'),(70,'Can change storage',18,'change_storage'),(71,'Can delete storage',18,'delete_storage'),(72,'Can view storage',18,'view_storage'),(73,'Can add motherboard',19,'add_motherboard'),(74,'Can change motherboard',19,'change_motherboard'),(75,'Can delete motherboard',19,'delete_motherboard'),(76,'Can view motherboard',19,'view_motherboard'),(77,'Can add cabinet',20,'add_cabinet'),(78,'Can change cabinet',20,'change_cabinet'),(79,'Can delete cabinet',20,'delete_cabinet'),(80,'Can view cabinet',20,'view_cabinet'),(81,'Can add ram',21,'add_ram'),(82,'Can change ram',21,'change_ram'),(83,'Can delete ram',21,'delete_ram'),(84,'Can view ram',21,'view_ram'),(85,'Can add cpu',22,'add_cpu'),(86,'Can change cpu',22,'change_cpu'),(87,'Can delete cpu',22,'delete_cpu'),(88,'Can view cpu',22,'view_cpu'),(89,'Can add psu',23,'add_psu'),(90,'Can change psu',23,'change_psu'),(91,'Can delete psu',23,'delete_psu'),(92,'Can view psu',23,'view_psu'),(93,'Can add inventory',24,'add_inventory'),(94,'Can change inventory',24,'change_inventory'),(95,'Can delete inventory',24,'delete_inventory'),(96,'Can view inventory',24,'view_inventory'),(97,'Can add purchase order',25,'add_purchaseorder'),(98,'Can change purchase order',25,'change_purchaseorder'),(99,'Can delete purchase order',25,'delete_purchaseorder'),(100,'Can view purchase order',25,'view_purchaseorder'),(101,'Can add inventory log',26,'add_inventorylog'),(102,'Can change inventory log',26,'change_inventorylog'),(103,'Can delete inventory log',26,'delete_inventorylog'),(104,'Can view inventory log',26,'view_inventorylog'),(105,'Can add purchase order item',27,'add_purchaseorderitem'),(106,'Can change purchase order item',27,'change_purchaseorderitem'),(107,'Can delete purchase order item',27,'delete_purchaseorderitem'),(108,'Can view purchase order item',27,'view_purchaseorderitem'),(109,'Can add product review',28,'add_productreview'),(110,'Can change product review',28,'change_productreview'),(111,'Can delete product review',28,'delete_productreview'),(112,'Can view product review',28,'view_productreview'),(113,'Can add cart',29,'add_cart'),(114,'Can change cart',29,'change_cart'),(115,'Can delete cart',29,'delete_cart'),(116,'Can view cart',29,'view_cart'),(117,'Can add invoice',30,'add_invoice'),(118,'Can change invoice',30,'change_invoice'),(119,'Can delete invoice',30,'delete_invoice'),(120,'Can view invoice',30,'view_invoice'),(121,'Can add order',31,'add_order'),(122,'Can change order',31,'change_order'),(123,'Can delete order',31,'delete_order'),(124,'Can view order',31,'view_order'),(125,'Can add order item',32,'add_orderitem'),(126,'Can change order item',32,'change_orderitem'),(127,'Can delete order item',32,'delete_orderitem'),(128,'Can view order item',32,'view_orderitem'),(129,'Can add payment',33,'add_payment'),(130,'Can change payment',33,'change_payment'),(131,'Can delete payment',33,'delete_payment'),(132,'Can view payment',33,'view_payment'),(133,'Can add tax',34,'add_tax'),(134,'Can change tax',34,'change_tax'),(135,'Can delete tax',34,'delete_tax'),(136,'Can view tax',34,'view_tax'),(137,'Can add return request',35,'add_returnrequest'),(138,'Can change return request',35,'change_returnrequest'),(139,'Can delete return request',35,'delete_returnrequest'),(140,'Can view return request',35,'view_returnrequest'),(141,'Can add refund',36,'add_refund'),(142,'Can change refund',36,'change_refund'),(143,'Can delete refund',36,'delete_refund'),(144,'Can view refund',36,'view_refund'),(145,'Can add return item',37,'add_returnitem'),(146,'Can change return item',37,'change_returnitem'),(147,'Can delete return item',37,'delete_returnitem'),(148,'Can view return item',37,'view_returnitem'),(149,'Can add order item tax',38,'add_orderitemtax'),(150,'Can change order item tax',38,'change_orderitemtax'),(151,'Can delete order item tax',38,'delete_orderitemtax'),(152,'Can view order item tax',38,'view_orderitemtax'),(153,'Can add cart item',39,'add_cartitem'),(154,'Can change cart item',39,'change_cartitem'),(155,'Can delete cart item',39,'delete_cartitem'),(156,'Can view cart item',39,'view_cartitem'),(157,'Can add service',40,'add_service'),(158,'Can change service',40,'change_service'),(159,'Can delete service',40,'delete_service'),(160,'Can view service',40,'view_service'),(161,'Can add service request',41,'add_servicerequest'),(162,'Can change service request',41,'change_servicerequest'),(163,'Can delete service request',41,'delete_servicerequest'),(164,'Can view service request',41,'view_servicerequest'),(165,'Can add pc build',42,'add_pcbuild'),(166,'Can change pc build',42,'change_pcbuild'),(167,'Can delete pc build',42,'delete_pcbuild'),(168,'Can view pc build',42,'view_pcbuild'),(169,'Can add pc build item',43,'add_pcbuilditem'),(170,'Can change pc build item',43,'change_pcbuilditem'),(171,'Can delete pc build item',43,'delete_pcbuilditem'),(172,'Can view pc build item',43,'view_pcbuilditem');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `builds_pcbuild`
--

DROP TABLE IF EXISTS `builds_pcbuild`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `builds_pcbuild` (
  `build_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  `description` longtext COLLATE utf8mb4_general_ci,
  `image_url` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`build_id`),
  KEY `builds_pcbuild_user_id_4ebb9ca1_fk_Users_user_id` (`user_id`),
  CONSTRAINT `builds_pcbuild_user_id_4ebb9ca1_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `builds_pcbuild`
--

LOCK TABLES `builds_pcbuild` WRITE;
/*!40000 ALTER TABLE `builds_pcbuild` DISABLE KEYS */;
/*!40000 ALTER TABLE `builds_pcbuild` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `builds_pcbuilditem`
--

DROP TABLE IF EXISTS `builds_pcbuilditem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `builds_pcbuilditem` (
  `build_item_id` int NOT NULL AUTO_INCREMENT,
  `component_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `quantity` int unsigned NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `build_id` int NOT NULL,
  `variant_id` int NOT NULL,
  PRIMARY KEY (`build_item_id`),
  UNIQUE KEY `builds_pcbuilditem_build_id_variant_id_464e6beb_uniq` (`build_id`,`variant_id`),
  KEY `builds_pcbuilditem_variant_id_4739bb90_fk_products_` (`variant_id`),
  CONSTRAINT `builds_pcbuilditem_build_id_cf3146b1_fk_builds_pcbuild_build_id` FOREIGN KEY (`build_id`) REFERENCES `builds_pcbuild` (`build_id`),
  CONSTRAINT `builds_pcbuilditem_variant_id_4739bb90_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`),
  CONSTRAINT `builds_pcbuilditem_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `builds_pcbuilditem`
--

LOCK TABLES `builds_pcbuilditem` WRITE;
/*!40000 ALTER TABLE `builds_pcbuilditem` DISABLE KEYS */;
/*!40000 ALTER TABLE `builds_pcbuilditem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_general_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_Users_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2026-03-09 11:16:21.191599','2','ranaomdevshih2005@gmail.com',1,'[{\"added\": {}}]',6,1),(2,'2026-03-09 11:51:53.943573','3','yashbariya9925@gmail.com',1,'[{\"added\": {}}]',6,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (6,'accounts','user'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(42,'builds','pcbuild'),(43,'builds','pcbuilditem'),(4,'contenttypes','contenttype'),(10,'dashboard','brand'),(11,'dashboard','category'),(24,'inventory','inventory'),(26,'inventory','inventorylog'),(25,'inventory','purchaseorder'),(27,'inventory','purchaseorderitem'),(9,'inventory','supplier'),(7,'locations','address'),(8,'locations','pincode'),(29,'orders','cart'),(39,'orders','cartitem'),(30,'orders','invoice'),(31,'orders','order'),(32,'orders','orderitem'),(38,'orders','orderitemtax'),(33,'orders','payment'),(36,'orders','refund'),(37,'orders','returnitem'),(35,'orders','returnrequest'),(34,'orders','tax'),(12,'products','brand'),(20,'products','cabinet'),(13,'products','category'),(22,'products','cpu'),(17,'products','gpu'),(19,'products','motherboard'),(15,'products','product'),(14,'products','productimage'),(28,'products','productreview'),(16,'products','productvariant'),(23,'products','psu'),(21,'products','ram'),(18,'products','storage'),(40,'services','service'),(41,'services','servicerequest'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'locations','0001_initial','2026-03-09 11:06:45.535511'),(2,'accounts','0001_initial','2026-03-09 11:06:45.574528'),(3,'accounts','0002_customer','2026-03-09 11:06:45.615195'),(4,'accounts','0003_staff','2026-03-09 11:06:45.649470'),(5,'accounts','0004_remove_staff_profile_image_user_profile_image','2026-03-09 11:06:45.672768'),(6,'accounts','0005_staffaddress_customeraddress','2026-03-09 11:06:45.832564'),(7,'accounts','0006_alter_customeraddress_unique_together_and_more','2026-03-09 11:06:46.573683'),(8,'accounts','0007_initial','2026-03-09 11:06:46.589628'),(9,'accounts','0008_alter_user_managers_alter_user_first_name_and_more','2026-03-09 11:06:46.623539'),(10,'contenttypes','0001_initial','2026-03-09 11:06:46.644951'),(11,'admin','0001_initial','2026-03-09 11:06:46.699419'),(12,'admin','0002_logentry_remove_auto_add','2026-03-09 11:06:46.707744'),(13,'admin','0003_logentry_add_action_flag_choices','2026-03-09 11:06:46.713870'),(14,'contenttypes','0002_remove_content_type_name','2026-03-09 11:06:46.746171'),(15,'auth','0001_initial','2026-03-09 11:06:46.857996'),(16,'auth','0002_alter_permission_name_max_length','2026-03-09 11:06:46.884760'),(17,'auth','0003_alter_user_email_max_length','2026-03-09 11:06:46.890457'),(18,'auth','0004_alter_user_username_opts','2026-03-09 11:06:46.898014'),(19,'auth','0005_alter_user_last_login_null','2026-03-09 11:06:46.903926'),(20,'auth','0006_require_contenttypes_0002','2026-03-09 11:06:46.906080'),(21,'auth','0007_alter_validators_add_error_messages','2026-03-09 11:06:46.911624'),(22,'auth','0008_alter_user_username_max_length','2026-03-09 11:06:46.916439'),(23,'auth','0009_alter_user_last_name_max_length','2026-03-09 11:06:46.921045'),(24,'auth','0010_alter_group_name_max_length','2026-03-09 11:06:46.933927'),(25,'auth','0011_update_proxy_permissions','2026-03-09 11:06:46.943758'),(26,'auth','0012_alter_user_first_name_max_length','2026-03-09 11:06:46.948553'),(27,'dashboard','0001_initial','2026-03-09 11:06:46.970365'),(28,'dashboard','0002_suppliers','2026-03-09 11:06:46.981440'),(29,'dashboard','0003_alter_suppliers_gst_number','2026-03-09 11:06:46.993173'),(30,'dashboard','0004_alter_suppliers_phone_number','2026-03-09 11:06:47.003429'),(31,'dashboard','0005_supplieraddress','2026-03-09 11:06:47.090718'),(32,'dashboard','0006_delete_brand_delete_category_delete_supplieraddress_and_more','2026-03-09 11:06:47.103085'),(33,'locations','0002_remove_address_pincode_delete_addresstype_and_more','2026-03-09 11:06:47.349338'),(34,'sessions','0001_initial','2026-03-09 11:06:47.371159'),(35,'accounts','0009_alter_user_profile_image','2026-03-10 10:12:51.637584'),(36,'locations','0003_initial','2026-03-10 11:14:15.410516'),(37,'inventory','0001_initial','2026-03-15 11:33:41.313423'),(38,'dashboard','0007_initial','2026-03-29 09:52:57.898519'),(39,'dashboard','0008_delete_brand_delete_category','2026-03-29 10:02:25.547822'),(40,'dashboard','0009_delete_brand_delete_category','2026-03-29 10:21:22.630170'),(41,'products','0001_initial','2026-03-29 10:23:13.814759'),(42,'products','0002_product_productvariant_productimage','2026-03-30 07:53:10.890882'),(43,'products','0003_product_description','2026-03-31 05:19:48.333391'),(44,'products','0004_storage_ram_motherboard_gpu_cpu_cabinet','2026-03-31 11:31:33.129742'),(45,'products','0005_psu','2026-03-31 11:35:52.224385'),(46,'products','0006_productreview','2026-04-01 04:32:23.468682'),(47,'builds','0001_initial','2026-04-01 04:32:23.541954'),(48,'inventory','0002_inventory_supplier_is_active_purchaseorder_and_more','2026-04-01 04:32:23.699291'),(49,'orders','0001_initial','2026-04-01 04:32:24.187119'),(50,'services','0001_initial','2026-04-01 04:32:24.295453'),(51,'products','0007_product_is_trending','2026-04-01 09:26:23.452768'),(52,'builds','0002_pcbuild_description_pcbuild_image_url_pcbuild_price','2026-04-01 10:06:12.734657'),(53,'orders','0002_order_cf_order_id_order_cf_payment_id_and_more','2026-04-05 07:07:36.796787'),(54,'payments','0001_initial','2026-04-05 07:07:37.760973'),(55,'payments','0002_add_payment_method','2026-04-05 07:07:38.016846'),(56,'payments','0003_delete_cashfreeorder','2026-04-05 07:07:38.075538');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('mmi8ngbnpthw1yhyvkrkrxislrtdlj0x','.eJxVjMsOwiAQRf-FtSG8BqhL934DGRiQqoGktCvjv2uTLnR7zzn3xQJuaw3byEuYiZ2ZZKffLWJ65LYDumO7dZ56W5c58l3hBx382ik_L4f7d1Bx1G9tdMmAkJQu5CxRySIZJ60toAroqRgiEC5DdAhT9BKjUkDJea-dJsHeH_gsOBE:1w7nHv:R4CBYrzl4Dm0tFiCqdxdRrjk9iCAuUHJVUuNRhWSnUA','2026-04-15 04:34:43.702722'),('st4szisy1rk0cbnnrb60wu4wewzozlww','.eJxVjMsOwiAQRf-FtSG8BqhL934DGRiQqoGktCvjv2uTLnR7zzn3xQJuaw3byEuYiZ2ZZKffLWJ65LYDumO7dZ56W5c58l3hBx382ik_L4f7d1Bx1G9tdMmAkJQu5CxRySIZJ60toAroqRgiEC5DdAhT9BKjUkDJea-dJsHeH_gsOBE:1vztl8:oVhp4NK_WFg1MfD9dA1Bh0FlqnAlW29_1cb6dS4ACVw','2026-03-24 09:52:14.291485');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_inventory`
--

DROP TABLE IF EXISTS `inventory_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_inventory` (
  `variant_id` int NOT NULL,
  `stock_quantity` int unsigned NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`variant_id`),
  CONSTRAINT `inventory_inventory_variant_id_e5a3203f_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`),
  CONSTRAINT `inventory_inventory_chk_1` CHECK ((`stock_quantity` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_inventory`
--

LOCK TABLES `inventory_inventory` WRITE;
/*!40000 ALTER TABLE `inventory_inventory` DISABLE KEYS */;
INSERT INTO `inventory_inventory` VALUES (8,45,'2026-04-01 09:08:57.945504'),(9,55,'2026-04-01 08:53:31.388016'),(10,10,'2026-04-01 08:54:20.433516');
/*!40000 ALTER TABLE `inventory_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_inventorylog`
--

DROP TABLE IF EXISTS `inventory_inventorylog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_inventorylog` (
  `inventory_log_id` int NOT NULL AUTO_INCREMENT,
  `quantity_change` int NOT NULL,
  `action` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `reference_type` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `reference_id` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `variant_id` int NOT NULL,
  PRIMARY KEY (`inventory_log_id`),
  KEY `inventory_inventoryl_variant_id_7fed3f72_fk_products_` (`variant_id`),
  CONSTRAINT `inventory_inventoryl_variant_id_7fed3f72_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_inventorylog`
--

LOCK TABLES `inventory_inventorylog` WRITE;
/*!40000 ALTER TABLE `inventory_inventorylog` DISABLE KEYS */;
INSERT INTO `inventory_inventorylog` VALUES (2,5,'remove','adjustment',0,'2026-04-01 08:44:41.265352',9),(3,50,'add','adjustment',0,'2026-04-01 08:53:31.389967',9),(4,45,'add','adjustment',0,'2026-04-01 08:54:13.170074',8),(5,10,'add','adjustment',0,'2026-04-01 08:54:20.433023',10),(6,5,'add','purchase_order',14,'2026-04-01 09:08:03.879937',8),(7,5,'remove','return',14,'2026-04-01 09:08:57.946726',8);
/*!40000 ALTER TABLE `inventory_inventorylog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_purchaseorder`
--

DROP TABLE IF EXISTS `inventory_purchaseorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_purchaseorder` (
  `purchase_order_id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `order_date` datetime(6) DEFAULT NULL,
  `expected_delivery` datetime(6) DEFAULT NULL,
  `remarks` longtext COLLATE utf8mb4_general_ci,
  `created_at` datetime(6) NOT NULL,
  `supplier_id` int NOT NULL,
  PRIMARY KEY (`purchase_order_id`),
  KEY `inventory_purchaseor_supplier_id_c6bc28e9_fk_inventory` (`supplier_id`),
  CONSTRAINT `inventory_purchaseor_supplier_id_c6bc28e9_fk_inventory` FOREIGN KEY (`supplier_id`) REFERENCES `inventory_supplier` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_purchaseorder`
--

LOCK TABLES `inventory_purchaseorder` WRITE;
/*!40000 ALTER TABLE `inventory_purchaseorder` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory_purchaseorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_purchaseorderitem`
--

DROP TABLE IF EXISTS `inventory_purchaseorderitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_purchaseorderitem` (
  `purchase_order_item_id` int NOT NULL AUTO_INCREMENT,
  `quantity` int unsigned NOT NULL,
  `unit_cost` decimal(10,2) NOT NULL,
  `received_quantity` int unsigned NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `purchase_order_id` int NOT NULL,
  `variant_id` int NOT NULL,
  PRIMARY KEY (`purchase_order_item_id`),
  UNIQUE KEY `inventory_purchaseorderi_purchase_order_id_varian_e418c12c_uniq` (`purchase_order_id`,`variant_id`),
  KEY `inventory_purchaseor_variant_id_a4f807cf_fk_products_` (`variant_id`),
  CONSTRAINT `inventory_purchaseor_purchase_order_id_af9dd3c5_fk_inventory` FOREIGN KEY (`purchase_order_id`) REFERENCES `inventory_purchaseorder` (`purchase_order_id`),
  CONSTRAINT `inventory_purchaseor_variant_id_a4f807cf_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`),
  CONSTRAINT `inventory_purchaseorderitem_chk_1` CHECK ((`quantity` >= 0)),
  CONSTRAINT `inventory_purchaseorderitem_chk_2` CHECK ((`received_quantity` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_purchaseorderitem`
--

LOCK TABLES `inventory_purchaseorderitem` WRITE;
/*!40000 ALTER TABLE `inventory_purchaseorderitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory_purchaseorderitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_supplier`
--

DROP TABLE IF EXISTS `inventory_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_supplier` (
  `supplier_id` int NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `company_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `gst_no` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address_one` varchar(300) COLLATE utf8mb4_general_ci NOT NULL,
  `address_two` varchar(300) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`supplier_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `gst_no` (`gst_no`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_supplier`
--

LOCK TABLES `inventory_supplier` WRITE;
/*!40000 ALTER TABLE `inventory_supplier` DISABLE KEYS */;
INSERT INTO `inventory_supplier` VALUES (10,'Rajesh Khanna','Apex Steel Works','sales@apexsteel.com','9820012345','27AAACA1234A1Z5','Plot 42, MIDC, Andheri, Mumbai','Warehouse 5, Thane','2026-03-29 11:05:34.954848','2026-03-29 11:05:34.954878',1),(11,'Sarah Jenkins','CloudNine Solutions','info@cloudnine.in','9910054321','07AAIFC5678B1Z2','12th Floor, Tech Park, Delhi','','2026-03-29 11:07:04.965643','2026-03-29 11:07:04.965673',1),(12,'Amit Shah','Global Logistics Co.','ops@globallog.com','9712398765','24AABCG9012C1Z9','101 Marine Drive, Surat, GJ','Port Terminal Office','2026-03-29 11:07:42.518386','2026-03-29 11:07:42.518425',1),(13,'Priya Nair','EcoPrint Media','print@ecoprint.co','9447011223','32AADCE3456D1Z1','55 Green St, Kochi, KL','','2026-03-29 11:08:59.599452','2026-03-29 11:08:59.599483',1),(14,'Michael Chen','Vertex Hardware','admin@vertex.com','8122334455','33AAHFV7890E1Z4','89 Industrial Estate, Chennai','Retail Branch, Anna Nagar','2026-03-29 11:10:09.665974','2026-03-29 11:10:39.982185',1),(15,'Fatima Sheikh','Zion Textiles','fatima@ziontex.in','7055566778','09AAJPZ2345F1Z7','Weaver’s Row, Kanpur, UP','Old Mill Rd, Kanpur','2026-03-29 11:11:21.067527','2026-03-29 11:11:21.067560',1),(16,'David Miller','Heritage Foods','supply@heritage.com','9830044556','19AAKPH6789G1Z0','14 Park Street, Kolkata, WB','','2026-03-29 11:12:11.617569','2026-03-29 11:12:11.617605',1),(17,'Kevin Parker','Nova Electronics','support@novaelec.in','9108877665','29AALPN0123H1Z3','Tech City, Bangalore, KA','Service Hub, Indiranagar','2026-03-29 11:12:58.014876','2026-03-29 11:12:58.014927',1);
/*!40000 ALTER TABLE `inventory_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations_address`
--

DROP TABLE IF EXISTS `locations_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations_address` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(300) COLLATE utf8mb4_general_ci NOT NULL,
  `is_primary` tinyint(1) NOT NULL,
  `pincode_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`address_id`),
  KEY `locations_address_pincode_id_5df9fee2_fk_locations` (`pincode_id`),
  KEY `locations_address_user_id_49501546_fk_Users_user_id` (`user_id`),
  CONSTRAINT `locations_address_pincode_id_5df9fee2_fk_locations` FOREIGN KEY (`pincode_id`) REFERENCES `locations_pincode` (`pincode_id`),
  CONSTRAINT `locations_address_user_id_49501546_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations_address`
--

LOCK TABLES `locations_address` WRITE;
/*!40000 ALTER TABLE `locations_address` DISABLE KEYS */;
INSERT INTO `locations_address` VALUES (3,'32, Umanager socity, rabariconly charrashta',0,1,10),(4,'33, Umanager Socity, Rabariy colony, charrasata',0,1,12),(5,'48, Ranchode sosayti, ',0,2,11),(6,'129, Ajay tenal mente, labha road',0,3,8),(7,'99, Kelasha nager, ',0,4,9);
/*!40000 ALTER TABLE `locations_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations_pincode`
--

DROP TABLE IF EXISTS `locations_pincode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations_pincode` (
  `pincode_id` int NOT NULL AUTO_INCREMENT,
  `pincode` int NOT NULL,
  `area_name` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `city` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`pincode_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations_pincode`
--

LOCK TABLES `locations_pincode` WRITE;
/*!40000 ALTER TABLE `locations_pincode` DISABLE KEYS */;
INSERT INTO `locations_pincode` VALUES (1,380026,'Amraiwadi','Ahmedabad'),(2,382440,'Vatva','Ahmedabad'),(3,380009,'Navrangpura','Ahmedabad'),(4,380054,'Thaltej','Ahmedabad');
/*!40000 ALTER TABLE `locations_pincode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_cart`
--

DROP TABLE IF EXISTS `orders_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_cart` (
  `cart_id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`cart_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `orders_cart_user_id_121a069e_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_cart`
--

LOCK TABLES `orders_cart` WRITE;
/*!40000 ALTER TABLE `orders_cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_cartitem`
--

DROP TABLE IF EXISTS `orders_cartitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_cartitem` (
  `cart_item_id` int NOT NULL AUTO_INCREMENT,
  `quantity` int unsigned NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `cart_id` int NOT NULL,
  `variant_id` int NOT NULL,
  PRIMARY KEY (`cart_item_id`),
  UNIQUE KEY `orders_cartitem_cart_id_variant_id_3af2015d_uniq` (`cart_id`,`variant_id`),
  KEY `orders_cartitem_variant_id_a3661000_fk_products_` (`variant_id`),
  CONSTRAINT `orders_cartitem_cart_id_529df5fa_fk_orders_cart_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `orders_cart` (`cart_id`),
  CONSTRAINT `orders_cartitem_variant_id_a3661000_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`),
  CONSTRAINT `orders_cartitem_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_cartitem`
--

LOCK TABLES `orders_cartitem` WRITE;
/*!40000 ALTER TABLE `orders_cartitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_cartitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_invoice`
--

DROP TABLE IF EXISTS `orders_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_invoice` (
  `invoice_id` int NOT NULL AUTO_INCREMENT,
  `total_amount` decimal(10,2) NOT NULL,
  `paid_amount` decimal(10,2) NOT NULL,
  `status` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `issued_at` datetime(6) DEFAULT NULL,
  `due_at` datetime(6) DEFAULT NULL,
  `order_id` int NOT NULL,
  PRIMARY KEY (`invoice_id`),
  UNIQUE KEY `order_id` (`order_id`),
  CONSTRAINT `orders_invoice_order_id_bc372e79_fk_orders_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_invoice`
--

LOCK TABLES `orders_invoice` WRITE;
/*!40000 ALTER TABLE `orders_invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_order`
--

DROP TABLE IF EXISTS `orders_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_order` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `total_amount` decimal(10,2) NOT NULL,
  `shipping_method` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `status` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `address_id` int NOT NULL,
  `cart_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  `cf_order_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cf_payment_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payment_method` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payment_raw` json DEFAULT NULL,
  `payment_session_id` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payment_status` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `orders_order_address_id_0daf897b_fk_locations_address_address_id` (`address_id`),
  KEY `orders_order_cart_id_7e0252e3_fk_orders_cart_cart_id` (`cart_id`),
  KEY `orders_order_user_id_e9b59eb1_fk_Users_user_id` (`user_id`),
  CONSTRAINT `orders_order_address_id_0daf897b_fk_locations_address_address_id` FOREIGN KEY (`address_id`) REFERENCES `locations_address` (`address_id`),
  CONSTRAINT `orders_order_cart_id_7e0252e3_fk_orders_cart_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `orders_cart` (`cart_id`),
  CONSTRAINT `orders_order_user_id_e9b59eb1_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_order`
--

LOCK TABLES `orders_order` WRITE;
/*!40000 ALTER TABLE `orders_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_orderitem`
--

DROP TABLE IF EXISTS `orders_orderitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_orderitem` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `quantity` int unsigned NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `order_id` int NOT NULL,
  `variant_id` int NOT NULL,
  PRIMARY KEY (`order_item_id`),
  UNIQUE KEY `orders_orderitem_order_id_variant_id_09cb22b2_uniq` (`order_id`,`variant_id`),
  KEY `orders_orderitem_variant_id_5d350ded_fk_products_` (`variant_id`),
  CONSTRAINT `orders_orderitem_order_id_fe61a34d_fk_orders_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`order_id`),
  CONSTRAINT `orders_orderitem_variant_id_5d350ded_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`),
  CONSTRAINT `orders_orderitem_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_orderitem`
--

LOCK TABLES `orders_orderitem` WRITE;
/*!40000 ALTER TABLE `orders_orderitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_orderitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_orderitemtax`
--

DROP TABLE IF EXISTS `orders_orderitemtax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_orderitemtax` (
  `order_item_tax_id` int NOT NULL AUTO_INCREMENT,
  `tax_amount` decimal(10,2) NOT NULL,
  `order_item_id` int NOT NULL,
  `tax_id` int NOT NULL,
  PRIMARY KEY (`order_item_tax_id`),
  UNIQUE KEY `orders_orderitemtax_order_item_id_tax_id_ea1018e6_uniq` (`order_item_id`,`tax_id`),
  KEY `orders_orderitemtax_tax_id_bd07012e_fk_orders_tax_tax_id` (`tax_id`),
  CONSTRAINT `orders_orderitemtax_order_item_id_7078bd83_fk_orders_or` FOREIGN KEY (`order_item_id`) REFERENCES `orders_orderitem` (`order_item_id`),
  CONSTRAINT `orders_orderitemtax_tax_id_bd07012e_fk_orders_tax_tax_id` FOREIGN KEY (`tax_id`) REFERENCES `orders_tax` (`tax_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_orderitemtax`
--

LOCK TABLES `orders_orderitemtax` WRITE;
/*!40000 ALTER TABLE `orders_orderitemtax` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_orderitemtax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_payment`
--

DROP TABLE IF EXISTS `orders_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_payment` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) NOT NULL,
  `reference_type` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `reference_id` int NOT NULL,
  `payment_method` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `gateway` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `gateway_payment_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gateway_order_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `raw_response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `payment_status` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `paid_at` datetime(6) DEFAULT NULL,
  `invoice_id` int NOT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `orders_payment_invoice_id_157ae570_fk_orders_invoice_invoice_id` (`invoice_id`),
  CONSTRAINT `orders_payment_invoice_id_157ae570_fk_orders_invoice_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `orders_invoice` (`invoice_id`),
  CONSTRAINT `orders_payment_chk_1` CHECK (json_valid(`raw_response`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_payment`
--

LOCK TABLES `orders_payment` WRITE;
/*!40000 ALTER TABLE `orders_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_refund`
--

DROP TABLE IF EXISTS `orders_refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_refund` (
  `refund_id` int NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) NOT NULL,
  `gateway_refund_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `reason` longtext COLLATE utf8mb4_general_ci,
  `raw_response` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` datetime(6) NOT NULL,
  `processed_at` datetime(6) DEFAULT NULL,
  `payment_id` int NOT NULL,
  PRIMARY KEY (`refund_id`),
  KEY `orders_refund_payment_id_a6b07753_fk_orders_payment_payment_id` (`payment_id`),
  CONSTRAINT `orders_refund_payment_id_a6b07753_fk_orders_payment_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `orders_payment` (`payment_id`),
  CONSTRAINT `orders_refund_chk_1` CHECK (json_valid(`raw_response`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_refund`
--

LOCK TABLES `orders_refund` WRITE;
/*!40000 ALTER TABLE `orders_refund` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_refund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_returnitem`
--

DROP TABLE IF EXISTS `orders_returnitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_returnitem` (
  `return_item_id` int NOT NULL AUTO_INCREMENT,
  `quantity` int unsigned NOT NULL,
  `refund_amount` decimal(10,2) NOT NULL,
  `is_restocked` tinyint(1) NOT NULL,
  `order_item_id` int NOT NULL,
  `return_request_id` int NOT NULL,
  PRIMARY KEY (`return_item_id`),
  UNIQUE KEY `orders_returnitem_return_request_id_order_item_id_99a4290b_uniq` (`return_request_id`,`order_item_id`),
  KEY `orders_returnitem_order_item_id_670df9dc_fk_orders_or` (`order_item_id`),
  CONSTRAINT `orders_returnitem_order_item_id_670df9dc_fk_orders_or` FOREIGN KEY (`order_item_id`) REFERENCES `orders_orderitem` (`order_item_id`),
  CONSTRAINT `orders_returnitem_return_request_id_a8d9d4ce_fk_orders_re` FOREIGN KEY (`return_request_id`) REFERENCES `orders_returnrequest` (`return_id`),
  CONSTRAINT `orders_returnitem_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_returnitem`
--

LOCK TABLES `orders_returnitem` WRITE;
/*!40000 ALTER TABLE `orders_returnitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_returnitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_returnrequest`
--

DROP TABLE IF EXISTS `orders_returnrequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_returnrequest` (
  `return_id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `reason` longtext COLLATE utf8mb4_general_ci,
  `created_at` datetime(6) NOT NULL,
  `approved_at` datetime(6) DEFAULT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `order_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`return_id`),
  KEY `orders_returnrequest_order_id_176addea_fk_orders_order_order_id` (`order_id`),
  KEY `orders_returnrequest_user_id_38896318_fk_Users_user_id` (`user_id`),
  CONSTRAINT `orders_returnrequest_order_id_176addea_fk_orders_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`order_id`),
  CONSTRAINT `orders_returnrequest_user_id_38896318_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_returnrequest`
--

LOCK TABLES `orders_returnrequest` WRITE;
/*!40000 ALTER TABLE `orders_returnrequest` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_returnrequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_tax`
--

DROP TABLE IF EXISTS `orders_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_tax` (
  `tax_id` int NOT NULL AUTO_INCREMENT,
  `tax_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `tax_rate` decimal(5,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`tax_id`),
  UNIQUE KEY `tax_name` (`tax_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_tax`
--

LOCK TABLES `orders_tax` WRITE;
/*!40000 ALTER TABLE `orders_tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_tax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_brand`
--

DROP TABLE IF EXISTS `products_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_brand` (
  `brand_id` int NOT NULL AUTO_INCREMENT,
  `brand_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`brand_id`),
  UNIQUE KEY `brand_name` (`brand_name`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_brand`
--

LOCK TABLES `products_brand` WRITE;
/*!40000 ALTER TABLE `products_brand` DISABLE KEYS */;
INSERT INTO `products_brand` VALUES (3,'AMD'),(18,'ANT Esports'),(4,'ASUS'),(5,'Corsair'),(13,'DeepCool'),(10,'EVGA'),(28,'Fractal Design'),(20,'G.Skill'),(9,'Gigabyte'),(2,'Intel'),(25,'Lian Li'),(8,'MSI'),(14,'Noctua'),(7,'NVIDIA'),(12,'NZXT'),(6,'Samsung'),(27,'Sapphire'),(11,'Seasonic'),(21,'Western Digital');
/*!40000 ALTER TABLE `products_brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_cabinet`
--

DROP TABLE IF EXISTS `products_cabinet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_cabinet` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tdp` int unsigned DEFAULT NULL,
  `supported_form_factors` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `max_gpu_length_mm` int unsigned NOT NULL,
  `max_psu_length_mm` int unsigned NOT NULL,
  `max_cooler_height_mm` int unsigned NOT NULL,
  `variant_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `variant_id` (`variant_id`),
  CONSTRAINT `products_cabinet_variant_id_7b2987c7_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`),
  CONSTRAINT `products_cabinet_chk_1` CHECK ((`tdp` >= 0)),
  CONSTRAINT `products_cabinet_chk_2` CHECK ((`max_gpu_length_mm` >= 0)),
  CONSTRAINT `products_cabinet_chk_3` CHECK ((`max_psu_length_mm` >= 0)),
  CONSTRAINT `products_cabinet_chk_4` CHECK ((`max_cooler_height_mm` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_cabinet`
--

LOCK TABLES `products_cabinet` WRITE;
/*!40000 ALTER TABLE `products_cabinet` DISABLE KEYS */;
INSERT INTO `products_cabinet` VALUES (1,NULL,'ATX',426,220,167,21),(2,NULL,'ATX',355,255,167,22);
/*!40000 ALTER TABLE `products_cabinet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_category`
--

DROP TABLE IF EXISTS `products_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_category`
--

LOCK TABLES `products_category` WRITE;
/*!40000 ALTER TABLE `products_category` DISABLE KEYS */;
INSERT INTO `products_category` VALUES (9,'Cabinet'),(10,'Cooler'),(2,'CPU'),(4,'GPU'),(12,'HDD'),(18,'Headset'),(16,'Keyboard'),(14,'M.2'),(15,'Moniter'),(5,'Motherboard'),(17,'Mouse'),(7,'PSU'),(6,'RAM'),(11,'SSD'),(19,'UPS');
/*!40000 ALTER TABLE `products_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_cpu`
--

DROP TABLE IF EXISTS `products_cpu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_cpu` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tdp` int unsigned DEFAULT NULL,
  `socket_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `cores` int NOT NULL,
  `threads` int NOT NULL,
  `base_clock` decimal(6,3) NOT NULL,
  `boost_clock` decimal(6,3) NOT NULL,
  `integrated_graphics` tinyint(1) NOT NULL,
  `variant_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `variant_id` (`variant_id`),
  CONSTRAINT `products_cpu_variant_id_90a132e3_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`),
  CONSTRAINT `products_cpu_chk_1` CHECK ((`tdp` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_cpu`
--

LOCK TABLES `products_cpu` WRITE;
/*!40000 ALTER TABLE `products_cpu` DISABLE KEYS */;
INSERT INTO `products_cpu` VALUES (3,170,'AM4',16,32,4.500,5.700,1,8),(4,125,'LGA1700',24,32,3.200,5.700,1,9);
/*!40000 ALTER TABLE `products_cpu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_gpu`
--

DROP TABLE IF EXISTS `products_gpu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_gpu` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tdp` int unsigned DEFAULT NULL,
  `memory_size` int NOT NULL,
  `pcie_version` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `length_mm` int NOT NULL,
  `interface_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `power_8pin_count` int NOT NULL,
  `power_6pin_count` int NOT NULL,
  `power_12vhpwr` tinyint(1) NOT NULL,
  `variant_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `variant_id` (`variant_id`),
  CONSTRAINT `products_gpu_variant_id_407ee883_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`),
  CONSTRAINT `products_gpu_chk_1` CHECK ((`tdp` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_gpu`
--

LOCK TABLES `products_gpu` WRITE;
/*!40000 ALTER TABLE `products_gpu` DISABLE KEYS */;
INSERT INTO `products_gpu` VALUES (1,450,24,'PCIe 4.0 x16',357,'DVI/HDMI/DP',1,1,0,10),(2,355,24,'PCIe 4.0 x16',320,'DVI/HDMI/DP',3,0,0,11),(3,220,12,'PCIe 4.0 x16',261,'HDMI/DP',0,0,0,12);
/*!40000 ALTER TABLE `products_gpu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_motherboard`
--

DROP TABLE IF EXISTS `products_motherboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_motherboard` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tdp` int unsigned DEFAULT NULL,
  `socket_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `ram_type` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `form_factor` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `chipset` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `m2_slots` smallint unsigned NOT NULL,
  `sata_ports` smallint unsigned NOT NULL,
  `pcie_x1_slots` int NOT NULL,
  `pcie_x16_slots` int NOT NULL,
  `variant_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `variant_id` (`variant_id`),
  CONSTRAINT `products_motherboard_variant_id_86f94d17_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`),
  CONSTRAINT `products_motherboard_chk_1` CHECK ((`tdp` >= 0)),
  CONSTRAINT `products_motherboard_chk_2` CHECK ((`m2_slots` >= 0)),
  CONSTRAINT `products_motherboard_chk_3` CHECK ((`sata_ports` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_motherboard`
--

LOCK TABLES `products_motherboard` WRITE;
/*!40000 ALTER TABLE `products_motherboard` DISABLE KEYS */;
INSERT INTO `products_motherboard` VALUES (1,0,'AM4','DDR5','ATX','B650',3,6,-2,2,13),(2,50,'LGA1700','DDR5','ATX','Z790',4,4,-3,1,14);
/*!40000 ALTER TABLE `products_motherboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_product`
--

DROP TABLE IF EXISTS `products_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `warranty_months` int unsigned NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `brand_id` int NOT NULL,
  `category_id` int NOT NULL,
  `description` varchar(512) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_trending` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `products_product_brand_id_3e2e8fd1_fk_products_brand_brand_id` (`brand_id`),
  KEY `products_product_category_id_9b594869_fk_products_` (`category_id`),
  CONSTRAINT `products_product_brand_id_3e2e8fd1_fk_products_brand_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `products_brand` (`brand_id`),
  CONSTRAINT `products_product_category_id_9b594869_fk_products_` FOREIGN KEY (`category_id`) REFERENCES `products_category` (`category_id`),
  CONSTRAINT `products_product_chk_1` CHECK ((`warranty_months` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_product`
--

LOCK TABLES `products_product` WRITE;
/*!40000 ALTER TABLE `products_product` DISABLE KEYS */;
INSERT INTO `products_product` VALUES (6,'i9 14k',36,'2026-03-31 09:40:30.071158','2026-04-01 09:31:58.388103',2,2,'',1),(11,'AMD Ryzen 7000 Series',36,'2026-04-01 05:04:03.666713','2026-04-01 08:54:13.162876',3,2,'User12 (5/5) - \"Absolute beast for multi-threaded workloads.\"',0),(12,'Intel Core 14th Gen',36,'2026-04-01 05:09:48.741765','2026-04-01 08:44:41.260224',2,2,'Incredibly fast, but runs extremely hot. Get a good AIO.',0),(13,'NVIDIA GeForce RTX 40 Series',36,'2026-04-01 05:13:09.868073','2026-04-01 08:54:20.428589',4,4,'Destroys 4K gaming, but it is massive. Check your case dimensions',0),(14,'AMD Radeon RX 7000 Series',24,'2026-04-01 05:33:03.557628','2026-04-01 05:33:03.557667',27,4,'Best value for rasterization performance right now.',0),(15,'NVIDIA GeForce RTX 40 Series',36,'2026-04-01 05:40:24.777160','2026-04-01 05:40:24.777191',9,4,'Great 1440p card, very quiet.',0),(16,'MAG Series AMD Motherboards',36,'2026-04-01 05:46:51.526167','2026-04-01 05:46:51.526217',8,5,'Solid VRMs and great IO for the price.',0),(17,'ROG Strix Intel Motherboards',38,'2026-04-01 05:50:44.823365','2026-04-01 05:50:44.823409',4,5,'Premium features, but the Asus Armoury Crate software is terrible.',0),(18,'Trident Z5 Neo Series',120,'2026-04-01 05:54:45.917757','2026-04-01 05:54:45.917826',20,6,'EXPO profile worked out of the box. Zero stability issues.',0),(19,'Vengeance RGB Series',120,'2026-04-01 05:59:47.108482','2026-04-01 05:59:47.108539',5,6,'Sweet spot for AMD Ryzen 7000 series.',0),(20,'990 PRO Series SSD',60,'2026-04-01 06:03:35.687960','2026-04-01 06:03:35.688015',6,14,'Blazing fast read/write speeds. Essential for DirectStorage games.',0),(21,'WD_BLACK SN850X Series',60,'2026-04-01 06:07:36.635579','2026-04-01 06:07:36.635615',21,14,'Great drive, runs a bit warm so use the motherboard heatsink.',0),(22,'RMx Shift Series',120,'2026-04-01 06:12:15.477265','2026-04-01 06:12:15.477317',5,7,'The side-mounted cables made building in my case incredibly easy.',0),(23,'Vertex GX Series',120,'2026-04-01 06:16:23.926457','2026-04-01 06:16:23.926508',11,7,'Tier A power supply. Dead silent even under heavy gaming load.',0),(24,'O11 Series Cases',12,'2026-04-01 06:20:08.626181','2026-04-01 06:20:08.626229',25,9,'Beautiful showcase case. Cable management in the dual chamber is a breeze.',0),(25,'North Series',24,'2026-04-01 06:25:28.502298','2026-04-01 06:25:28.502359',28,9,'Finally, a PC case that looks like actual furniture and not a spaceship.',0);
/*!40000 ALTER TABLE `products_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_productimage`
--

DROP TABLE IF EXISTS `products_productimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_productimage` (
  `image_id` int NOT NULL AUTO_INCREMENT,
  `image` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `is_primary` tinyint(1) NOT NULL,
  `variant_id` int NOT NULL,
  PRIMARY KEY (`image_id`),
  KEY `products_productimag_variant_id_bf70ade8_fk_products_` (`variant_id`),
  CONSTRAINT `products_productimag_variant_id_bf70ade8_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_productimage`
--

LOCK TABLES `products_productimage` WRITE;
/*!40000 ALTER TABLE `products_productimage` DISABLE KEYS */;
INSERT INTO `products_productimage` VALUES (21,'product_variants_images/51jNS8epPeL._SL1500_.jpg',1,8),(22,'product_variants_images/51qA89Dg6UL._SL1500_.jpg',0,8),(23,'product_variants_images/51wD3-OAv0L._SL1500_.jpg',0,8),(24,'product_variants_images/61rKeM-2DpL._SL1500_.jpg',0,8),(25,'product_variants_images/619ytLAytAL._SX679_.jpg',1,9),(26,'product_variants_images/61f8hqeg-dL._SX679_.jpg',0,9),(27,'product_variants_images/61x6XuKeEGL._SX679_.jpg',0,9),(28,'product_variants_images/61ujd7RN-3L._SX679_.jpg',0,9),(29,'product_variants_images/51Biv-FVi0L._SS40_.jpg',1,10),(30,'product_variants_images/41G3K1QLjdL._SS40_.jpg',0,10),(31,'product_variants_images/41cjI51AxQL._SS40_.jpg',0,10),(32,'product_variants_images/41BYaHgXDL._SS40_.jpg',0,10),(33,'product_variants_images/71rUjuE0qoL._SL1469_.jpg',0,10),(34,'product_variants_images/71zH2icVUsL._SL1500_.jpg',0,10),(35,'product_variants_images/414QUz0rAWL._SS40_.jpg',0,10),(36,'product_variants_images/617BMtpqmNL._SL1406_.jpg',0,10),(37,'product_variants_images/513-G9LMbOL._SS40_.jpg',1,11),(38,'product_variants_images/51DeZ6FOg5L._SS40_.jpg',0,11),(39,'product_variants_images/51Biv-FVi0L._SS40__N5so4nl.jpg',1,12),(40,'product_variants_images/31E6vxfzvpL._SS40_.jpg',0,12),(41,'product_variants_images/31idann8TdL._SS40_.jpg',0,12),(42,'product_variants_images/41EMMyLoVXL._SS40_.jpg',0,12),(43,'product_variants_images/41pR1Y6X2cL._SS40_.jpg',0,12),(44,'product_variants_images/61goxBF5bfL._SL1500_.jpg',0,12),(45,'product_variants_images/71OEy7TwhUL._SL1500_.jpg',0,12),(46,'product_variants_images/41XpW2Sp79L._SS40_.jpg',1,13),(47,'product_variants_images/41zQrWdmq9L._SS40_.jpg',0,13),(48,'product_variants_images/51uh0FPtGL._SS40_.jpg',0,13),(49,'product_variants_images/51q0xKMzy6L._SS40_.jpg',0,13),(50,'product_variants_images/51qvy2k54yL._SS40_.jpg',0,13),(51,'product_variants_images/71mbLOr5UhL._SL1500_.jpg',0,13),(52,'product_variants_images/715u9a1XOuL._SL1500_.jpg',0,13),(53,'product_variants_images/41cSJavJ3QL._SS40_.jpg',1,14),(54,'product_variants_images/51bT1YzSRjL._SS40_.jpg',0,14),(55,'product_variants_images/51e7nHopFL._SS40_.jpg',0,14),(56,'product_variants_images/51ku6zoHspL._SS40_.jpg',0,14),(57,'product_variants_images/51SwOH2ihL._SS40_.jpg',0,14),(58,'product_variants_images/510hcdhq7dL._SS40_.jpg',0,14),(59,'product_variants_images/61XlVUhmP_L._SL1200.webp',1,15),(60,'product_variants_images/31IEEONNmL._SS40_.jpg',1,16),(61,'product_variants_images/31-zmIkd0BL._SS40_.jpg',0,16),(62,'product_variants_images/51fLN1HwhL._SS40_.jpg',0,16),(63,'product_variants_images/51hMYMbYI7L._SS40_.jpg',0,16),(64,'product_variants_images/51MBfeMNJuL._SS40_.jpg',0,16),(65,'product_variants_images/418MnX0bKZL._SS40_.jpg',0,16),(66,'product_variants_images/31zlOP3YoL._SS40_.jpg',1,17),(67,'product_variants_images/41ApSoewVL._SS40_.jpg',0,17),(68,'product_variants_images/41IWzc1mUwL._SS40_.jpg',0,17),(69,'product_variants_images/41SOSO0Q3L._SS40_.jpg',0,17),(70,'product_variants_images/61oUXUCnzL._SL1200_.jpg',0,17),(71,'product_variants_images/71RHSRTUzL._SL1500_.jpg',0,17),(72,'product_variants_images/71XHEQZZWL._SX679_.jpg',0,17),(73,'product_variants_images/81rxocaalcL._SL1500_.jpg',0,17),(74,'product_variants_images/619A8I81-gL._SL1200_.jpg',0,17),(75,'product_variants_images/811HMbbmDaL._SL1500_.jpg',0,17),(76,'product_variants_images/310khwHZjtL._SS40_.jpg',1,18),(77,'product_variants_images/91aQPAqVAAL._SL1500_.jpg',0,18),(78,'product_variants_images/31zG5wzjNaL._SS40_.jpg',0,18),(79,'product_variants_images/41y1ElPe57L._SS40_.jpg',0,18),(80,'product_variants_images/51mhEgW7kEL._SS40_.jpg',0,18),(81,'product_variants_images/81amViqJ5LL._SL1500_.jpg',0,18),(82,'product_variants_images/81luU-6OFDL._SL1500_.jpg',0,18),(83,'product_variants_images/81qNtnKNFL._SL1500_.jpg',0,18),(84,'product_variants_images/41WKmC1jO5L._AC_US40_.jpg',1,19),(85,'product_variants_images/51BMivUUGlL._AC_US40_.jpg',0,19),(86,'product_variants_images/51okh5daAVL._AC_US40_.jpg',0,19),(87,'product_variants_images/51TkgW11ylL._AC_US40_.jpg',0,19),(88,'product_variants_images/51ZRs5vUZ2L._AC_US40_.jpg',0,19),(89,'product_variants_images/81cohE975dL._AC_SL1500_.jpg',0,19),(90,'product_variants_images/81qb0HipCL._AC_SL1500_.jpg',0,19),(91,'product_variants_images/41YlZdQtUZL._SX38_SY50_CR003850_.jpg',1,20),(92,'product_variants_images/41G7uzIQfL._SX38_SY50_CR003850_.jpg',0,20),(93,'product_variants_images/81vaTOziBOL._SL1500_.jpg',0,20),(94,'product_variants_images/81Y922LAg4L._SL1500_.jpg',0,20),(95,'product_variants_images/41gzz82yoPL._SX38_SY50_CR003850_.jpg',0,20),(96,'product_variants_images/41StTuduluL._SX38_SY50_CR003850_.jpg',0,20),(97,'product_variants_images/416bxwtyauL._SX38_SY50_CR003850_.jpg',0,20),(98,'product_variants_images/817IibC24L._SL1500_.jpg',0,20),(99,'product_variants_images/81jMOzwZ08L._SL1500_.jpg',0,20),(100,'product_variants_images/41iw9MjiqL._AC_US40_.jpg',1,21),(101,'product_variants_images/31HpWr21KYL._AC_US40_.jpg',0,21),(102,'product_variants_images/41mQELQfhtL._AC_US40_.jpg',0,21),(103,'product_variants_images/61KWhUxRJJL._AC_SL1200_.jpg',0,21),(104,'product_variants_images/61XuvzdlxhL._AC_SL1372_.jpg',0,21),(105,'product_variants_images/71HXFl35SGL._AC_SL1200_.jpg',0,21),(106,'product_variants_images/416lADiCWoL._AC_US40_.jpg',0,21),(107,'product_variants_images/417GEZWYenL._AC_US40_.jpg',0,21),(108,'product_variants_images/616CIe906L._AC_SL1200_.jpg',0,21),(109,'product_variants_images/6141sOuWBaL._AC_SL1200_.jpg',0,21),(110,'product_variants_images/81j6lE2tKyL._AC_SL1500_.jpg',1,22),(111,'product_variants_images/417KIaaHKWL._AC_US40_.jpg',0,22),(112,'product_variants_images/318o4rjhmjL._AC_US40_.jpg',0,22),(113,'product_variants_images/81kbao0byYL._AC_SL1500_.jpg',0,22),(114,'product_variants_images/71WUSDzuEjL._AC_SL1500_.jpg',0,22),(115,'product_variants_images/71sNDaoacfL._AC_SL1500_.jpg',0,22),(116,'product_variants_images/71hlfxZ5eRL._AC_SL1500_.jpg',0,22),(117,'product_variants_images/71jP7FjrSVL._AC_SL1500_.jpg',0,22),(118,'product_variants_images/71JzLfSRB1L._AC_SL1500_.jpg',0,22),(119,'product_variants_images/71MspiRUuL._AC_SL1500_.jpg',0,22),(120,'product_variants_images/71P20Fmk9VL._AC_SL1500_.jpg',0,22),(121,'product_variants_images/71qGthDIL2L._AC_SL1500_.jpg',0,22),(122,'product_variants_images/71ESOREig2L._AC_SL1500_.jpg',0,22),(123,'product_variants_images/71b0Lvpc9gL._AC_SL1500_.jpg',0,22),(124,'product_variants_images/51yC6aCp90L._AC_SL1500_.jpg',0,22),(125,'product_variants_images/41LAVpTm40L._AC_US40_.jpg',0,22),(126,'product_variants_images/41F6SdjBE2L._AC_US40_.jpg',0,22),(127,'product_variants_images/41BBuj1iyuL._AC_US40_.jpg',0,22),(128,'product_variants_images/611sGianmaL._AC_SL1500_.jpg',0,22),(129,'product_variants_images/711tbgDYsoL._AC_SL1500_.jpg',0,22),(130,'product_variants_images/6110y1NIrdL._AC_SL1500_.jpg',0,22);
/*!40000 ALTER TABLE `products_productimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_productreview`
--

DROP TABLE IF EXISTS `products_productreview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_productreview` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `rating` smallint unsigned NOT NULL,
  `comment` longtext COLLATE utf8mb4_general_ci,
  `created_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  `variant_id` int NOT NULL,
  PRIMARY KEY (`review_id`),
  UNIQUE KEY `products_productreview_variant_id_user_id_7a654704_uniq` (`variant_id`,`user_id`),
  KEY `products_productreview_user_id_5c551aaa_fk_Users_user_id` (`user_id`),
  CONSTRAINT `products_productrevi_variant_id_2b1dba36_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`),
  CONSTRAINT `products_productreview_user_id_5c551aaa_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `products_productreview_chk_1` CHECK ((`rating` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_productreview`
--

LOCK TABLES `products_productreview` WRITE;
/*!40000 ALTER TABLE `products_productreview` DISABLE KEYS */;
/*!40000 ALTER TABLE `products_productreview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_productvariant`
--

DROP TABLE IF EXISTS `products_productvariant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_productvariant` (
  `variant_id` int NOT NULL AUTO_INCREMENT,
  `variant_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `sku` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`variant_id`),
  UNIQUE KEY `sku` (`sku`),
  KEY `products_productvari_product_id_d9c22902_fk_products_` (`product_id`),
  CONSTRAINT `products_productvari_product_id_d9c22902_fk_products_` FOREIGN KEY (`product_id`) REFERENCES `products_product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_productvariant`
--

LOCK TABLES `products_productvariant` WRITE;
/*!40000 ALTER TABLE `products_productvariant` DISABLE KEYS */;
INSERT INTO `products_productvariant` VALUES (8,'Ryzen 9 7950X Boxed','SKU: AMD-R9-7950X',56999.00,11),(9,'Core i9-14900K Unlocked','INT-I9-14900K',55199.00,12),(10,'ROG Strix GeForce RTX 4090 OC Edition','ASUS-ROG-4090-OC',600942.00,13),(11,'Nitro+ AMD Radeon RX 7900 XTX Vapor-X','SKU: SAP-NITRO-7900XTX',94000.00,14),(12,'Windforce OC 12G','GIG-WF-4070S',56299.00,15),(13,'MAG B650 TOMAHAWK WIFI AM5','MSI-MAG-B650-TOM',20500.00,16),(14,'Z790-E Gaming WIFI II LGA1700','ASUS-STRIX-Z790E2',44999.00,17),(15,'64GB (2x32GB) DDR5 6000MHz C30','GSK-TZ5N-64G-6000',19502.00,18),(16,'32GB (2x16GB) DDR5 6000MHz C30 Black','COR-VEN-32G-6000',24779.00,19),(17,'2TB PCIe 4.0 NVMe M.2','SAM-990P-2TB',26649.00,20),(18,'4TB PCIe 4.0 NVMe M.2','WD-SN850X-4TB',59000.00,21),(19,'RM850x Shift 80 PLUS Gold Fully Modular','COR-RM850X-SHIFT',13146.00,22),(20,'1000W 80+ Gold ATX 3.0','SEA-VGX-1000',13292.00,23),(21,'O11 Dynamic EVO Mid-Tower White','LL-O11D-EVO-WHT',15963.00,24),(22,'North Charcoal Black with Walnut Wood Front','FD-NORTH-BLK-TG',11643.00,25);
/*!40000 ALTER TABLE `products_productvariant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_psu`
--

DROP TABLE IF EXISTS `products_psu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_psu` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tdp` int unsigned DEFAULT NULL,
  `wattage` int unsigned NOT NULL,
  `form_factor` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `efficiency_rating` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `modularity` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `length_mm` int unsigned NOT NULL,
  `power_8pin_count` smallint unsigned NOT NULL,
  `power_6pin_count` smallint unsigned NOT NULL,
  `power_12vhpwr` tinyint(1) NOT NULL,
  `variant_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `variant_id` (`variant_id`),
  CONSTRAINT `products_psu_variant_id_83555a69_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`),
  CONSTRAINT `products_psu_chk_1` CHECK ((`tdp` >= 0)),
  CONSTRAINT `products_psu_chk_2` CHECK ((`wattage` >= 0)),
  CONSTRAINT `products_psu_chk_3` CHECK ((`length_mm` >= 0)),
  CONSTRAINT `products_psu_chk_4` CHECK ((`power_8pin_count` >= 0)),
  CONSTRAINT `products_psu_chk_5` CHECK ((`power_6pin_count` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_psu`
--

LOCK TABLES `products_psu` WRITE;
/*!40000 ALTER TABLE `products_psu` DISABLE KEYS */;
INSERT INTO `products_psu` VALUES (1,NULL,850,'ATX','80+ Gold','FULL',160,0,0,1,19),(2,NULL,1000,'ATX','80+ Gold','FULL',160,0,0,1,20);
/*!40000 ALTER TABLE `products_psu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_ram`
--

DROP TABLE IF EXISTS `products_ram`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_ram` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tdp` int unsigned DEFAULT NULL,
  `ram_type` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `capacity_gb` int unsigned NOT NULL,
  `speed_mhz` int unsigned NOT NULL,
  `module_count` smallint unsigned NOT NULL,
  `variant_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `variant_id` (`variant_id`),
  CONSTRAINT `products_ram_variant_id_d4f5a0de_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`),
  CONSTRAINT `products_ram_chk_1` CHECK ((`tdp` >= 0)),
  CONSTRAINT `products_ram_chk_2` CHECK ((`capacity_gb` >= 0)),
  CONSTRAINT `products_ram_chk_3` CHECK ((`speed_mhz` >= 0)),
  CONSTRAINT `products_ram_chk_4` CHECK ((`module_count` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_ram`
--

LOCK TABLES `products_ram` WRITE;
/*!40000 ALTER TABLE `products_ram` DISABLE KEYS */;
INSERT INTO `products_ram` VALUES (1,0,'DDR5',64,6000,2,15),(2,5,'DDR5',16,6000,2,16);
/*!40000 ALTER TABLE `products_ram` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_storage`
--

DROP TABLE IF EXISTS `products_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_storage` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tdp` int unsigned DEFAULT NULL,
  `storage_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `capacity_gb` int NOT NULL,
  `interface_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `form_factor` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `variant_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `variant_id` (`variant_id`),
  CONSTRAINT `products_storage_variant_id_4b2204f0_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`),
  CONSTRAINT `products_storage_chk_1` CHECK ((`tdp` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_storage`
--

LOCK TABLES `products_storage` WRITE;
/*!40000 ALTER TABLE `products_storage` DISABLE KEYS */;
/*!40000 ALTER TABLE `products_storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services_service`
--

DROP TABLE IF EXISTS `services_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services_service` (
  `service_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_general_ci,
  `base_price` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`service_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_service`
--

LOCK TABLES `services_service` WRITE;
/*!40000 ALTER TABLE `services_service` DISABLE KEYS */;
/*!40000 ALTER TABLE `services_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services_servicerequest`
--

DROP TABLE IF EXISTS `services_servicerequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services_servicerequest` (
  `service_request_id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `issue_description` longtext COLLATE utf8mb4_general_ci,
  `total_amount` decimal(10,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `service_id` int NOT NULL,
  `user_id` int NOT NULL,
  `variant_id` int DEFAULT NULL,
  PRIMARY KEY (`service_request_id`),
  KEY `services_servicerequ_order_id_8394a2a7_fk_orders_or` (`order_id`),
  KEY `services_servicerequ_service_id_b9613175_fk_services_` (`service_id`),
  KEY `services_servicerequest_user_id_5ba6e88c_fk_Users_user_id` (`user_id`),
  KEY `services_servicerequ_variant_id_ddfc13cd_fk_products_` (`variant_id`),
  CONSTRAINT `services_servicerequ_order_id_8394a2a7_fk_orders_or` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`order_id`),
  CONSTRAINT `services_servicerequ_service_id_b9613175_fk_services_` FOREIGN KEY (`service_id`) REFERENCES `services_service` (`service_id`),
  CONSTRAINT `services_servicerequ_variant_id_ddfc13cd_fk_products_` FOREIGN KEY (`variant_id`) REFERENCES `products_productvariant` (`variant_id`),
  CONSTRAINT `services_servicerequest_user_id_5ba6e88c_fk_Users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_servicerequest`
--

LOCK TABLES `services_servicerequest` WRITE;
/*!40000 ALTER TABLE `services_servicerequest` DISABLE KEYS */;
/*!40000 ALTER TABLE `services_servicerequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `last_login` datetime(6) DEFAULT NULL,
  `user_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `phone_number` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `profile_image` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `role` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('2026-04-01 04:34:43.701801',1,'ashok','bariya','asohkbariya1982@gmail.com',NULL,'pbkdf2_sha256$600000$B278IHZeeaxKMIfJKUbiif$Ec3i7Kd7CdQPfJTkOpDVUsLi4BkTQT5jiwywb/1VzWw=',NULL,'admin',1,'2026-03-09 11:07:55.147040','2026-03-09 11:07:55.147294'),('2026-03-09 11:51:32.000000',3,'Yash','Bariya','yashbariya9925@gmail.com','8140031718','pbkdf2_sha256$600000$BzjzqHXIiVzDY7I4e7s15P$uLdhMzAk7glQIM98VO3tosnoNBN0CW+8VCamtCX6VPA=',NULL,'customer',1,'2026-03-09 11:51:53.934914','2026-03-09 11:51:53.934923'),(NULL,4,'Prem','Makawan','gamingxyz981@gmail.com','7016455514','pbkdf2_sha256$600000$9tpcXhWFoaC5J6gS1BN1NC$vXpBdoKbvmVsn2j/1hjPux0zhMX9+VZmqM2s9aP4xE8=',NULL,'customer',1,'2026-03-10 05:02:57.458394','2026-03-10 05:02:57.458622'),(NULL,5,'Prince','Jain','princejain200595@gmail.com','6352674484','pbkdf2_sha256$600000$yV2V5BZfvG7Jw2JgFTWTdf$c8h74pfIn4UufWIL4l7vmRb38jL4KX3OtPgOJF2SRiU=',NULL,'customer',1,'2026-03-10 05:25:42.551391','2026-03-10 05:25:42.551420'),(NULL,6,'Manish','Zala','manish2005@gmail.com','9737682783','pbkdf2_sha256$600000$JWaLCIDM3icPPUhBVb682q$c7YGLUHVjR9f4Z3JD5CiPCWlvVNrfBhzpNhGru0RmNA=',NULL,'customer',1,'2026-03-10 05:29:57.115967','2026-03-10 05:29:57.115987'),(NULL,7,'Omdevshih','Rana','omdevshih82@gmail.com','6355504818','pbkdf2_sha256$600000$QyuTh7kfbjbVnF4yOHaixD$EkFsaxm3j9tddWsyQfjadd9ADW3tI18tacF/JCMABik=',NULL,'customer',1,'2026-03-10 05:34:41.347327','2026-03-10 05:34:41.347464'),(NULL,8,'Vicky','Patel','vickypatel2000@gmail.com','8469836615','pbkdf2_sha256$600000$Wjh5iD2m3XkcULKaxrbssk$n9RhHG6tDx6hCg4QFPjvhFyFGSwawZflX+DaO8lWpKQ=','profile_images/Screenshot_2026-03-10_at_3.50.19PM.png','employee',1,'2026-03-10 10:22:58.647144','2026-03-30 05:02:07.420313'),(NULL,9,'Sumit','Mishara','sumitmishara2726@gmail.com','9054513290','pbkdf2_sha256$600000$3bsRn4TRAmaQxszqE2iwXt$Xl70kgEsWlF0UPkr4Htpm0cn1h20eyU2Sedhe7LjOnc=','profile_images/Screenshot_2026-03-10_at_4.03.35PM.png','employee',1,'2026-03-10 10:35:14.434415','2026-03-30 05:02:44.572294'),(NULL,10,'Harsh','Upadhaya','harshupadhaya2005@gmail.com','9426966021','pbkdf2_sha256$600000$MzgRL5dQrwsMR9n7ibffXS$4R68TSSucL+aYTQTlOhATVKDWbdforeGKstb+RtpThU=','profile_images/DK.jpeg','employee',1,'2026-03-10 10:38:03.657343','2026-03-16 05:16:01.741591'),(NULL,11,'Vikash','Gupata','vikashgupata2019@gmail.com','8320882919','pbkdf2_sha256$600000$nZYZarnUvHgsc2FS5G4keg$EKfuO0r3cJh6PZEXGd/8Q7NNJ34PVhgUymmVdmcH6VY=','profile_images/Screenshot_2026-03-10_at_4.09.06PM.png','employee',1,'2026-03-10 10:40:32.185119','2026-03-30 05:01:04.114024'),(NULL,12,'Sunil','Bariya','sunilbariya1516@gmail.com','8866361516','pbkdf2_sha256$600000$jNY1IEFIW7Oni3YnCYxsjh$DK6JvGEEaFK2Y9ub5J4EcqwwQP7LlQapMdmPH+6U9jg=','profile_images/Screenshot_2026-03-10_at_4.12.31PM.png','employee',1,'2026-03-10 10:43:25.224441','2026-03-15 06:25:46.154122');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-05 12:39:20
