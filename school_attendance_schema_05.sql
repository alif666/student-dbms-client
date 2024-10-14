-- MySQL dump 10.13  Distrib 5.7.20, for Linux (x86_64)
--
-- Host: localhost    Database: school_attendance_system_test
-- ------------------------------------------------------
-- Server version	5.7.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `district` varchar(100) DEFAULT NULL,
  `division` varchar(100) DEFAULT NULL,
  `post_code` varchar(100) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `unions` varchar(100) DEFAULT NULL,
  `upazila` varchar(100) DEFAULT NULL,
  `mandal` varchar(100) DEFAULT NULL,
  `town` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=522 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `class_name` varchar(20) NOT NULL,
  `is_routine_complete` bit(1) DEFAULT NULL,
  `medium` varchar(20) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `section_name` varchar(20) DEFAULT NULL,
  `shift` varchar(20) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `version` varchar(20) DEFAULT NULL,
  `room_id` int(11) NOT NULL,
  `school_id` int(11) NOT NULL,
  `class_name_bn` varchar(200) DEFAULT NULL,
  `section_name_bn` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK1vyvj68yfglcjb01judlot1yp` (`class_name`,`section_name`,`shift`,`medium`,`version`,`school_id`),
  KEY `FK5raqcdg4omqjrm0rllkc4d6km` (`room_id`),
  KEY `FK96x0psi3ip7rge1n5ubwbhe3y` (`school_id`),
  CONSTRAINT `FK5raqcdg4omqjrm0rllkc4d6km` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`),
  CONSTRAINT `FK96x0psi3ip7rge1n5ubwbhe3y` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `class_device_assign`
--

DROP TABLE IF EXISTS `class_device_assign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_device_assign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(20) NOT NULL,
  `class_id` int(11) NOT NULL,
  `device_id` int(11) NOT NULL,
  `school_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4a1xnmvr5hqgca209gjxddp2u` (`class_id`),
  KEY `FKgvq6ib4gxkqcc6seyxr297c3w` (`device_id`),
  KEY `FKigvf430cweqfsx2cq0gsifswc` (`school_id`),
  CONSTRAINT `FK4a1xnmvr5hqgca209gjxddp2u` FOREIGN KEY (`class_id`) REFERENCES `class` (`id`),
  CONSTRAINT `FKgvq6ib4gxkqcc6seyxr297c3w` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`),
  CONSTRAINT `FKigvf430cweqfsx2cq0gsifswc` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=640 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `class_group`
--

DROP TABLE IF EXISTS `class_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_group` (
  `id` int(11) NOT NULL,
  `groups` varchar(255) NOT NULL,
  KEY `FK5y96nvlfsvcso778fupe1p66w` (`id`),
  CONSTRAINT `FK5y96nvlfsvcso778fupe1p66w` FOREIGN KEY (`id`) REFERENCES `class` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `class_name_lookup`
--

DROP TABLE IF EXISTS `class_name_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_name_lookup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `display_order` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `value_bn` varchar(100) DEFAULT NULL,
  `value_en` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `class_routine`
--

DROP TABLE IF EXISTS `class_routine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_routine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `day` varchar(10) NOT NULL,
  `groups` varchar(10) NOT NULL,
  `status` varchar(20) NOT NULL,
  `subject` varchar(50) NOT NULL,
  `year` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `period_id` int(11) NOT NULL,
  `school_id` int(11) NOT NULL,
  `staff_id` varchar(36) NOT NULL,
  `subject_bn` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK3hsfhdui2qgvmeuwcxco9iv4` (`day`,`year`,`groups`,`subject`,`class_id`,`period_id`),
  KEY `FKivpjr54h7m9scu79ltdwuefba` (`class_id`),
  KEY `FKoo8yxvjdo0pmm8irp8vjlcwmu` (`period_id`),
  KEY `FK7wlopx0px84l2uyruxlgd5a7e` (`school_id`),
  KEY `FK8dr7ff63xaup4w9wwrecpt0ue` (`staff_id`),
  CONSTRAINT `FK7wlopx0px84l2uyruxlgd5a7e` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`),
  CONSTRAINT `FK8dr7ff63xaup4w9wwrecpt0ue` FOREIGN KEY (`staff_id`) REFERENCES `staff_info` (`id`),
  CONSTRAINT `FKivpjr54h7m9scu79ltdwuefba` FOREIGN KEY (`class_id`) REFERENCES `class` (`id`),
  CONSTRAINT `FKoo8yxvjdo0pmm8irp8vjlcwmu` FOREIGN KEY (`period_id`) REFERENCES `period` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `class_staff`
