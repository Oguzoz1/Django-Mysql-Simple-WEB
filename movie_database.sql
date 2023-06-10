-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: moviedatabase
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `audience`
--

DROP TABLE IF EXISTS `audience`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audience` (
  `username` varchar(50) NOT NULL,
  PRIMARY KEY (`username`),
  CONSTRAINT `audience_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE,
  CONSTRAINT `audience_user_fk` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audience`
--

LOCK TABLES `audience` WRITE;
/*!40000 ALTER TABLE `audience` DISABLE KEYS */;
INSERT INTO `audience` VALUES ('audience1'),('audience2');
/*!40000 ALTER TABLE `audience` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bought_tickets`
--

DROP TABLE IF EXISTS `bought_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bought_tickets` (
  `ticket_id` int NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `session_id` int DEFAULT NULL,
  PRIMARY KEY (`ticket_id`),
  KEY `username` (`username`),
  KEY `session_id` (`session_id`),
  CONSTRAINT `bought_tickets_ibfk_1` FOREIGN KEY (`username`) REFERENCES `audience` (`username`),
  CONSTRAINT `bought_tickets_ibfk_2` FOREIGN KEY (`session_id`) REFERENCES `movie_sessions` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bought_tickets`
--

LOCK TABLES `bought_tickets` WRITE;
/*!40000 ALTER TABLE `bought_tickets` DISABLE KEYS */;
INSERT INTO `bought_tickets` VALUES (601000,'audience1',601),(601002,'audience1',601),(603001,'audience1',603);
/*!40000 ALTER TABLE `bought_tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `database_managers`
--

DROP TABLE IF EXISTS `database_managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `database_managers` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `database_managers`
--

LOCK TABLES `database_managers` WRITE;
/*!40000 ALTER TABLE `database_managers` DISABLE KEYS */;
INSERT INTO `database_managers` VALUES ('manager1','managerpass1'),('manager2','managerpass2'),('manager35','managerpass35');
/*!40000 ALTER TABLE `database_managers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `director`
--

DROP TABLE IF EXISTS `director`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `director` (
  `username` varchar(50) NOT NULL,
  `nation` varchar(50) DEFAULT NULL,
  `platform_id` int DEFAULT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `unique_username` (`username`),
  UNIQUE KEY `unique_platform_id` (`platform_id`),
  CONSTRAINT `director_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE,
  CONSTRAINT `director_ibfk_2` FOREIGN KEY (`platform_id`) REFERENCES `rating_platform` (`platform_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `director`
--

LOCK TABLES `director` WRITE;
/*!40000 ALTER TABLE `director` DISABLE KEYS */;
INSERT INTO `director` VALUES ('director1','Turkey',10130);
/*!40000 ALTER TABLE `director` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre` (
  `genre_id` int NOT NULL,
  `genre_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`genre_id`),
  KEY `genre_name` (`genre_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES (80003,'Adventure'),(80001,'Animation'),(80002,'Comedy'),(80006,'Drama'),(80004,'Real Story'),(80005,'Thriller');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_sessions`
--

DROP TABLE IF EXISTS `movie_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_sessions` (
  `session_id` int NOT NULL,
  `movie_id` int NOT NULL,
  `movie_name` varchar(100) NOT NULL,
  `duration` int NOT NULL,
  `genre` varchar(50) NOT NULL,
  `average_rating` decimal(3,2) NOT NULL,
  `director_username` varchar(50) NOT NULL,
  `platform_id` int NOT NULL,
  `predecessors` varchar(255) DEFAULT NULL,
  `theatre_id` int NOT NULL,
  `time_slot` int NOT NULL,
  `session_date` date NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `movie_id` (`movie_id`),
  KEY `director_username` (`director_username`),
  KEY `platform_id` (`platform_id`),
  KEY `theatre_id` (`theatre_id`),
  KEY `fk_movie_sessions_genre` (`genre`),
  KEY `fk_movie_sessions_average_rating` (`average_rating`),
  CONSTRAINT `fk_movie_sessions_average_rating` FOREIGN KEY (`average_rating`) REFERENCES `movies` (`overall_rating`),
  CONSTRAINT `fk_movie_sessions_genre` FOREIGN KEY (`genre`) REFERENCES `movies` (`genre`),
  CONSTRAINT `movie_sessions_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`),
  CONSTRAINT `movie_sessions_ibfk_2` FOREIGN KEY (`director_username`) REFERENCES `director` (`username`),
  CONSTRAINT `movie_sessions_ibfk_3` FOREIGN KEY (`platform_id`) REFERENCES `rating_platform` (`platform_id`),
  CONSTRAINT `movie_sessions_ibfk_4` FOREIGN KEY (`theatre_id`) REFERENCES `theatre` (`theatre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_sessions`
--

LOCK TABLES `movie_sessions` WRITE;
/*!40000 ALTER TABLE `movie_sessions` DISABLE KEYS */;
INSERT INTO `movie_sessions` VALUES (601,101,'Test Movie',120,'Adventure',3.47,'director1',10130,NULL,901,1,'2023-06-03'),(602,102,'Test Movie 2',120,'Adventure',2.00,'director1',10130,'101',901,1,'2023-06-03'),(603,103,'Test Movie 3',120,'Adventure',1.00,'director1',10130,'101,102',901,1,'2023-06-03'),(604,104,'Test Movie 4',150,'Adventure',1.00,'director1',10130,'101,102,103',901,1,'2023-06-03'),(605,105,'X movie',90,'Adventure',4.00,'director1',10130,NULL,901,1,'2023-06-03');
/*!40000 ALTER TABLE `movie_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movies` (
  `movie_id` int NOT NULL,
  `movie_name` varchar(100) NOT NULL,
  `duration` int NOT NULL,
  `overall_rating` decimal(3,2) DEFAULT NULL,
  `director_username` varchar(50) NOT NULL,
  `platform_id` int NOT NULL,
  `genre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`movie_id`),
  KEY `director_username` (`director_username`),
  KEY `platform_id` (`platform_id`),
  KEY `idx_movies_overall_rating` (`overall_rating`),
  KEY `movie_genre` (`genre`),
  CONSTRAINT `fk_movie_genre` FOREIGN KEY (`genre`) REFERENCES `genre` (`genre_name`),
  CONSTRAINT `movies_ibfk_1` FOREIGN KEY (`director_username`) REFERENCES `director` (`username`),
  CONSTRAINT `movies_ibfk_2` FOREIGN KEY (`platform_id`) REFERENCES `rating_platform` (`platform_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
INSERT INTO `movies` VALUES (101,'Test Movie',120,3.47,'director1',10130,'Adventure'),(102,'Test Movie 2',120,2.00,'director1',10130,'Adventure'),(103,'Test Movie 3',120,1.00,'director1',10130,'Adventure'),(104,'Test Movie 4',150,1.00,'director1',10130,'Adventure'),(105,'X movie',90,4.00,'director1',10130,'Adventure');
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating_platform`
--

DROP TABLE IF EXISTS `rating_platform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rating_platform` (
  `platform_id` int NOT NULL,
  `platform_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`platform_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating_platform`
--

LOCK TABLES `rating_platform` WRITE;
/*!40000 ALTER TABLE `rating_platform` DISABLE KEYS */;
INSERT INTO `rating_platform` VALUES (10130,'IMDB'),(10131,'Letterboxd'),(10132,'FilmIzle'),(10133,'Filmora'),(10134,'BollywoodMDB');
/*!40000 ALTER TABLE `rating_platform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ratings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `movie_id` int NOT NULL,
  `rating` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_rating` (`username`,`movie_id`),
  KEY `movie_id` (`movie_id`),
  CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`username`) REFERENCES `audience` (`username`) ON DELETE CASCADE,
  CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`movie_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
INSERT INTO `ratings` VALUES (1,'audience1',101,2),(2,'audience1',102,2),(3,'audience1',103,1),(4,'audience1',104,1),(5,'audience1',105,4),(9,'audience2',101,4.2);
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_movie_rating` AFTER INSERT ON `ratings` FOR EACH ROW BEGIN
    DECLARE total_ratings DECIMAL(3,2);
    DECLARE num_ratings INT;
    DECLARE avg_rating DECIMAL(3,2);
    DECLARE new_movie_id INT;

    SELECT SUM(rating), COUNT(*) INTO total_ratings, num_ratings
    FROM ratings
    WHERE movie_id = NEW.movie_id;

    IF num_ratings > 0 THEN
        SET avg_rating = (total_ratings + NEW.rating) / (num_ratings + 1);
    ELSE
        SET avg_rating = NEW.rating;
    END IF;

    UPDATE movies
    SET overall_rating = avg_rating
    WHERE movie_id = NEW.movie_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `subscribed_platforms`
--

DROP TABLE IF EXISTS `subscribed_platforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscribed_platforms` (
  `audience_username` varchar(50) NOT NULL,
  `platform_id` int NOT NULL,
  PRIMARY KEY (`audience_username`,`platform_id`),
  KEY `platform_id` (`platform_id`),
  CONSTRAINT `subscribed_platforms_ibfk_1` FOREIGN KEY (`audience_username`) REFERENCES `audience` (`username`) ON DELETE CASCADE,
  CONSTRAINT `subscribed_platforms_ibfk_2` FOREIGN KEY (`platform_id`) REFERENCES `rating_platform` (`platform_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscribed_platforms`
--

LOCK TABLES `subscribed_platforms` WRITE;
/*!40000 ALTER TABLE `subscribed_platforms` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscribed_platforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `theatre`
--

DROP TABLE IF EXISTS `theatre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `theatre` (
  `theatre_id` int NOT NULL,
  `theatre_name` varchar(100) DEFAULT NULL,
  `theatre_capacity` int DEFAULT NULL,
  `time_slot` int DEFAULT NULL,
  PRIMARY KEY (`theatre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `theatre`
--

LOCK TABLES `theatre` WRITE;
/*!40000 ALTER TABLE `theatre` DISABLE KEYS */;
INSERT INTO `theatre` VALUES (901,'Test Theatre',97,4);
/*!40000 ALTER TABLE `theatre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `username` varchar(50) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `surname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('audience1','password','Selim','Satar'),('audience2','password','Özkan','Samet'),('director1','password','Mehmet','Akar');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'moviedatabase'
--

--
-- Dumping routines for database 'moviedatabase'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-04  2:20:05
