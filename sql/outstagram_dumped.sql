-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: outstagram
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `avg_rating_p`
--

DROP TABLE IF EXISTS `avg_rating_p`;
/*!50001 DROP VIEW IF EXISTS `avg_rating_p`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `avg_rating_p` AS SELECT 
 1 AS `p_id`,
 1 AS `avg_rating`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `chat`
--

DROP TABLE IF EXISTS `chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat` (
  `p_id` varchar(10) NOT NULL,
  `c_id` varchar(10) NOT NULL,
  `chat_log` json DEFAULT NULL,
  PRIMARY KEY (`p_id`,`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `c_id` varchar(10) NOT NULL REFERENCES user(id) ON DELETE CASCADE ,
  `credit_card` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('0000000001','credit1'),('0000000002','credit2'),('0000000003','credit3'),('0000000004','credit4');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matching`
--

DROP TABLE IF EXISTS `matching`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matching` (
  `p_id` varchar(10) NOT NULL,
  `c_id` varchar(10) NOT NULL,
  `pay_id` varchar(10) NOT NULL,
  `status` enum('p_accept_match','p_deny_match','c_accept_price','c_deny_price','complete_task','send_result','accept_result') NOT NULL,
  PRIMARY KEY (`p_id`,`c_id`,`pay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matching`
--

LOCK TABLES `matching` WRITE;
/*!40000 ALTER TABLE `matching` DISABLE KEYS */;
INSERT INTO `matching` VALUES ('0000000005','0000000004','0000000011','complete_task'),('0000000006','0000000002','1111111011','complete_task'),('0000000006','0000000004','0000000010','complete_task'),('0000000007','0000000001','1111111100','complete_task'),('0000000007','0000000003','1111111101','complete_task'),('0000000007','0000000004','0000000001','complete_task'),('0000000008','0000000003','1111111111','complete_task'),('0000000008','0000000004','1111111110','complete_task');
/*!40000 ALTER TABLE `matching` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `pay_id` varchar(10) NOT NULL,
  `pay_status` enum('incomplete','complete') DEFAULT 'incomplete',
  `amount` float(10,2) NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`pay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES ('0000000001','complete',4000.00,'2000-11-01 14:29:00'),('0000000010','complete',3000.00,'2010-11-01 14:29:10'),('0000000011','complete',2000.00,'2020-11-01 14:29:20'),('1111111011','complete',500.00,'2015-11-01 14:29:36'),('1111111100','complete',1000.00,'2015-11-02 14:29:36'),('1111111101','complete',2000.00,'2015-11-03 14:29:36'),('1111111110','complete',3000.00,'2015-11-04 14:29:36'),('1111111111','complete',4000.00,'2015-11-05 14:29:36');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photographer`
--

DROP TABLE IF EXISTS `photographer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photographer` (
  `p_id` varchar(10) NOT NULL,
  `matching_count` int NOT NULL DEFAULT '0',
  `location` json DEFAULT NULL,
  `style` varchar(64) DEFAULT NULL,
  `price_min` float(10,2) DEFAULT '0.00',
  `price_max` float(10,2) DEFAULT '100000000.00',
  `bank_name` varchar(6) DEFAULT NULL,
  `bank_account` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`p_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photographer`
--

LOCK TABLES `photographer` WRITE;
/*!40000 ALTER TABLE `photographer` DISABLE KEYS */;
INSERT INTO `photographer` VALUES ('0000000005',0,NULL,NULL,100.00,100.00,'BBL','1000000005'),('0000000006',1,NULL,NULL,200.00,1000.00,'KBANK','1000000006'),('0000000007',2,NULL,NULL,300.00,2000.00,'TFB','1000000007'),('0000000008',2,NULL,NULL,400.00,5000.00,'SCB','1000000008');
/*!40000 ALTER TABLE `photographer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `p_id` varchar(10) NOT NULL,
  `c_id` varchar(10) NOT NULL,
  `rating` float(2,1) NOT NULL,
  `message` text,
  PRIMARY KEY (`p_id`,`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES ('0000000005','0000000004',4.5,'noice'),('0000000006','0000000002',3.0,'test'),('0000000006','0000000004',1.5,'wowza'),('0000000007','0000000001',4.0,'good'),('0000000007','0000000003',5.0,'perfect'),('0000000007','0000000004',3.2,'subarashi destsune'),('0000000008','0000000003',2.5,'bad'),('0000000008','0000000004',4.5,'nice');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` varchar(10) NOT NULL,
  `national_id` varchar(13) NOT NULL,
  `username` varchar(64) NOT NULL,
  `email` varchar(64) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('0000000001','1234567890121','phu','phu@gmail.com','pass1'),('0000000002','1234567890122','bow','bow@gmail.com','pass2'),('0000000003','1234567890123','pepper','pepper@gmail.com','pass3'),('0000000004','1234567890124','nattee','nattee@gmail.com','pass4'),('0000000005','1234567890125','put','put@gmail.com','pass5'),('0000000006','1234567890126','yod','yod@gmail.com','pass6'),('0000000007','1234567890127','peem','peem@gmail.com','pass7'),('0000000008','1234567890128','aof','aof@gmail.com','pass8');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_national_id`
--

DROP TABLE IF EXISTS `user_national_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_national_id` (
  `national_id` varchar(13) NOT NULL REFERENCES user(national_id) ON DELETE CASCADE,
  `birthdate` datetime DEFAULT NULL,
  `gender` varchar(64) DEFAULT NULL,
  `firstname` varchar(64) DEFAULT NULL,
  `lastname` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`national_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_national_id`
--

LOCK TABLES `user_national_id` WRITE;
/*!40000 ALTER TABLE `user_national_id` DISABLE KEYS */;
INSERT INTO `user_national_id` VALUES ('1234567890121','2008-11-11 00:00:00','M','Phu','Jongsaratis'),('1234567890122','2008-11-12 00:00:00','F','Wipawan','Temterakij'),('1234567890123','2008-11-13 00:00:00','M','Pepper','Pepper'),('1234567890124','2008-11-14 00:00:00','M','Nattee','Nepanan'),('1234567890125','2008-10-01 00:00:00','M','Puttinart','Puto'),('1234567890126','2008-10-02 00:00:00','M','Pakorn','Naja'),('1234567890127','2008-10-03 00:00:00','M','Peemaphoj','Phojmapeem'),('1234567890128','2008-10-04 00:00:00','M','Aof','Pongsak');
/*!40000 ALTER TABLE `user_national_id` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `avg_rating_p`
--

/*!50001 DROP VIEW IF EXISTS `avg_rating_p`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = tis620 */;
/*!50001 SET character_set_results     = tis620 */;
/*!50001 SET collation_connection      = tis620_thai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`pakorn`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `avg_rating_p` AS select `review`.`p_id` AS `p_id`,avg(`review`.`rating`) AS `avg_rating` from `review` group by `review`.`p_id` */;
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

-- Dump completed on 2021-11-19 18:19:39