--

DROP TABLE IF EXISTS `class_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_staff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` int(11) NOT NULL,
  `staff_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK43xgs97uoy6xt9dr89faogsra` (`class_id`),
  KEY `FKrshx0jilb2pj4gdh0l4was2n4` (`staff_id`),
  CONSTRAINT `FK43xgs97uoy6xt9dr89faogsra` FOREIGN KEY (`class_id`) REFERENCES `class` (`id`),
  CONSTRAINT `FKrshx0jilb2pj4gdh0l4was2n4` FOREIGN KEY (`staff_id`) REFERENCES `staff_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device`
--

DROP TABLE IF EXISTS `device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `app_id` varchar(36) NOT NULL,
  `device_tag` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `registration_no` varchar(20) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `vendor` varchar(100) DEFAULT NULL,
  `school_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_2eue55path8c4vg8sv4adhwd6` (`app_id`),
  UNIQUE KEY `UK_ajobr7mr6a3623nfi821q8qf` (`registration_no`),
  KEY `FKsbtq14gnrckppbw0jx4tgqqd8` (`school_id`),
  CONSTRAINT `FKsbtq14gnrckppbw0jx4tgqqd8` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=230 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device_registration_no`
--

DROP TABLE IF EXISTS `device_registration_no`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `device_registration_no` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_tag` varchar(20) NOT NULL,
  `expire_time` datetime DEFAULT NULL,
  `registration_no` varchar(20) DEFAULT NULL,
  `used` bit(1) NOT NULL,
  `school_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_dyenoeq5a2s9s75m6cxb8j1xi` (`registration_no`),
  KEY `FKleg6fuq19p8yphly58age1uss` (`school_id`),
  CONSTRAINT `FKleg6fuq19p8yphly58age1uss` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exam_room`
--

DROP TABLE IF EXISTS `exam_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `roll_end` int(11) NOT NULL,
  `roll_start` int(11) NOT NULL,
  `roll_type` varchar(20) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `class_id` int(11) NOT NULL,
  `exam_routine_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `school_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKbkdk1el4rw769ewj034jfsnpo` (`class_id`),
  KEY `FKfg7xo89e0x5i1rq8lxbw928us` (`exam_routine_id`),
  KEY `FK1s7qasr1wh6wprfbqrl0gjif1` (`room_id`),
  KEY `FKoqpxj126op6c0y4a7mba6meg1` (`school_id`),
  CONSTRAINT `FK1s7qasr1wh6wprfbqrl0gjif1` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`),
  CONSTRAINT `FKbkdk1el4rw769ewj034jfsnpo` FOREIGN KEY (`class_id`) REFERENCES `class` (`id`),
  CONSTRAINT `FKfg7xo89e0x5i1rq8lxbw928us` FOREIGN KEY (`exam_routine_id`) REFERENCES `exam_routine` (`id`),
  CONSTRAINT `FKoqpxj126op6c0y4a7mba6meg1` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exam_routine`
--

DROP TABLE IF EXISTS `exam_routine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_routine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `class_name` varchar(20) NOT NULL,
  `date` date DEFAULT NULL,
  `exam_name` varchar(255) NOT NULL,
  `status` varchar(20) NOT NULL,
  `subject` varchar(50) NOT NULL,
  `year` int(11) NOT NULL,
  `period_id` int(11) NOT NULL,
  `school_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKa49oefvjigl567exwipn1q0hk` (`period_id`),
  KEY `FK44ilslo7wep6dwq4pk7fm2kjq` (`school_id`),
  CONSTRAINT `FK44ilslo7wep6dwq4pk7fm2kjq` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`),
  CONSTRAINT `FKa49oefvjigl567exwipn1q0hk` FOREIGN KEY (`period_id`) REFERENCES `period` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `face`
--

