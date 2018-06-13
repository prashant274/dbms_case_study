/*
SQLyog Ultimate v10.00 Beta1
MySQL - 5.5.27 : Database - car_rental_case_study
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`car_rental_case_study` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `car_rental_case_study`;

/*Table structure for table `age_categories` */

DROP TABLE IF EXISTS `age_categories`;

CREATE TABLE `age_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `max_age` int(11) DEFAULT NULL,
  `min_age` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `age_categories` */

/*Table structure for table `car_categories` */

DROP TABLE IF EXISTS `car_categories`;

CREATE TABLE `car_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `car_categories` */

/*Table structure for table `cars` */

DROP TABLE IF EXISTS `cars`;

CREATE TABLE `cars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle_no` varchar(15) DEFAULT NULL,
  `brand` varchar(20) DEFAULT NULL,
  `model` varchar(20) DEFAULT NULL,
  `production_year` year(4) DEFAULT NULL,
  `mileage` int(11) DEFAULT NULL,
  `color` varchar(15) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `category_id` FOREIGN KEY (`category_id`) REFERENCES `car_categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cars` */

/*Table structure for table `charges` */

DROP TABLE IF EXISTS `charges`;

CREATE TABLE `charges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `age_category_id` int(11) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `age_category_id_unique` (`age_category_id`),
  CONSTRAINT `age_category_id` FOREIGN KEY (`age_category_id`) REFERENCES `age_categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `charges` */

/*Table structure for table `cities` */

DROP TABLE IF EXISTS `cities`;

CREATE TABLE `cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cities` */

/*Table structure for table `customers` */

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  `license_no` varchar(15) DEFAULT NULL,
  `age_category_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `age_cateogry_id` (`age_category_id`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `age_cateogry_id` FOREIGN KEY (`age_category_id`) REFERENCES `age_categories` (`id`),
  CONSTRAINT `location_id` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `customers` */

/*Table structure for table `equipments` */

DROP TABLE IF EXISTS `equipments`;

CREATE TABLE `equipments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `equipments` */

/*Table structure for table `facilities` */

DROP TABLE IF EXISTS `facilities`;

CREATE TABLE `facilities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `facilities` */

/*Table structure for table `insurances` */

DROP TABLE IF EXISTS `insurances`;

CREATE TABLE `insurances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `insurance_type` varchar(25) DEFAULT NULL,
  `insurance_no` varchar(30) DEFAULT NULL,
  `insurance_company` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `insurances` */

/*Table structure for table `locations` */

DROP TABLE IF EXISTS `locations`;

CREATE TABLE `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city_id` int(11) DEFAULT NULL,
  `pincode` int(11) DEFAULT NULL,
  `landmark` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `city_id` (`city_id`),
  CONSTRAINT `city_id` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `locations` */

/*Table structure for table `rentals` */

DROP TABLE IF EXISTS `rentals`;

CREATE TABLE `rentals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reservation_id` int(11) DEFAULT NULL,
  `car_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reservation_id_unique` (`reservation_id`),
  KEY `car_id` (`car_id`),
  CONSTRAINT `car_id` FOREIGN KEY (`car_id`) REFERENCES `cars` (`id`),
  CONSTRAINT `reservation_id` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `rentals` */

/*Table structure for table `reservations` */

DROP TABLE IF EXISTS `reservations`;

CREATE TABLE `reservations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pickup_location_id` int(11) DEFAULT NULL,
  `pickup_date` date DEFAULT NULL,
  `dropoff_location_id` int(11) DEFAULT NULL,
  `dropoff_date` date DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `car_category_id` int(11) DEFAULT NULL,
  `equipment_id` int(11) DEFAULT NULL,
  `facility_id` int(11) DEFAULT NULL,
  `insurance_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `insurance_id_unique` (`insurance_id`),
  KEY `equipment_id` (`equipment_id`),
  KEY `facility_id` (`facility_id`),
  KEY `customer_id` (`customer_id`),
  KEY `car_category_id` (`car_category_id`),
  KEY `pickup_location_id` (`pickup_location_id`),
  KEY `dropoff_location_id` (`dropoff_location_id`),
  CONSTRAINT `car_category_id` FOREIGN KEY (`car_category_id`) REFERENCES `car_categories` (`id`),
  CONSTRAINT `customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `dropoff_location_id` FOREIGN KEY (`dropoff_location_id`) REFERENCES `locations` (`id`),
  CONSTRAINT `equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `equipments` (`id`),
  CONSTRAINT `facility_id` FOREIGN KEY (`facility_id`) REFERENCES `facilities` (`id`),
  CONSTRAINT `insurance_id` FOREIGN KEY (`insurance_id`) REFERENCES `insurances` (`id`),
  CONSTRAINT `pickup_location_id` FOREIGN KEY (`pickup_location_id`) REFERENCES `locations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `reservations` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
