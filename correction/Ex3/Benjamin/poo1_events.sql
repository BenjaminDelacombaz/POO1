/*
SQLyog Community v8.4 
MySQL - 5.1.47 : Database - poo1_events
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`poo1_events` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

/*Table structure for table `bookable_items` */

CREATE TABLE `bookable_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(63) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(127) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `bookable_items` */

insert  into `bookable_items`(`id`,`type`,`name`) values (1,'Vehicle','Diligence'),(2,'Vehicle','Hearse'),(3,'Equipment','Tar'),(4,'Equipment','Feather'),(5,'Room','Saloon'),(6,'Room','Church');

/*Table structure for table `bookable_items_groups` */

CREATE TABLE `bookable_items_groups` (
  `bookable_item_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`bookable_item_id`,`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `bookable_items_groups` */

insert  into `bookable_items_groups`(`bookable_item_id`,`group_id`) values (1,1),(1,2),(1,3),(2,2),(3,1),(4,3),(5,1),(5,2),(6,1),(6,3);

/*Table structure for table `bookings_items` */

CREATE TABLE `bookings_items` (
  `bookable_item_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  PRIMARY KEY (`bookable_item_id`,`booking_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `bookings_items` */

insert  into `bookings_items`(`bookable_item_id`,`booking_id`) values (3,5),(4,5),(5,4);

/*Table structure for table `equipment_responsibles` */

CREATE TABLE `equipment_responsibles` (
  `equipment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`equipment_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `equipment_responsibles` */

insert  into `equipment_responsibles`(`equipment_id`,`user_id`) values (3,3),(4,4);

/*Table structure for table `events` */

CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(63) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `starts_at` datetime DEFAULT NULL,
  `ends_at` datetime DEFAULT NULL,
  `created_for_id` int(11) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `events` */

insert  into `events`(`id`,`type`,`title`,`starts_at`,`ends_at`,`created_for_id`,`created_by_id`,`created_at`) values (1,NULL,'Simple event','2014-03-31 15:43:43','2014-03-31 16:43:43',NULL,1,'2014-03-31 15:43:43'),(2,NULL,'Bar Mitzvah','2014-03-31 15:43:43','2014-03-31 16:43:43',4,3,'2014-03-31 15:43:43'),(4,'Booking','Mini fiesta','2014-03-31 15:43:43','2014-03-31 16:43:43',NULL,1,'2014-03-31 15:43:43'),(5,'Booking','Lynching','2014-03-31 17:43:43','2014-03-31 18:43:43',NULL,3,'2014-03-31 15:43:43');

/*Table structure for table `events_users` */

CREATE TABLE `events_users` (
  `event_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`event_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `events_users` */

insert  into `events_users`(`event_id`,`user_id`) values (2,1),(2,2);

/*Table structure for table `groups` */

CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(127) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `groups` */

insert  into `groups`(`id`,`name`) values (1,'The good'),(2,'The bad'),(3,'The ugly');

/*Table structure for table `groups_users` */

CREATE TABLE `groups_users` (
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `groups_users` */

insert  into `groups_users`(`user_id`,`group_id`) values (1,2),(2,2),(3,1),(4,3);

/*Table structure for table `manuals` */

CREATE TABLE `manuals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(127) COLLATE utf8_unicode_ci DEFAULT NULL,
  `file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `file_type` varchar(63) COLLATE utf8_unicode_ci DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `item_type` varchar(63) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `manuals` */

insert  into `manuals`(`id`,`title`,`file_name`,`file_type`,`item_id`,`item_type`) values (1,'How to drive a dilly','howtodrive.pdf',NULL,1,'BookableItem'),(2,'RIP','rip.pdf',NULL,2,'BookableItem');

/*Table structure for table `users` */

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(63) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(63) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(127) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`firstname`,`lastname`,`email`) values (1,'Joe','Dalton','joe@dalton.com'),(2,'Averell','Dalton','averell@dalton.com'),(3,'Lucky','Luke','luke@theforce.com'),(4,'Jolly','Jumper','jolly@jumper.com');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