DROP TABLE IF EXISTS `face`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `face` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `capture_date` date DEFAULT NULL,
  `capture_type` varchar(20) DEFAULT NULL,
  `face` mediumblob NOT NULL,
  `image_type` varchar(20) DEFAULT NULL,
  `landmark_info` tinyblob,
  `score` double DEFAULT NULL,
  `create_by` varchar(50) NOT NULL DEFAULT 'admin',
  `update_by` varchar(50) NOT NULL DEFAULT 'admin',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=261 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `face_cron`
--

DROP TABLE IF EXISTS `face_cron`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `face_cron` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `action` varchar(20) NOT NULL,
  `enroll_id` varchar(255) NOT NULL,
  `status` varchar(20) NOT NULL,
  `student` bit(1) NOT NULL,
  `school_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_5ccm0fq8xr8gs8dv08uu4rp2w` (`enroll_id`),
  KEY `FK4stgmmb4x956ktcan0fxc5u3` (`school_id`),
  CONSTRAINT `FK4stgmmb4x956ktcan0fxc5u3` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=312 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fee`
--

DROP TABLE IF EXISTS `fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `amount` int(11) NOT NULL,
  `class_name` varchar(20) NOT NULL,
  `fee_type` varchar(20) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `school_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK3m687r94bl3m1f2le409b8kv5` (`class_name`,`fee_type`),
  KEY `FKcu0tfwx7mptkxogtl8yp7e4ao` (`school_id`),
  CONSTRAINT `FKcu0tfwx7mptkxogtl8yp7e4ao` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fees_discount`
--

DROP TABLE IF EXISTS `fees_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fees_discount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `discount` int(11) NOT NULL,
  `fee_type` varchar(20) NOT NULL,
  `status` varchar(20) NOT NULL,
  `student_id` varchar(36) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `waiver_reason` varchar(20) DEFAULT 'scholarship',
  `waiver_reason_other` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK7a49cy45ynkaix4vh06gujnyt` (`student_id`,`fee_type`),
  CONSTRAINT `FK37fonscl83y28a9qvqf7tpo6g` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `general_lookup`
--

DROP TABLE IF EXISTS `general_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `general_lookup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(20) NOT NULL,
  `code` varchar(20) NOT NULL,
  `display_order` int(11) DEFAULT NULL,
  `object_version_id` int(11) DEFAULT NULL,
  `school_id` int(11) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `value_bn` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `value_en` varchar(100) NOT NULL,
  `create_by` varchar(50) NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKaa7nfxsdskkcrxwd0vtp40j31` (`code`,`category`,`school_id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guardian`
--

DROP TABLE IF EXISTS `guardian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guardian` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `father_contact_no` varchar(15) DEFAULT NULL,
  `father_designation` varchar(50) DEFAULT NULL,
  `father_name` varchar(50) NOT NULL,
  `guardian_contact_no` varchar(15) DEFAULT NULL,
  `guardian_name` varchar(50) DEFAULT NULL,
  `guardian_relation` varchar(50) DEFAULT NULL,
  `mother_contact_no` varchar(15) DEFAULT NULL,
  `mother_designation` varchar(50) DEFAULT NULL,
  `mother_name` varchar(50) NOT NULL,
  `guardian_name_bn` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `guardian_relation_bn` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `insert_payment_history`
--

DROP TABLE IF EXISTS `insert_payment_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insert_payment_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `class_name` varchar(20) NOT NULL,
  `fee_type` varchar(20) NOT NULL,
  `month` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `school_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK62tcs9ouanlqn6ffo6f4igqm1` (`school_id`),
  CONSTRAINT `FK62tcs9ouanlqn6ffo6f4igqm1` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monitor`
--

DROP TABLE IF EXISTS `monitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `reason` varchar(50) NOT NULL,
  `reason_other` varchar(255) DEFAULT NULL,
  `school_id` int(11) NOT NULL,
  `staff_id` varchar(36) NOT NULL,
  `student_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKrri4di5epe7ny9ute0u6l69v4` (`school_id`),
  KEY `FKmih0olbxjcax01lk9cv8gckvq` (`staff_id`),
  KEY `FKnycr8cbo6q4hwaxytnda8xvcd` (`student_id`),
  CONSTRAINT `FKmih0olbxjcax01lk9cv8gckvq` FOREIGN KEY (`staff_id`) REFERENCES `staff_info` (`id`),
  CONSTRAINT `FKnycr8cbo6q4hwaxytnda8xvcd` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`),
  CONSTRAINT `FKrri4di5epe7ny9ute0u6l69v4` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monitor_log`
--

DROP TABLE IF EXISTS `monitor_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitor_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_by` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `delete_by` varchar(255) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `reason` varchar(50) NOT NULL,
  `reason_other` varchar(255) DEFAULT NULL,
  `reference_id` int(11) NOT NULL,
  `school_id` int(11) NOT NULL,
  `staff_id` varchar(255) NOT NULL,
  `student_id` varchar(255) NOT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `description` varchar(255) NOT NULL,
  `expire_date` datetime NOT NULL,
  `notice_type` varchar(50) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `version` varchar(20) DEFAULT NULL,
  `school_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKtgexi2p1fmnq9eicduatqggsg` (`school_id`),
  CONSTRAINT `FKtgexi2p1fmnq9eicduatqggsg` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `exam_name` varchar(255) DEFAULT NULL,
  `fee_type` varchar(20) NOT NULL,
  `invoice_id` varchar(20) DEFAULT NULL,
  `month_` int(11) DEFAULT NULL,
  `payable_amount` int(11) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `total_amount` int(11) NOT NULL,
  `year_` int(11) DEFAULT NULL,
  `class_id` int(11) NOT NULL,
  `school_id` int(11) NOT NULL,
  `student_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8nqgb6co2qub9sucast4ksf1d` (`class_id`),
  KEY `FKo16l5ak0wv4tbais81oc13i4u` (`school_id`),
  KEY `FKq0mpbhvyrwyggk1gwjams69wf` (`student_id`),
  CONSTRAINT `FK8nqgb6co2qub9sucast4ksf1d` FOREIGN KEY (`class_id`) REFERENCES `class` (`id`),
  CONSTRAINT `FKo16l5ak0wv4tbais81oc13i4u` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`),
  CONSTRAINT `FKq0mpbhvyrwyggk1gwjams69wf` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `period`
