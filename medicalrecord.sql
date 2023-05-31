-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        8.0.31 - MySQL Community Server - GPL
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- 导出 medical_record 的数据库结构
CREATE DATABASE IF NOT EXISTS `medical_record` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `medical_record`;

-- 导出  表 medical_record.patient 结构
CREATE TABLE IF NOT EXISTS `patient` (
  `patient_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '病人',
  `sex` varchar(50) NOT NULL DEFAULT '男',
  `age` int NOT NULL DEFAULT '0',
  `phone` varchar(50) DEFAULT '电话号码',
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8mb3;

-- 数据导出被取消选择。

-- 导出  表 medical_record.print_record 结构
CREATE TABLE IF NOT EXISTS `print_record` (
  `print_id` int NOT NULL AUTO_INCREMENT,
  `medical_id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `diagnose_time` varchar(50) NOT NULL,
  `cure` varchar(300) NOT NULL,
  `print_time` varchar(50) NOT NULL,
  `all_in_cost` float NOT NULL DEFAULT '0',
  `rec_cost` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`print_id`),
  KEY `print_medical` (`medical_id`),
  CONSTRAINT `print_medical` FOREIGN KEY (`medical_id`) REFERENCES `record` (`medical_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb3;

-- 数据导出被取消选择。

-- 导出  表 medical_record.record 结构
CREATE TABLE IF NOT EXISTS `record` (
  `medical_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `first_visit_time` varchar(50) NOT NULL,
  `diagnose` varchar(100) DEFAULT NULL,
  `cure` varchar(100) DEFAULT NULL,
  `all_in_cost` float NOT NULL DEFAULT '0',
  `rec_cost` float NOT NULL DEFAULT '0',
  `detail` varchar(500) DEFAULT NULL,
  `if_printed` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`medical_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `record_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8mb3;

-- 数据导出被取消选择。

-- 导出  表 medical_record.sys_log 结构
CREATE TABLE IF NOT EXISTS `sys_log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `log_time` varchar(50) NOT NULL,
  `content` varchar(600) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=270 DEFAULT CHARSET=utf8mb3;

-- 数据导出被取消选择。

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
