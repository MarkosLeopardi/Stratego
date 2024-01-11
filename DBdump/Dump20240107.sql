CREATE DATABASE  IF NOT EXISTS `it175128` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `it175128`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: dblabs.iee.ihu.gr    Database: it175128
-- ------------------------------------------------------
-- Server version	5.7.35

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
-- Table structure for table `RemovedPiecesPool`
--

DROP TABLE IF EXISTS `RemovedPiecesPool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RemovedPiecesPool` (
  `piece_id` int(11) NOT NULL,
  `piece_color` enum('B','R') NOT NULL,
  `piece_count` int(11) NOT NULL,
  PRIMARY KEY (`piece_id`,`piece_color`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RemovedPiecesPool`
--

LOCK TABLES `RemovedPiecesPool` WRITE;
/*!40000 ALTER TABLE `RemovedPiecesPool` DISABLE KEYS */;
INSERT INTO `RemovedPiecesPool` VALUES (1,'R',1),(3,'B',1),(4,'B',5),(4,'R',4),(5,'B',1),(5,'R',3),(6,'B',2),(6,'R',3),(7,'B',1),(7,'R',3),(8,'B',1),(8,'R',3),(9,'B',3),(9,'R',3),(10,'R',1),(12,'R',1);
/*!40000 ALTER TABLE `RemovedPiecesPool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board` (
  `position_x` tinyint(1) unsigned NOT NULL,
  `position_y` tinyint(1) unsigned NOT NULL,
  `piece_color` enum('B','R') DEFAULT NULL,
  `piece_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`position_x`,`position_y`),
  KEY `piece_id` (`piece_id`),
  CONSTRAINT `board_ibfk_1` FOREIGN KEY (`piece_id`) REFERENCES `pieces` (`piece_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (1,1,'R',12),(1,2,'R',2),(1,3,'R',5),(1,4,'R',9),(1,5,'R',6),(1,6,'R',2),(1,7,'R',2),(1,8,'R',5),(1,9,'R',7),(1,10,'R',4),(2,1,'R',4),(2,2,'R',5),(2,3,'R',4),(2,4,'R',6),(2,5,'R',3),(2,6,'R',2),(2,7,'R',4),(2,8,'R',9),(2,9,'R',8),(2,10,'R',7),(3,1,'R',11),(3,2,'R',8),(3,3,'R',8),(3,4,'R',8),(3,5,'R',6),(3,6,'R',5),(3,7,'R',10),(3,8,'R',10),(3,9,'R',4),(3,10,'R',7),(4,1,'R',1),(4,2,'R',5),(4,3,'R',2),(4,4,'R',9),(4,5,'R',6),(4,6,'R',2),(4,7,'R',7),(4,8,'R',4),(4,9,'R',4),(4,10,'R',4),(5,1,NULL,NULL),(5,2,NULL,NULL),(5,3,NULL,NULL),(5,4,NULL,NULL),(5,5,NULL,NULL),(5,6,NULL,NULL),(5,7,NULL,NULL),(5,8,NULL,NULL),(5,9,NULL,NULL),(5,10,NULL,NULL),(6,1,NULL,NULL),(6,2,NULL,NULL),(6,3,NULL,NULL),(6,4,NULL,NULL),(6,5,NULL,NULL),(6,6,NULL,NULL),(6,7,NULL,NULL),(6,8,NULL,NULL),(6,9,NULL,NULL),(6,10,'B',8),(7,1,'B',6),(7,2,'B',11),(7,3,'B',2),(7,4,'B',4),(7,5,'B',7),(7,6,'B',2),(7,7,'B',7),(7,8,'B',7),(7,9,'B',6),(7,10,'B',10),(8,1,'B',8),(8,2,'B',5),(8,3,'B',4),(8,4,'B',10),(8,5,'B',8),(8,6,'B',3),(8,7,'B',5),(8,8,'B',2),(8,9,'B',4),(8,10,'B',1),(9,1,'B',4),(9,2,'B',9),(9,3,'B',8),(9,4,'B',2),(9,5,'B',5),(9,6,'B',9),(9,7,'B',2),(9,8,'B',5),(9,9,'B',7),(9,10,'B',12),(10,1,'B',8),(10,2,'B',2),(10,3,'B',6),(10,4,'B',9),(10,5,'B',4),(10,6,'B',4),(10,7,'B',5),(10,8,'B',4),(10,9,'B',6),(10,10,'B',4);
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empty_board`
--

DROP TABLE IF EXISTS `empty_board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empty_board` (
  `position_x` tinyint(1) unsigned NOT NULL,
  `position_y` tinyint(1) unsigned NOT NULL,
  `piece_color` enum('B','R') DEFAULT NULL,
  `piece_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empty_board`
--

LOCK TABLES `empty_board` WRITE;
/*!40000 ALTER TABLE `empty_board` DISABLE KEYS */;
INSERT INTO `empty_board` VALUES (1,1,NULL,NULL),(1,2,NULL,NULL),(1,3,NULL,NULL),(1,4,NULL,NULL),(1,5,NULL,NULL),(1,6,NULL,NULL),(1,7,NULL,NULL),(1,8,NULL,NULL),(1,9,NULL,NULL),(1,10,NULL,NULL),(2,1,NULL,NULL),(2,2,NULL,NULL),(2,3,NULL,NULL),(2,4,NULL,NULL),(2,5,NULL,NULL),(2,6,NULL,NULL),(2,7,NULL,NULL),(2,8,NULL,NULL),(2,9,NULL,NULL),(2,10,NULL,NULL),(3,1,NULL,NULL),(3,2,NULL,NULL),(3,3,NULL,NULL),(3,4,NULL,NULL),(3,5,NULL,NULL),(3,6,NULL,NULL),(3,7,NULL,NULL),(3,8,NULL,NULL),(3,9,NULL,NULL),(3,10,NULL,NULL),(4,1,NULL,NULL),(4,2,NULL,NULL),(4,3,NULL,NULL),(4,4,NULL,NULL),(4,5,NULL,NULL),(4,6,NULL,NULL),(4,7,NULL,NULL),(4,8,NULL,NULL),(4,9,NULL,NULL),(4,10,NULL,NULL),(5,1,NULL,NULL),(5,2,NULL,NULL),(5,3,NULL,NULL),(5,4,NULL,NULL),(5,5,NULL,NULL),(5,6,NULL,NULL),(5,7,NULL,NULL),(5,8,NULL,NULL),(5,9,NULL,NULL),(5,10,NULL,NULL),(6,1,NULL,NULL),(6,2,NULL,NULL),(6,3,NULL,NULL),(6,4,NULL,NULL),(6,5,NULL,NULL),(6,6,NULL,NULL),(6,7,NULL,NULL),(6,8,NULL,NULL),(6,9,NULL,NULL),(6,10,NULL,NULL),(7,1,NULL,NULL),(7,2,NULL,NULL),(7,3,NULL,NULL),(7,4,NULL,NULL),(7,5,NULL,NULL),(7,6,NULL,NULL),(7,7,NULL,NULL),(7,8,NULL,NULL),(7,9,NULL,NULL),(7,10,NULL,NULL),(8,1,NULL,NULL),(8,2,NULL,NULL),(8,3,NULL,NULL),(8,4,NULL,NULL),(8,5,NULL,NULL),(8,6,NULL,NULL),(8,7,NULL,NULL),(8,8,NULL,NULL),(8,9,NULL,NULL),(8,10,NULL,NULL),(9,1,NULL,NULL),(9,2,NULL,NULL),(9,3,NULL,NULL),(9,4,NULL,NULL),(9,5,NULL,NULL),(9,6,NULL,NULL),(9,7,NULL,NULL),(9,8,NULL,NULL),(9,9,NULL,NULL),(9,10,NULL,NULL),(10,1,NULL,NULL),(10,2,NULL,NULL),(10,3,NULL,NULL),(10,4,NULL,NULL),(10,5,NULL,NULL),(10,6,NULL,NULL),(10,7,NULL,NULL),(10,8,NULL,NULL),(10,9,NULL,NULL),(10,10,NULL,NULL);
/*!40000 ALTER TABLE `empty_board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_status`
--

DROP TABLE IF EXISTS `game_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_status` (
  `game_id` int(11) NOT NULL AUTO_INCREMENT,
  `status` enum('Inactive','Initialized','Started','Ended','Aborted') DEFAULT 'Initialized',
  `player_turn` enum('R','B') DEFAULT 'R',
  `winner` int(11) DEFAULT NULL,
  `game_started_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `game_ended_at` timestamp DATETIME DEFAULT NULL,
  `last_change` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`game_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_status`
--

LOCK TABLES `game_status` WRITE;
/*!40000 ALTER TABLE `game_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moves`
--

DROP TABLE IF EXISTS `moves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moves` (
  `move_id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` int(11) DEFAULT NULL,
  `player_id` int(11) DEFAULT NULL,
  `piece_id` int(11) DEFAULT NULL,
  `from_position_x` int(11) DEFAULT NULL,
  `from_position_y` int(11) DEFAULT NULL,
  `to_position_x` int(11) DEFAULT NULL,
  `to_position_y` int(11) DEFAULT NULL,
  `move_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`move_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moves`
--

LOCK TABLES `moves` WRITE;
/*!40000 ALTER TABLE `moves` DISABLE KEYS */;
/*!40000 ALTER TABLE `moves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pieces`
--

DROP TABLE IF EXISTS `pieces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pieces` (
  `piece_id` int(11) NOT NULL AUTO_INCREMENT,
  `piece_type` enum('Flag','Spy','Scout','Miner','Sergeant','Lieutenant','Captain','Major','Colonel','General','Marshal','Bomb') NOT NULL,
  `piece_rank` int(11) DEFAULT NULL,
  `piece_count` int(11) DEFAULT '0',
  `special_properties` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`piece_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pieces`
--

LOCK TABLES `pieces` WRITE;
/*!40000 ALTER TABLE `pieces` DISABLE KEYS */;
INSERT INTO `pieces` VALUES (1,'Flag',1,1,'Immovable; capturing the opponent\'s Flag wins the game.'),(2,'Bomb',12,6,'Immovable; any piece attacking a Bomb is removed from the game, unless the attacking piece was a Miner'),(3,'Spy',2,1,'Weakest piece, captured by any other attacking piece, but an attacking Spy can capture the Marshal'),(4,'Scout',3,8,'Can move any distance in a horizontal or vertical straight line without leaping over pieces or lakes; originally unable to move and attack in the same turn, later changed to allow movement and attack.'),(5,'Miner',4,5,'Can defuse (i.e. capture) Bombs'),(6,'Sergeant',5,4,NULL),(7,'Lieutenant',6,4,NULL),(8,'Captain',7,4,NULL),(9,'Major',8,3,NULL),(10,'Colonel',9,2,NULL),(11,'General',10,1,NULL),(12,'Marshal',11,1,'Most powerful piece, but vulnerable to capture by an attacking Spy');
/*!40000 ALTER TABLE `pieces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `players` (
  `player_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_name` varchar(255) NOT NULL,
  `player_password` varchar(255) NOT NULL,
  `player_username` varchar(255) DEFAULT NULL,
  `piece_color` enum('R','B') DEFAULT NULL,
  `logged_in` tinyint(1) NOT NULL DEFAULT '0',
  `ready_to_play` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT INTO `players` VALUES (1,'Guest','Guest','Guest','R',1,1),(2,'Guest2','Guest2','Guest2','B',1,1);
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'it175128'
--

--
-- Dumping routines for database 'it175128'
--
/*!50003 DROP PROCEDURE IF EXISTS `DeleteGameStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`it175128`@`%` PROCEDURE `DeleteGameStatus`()
BEGIN
    DELETE FROM game_status WHERE status = 'Aborted' and game_id=1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertGame` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`it175128`@`%` PROCEDURE `InsertGame`(OUT p_game_id INT)
BEGIN
    -- Set initial values
    DECLARE p_game_id INT;
    DECLARE p_status ENUM('Inactive', 'Initialized', 'Started', 'Ended', 'Aborted') DEFAULT 'Initialized';
    DECLARE p_player_turn ENUM('R', 'B') DEFAULT 'R';
    DECLARE p_winner INT DEFAULT NULL;
    DECLARE p_game_started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
    DECLARE p_last_change TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
    
	IF (SELECT COUNT(*) FROM game_status WHERE game_id = 1) <= 0 THEN
       -- Insert new game record
	SET p_game_id=1;
    INSERT INTO game_status (game_id,status, player_turn, winner, game_started_at, last_change)
    VALUES (p_game_id,p_status, p_player_turn, p_winner, p_game_started_at, p_last_change);
    SET p_game_id = LAST_INSERT_ID();
    ELSE 
	SET p_game_id = 1;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Lose` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`it175128`@`%` PROCEDURE `Lose`(IN irow INT, IN icol INT)
BEGIN
    -- Declare variables to store selected values for the specified position
    DECLARE lost_piece_id INT;
    DECLARE lost_piece_color ENUM('R', 'B');

    SELECT piece_id, piece_color
    INTO lost_piece_id, lost_piece_color
    FROM board
    WHERE position_x = irow AND position_y = icol;


    IF lost_piece_id IS NOT NULL THEN
        UPDATE board SET piece_id =null, piece_color=null WHERE position_x =irow AND position_y = icol;

        IF EXISTS (SELECT 1 FROM RemovedPiecesPool WHERE piece_id = lost_piece_id AND piece_color = lost_piece_color) THEN
            UPDATE RemovedPiecesPool SET piece_count = piece_count + 1
            WHERE piece_id = lost_piece_id AND piece_color = lost_piece_color;
        ELSE
            INSERT INTO RemovedPiecesPool (piece_id, piece_color, piece_count)
            VALUES (lost_piece_id, lost_piece_color, 1);
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `moves` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`it175128`@`%` PROCEDURE `moves`(
	IN finalrow INT, 
    IN finalcol INT, 
    IN firstrow INT, 
    IN firstcol INT
    )
BEGIN
    -- Set initial values
    DECLARE pcolor ENUM ('B','R');
    DECLARE pid TINYINT;

    -- Update the Game Board
    SELECT  piece_id, piece_color INTO pid, pcolor FROM `board` WHERE position_x=firstrow AND position_y=firstcol;
    
    UPDATE board SET piece_id=pid, piece_color=pcolor WHERE position_x=finalrow AND position_y=finalcol; 
    
    UPDATE board SET piece_id=NULL,piece_color=NULL WHERE position_x=firstrow AND position_y=firstcol;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `removePiece` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`it175128`@`%` PROCEDURE `removePiece`(IN loss_frow INT, IN loss_fcol INT)
BEGIN
    -- Declare variables to store selected values
    DECLARE bid INT;
    DECLARE bcolor ENUM('R', 'B');

    -- Select piece_id and piece_color from the board table
    SELECT piece_id, piece_color
    INTO bid, bcolor
    FROM board
    WHERE position_x = loss_frow AND position_y = loss_fcol;

    -- Check if the piece exists in the board
    IF bid IS NOT NULL THEN
        -- Check if the combination exists in RemovedPiecesPool
        IF EXISTS (SELECT 1 FROM RemovedPiecesPool WHERE piece_id = bid AND piece_color = bcolor) THEN
            -- Update piece_count if the combination exists
            UPDATE RemovedPiecesPool SET piece_count = piece_count + 1
            WHERE piece_id = bpiece_id AND piece_color = bcolor;
        ELSE
            -- Insert a new row if the combination doesn't exist
            INSERT INTO RemovedPiecesPool (piece_id, piece_color, piece_count)
            VALUES (bid, bcolor, 1);
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ResetBoard` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`it175128`@`%` PROCEDURE `ResetBoard`()
BEGIN
    SET SQL_SAFE_UPDATES = 0;
DELETE FROM board;
SET SQL_SAFE_UPDATES = 1;

    -- Insert data into the "board" table from the "empty_board" table
    INSERT INTO board SELECT * FROM empty_board;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `resetPlayer1PiecesPool` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`it175128`@`%` PROCEDURE `resetPlayer1PiecesPool`()
BEGIN
    -- Clear existing data in Player1PiecesPool
    TRUNCATE TABLE Player1PiecesPool;

    -- Insert data into Player1PiecesPool from pieces table
    INSERT INTO Player1PiecesPool (piece_id, piece_count)
    SELECT piece_id, piece_count FROM pieces;

    -- Optionally, you can add additional logic or conditions here

    -- Signal the success of the procedure
    SELECT 'Player1PiecesPool reset successfully.' AS Result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ResetReadyFlag` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`it175128`@`%` PROCEDURE `ResetReadyFlag`(playerId INT)
BEGIN
	update players 
	set ready_to_play=0 
	where player_id=playerId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `resetRemovedPiecesPool` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`it175128`@`%` PROCEDURE `resetRemovedPiecesPool`()
BEGIN
    -- Clear existing data in Player1PiecesPool
    TRUNCATE TABLE RemovedPiecesPool;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `startGame` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`it175128`@`%` PROCEDURE `startGame`(IN p_game_id INT)
BEGIN
    -- Declare variable to store the current game status
    DECLARE currentStatus enum('Inactive','Initialized','Started','Ended','Aborted');

    -- Select the current game status from the game_status table
    SELECT status INTO currentStatus FROM game_status WHERE game_id = p_game_id;

    -- Check if the current status is 'Initialized'
    IF currentStatus = 'Initialized' THEN
        -- Update the game_status to 'Started'
        UPDATE game_status SET status = 'Started' WHERE game_id = p_game_id;
        SELECT 'Game started successfully.' AS result;
    ELSE
        -- Return a message indicating that the game is already started or in another state
        SELECT 'Game is already started or in another state.' AS result;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Tie` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`it175128`@`%` PROCEDURE `Tie`(IN frow INT, IN fcol INT, IN irow INT, IN icol INT)
BEGIN

    DECLARE first_piece_id INT; 
    DECLARE first_piece_color ENUM('R', 'B');
    DECLARE second_piece_id INT;
    DECLARE second_piece_color ENUM('R', 'B');

    SELECT piece_id, piece_color
    INTO first_piece_id, first_piece_color
    FROM board
    WHERE position_x = frow AND position_y = fcol;

    SELECT piece_id, piece_color
    INTO second_piece_id, second_piece_color
    FROM board
    WHERE position_x = irow AND position_y = icol;

    IF first_piece_id IS NOT NULL AND second_piece_id IS NOT NULL THEN

        UPDATE board SET piece_id =null, piece_color=null WHERE position_x = frow AND position_y = fcol;
        UPDATE board SET piece_id =null, piece_color=null WHERE position_x =irow AND position_y = icol;


        IF EXISTS (SELECT 1 FROM RemovedPiecesPool WHERE piece_id = first_piece_id AND piece_color = first_piece_color) THEN
            UPDATE RemovedPiecesPool SET piece_count = piece_count + 1
            WHERE piece_id = first_piece_id AND piece_color = first_piece_color;
        ELSE
            INSERT INTO RemovedPiecesPool (piece_id, piece_color, piece_count)
            VALUES (first_piece_id, first_piece_color, 1);
        END IF;


        IF EXISTS (SELECT 1 FROM RemovedPiecesPool WHERE piece_id = second_piece_id AND piece_color = second_piece_color) THEN
            UPDATE RemovedPiecesPool SET piece_count = piece_count + 1
            WHERE piece_id = second_piece_id AND piece_color = second_piece_color;
        ELSE
            INSERT INTO RemovedPiecesPool (piece_id, piece_color, piece_count)
            VALUES (second_piece_id, second_piece_color, 1);
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TogglePlayerTurn` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`it175128`@`%` PROCEDURE `TogglePlayerTurn`(IN p_game_id INT)
BEGIN
    -- Toggle player_turn in game_status table
    UPDATE game_status
    SET player_turn = CASE WHEN player_turn = 'R' THEN 'B' ELSE 'R' END
    WHERE game_id = p_game_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Win` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`it175128`@`%` PROCEDURE `Win`(IN irow INT, IN icol INT)
BEGIN
    -- Declare variables to store selected values for the specified position
    DECLARE win_piece_id INT;
    DECLARE win_piece_color ENUM('R', 'B');

    SELECT piece_id, piece_color
    INTO win_piece_id, win_piece_color
    FROM board
    WHERE position_x = irow AND position_y = icol;
    
    IF win_piece_id IS NOT NULL THEN
        UPDATE game_status SET status = 'Ended', winner=win_piece_color, game_ended_at = current_timestamp() ;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-07  0:46:58