--

DROP TABLE IF EXISTS `period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `period` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `end_time` time NOT NULL,
  `name` varchar(100) NOT NULL,
  `period_type` varchar(50) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `start_time` time NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `school_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK97qls3bc7g0tdkv0mbgm7a08x` (`school_id`),
  CONSTRAINT `FK97qls3bc7g0tdkv0mbgm7a08x` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(50) NOT NULL,
  `code` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `report_for` varchar(50) NOT NULL,
  `school_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_kc1wmcky1ooleovi36oqcqmqe` (`code`),
  KEY `FK38dsrbwwrh6ovjnlyh1dpy1ms` (`school_id`),
  CONSTRAINT `FK38dsrbwwrh6ovjnlyh1dpy1ms` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `building_name` varchar(100) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `floor_no` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `room_no` int(11) NOT NULL,
  `room_type` varchar(255) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `school_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK7xulg5ea1hefr4nyhxovkcn47` (`school_id`,`room_no`),
  CONSTRAINT `FKje2l56534jc546t3swae63w0h` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `room_device_assign`
--

DROP TABLE IF EXISTS `room_device_assign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_device_assign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(20) NOT NULL,
  `device_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `school_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4a1qt6g33a6xiki129eeh5f5i` (`device_id`),
  KEY `FKn7hid8432eej7aos7lyp3v9ag` (`room_id`),
  KEY `FK32vgk4s02kbc03ckkhvp94570` (`school_id`),
  CONSTRAINT `FK32vgk4s02kbc03ckkhvp94570` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`),
  CONSTRAINT `FK4a1qt6g33a6xiki129eeh5f5i` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`),
  CONSTRAINT `FKn7hid8432eej7aos7lyp3v9ag` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `school`
--

DROP TABLE IF EXISTS `school`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `class_name_end` varchar(20) DEFAULT NULL,
  `class_name_start` varchar(20) DEFAULT NULL,
  `contact_no` varchar(20) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `established_year` datetime DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `registration_no` varchar(20) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `name_bn` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_1kfjvf43ewftmqn4k75ppppg8` (`registration_no`),
  KEY `FKje7ysjh9qami0jc33ykm13g1d` (`address_id`),
  CONSTRAINT `FKje7ysjh9qami0jc33ykm13g1d` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `school_medium`
--

