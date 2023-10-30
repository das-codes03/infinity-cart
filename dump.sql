CREATE DATABASE  IF NOT EXISTS `infinitycart` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `infinitycart`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: infinitycart
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `cart_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  PRIMARY KEY (`cart_id`),
  KEY `customer_id_idx` (`customer_id`),
  CONSTRAINT `customer_id_cart` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,1);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_item`
--

DROP TABLE IF EXISTS `cart_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_item` (
  `product_id` int NOT NULL,
  `cart_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`product_id`,`cart_id`),
  KEY `product_id_cart_idx` (`product_id`),
  KEY `cart_id_idx` (`cart_id`),
  CONSTRAINT `cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `product_id_cart` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_item`
--

LOCK TABLES `cart_item` WRITE;
/*!40000 ALTER TABLE `cart_item` DISABLE KEYS */;
INSERT INTO `cart_item` VALUES (21,1,6);
/*!40000 ALTER TABLE `cart_item` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_cart_item_seller` BEFORE INSERT ON `cart_item` FOR EACH ROW BEGIN
    DECLARE cart_seller_id INT;
    DECLARE new_product_id INT;
    DECLARE new_cart_id INT;
    
    -- Get the seller_id of the cart's customer
    SELECT seller_id INTO cart_seller_id
    FROM seller
    WHERE seller_id = (
        SELECT seller_id
        FROM cart
        WHERE cart_id = NEW.cart_id
        LIMIT 1
    ) LIMIT 1;

    -- Get the seller_id of the new product
    SELECT seller_id INTO new_product_id
    FROM product
    WHERE product_id = NEW.product_id;

    -- Get the cart_id of the new cart_item
    SET new_cart_id = NEW.cart_id;

    -- Check if the new product has a different seller
    IF new_product_id != cart_seller_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'New cart_item has a different seller than the cart';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `address` varchar(200) NOT NULL,
  `pincode` bigint NOT NULL,
  `phone` varchar(15) NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Arghadeep','Pune',411021,'8153066859');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_login`
--

DROP TABLE IF EXISTS `customer_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_login` (
  `customer_id` int NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  CONSTRAINT `customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_login`
--

LOCK TABLES `customer_login` WRITE;
/*!40000 ALTER TABLE `customer_login` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `delivered` tinyint NOT NULL DEFAULT '0',
  `transaction_id` int DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id_idx` (`customer_id`),
  KEY `transaction_id_idx` (`transaction_id`),
  CONSTRAINT `customer_id_order` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON UPDATE CASCADE,
  CONSTRAINT `transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (105,1,0,71),(106,1,0,71),(112,1,0,71),(115,1,0,71),(153,1,0,71),(154,1,0,71),(155,1,0,71),(156,1,0,71),(157,1,0,71),(158,1,0,71),(159,1,0,71),(163,1,0,71),(168,1,0,71),(169,1,0,72),(175,1,0,73),(176,1,0,74);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!50001 DROP VIEW IF EXISTS `order_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `order_details` AS SELECT 
 1 AS `order_id`,
 1 AS `customer_id`,
 1 AS `customer_name`,
 1 AS `product_id`,
 1 AS `product_name`,
 1 AS `mrp`,
 1 AS `quantity`,
 1 AS `total_price`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `product_id_orderItem_idx` (`product_id`),
  CONSTRAINT `order_id_item` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `product_id_orderItem` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (105,22,10),(106,22,10),(112,22,10),(115,22,10),(115,23,1),(153,22,10),(153,23,6),(154,22,10),(154,23,6),(155,22,10),(155,23,6),(156,22,10),(156,23,6),(157,22,10),(157,23,6),(158,22,10),(158,23,6),(159,22,10),(159,23,6),(163,22,10),(163,23,6),(168,22,10),(168,23,6),(169,22,10),(169,23,6),(175,22,10),(175,23,6);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` varchar(512) NOT NULL,
  `mrp` decimal(10,2) NOT NULL,
  `seller_id` int NOT NULL,
  `image_url` varchar(1000) DEFAULT NULL,
  `quantity_available` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`product_id`),
  KEY `seller_id_idx` (`seller_id`),
  CONSTRAINT `seller_id` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (21,'Product 1','Description for Product 1',19.99,1,'image_url_1.jpg',101),(22,'Product 2','Description for Product 2',29.99,2,'image_url_2.jpg',91),(23,'Product 3','Description for Product 3',39.99,3,'image_url_3.jpg',134),(24,'Product 4','Description for Product 4',49.99,4,'image_url_4.jpg',1),(25,'Product 5','Description for Product 5',59.99,5,'image_url_5.jpg',1),(26,'Product 6','Description for Product 6',69.99,6,'image_url_6.jpg',1),(27,'Product 7','Description for Product 7',79.99,7,'image_url_7.jpg',1),(28,'Product 8','Description for Product 8',89.99,8,'image_url_8.jpg',1),(29,'Product 9','Description for Product 9',99.99,9,'image_url_9.jpg',1),(30,'Product 10','Description for Product 10',109.99,10,'image_url_10.jpg',1),(31,'Product 11','Description for Product 11',119.99,1,'image_url_11.jpg',1),(32,'Product 12','Description for Product 12',129.99,2,'image_url_12.jpg',1),(33,'Product 13','Description for Product 13',139.99,3,'image_url_13.jpg',1),(34,'Product 14','Description for Product 14',149.99,4,'image_url_14.jpg',1),(35,'Product 15','Description for Product 15',159.99,5,'image_url_15.jpg',1),(36,'Product 16','Description for Product 16',169.99,6,'image_url_16.jpg',1),(37,'Product 17','Description for Product 17',179.99,7,'image_url_17.jpg',1),(38,'Product 18','Description for Product 18',189.99,8,'image_url_18.jpg',1),(39,'Product 19','Description for Product 19',199.99,9,'image_url_19.jpg',1),(40,'Product 20','Description for Product 20',209.99,10,'image_url_20.jpg',1),(41,'Shampoo','used for bathing',199.99,1,NULL,100);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller`
--

DROP TABLE IF EXISTS `seller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seller` (
  `seller_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `address` varchar(512) NOT NULL,
  `phone` varchar(15) NOT NULL,
  PRIMARY KEY (`seller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller`
--

LOCK TABLES `seller` WRITE;
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
INSERT INTO `seller` VALUES (1,'Seller 1','Address 1','123-456-7890'),(2,'Seller 2','Address 2','987-654-3210'),(3,'Seller 3','Address 3','555-555-5555'),(4,'Seller 4','Address 4','777-777-7777'),(5,'Seller 5','Address 5','888-888-8888'),(6,'Seller 6','Address 6','999-999-9999'),(7,'Seller 7','Address 7','111-222-3333'),(8,'Seller 8','Address 8','444-444-4444'),(9,'Seller 9','Address 9','666-666-6666'),(10,'Seller 10','Address 10','333-333-3333');
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller_login`
--

DROP TABLE IF EXISTS `seller_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seller_login` (
  `seller_id` int NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`seller_id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  CONSTRAINT `seller_id_login` FOREIGN KEY (`seller_id`) REFERENCES `seller` (`seller_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller_login`
--

LOCK TABLES `seller_login` WRITE;
/*!40000 ALTER TABLE `seller_login` DISABLE KEYS */;
/*!40000 ALTER TABLE `seller_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `seller_id` int NOT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `customer_id_idx` (`customer_id`),
  KEY `seller_id_transaction_idx` (`seller_id`),
  CONSTRAINT `customer_id_transaction` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (51,'2023-10-30 11:46:00',1,300.00,1),(52,'2023-10-30 11:46:42',1,300.00,1),(53,'2023-10-30 13:29:25',1,300.00,1),(54,'2023-10-30 13:39:03',1,340.00,1),(56,'2023-10-30 18:42:52',1,540.00,1),(57,'2023-10-30 18:44:31',1,540.00,1),(58,'2023-10-30 18:46:29',1,540.00,1),(59,'2023-10-30 18:46:56',1,540.00,1),(60,'2023-10-30 18:48:14',1,540.00,1),(61,'2023-10-30 18:48:36',1,540.00,1),(62,'2023-10-30 18:49:04',1,540.00,1),(66,'2023-10-30 18:54:18',1,540.00,1),(71,'2023-10-30 18:55:34',1,540.00,1),(72,'2023-10-30 18:55:51',1,540.00,1),(73,'2023-10-30 19:00:33',1,540.00,1),(74,'2023-10-30 19:27:46',1,0.00,1);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'infinitycart'
--
/*!50003 DROP FUNCTION IF EXISTS `get_order_bill` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_order_bill`(orderId INT) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
	declare total decimal(10,2);
    
    SELECT amount into total from `order` join `transaction` on `order`.transaction_id = `transaction`.transaction_id where `order`.order_id = orderId;
    
    
RETURN total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `IncreaseProductCount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `IncreaseProductCount`(
    IN p_id INT,
    IN n INT
)
BEGIN
    DECLARE available_count INT;

    -- Get the current available count of the product
SELECT 
    quantity_available
INTO available_count FROM
    product
WHERE
    product_id = p_id;

        -- Increase the available count by n
UPDATE product
SET 
    quantity_available = quantity_available + n
WHERE
    product_id = p_id;
        
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PlaceOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PlaceOrder`(IN cartId INT)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE current_product_id INT;
    DECLARE current_quantity INT;
    DECLARE customerId INT;
    DECLARE orderId INT;
    DECLARE transactionId INT;
    
    DECLARE total_price INT default 0;
	DECLARE currentProductPrice INT;
    
    Declare test int;
    
    DECLARE cart_item_cursor CURSOR FOR
        SELECT product_id, quantity
        FROM cart_item
        WHERE cart_id = cartId;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	  DECLARE exit handler for sqlexception
 BEGIN
    -- ERROR
  ROLLBACK;
  resignal;
END;

	-- start transaction here
	START TRANSACTION;

	SELECT 
    customer_id
INTO customerId FROM
    cart
WHERE
    cart_id = cartId;
	-- start new order
	INSERT into `order`(customer_id) values (customerId);
	set orderId = last_insert_id();
    
    OPEN cart_item_cursor;
	-- traverse through every cart_item
    read_loop: LOOP
        FETCH cart_item_cursor INTO current_product_id, current_quantity;
		IF done THEN
            LEAVE read_loop;
        END IF;
        delete from cart_item where cart_id = cartId and product_id = current_product_id;
        INSERT into order_item (order_id, product_id, quantity) values (orderId, current_product_id, current_quantity);
SELECT 
    mrp
INTO currentProductPrice FROM
    product
WHERE
    product_id = current_product_id;
        set total_price = total_price + (current_quantity *  currentProductPrice);
        
        -- Call the ReduceProductCount procedure for the current cart item
        CALL ReduceProductCount(current_product_id, current_quantity);
    END LOOP;

    CLOSE cart_item_cursor;
	
    -- now create a transaction
    insert into `transaction` (customer_id, amount) values (customerId, total_price);
	set transactionId = last_insert_id();
	-- delete the cart items
SET foreign_key_checks = 0;

select count(*) into test from `order` where order_id > 0;




UPDATE `order` 
SET 
    transaction_id = transactionId
WHERE
    order_id = orderId;
SET foreign_key_checks = 1;
   -- signal sqlstate '45000' SET MESSAGE_TEXT = transactionId;
     COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ReduceProductCount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ReduceProductCount`(
    IN p_id INT,
    IN n INT
)
BEGIN
    DECLARE available_count INT;
    
     DECLARE exit handler for sqlexception
 BEGIN
    -- ERROR
  ROLLBACK;
  resignal;
END;

    -- Get the current available count of the product
SELECT 
    quantity_available
INTO available_count FROM
    product
WHERE
    product_id = p_id;

    -- Check if there are enough products available
    IF available_count < n THEN
        -- Not enough products available, rollback the transaction
       
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient product quantity';
    ELSE
        -- Reduce the available count by n
        UPDATE product
        SET quantity_available = quantity_available - n
        WHERE product_id = p_id;
        
      
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `order_details`
--

/*!50001 DROP VIEW IF EXISTS `order_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `order_details` AS select `o`.`order_id` AS `order_id`,`o`.`customer_id` AS `customer_id`,`c`.`name` AS `customer_name`,`p`.`product_id` AS `product_id`,`p`.`name` AS `product_name`,`p`.`mrp` AS `mrp`,`oi`.`quantity` AS `quantity`,(`oi`.`quantity` * `p`.`mrp`) AS `total_price` from (((`order` `o` join `order_item` `oi` on((`o`.`order_id` = `oi`.`order_id`))) join `product` `p` on((`oi`.`product_id` = `p`.`product_id`))) join `customer` `c` on((`c`.`customer_id` = `o`.`customer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-31  1:37:45