DROP TABLE IF EXISTS `school_medium`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_medium` (
  `id` int(11) NOT NULL,
  `medium` varchar(255) NOT NULL,
  KEY `FKitplpx08h1hpy7mfywkrbct0l` (`id`),
  CONSTRAINT `FKitplpx08h1hpy7mfywkrbct0l` FOREIGN KEY (`id`) REFERENCES `school` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `school_shift`
--

DROP TABLE IF EXISTS `school_shift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_shift` (
  `id` int(11) NOT NULL,
  `shift` varchar(255) NOT NULL,
  KEY `FK3fb2km7kjtf0p81w9jcegral3` (`id`),
  CONSTRAINT `FK3fb2km7kjtf0p81w9jcegral3` FOREIGN KEY (`id`) REFERENCES `school` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `school_version`
--

DROP TABLE IF EXISTS `school_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_version` (
  `id` int(11) NOT NULL,
  `version` varchar(255) NOT NULL,
  KEY `FK52ytib1to8gg1vqrwp8bi544g` (`id`),
  CONSTRAINT `FK52ytib1to8gg1vqrwp8bi544g` FOREIGN KEY (`id`) REFERENCES `school` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `section_lookup`
--

DROP TABLE IF EXISTS `section_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section_lookup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `display_order` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `value_bn` varchar(100) DEFAULT NULL,
  `value_en` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `staff_attendance`
--

DROP TABLE IF EXISTS `staff_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_attendance` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `attendance_mode` varchar(20) NOT NULL,
  `attendance_status` varchar(20) NOT NULL,
  `entry_exit_mode` varchar(20) NOT NULL,
  `late` bit(1) NOT NULL,
  `remarks` varchar(100) DEFAULT NULL,
  `device_id` int(11) DEFAULT NULL,
  `school_id` int(11) NOT NULL,
  `staff_info_id` varchar(36) NOT NULL,
  `client_create_by` varchar(50) DEFAULT NULL,
  `client_created_at` datetime DEFAULT NULL,
  `client_id` varchar(50) DEFAULT NULL,
  `client_update_by` varchar(50) DEFAULT NULL,
  `client_updated_at` datetime DEFAULT NULL,
  `attendance_session_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKfqtlqf87bghhopjfwsb1pjqno` (`device_id`),
  KEY `FKoc7lbug2fiwc5v2jabk1r8ugg` (`school_id`),
  KEY `FK22ptgg55d9mgrnoy4ygh0cq38` (`staff_info_id`),
  KEY `FKsaqvbtsfs9twxoo0w34lfx7qr` (`attendance_session_id`),
  CONSTRAINT `FK22ptgg55d9mgrnoy4ygh0cq38` FOREIGN KEY (`staff_info_id`) REFERENCES `staff_info` (`id`),
  CONSTRAINT `FKfqtlqf87bghhopjfwsb1pjqno` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`),
  CONSTRAINT `FKoc7lbug2fiwc5v2jabk1r8ugg` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`),
  CONSTRAINT `FKsaqvbtsfs9twxoo0w34lfx7qr` FOREIGN KEY (`attendance_session_id`) REFERENCES `staff_attendance_sessions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `staff_attendance_sessions`
--

DROP TABLE IF EXISTS `staff_attendance_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_attendance_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `client_create_by` varchar(50) DEFAULT NULL,
  `client_created_at` datetime DEFAULT NULL,
  `client_id` varchar(50) DEFAULT NULL,
  `client_update_by` varchar(50) DEFAULT NULL,
  `client_updated_at` datetime DEFAULT NULL,
  `attendance_order` int(11) NOT NULL,
  `end_time` datetime NOT NULL,
  `entry_exit_mode` varchar(20) NOT NULL,
  `late_time` datetime DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `start_time` datetime NOT NULL,
  `status` varchar(20) NOT NULL,
  `device_id` int(11) NOT NULL,
  `school_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`),
  KEY `FKfavjsomc07e339b43otedgnge` (`device_id`),
  KEY `FK89rcdurryb1lhjrel2fdxrqmo` (`school_id`),
  CONSTRAINT `FK89rcdurryb1lhjrel2fdxrqmo` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`),
  CONSTRAINT `FKfavjsomc07e339b43otedgnge` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `staff_info`
--

DROP TABLE IF EXISTS `staff_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff_info` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `blood_group` varchar(20) DEFAULT NULL,
  `contact_no` varchar(20) NOT NULL,
  `designation` varchar(20) DEFAULT NULL,
  `dob` datetime NOT NULL,
  `educational_degree` varchar(100) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `emergency_contact_no` varchar(20) DEFAULT NULL,
  `gender` varchar(15) NOT NULL,
  `job_joining_date` datetime DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `nid` varchar(20) NOT NULL,
  `organization_ending_date` datetime DEFAULT NULL,
  `organization_joining_date` datetime DEFAULT NULL,
  `religion` varchar(20) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `staff_id` varchar(20) NOT NULL,
  `staff_type` varchar(20) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `face_id` int(11) NOT NULL,
  `permanent_address_id` int(11) NOT NULL,
  `present_address_id` int(11) NOT NULL,
  `school_id` int(11) NOT NULL,
  `name_bn` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_b0r9yf3ria80ebowroxtjq5kw` (`nid`),
  UNIQUE KEY `UK_bgis2hb4yafdwrcql7ogai9n7` (`staff_id`),
  UNIQUE KEY `UK_c9k4uvohd4koogtvlblwajgmr` (`email`),
  KEY `FKe86ypciocmomp68skpw9a5twj` (`face_id`),
  KEY `FKm35g9caaggjhovrrxk8upswly` (`permanent_address_id`),
  KEY `FKlrtahwiwfp9564bdf8489v64o` (`present_address_id`),
  KEY `FKt2ggimsj23vbw7fod7i2gbk66` (`school_id`),
  CONSTRAINT `FKe86ypciocmomp68skpw9a5twj` FOREIGN KEY (`face_id`) REFERENCES `face` (`id`),
  CONSTRAINT `FKlrtahwiwfp9564bdf8489v64o` FOREIGN KEY (`present_address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `FKm35g9caaggjhovrrxk8upswly` FOREIGN KEY (`permanent_address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `FKt2ggimsj23vbw7fod7i2gbk66` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `birth_certificate` varchar(20) NOT NULL,
  `blood_group` varchar(20) DEFAULT NULL,
  `contact_no` varchar(20) DEFAULT NULL,
  `dob` datetime NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `ending_date` datetime DEFAULT NULL,
  `gender` varchar(15) NOT NULL,
  `sub_group` varchar(20) DEFAULT NULL,
  `identification_mark` varchar(255) DEFAULT NULL,
  `joining_date` datetime DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `previous_school` varchar(255) DEFAULT NULL,
  `religion` varchar(20) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `roll_no` int(11) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `student_id` varchar(20) NOT NULL,
  `class_id` int(11) NOT NULL,
  `face_id` int(11) NOT NULL,
  `guardian_id` int(11) NOT NULL,
  `permanent_address_id` int(11) NOT NULL,
  `present_address_id` int(11) NOT NULL,
  `school_id` int(11) NOT NULL,
  `name_bn` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKtj2gbuvn0b1ifyiwrdgk3vp21` (`student_id`,`roll_no`,`class_id`,`school_id`),
  UNIQUE KEY `UK_kxvot1onh16lbtp9ojndcwufy` (`birth_certificate`),
  UNIQUE KEY `UK_lh7am6sc9pv0nhyg7qkj7w5d3` (`student_id`),
  KEY `FKdwhkib64u47wc4yo4hk0cub90` (`class_id`),
  KEY `FK45maxve7l2tisr6dopmk6salh` (`face_id`),
  KEY `FKkktpamdaydbva4kxjcn17sbvk` (`guardian_id`),
  KEY `FKe0jaefltp39n72oaynbquavtu` (`permanent_address_id`),
  KEY `FKmnn23oaq3ha5332153l9luv3x` (`present_address_id`),
  KEY `FK1vm0oqhk9viil6eocn49rj1l9` (`school_id`),
  CONSTRAINT `FK1vm0oqhk9viil6eocn49rj1l9` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`),
  CONSTRAINT `FK45maxve7l2tisr6dopmk6salh` FOREIGN KEY (`face_id`) REFERENCES `face` (`id`),
  CONSTRAINT `FKdwhkib64u47wc4yo4hk0cub90` FOREIGN KEY (`class_id`) REFERENCES `class` (`id`),
  CONSTRAINT `FKe0jaefltp39n72oaynbquavtu` FOREIGN KEY (`permanent_address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `FKkktpamdaydbva4kxjcn17sbvk` FOREIGN KEY (`guardian_id`) REFERENCES `guardian` (`id`),
  CONSTRAINT `FKmnn23oaq3ha5332153l9luv3x` FOREIGN KEY (`present_address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student_attendance`
--

DROP TABLE IF EXISTS `student_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_attendance` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `attendance_mode` varchar(20) NOT NULL,
  `attendance_status` varchar(20) NOT NULL,
  `entry_exit_mode` varchar(20) NOT NULL,
  `late` bit(1) NOT NULL,
  `remarks` varchar(100) DEFAULT NULL,
  `attendance_session_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `device_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `school_id` int(11) NOT NULL,
  `staff_id` varchar(36) DEFAULT NULL,
  `student_id` varchar(36) NOT NULL,
  `client_create_by` varchar(50) DEFAULT NULL,
  `client_created_at` datetime DEFAULT NULL,
  `client_id` varchar(50) DEFAULT NULL,
  `client_update_by` varchar(50) DEFAULT NULL,
  `client_updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKf9yi0nsnxwcpk9b5b15fhe9ag` (`attendance_session_id`),
  KEY `FKsqgi3ddc21695nrjyloei2o67` (`class_id`),
  KEY `FKgtxtwam015hciwju9c9p81k6b` (`device_id`),
  KEY `FKj3d2rnm3jn0n8awxxe6yvqoy3` (`room_id`),
  KEY `FKrfqwhq37n6tuked72amflu890` (`school_id`),
  KEY `FK3ct4hnnkq7xuom1eg107ch74h` (`staff_id`),
  KEY `FKrxjgxdiwf7l4gn2ynshg4o46y` (`student_id`),
  CONSTRAINT `FK3ct4hnnkq7xuom1eg107ch74h` FOREIGN KEY (`staff_id`) REFERENCES `staff_info` (`id`),
  CONSTRAINT `FKf9yi0nsnxwcpk9b5b15fhe9ag` FOREIGN KEY (`attendance_session_id`) REFERENCES `student_attendance_sessions` (`id`),
  CONSTRAINT `FKgtxtwam015hciwju9c9p81k6b` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`),
  CONSTRAINT `FKj3d2rnm3jn0n8awxxe6yvqoy3` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`),
  CONSTRAINT `FKrfqwhq37n6tuked72amflu890` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`),
  CONSTRAINT `FKrxjgxdiwf7l4gn2ynshg4o46y` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`),
  CONSTRAINT `FKsqgi3ddc21695nrjyloei2o67` FOREIGN KEY (`class_id`) REFERENCES `class` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student_attendance_sessions`
--

DROP TABLE IF EXISTS `student_attendance_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_attendance_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `attendance_order` int(11) NOT NULL,
  `attendance_type` varchar(20) NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `entry_exit_mode` varchar(20) NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `class_id` int(11) DEFAULT NULL,
  `device_id` int(11) NOT NULL,
  `room_id` int(11) DEFAULT NULL,
  `school_id` int(11) NOT NULL,
  `staff_id` varchar(36) NOT NULL,
  `client_create_by` varchar(50) DEFAULT NULL,
  `client_created_at` datetime DEFAULT NULL,
  `client_id` varchar(50) DEFAULT NULL,
  `client_update_by` varchar(50) DEFAULT NULL,
  `client_updated_at` datetime DEFAULT NULL,
  `late_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`),
  KEY `FKegkt6p2lvdxvswqrgg24pnleu` (`class_id`),
  KEY `FKmjjb2hwxds1tetjcel0a2rwat` (`device_id`),
  KEY `FKnb160cnubji1qsjnhndyndks2` (`room_id`),
  KEY `FKfgshpwc0d4sxc6q6dukjh747s` (`school_id`),
  KEY `FKery4g0htkhfxend2vsxrpx4qn` (`staff_id`),
  CONSTRAINT `FKegkt6p2lvdxvswqrgg24pnleu` FOREIGN KEY (`class_id`) REFERENCES `class` (`id`),
  CONSTRAINT `FKery4g0htkhfxend2vsxrpx4qn` FOREIGN KEY (`staff_id`) REFERENCES `staff_info` (`id`),
  CONSTRAINT `FKfgshpwc0d4sxc6q6dukjh747s` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`),
  CONSTRAINT `FKmjjb2hwxds1tetjcel0a2rwat` FOREIGN KEY (`device_id`) REFERENCES `device` (`id`),
  CONSTRAINT `FKnb160cnubji1qsjnhndyndks2` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1792 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student_backup`
--

DROP TABLE IF EXISTS `student_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_backup` (
  `id` varchar(36) NOT NULL,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `birth_certificate` varchar(20) NOT NULL,
  `blood_group` varchar(20) DEFAULT NULL,
  `contact_no` varchar(20) DEFAULT NULL,
  `dob` datetime NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `ending_date` datetime DEFAULT NULL,
  `gender` varchar(15) NOT NULL,
  `sub_group` varchar(20) DEFAULT NULL,
  `identification_mark` varchar(255) DEFAULT NULL,
  `joining_date` datetime DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `previous_school` varchar(255) DEFAULT NULL,
  `religion` varchar(20) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `roll_no` int(11) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `student_id` varchar(20) NOT NULL,
  `class_id` int(11) NOT NULL,
  `face_id` int(11) NOT NULL,
  `guardian_id` int(11) NOT NULL,
  `permanent_address_id` int(11) NOT NULL,
  `present_address_id` int(11) NOT NULL,
  `school_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student_promotion`
--

DROP TABLE IF EXISTS `student_promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_promotion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `created_by` varchar(50) NOT NULL,
  `new_class` int(11) NOT NULL,
  `new_group` varchar(255) DEFAULT NULL,
  `new_roll` int(11) NOT NULL,
  `old_class` int(11) NOT NULL,
  `old_group` varchar(255) DEFAULT NULL,
  `old_roll` int(11) NOT NULL,
  `promotion_status` varchar(255) NOT NULL,
  `school_id` int(11) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_3urrt2sb7qd6nxmfr5pjd5mr1` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student_promotion_log`
--

DROP TABLE IF EXISTS `student_promotion_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_promotion_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `created_by` varchar(50) NOT NULL,
  `new_class` int(11) NOT NULL,
  `new_group` varchar(255) DEFAULT NULL,
  `new_roll` int(11) NOT NULL,
  `old_class` int(11) NOT NULL,
  `old_group` varchar(255) DEFAULT NULL,
  `old_roll` int(11) NOT NULL,
  `promotion_status` varchar(255) NOT NULL,
  `reference_id` int(11) NOT NULL,
  `school_id` int(11) NOT NULL,
  `student_id` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subject_lookup`
--

DROP TABLE IF EXISTS `subject_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subject_lookup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `display_order` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `value_bn` varchar(100) DEFAULT NULL,
  `value_en` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_credential_info`
--

DROP TABLE IF EXISTS `user_credential_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_credential_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_by` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `update_by` varchar(50) NOT NULL,
  `updated_at` datetime NOT NULL,
  `password` varchar(255) NOT NULL,
  `password_updated` bit(1) NOT NULL,
  `status` varchar(20) NOT NULL,
  `username` varchar(50) NOT NULL,
  `school_id` int(11) DEFAULT NULL,
  `staff_info_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_4xrhr68efn9i4iv8bgvel6u06` (`username`),
  UNIQUE KEY `UKf90hhgmbu00ehtjsiflap7ln8` (`staff_info_id`),
  KEY `FKq6gt008iuhsb8xqvummw0f1gx` (`school_id`),
  CONSTRAINT `FKg4r8w22r2qq0x9qsnvy9g1a8b` FOREIGN KEY (`staff_info_id`) REFERENCES `staff_info` (`id`),
  CONSTRAINT `FKq6gt008iuhsb8xqvummw0f1gx` FOREIGN KEY (`school_id`) REFERENCES `school` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_roles`
--

DROP TABLE IF EXISTS `users_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_roles` (
  `id` int(11) NOT NULL,
  `role` varchar(20) NOT NULL,
  KEY `FKgwnfja5fuqv2n8w7kpk8dl6l4` (`id`),
  CONSTRAINT `FKgwnfja5fuqv2n8w7kpk8dl6l4` FOREIGN KEY (`id`) REFERENCES `user_credential_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
