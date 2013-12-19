-- MySQL dump 10.13  Distrib 5.5.32, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: clover
-- ------------------------------------------------------
-- Server version	5.5.32-0ubuntu0.12.04.1

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
-- Table structure for table `activecode`
--

DROP TABLE IF EXISTS `activecode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activecode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) NOT NULL,
  `creator_uid` int(11) NOT NULL,
  `timeline` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activecode`
--

LOCK TABLES `activecode` WRITE;
/*!40000 ALTER TABLE `activecode` DISABLE KEYS */;
/*!40000 ALTER TABLE `activecode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attachment`
--

DROP TABLE IF EXISTS `attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1=file;2=image;3=doc',
  `path` varchar(255) NOT NULL,
  `tid` int(11) DEFAULT NULL,
  `fid` int(11) DEFAULT NULL,
  `uid` int(11) NOT NULL,
  `timeline` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fid` (`fid`),
  KEY `tid` (`tid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachment`
--

LOCK TABLES `attachment` WRITE;
/*!40000 ALTER TABLE `attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(50) NOT NULL,
  `visible` enum('all','group','private') NOT NULL DEFAULT 'all',
  `visible_value` char(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_list`
--

DROP TABLE IF EXISTS `board_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(50) NOT NULL,
  `board_id` int(11) unsigned NOT NULL,
  `todos` text,
  `sort` tinyint(4) unsigned NOT NULL DEFAULT '99',
  PRIMARY KEY (`id`),
  KEY `board_id` (`board_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_list`
--

LOCK TABLES `board_list` WRITE;
/*!40000 ALTER TABLE `board_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `board_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business`
--

DROP TABLE IF EXISTS `business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business`
--

LOCK TABLES `business` WRITE;
/*!40000 ALTER TABLE `business` DISABLE KEYS */;
INSERT INTO `business` VALUES (1,'默认业务类型','2013-11-18 14:07:39',NULL),(2,'互联网全案','2013-11-18 14:07:52',NULL),(3,'Clover研发','2013-11-18 14:08:04',NULL);
/*!40000 ALTER TABLE `business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `checklist`
--

DROP TABLE IF EXISTS `checklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `checklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL,
  `title` varchar(64) NOT NULL,
  `content` varchar(255) NOT NULL,
  `timeline` datetime NOT NULL,
  `uid` int(11) NOT NULL,
  `is_done` tinyint(1) NOT NULL DEFAULT '0',
  `sub_tid` int(11) NOT NULL DEFAULT '0',
  `order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tid` (`tid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checklist`
--

LOCK TABLES `checklist` WRITE;
/*!40000 ALTER TABLE `checklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `checklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `checklist_tpl`
--

DROP TABLE IF EXISTS `checklist_tpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `checklist_tpl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `uid` int(11) NOT NULL DEFAULT '0',
  `version` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checklist_tpl`
--

LOCK TABLES `checklist_tpl` WRITE;
/*!40000 ALTER TABLE `checklist_tpl` DISABLE KEYS */;
/*!40000 ALTER TABLE `checklist_tpl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `logo` text,
  `oweruid` int(11) NOT NULL,
  `timeline` datetime NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'三精药业','8c7609b9a9761d4c8d5d4297a4094ca2.gif',0,'0000-00-00 00:00:00',0),(2,'美国乐动','5c61427f69af0843216deb03ff699717.gif',0,'0000-00-00 00:00:00',0),(3,'修正药业','f75be02e520b68efd7489c5d4ae8d258.gif',0,'0000-00-00 00:00:00',0),(4,'神威药业','f259d4e76c1d9da14fb27530e76bd7e4.gif',0,'0000-00-00 00:00:00',0);
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` int(11) NOT NULL,
  `content` varchar(255) NOT NULL,
  `timeline` datetime DEFAULT NULL,
  `uid` int(11) NOT NULL,
  `device` varchar(16) DEFAULT 'web',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `creator` int(11) NOT NULL,
  `body` varchar(256) NOT NULL,
  `type` enum('Change','Comment') NOT NULL DEFAULT 'Change',
  `goal_id` int(11) NOT NULL,
  `tid` int(11) NOT NULL,
  `attachments` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (11,'2013-12-11 02:49:44',4,'创建任务','Change',42,117,NULL),(12,'2013-12-11 02:51:15',4,'update closed','Change',42,117,NULL),(13,'2013-12-11 02:52:13',4,'update due date','Change',42,117,NULL),(14,'2013-12-11 06:56:20',4,'update due date','Change',42,117,NULL),(15,'2013-12-11 07:07:40',4,'update due date','Change',42,117,NULL),(16,'2013-12-11 09:45:03',4,'创建任务','Change',43,118,NULL),(17,'2013-12-11 10:01:10',4,'创建任务','Change',43,119,NULL),(18,'2013-12-11 10:07:39',4,'创建任务','Change',43,120,NULL),(19,'2013-12-11 10:17:46',4,'创建任务','Change',43,121,NULL),(20,'2013-12-11 10:32:28',4,'创建任务','Change',43,122,NULL),(21,'2013-12-11 10:33:01',4,'创建任务','Change',43,123,NULL),(22,'2013-12-11 10:38:20',4,'创建任务','Change',43,124,NULL),(23,'2013-12-11 11:07:58',4,'创建任务','Change',43,125,NULL),(24,'2013-12-11 11:09:37',4,'创建任务','Change',43,126,NULL),(25,'2013-12-11 11:10:18',4,'创建任务','Change',43,127,NULL),(26,'2013-12-11 11:11:06',4,'创建任务','Change',43,128,NULL),(27,'2013-12-11 11:14:31',4,'创建任务','Change',43,129,NULL),(28,'2013-12-11 11:15:04',4,'创建任务','Change',43,130,NULL),(29,'2013-12-12 03:31:06',4,'update due date','Change',43,93,NULL),(30,'2013-12-12 05:55:48',4,'update assigner','Change',43,94,NULL),(31,'2013-12-12 08:27:42',4,'update due date','Change',43,94,NULL),(32,'2013-12-12 08:28:42',4,'update assigner','Change',43,94,NULL),(33,'2013-12-12 08:28:47',4,'update due date','Change',43,94,NULL),(34,'2013-12-12 08:28:58',4,'创建任务','Change',43,131,NULL),(35,'2013-12-12 08:29:03',4,'update closed','Change',43,91,NULL),(36,'2013-12-12 08:29:07',4,'update closed','Change',43,95,NULL),(37,'2013-12-12 08:29:09',4,'update closed','Change',43,94,NULL),(38,'2013-12-12 13:36:04',4,'update assigner','Change',42,117,NULL),(39,'2013-12-12 13:36:13',4,'update assigner','Change',42,117,NULL),(40,'2013-12-12 13:37:41',4,'update assigner','Change',42,117,NULL),(41,'2013-12-12 13:40:45',4,'update assigner','Change',42,117,NULL),(42,'2013-12-12 13:45:42',4,'update assigner','Change',42,117,NULL),(43,'2013-12-12 13:46:25',4,'update assigner','Change',42,117,NULL),(44,'2013-12-12 13:49:08',4,'update assigner','Change',42,117,NULL),(45,'2013-12-12 13:50:31',4,'update assigner','Change',42,117,NULL),(46,'2013-12-12 13:51:30',4,'update assigner','Change',42,117,NULL),(47,'2013-12-12 13:51:32',4,'update assigner','Change',42,117,NULL),(48,'2013-12-12 13:56:36',4,'update assigner','Change',42,117,NULL),(49,'2013-12-12 13:57:36',4,'update assigner','Change',42,117,NULL),(50,'2013-12-12 13:58:13',4,'update assigner','Change',42,117,NULL),(53,'2013-12-13 08:25:45',11,'不错啊','Comment',42,117,NULL),(54,'2013-12-13 08:29:49',11,'不错啊','Comment',42,117,NULL),(55,'2013-12-13 09:22:04',4,'dddd','Comment',43,95,NULL),(56,'2013-12-14 04:44:50',4,'update assigner','Change',42,89,NULL),(57,'2013-12-14 05:12:42',4,'tttttttttttttt','Comment',43,127,NULL),(58,'2013-12-14 05:14:03',4,'eeeeeeee','Comment',43,127,NULL),(59,'2013-12-14 05:14:40',4,'sssssssssssssss','Comment',43,127,NULL),(60,'2013-12-14 05:15:13',4,'ssssssssss','Comment',43,127,NULL),(61,'2013-12-14 05:15:39',4,'sssssssss','Comment',43,127,NULL),(62,'2013-12-14 05:16:16',4,'11111111111','Comment',43,127,NULL),(63,'2013-12-14 05:19:29',4,'wwwwwwwwwwwww','Comment',43,127,NULL),(64,'2013-12-14 07:14:37',4,'q1','Comment',43,127,NULL),(65,'2013-12-14 07:56:10',4,'q2','Comment',43,127,NULL),(66,'2013-12-14 07:58:38',4,'q3','Comment',43,127,NULL),(67,'2013-12-14 08:04:22',4,'q4','Comment',43,127,NULL),(68,'2013-12-14 08:08:21',4,'q5','Comment',43,127,NULL),(69,'2013-12-14 08:09:41',4,'q1','Comment',43,118,NULL),(70,'2013-12-14 08:10:10',4,'q2','Comment',43,118,NULL),(71,'2013-12-14 08:12:22',4,'Q3','Comment',43,118,NULL),(72,'2013-12-14 08:13:05',4,'q4','Comment',43,118,NULL),(73,'2013-12-14 08:20:46',4,'Q5','Comment',43,118,NULL),(74,'2013-12-14 08:21:24',4,'dddddd','Comment',43,118,NULL),(75,'2013-12-14 08:22:14',4,'555','Comment',43,118,NULL),(76,'2013-12-14 08:24:05',4,'dddddddd','Comment',43,118,NULL),(77,'2013-12-14 08:28:30',4,'ffffff','Comment',43,118,NULL),(78,'2013-12-14 08:48:38',4,'ee','Comment',43,119,NULL),(79,'2013-12-14 08:48:59',4,'eeeeeeeeee','Comment',43,119,NULL),(80,'2013-12-14 08:51:22',4,'s','Comment',43,119,NULL),(81,'2013-12-14 08:57:37',4,'yyyyyy','Comment',43,119,NULL),(82,'2013-12-14 08:57:54',4,'ddd','Comment',43,119,NULL),(83,'2013-12-14 08:58:10',4,'ddd','Comment',43,119,NULL),(84,'2013-12-16 03:53:21',4,'update due date','Change',42,88,NULL),(85,'2013-12-17 03:38:44',4,'update closed','Change',43,94,NULL),(86,'2013-12-17 03:46:11',4,'12313213','Comment',43,91,NULL),(87,'2013-12-17 03:52:34',4,'1234','Comment',43,91,NULL);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `css`
--

DROP TABLE IF EXISTS `css`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `css` (
  `uid` int(11) NOT NULL,
  `css` text,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `css`
--

LOCK TABLES `css` WRITE;
/*!40000 ALTER TABLE `css` DISABLE KEYS */;
/*!40000 ALTER TABLE `css` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_option_todos`
--

DROP TABLE IF EXISTS `department_option_todos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department_option_todos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `optionid` int(11) NOT NULL,
  `listorder` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_option_todos`
--

LOCK TABLES `department_option_todos` WRITE;
/*!40000 ALTER TABLE `department_option_todos` DISABLE KEYS */;
/*!40000 ALTER TABLE `department_option_todos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_options`
--

DROP TABLE IF EXISTS `department_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `departmentid` smallint(6) NOT NULL,
  `listorder` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_options`
--

LOCK TABLES `department_options` WRITE;
/*!40000 ALTER TABLE `department_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `department_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_practice_assoc`
--

DROP TABLE IF EXISTS `department_practice_assoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department_practice_assoc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `departmentid` int(11) NOT NULL,
  `prid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_practice_assoc`
--

LOCK TABLES `department_practice_assoc` WRITE;
/*!40000 ALTER TABLE `department_practice_assoc` DISABLE KEYS */;
INSERT INTO `department_practice_assoc` VALUES (1,1,1);
/*!40000 ALTER TABLE `department_practice_assoc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(40) NOT NULL DEFAULT '',
  `parentid` smallint(6) NOT NULL DEFAULT '0',
  `new_parentid` int(11) NOT NULL,
  `data` char(100) NOT NULL DEFAULT '',
  `listorder` smallint(6) unsigned NOT NULL DEFAULT '0',
  `display` enum('1','0') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `listorder` (`listorder`),
  KEY `parentid` (`parentid`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'合众传播',0,0,'',0,'1'),(2,'合众互动',1,1,'',0,'1'),(3,'合众媒体',1,1,'',0,'1'),(4,'合众广告',1,1,'',0,'1'),(5,'服务中心',1,1,'',0,'1'),(6,'媒介部',2,2,'',0,'1'),(7,'技术部',2,2,'',0,'1'),(8,'客户部',2,2,'',0,'0'),(9,'管理部',2,2,'',8,'1'),(10,'购买部',6,6,'',0,'0'),(11,'事业一部',8,2,'',0,'1'),(12,'事业二部',8,2,'',0,'1'),(13,'事业三部',8,2,'',0,'1'),(14,'事业四部',8,2,'',0,'1'),(15,'合众媒体（北京）',3,3,'',0,'0'),(16,'合众媒体（成都）',3,3,'',0,'1'),(17,'管理部',3,3,'',0,'1'),(18,'一部',15,3,'',0,'1'),(19,'二部',15,3,'',0,'1'),(20,'三部',15,3,'',0,'1'),(21,'四部',15,3,'',0,'1'),(22,'媒介执行部',15,3,'',0,'1'),(23,'策略部',15,3,'',0,'1'),(24,'事业一部',4,4,'',0,'1'),(25,'事业二部',4,4,'',0,'1'),(26,'事业三部',4,4,'',0,'1'),(27,'事业四部',4,4,'',0,'1'),(28,'公关事业部',4,4,'',0,'1'),(29,'制作部',4,4,'',0,'1'),(30,'管理部',4,4,'',0,'1'),(31,'客户一部',24,24,'',0,'0'),(32,'客户三部',24,24,'',0,'0'),(33,'文案组',24,24,'',0,'0'),(34,'美术一组',24,24,'',0,'0'),(35,'美术二组',24,24,'',0,'0'),(36,'客户一部',25,25,'',0,'0'),(37,'文案组',25,25,'',0,'0'),(38,'美术组',25,25,'',0,'0'),(39,'客户一部',26,26,'',0,'0'),(40,'创作部',26,26,'',0,'0'),(41,'客户部',27,27,'',0,'0'),(42,'人事部',5,5,'',0,'1'),(43,'总经办',5,5,'',0,'1'),(44,'流程控管部',5,5,'',0,'1'),(45,'知识管理中心',5,5,'',0,'1'),(46,'行政部',5,5,'',0,'1'),(47,'财务部',5,5,'',0,'1'),(48,'IT部',5,5,'',0,'1');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evernote_user`
--

DROP TABLE IF EXISTS `evernote_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evernote_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `name` varchar(64) NOT NULL COMMENT '用户名',
  `edam_userId` bigint(20) NOT NULL COMMENT 'Evernote用户ID',
  `edam_shard` varchar(64) DEFAULT NULL COMMENT 'Evernote Shard',
  `oauth_token` varchar(256) NOT NULL COMMENT 'Evernote oauth Token',
  `oauth_token_secret` varchar(256) DEFAULT NULL COMMENT 'Evernote oauth Token Secret',
  `edam_expires` bigint(20) NOT NULL COMMENT 'Token过期时间',
  `domain` tinyint(1) NOT NULL DEFAULT '1' COMMENT '服务Domain',
  `createdtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据插入时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `inx_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evernote_user`
--

LOCK TABLES `evernote_user` WRITE;
/*!40000 ALTER TABLE `evernote_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `evernote_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feed`
--

DROP TABLE IF EXISTS `feed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` mediumtext NOT NULL,
  `uid` int(11) NOT NULL,
  `tid` int(11) NOT NULL DEFAULT '0',
  `reblog_id` int(11) NOT NULL DEFAULT '0' COMMENT '0=no_relog',
  `timeline` datetime DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0=normal,1=notice,2=todo,3=user activity,4=cast',
  `device` varchar(16) DEFAULT 'web',
  `comment_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feed`
--

LOCK TABLES `feed` WRITE;
/*!40000 ALTER TABLE `feed` DISABLE KEYS */;
/*!40000 ALTER TABLE `feed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `content` text NOT NULL,
  `timeline` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `followers`
--

DROP TABLE IF EXISTS `followers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `followers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projectid` int(11) NOT NULL,
  `tid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `followers`
--

LOCK TABLES `followers` WRITE;
/*!40000 ALTER TABLE `followers` DISABLE KEYS */;
INSERT INTO `followers` VALUES (5,42,117,5,4,'2013-12-12 13:58:13'),(6,42,117,6,4,'2013-12-12 14:14:24'),(9,42,117,11,11,'2013-12-13 08:25:45'),(10,42,117,11,11,'2013-12-13 08:29:49'),(11,43,95,4,4,'2013-12-13 09:22:04'),(12,42,89,2,4,'2013-12-14 04:44:50'),(13,43,127,4,4,'2013-12-14 05:12:42'),(14,43,127,4,4,'2013-12-14 05:14:03'),(15,43,127,4,4,'2013-12-14 05:14:40'),(16,43,127,4,4,'2013-12-14 05:15:13'),(17,43,127,4,4,'2013-12-14 05:15:39'),(18,43,127,4,4,'2013-12-14 05:16:16'),(19,43,127,4,4,'2013-12-14 05:19:29'),(20,43,127,4,4,'2013-12-14 07:14:37'),(21,43,127,4,4,'2013-12-14 07:56:10'),(22,43,127,4,4,'2013-12-14 07:58:38'),(23,43,127,4,4,'2013-12-14 08:04:22'),(24,43,127,4,4,'2013-12-14 08:08:21'),(25,43,118,4,4,'2013-12-14 08:09:41'),(26,43,118,4,4,'2013-12-14 08:10:10'),(27,43,118,4,4,'2013-12-14 08:12:22'),(28,43,118,4,4,'2013-12-14 08:13:05'),(29,43,118,4,4,'2013-12-14 08:20:46'),(30,43,118,4,4,'2013-12-14 08:21:24'),(31,43,118,4,4,'2013-12-14 08:22:14'),(32,43,118,4,4,'2013-12-14 08:24:05'),(33,43,118,4,4,'2013-12-14 08:28:30'),(34,43,119,4,4,'2013-12-14 08:48:38'),(35,43,119,4,4,'2013-12-14 08:48:59'),(36,43,119,4,4,'2013-12-14 08:51:22'),(37,43,119,4,4,'2013-12-14 08:57:37'),(38,43,119,4,4,'2013-12-14 08:57:54'),(39,43,119,4,4,'2013-12-14 08:58:10'),(40,43,91,4,4,'2013-12-17 03:46:11'),(41,43,91,4,4,'2013-12-17 03:52:34');
/*!40000 ALTER TABLE `followers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `helps`
--

DROP TABLE IF EXISTS `helps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `helps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `files` varchar(255) NOT NULL,
  `oweruid` int(10) NOT NULL,
  `timeline` datetime NOT NULL,
  `todoid` int(10) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `downloads` int(10) NOT NULL,
  `size` varchar(100) NOT NULL,
  `ftype` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `helps`
--

LOCK TABLES `helps` WRITE;
/*!40000 ALTER TABLE `helps` DISABLE KEYS */;
/*!40000 ALTER TABLE `helps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `keyvalue`
--

DROP TABLE IF EXISTS `keyvalue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keyvalue` (
  `key` varchar(64) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  UNIQUE KEY `key` (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keyvalue`
--

LOCK TABLES `keyvalue` WRITE;
/*!40000 ALTER TABLE `keyvalue` DISABLE KEYS */;
/*!40000 ALTER TABLE `keyvalue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mail_queue`
--

DROP TABLE IF EXISTS `mail_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `data` text,
  `timeline` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mail_queue`
--

LOCK TABLES `mail_queue` WRITE;
/*!40000 ALTER TABLE `mail_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `mail_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_uid` int(11) NOT NULL COMMENT 'from_uid=0表示系统消息',
  `to_uid` int(11) NOT NULL,
  `from_delete` tinyint(1) NOT NULL DEFAULT '0',
  `to_delete` tinyint(1) NOT NULL DEFAULT '0',
  `timeline` datetime DEFAULT NULL,
  `content` varchar(255) NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `to_uid` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1=todo;2=feed',
  `content` varchar(255) NOT NULL,
  `data` varchar(255) DEFAULT NULL,
  `timeline` datetime DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `online`
--

DROP TABLE IF EXISTS `online`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `online` (
  `uid` int(11) NOT NULL,
  `last_active` datetime NOT NULL,
  `session` varchar(32) NOT NULL,
  `device` varchar(32) DEFAULT NULL,
  `place` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  KEY `last_active` (`last_active`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `online`
--

LOCK TABLES `online` WRITE;
/*!40000 ALTER TABLE `online` DISABLE KEYS */;
/*!40000 ALTER TABLE `online` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phases`
--

DROP TABLE IF EXISTS `phases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phases`
--

LOCK TABLES `phases` WRITE;
/*!40000 ALTER TABLE `phases` DISABLE KEYS */;
INSERT INTO `phases` VALUES (1,'客户开发'),(2,'售前'),(3,'售中'),(4,'售后');
/*!40000 ALTER TABLE `phases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugin`
--

DROP TABLE IF EXISTS `plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin` (
  `folder_name` varchar(32) NOT NULL,
  `on` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`folder_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugin`
--

LOCK TABLES `plugin` WRITE;
/*!40000 ALTER TABLE `plugin` DISABLE KEYS */;
INSERT INTO `plugin` VALUES ('check_list',0),('board',1),('css_modifier',0),('todo_flow',1),('todo_link',1),('evernote',0),('simple_token',1),('note',0),('department',1);
/*!40000 ALTER TABLE `plugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `practice_phase_task_assoc`
--

DROP TABLE IF EXISTS `practice_phase_task_assoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `practice_phase_task_assoc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prid` int(11) NOT NULL,
  `phid` int(11) NOT NULL,
  `tkid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `practice_phase_task_assoc`
--

LOCK TABLES `practice_phase_task_assoc` WRITE;
/*!40000 ALTER TABLE `practice_phase_task_assoc` DISABLE KEYS */;
INSERT INTO `practice_phase_task_assoc` VALUES (1,1,1,1),(2,1,1,2),(3,1,1,3),(4,1,1,4),(5,1,1,5),(6,1,1,6),(7,1,2,7),(8,1,2,8),(9,1,2,9),(10,1,2,10),(11,1,2,11),(12,1,2,12),(13,1,2,13),(14,1,2,14),(15,1,2,15),(16,1,2,16),(17,1,3,17),(18,1,3,18),(19,1,3,19),(20,1,3,20),(21,1,3,21),(22,1,3,22),(23,1,3,23),(24,1,3,24),(25,1,4,25),(26,1,4,26),(27,1,4,27),(28,1,4,28),(29,1,4,29),(30,1,4,30),(31,1,4,31),(32,1,4,32),(33,1,4,33),(34,1,4,34),(35,1,4,35),(36,1,4,36),(37,1,4,37),(38,1,4,38);
/*!40000 ALTER TABLE `practice_phase_task_assoc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `practices`
--

DROP TABLE IF EXISTS `practices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `practices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `practices`
--

LOCK TABLES `practices` WRITE;
/*!40000 ALTER TABLE `practices` DISABLE KEYS */;
INSERT INTO `practices` VALUES (1,'默认业务类型');
/*!40000 ALTER TABLE `practices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_options`
--

DROP TABLE IF EXISTS `project_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projectid` int(11) NOT NULL,
  `dpid` int(11) NOT NULL,
  `current` tinyint(1) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `timeline` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_options`
--

LOCK TABLES `project_options` WRITE;
/*!40000 ALTER TABLE `project_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_users`
--

DROP TABLE IF EXISTS `project_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projectid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_users`
--

LOCK TABLES `project_users` WRITE;
/*!40000 ALTER TABLE `project_users` DISABLE KEYS */;
INSERT INTO `project_users` VALUES (1,43,4,4,'2013-12-12 07:37:14'),(6,42,5,4,'2013-12-12 13:58:13'),(4,42,4,4,'2013-12-12 13:26:21'),(7,42,6,4,'2013-12-12 14:14:24'),(10,42,11,11,'2013-12-13 08:25:45'),(11,42,2,4,'2013-12-14 04:44:50');
/*!40000 ALTER TABLE `project_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `worknumber` varchar(65) NOT NULL,
  `desp` text,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `deleted` enum('Y','N') NOT NULL DEFAULT 'N',
  `oweruid` int(11) NOT NULL,
  `timeline` datetime DEFAULT NULL,
  `cid` int(11) NOT NULL,
  `prid` int(11) NOT NULL,
  `phases` varchar(255) DEFAULT NULL,
  `phase` varchar(100) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `create_template_id` int(11) DEFAULT NULL,
  `business_id` int(11) NOT NULL,
  `type` varchar(30) NOT NULL,
  `private` smallint(5) NOT NULL,
  `archived` smallint(5) NOT NULL,
  `creator` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `departmentid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'互联网全案','1','模版描述',1,'N',4,'2013-11-19 15:21:52',0,0,NULL,NULL,50000.00,NULL,1,'template',0,0,4,'2013-11-19 15:21:52',NULL,NULL),(2,'Clover研发','1','模版描述',1,'N',4,'2013-11-19 15:24:38',0,0,NULL,NULL,50000.00,NULL,1,'template',0,0,4,'2013-11-19 15:24:38',NULL,NULL),(43,'互动互联网全案测试','1','描述',1,'N',4,'2013-12-07 08:13:23',1,0,NULL,NULL,1000000.00,1,2,'project',0,0,4,'2013-12-07 08:13:23',NULL,11),(42,'Clover开发','1','描述字段测试',1,'N',4,'2013-12-06 06:42:56',4,0,NULL,NULL,110.00,2,3,'project',0,0,4,'2013-12-06 06:42:56',NULL,11);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goal_id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL,
  `unfiled` smallint(6) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ranking` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (1,1,'unfiled',0,'2013-11-19 15:35:42',NULL,0),(2,1,'售前',1,'2013-11-19 15:36:33',NULL,0),(3,1,'售中',1,'2013-11-19 15:36:40',NULL,0),(4,1,'售后',1,'2013-11-19 15:36:44',NULL,0),(5,2,'unfiled',0,'2013-11-19 15:37:33',NULL,0),(6,2,'视觉设计',1,'2013-11-19 15:38:09',NULL,0),(7,2,'编码阶段',1,'2013-11-19 15:38:18',NULL,0),(8,2,'测试阶段',1,'2013-11-19 15:38:24',NULL,0),(9,2,'发布产品',1,'2013-11-19 15:38:34',NULL,0),(36,42,'unfiled',0,'2013-12-06 06:42:56',NULL,4),(37,42,'视觉设计',1,'2013-12-06 06:42:56',NULL,5),(38,42,'r',1,'2013-12-06 06:42:56','2013-12-16 09:01:03',1),(39,42,'测试阶段',1,'2013-12-06 06:42:56',NULL,3),(40,42,'发布产品',1,'2013-12-06 06:42:56',NULL,2),(41,43,'unfiled',0,'2013-12-07 08:13:23',NULL,0),(42,43,'售前',1,'2013-12-07 08:13:23',NULL,0),(43,43,'售中',1,'2013-12-07 08:13:23',NULL,0),(44,43,'售后',1,'2013-12-07 08:13:23',NULL,0),(45,42,'更新',1,'2013-12-16 06:15:24','2013-12-16 06:43:00',6),(46,42,'最新阶段',1,'2013-12-16 06:43:48',NULL,7),(47,42,'sssss',1,'2013-12-16 09:05:15','2013-12-16 09:05:30',8);
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stoken`
--

DROP TABLE IF EXISTS `stoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stoken` (
  `uid` int(11) NOT NULL,
  `token` varchar(32) NOT NULL,
  `on` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stoken`
--

LOCK TABLES `stoken` WRITE;
/*!40000 ALTER TABLE `stoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `stoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `orderlist` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,'确认客户目标',0),(2,'拿到客户广告策略需求(brief)',0),(3,'调查客户基本资料及客户销售策略',0),(4,'预约客户沟通广告策略方向',0),(5,'提供目标客户项目可行性分析报告',0),(6,'提供目标客户确定立项报告',0),(7,'确定立项会议进行任务分配',0),(8,'制定项目整体阶段进度推进时间表',0),(9,'提案分解任务安排与提案讨论会议',0),(10,'针对已确定客户选写策略分析方案',0),(11,'针对已确定客户策划广告策略提案',0),(12,'提案分解任务安排与提案讨论会议',0),(13,'针对已确定客户选写策略分析方案',0),(14,'汇集提案整合提案',0),(15,'项目组准备汇报、提案汇报预演',0),(16,'提案审核预演汇报（总经理）',0),(17,'AE预约客户进行提案汇报',0),(18,'客户反馈建议与其他需求报告',0),(19,'项目组进行优势略势分析',0),(20,'推动提案跟进客户',0),(21,'解决公关事宜推进高层见面',0),(22,'确定方案实施计划与排期安排',0),(23,'项目组确定提案内容及讨论会议',0),(24,'确定方案及提案签署',0),(25,'网站专题设计方案确定',0),(26,'网站活动方案确定',0),(27,'网站专题制作前端设计',0),(28,'网站专题前端开发',0),(29,'后台架构设计及程序开发',0),(30,'网站广告方案制作',0),(31,'广告方案审核确定投放',0),(32,'网络媒体投放及价格策略分析',0),(33,'网络媒介投放名单确定',0),(34,'媒介阶段性投放策略分析及报告',0),(35,'投放监播跟踪反馈',0),(36,'网络公关检测报告',0),(37,'网络软性文章选写',0),(38,'项目组结案总结报告',0);
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `todo`
--

DROP TABLE IF EXISTS `todo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `todo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) NOT NULL,
  `description` text,
  `timeline` datetime DEFAULT NULL,
  `owner_uid` int(11) DEFAULT NULL,
  `assigner` int(11) NOT NULL,
  `comment_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=132 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `todo`
--

LOCK TABLES `todo` WRITE;
/*!40000 ALTER TABLE `todo` DISABLE KEYS */;
INSERT INTO `todo` VALUES (8,'完成视觉设计',NULL,'2013-11-19 20:35:52',4,0,0),(2,'确定立项会议进行任务分配',NULL,'2013-11-19 20:31:30',4,0,0),(3,'AE预约客户进行提案汇报',NULL,'2013-11-19 20:31:46',4,0,0),(4,'客户反馈建议与其他需求报告',NULL,'2013-11-19 20:31:55',4,0,0),(5,'网站专题设计方案确定',NULL,'2013-11-19 20:32:04',4,0,0),(6,'网站活动方案确定',NULL,'2013-11-19 20:32:12',4,0,0),(7,'网站专题制作前端设计',NULL,'2013-11-19 20:32:21',4,0,0),(9,'完成主要功能的编码工作',NULL,'2013-11-19 20:36:12',4,0,0),(10,'测试主要功能模块的Bug',NULL,'2013-11-19 20:36:33',4,0,0),(11,'发布产品到服务器',NULL,'2013-11-19 20:36:50',4,0,0),(93,'客户反馈建议与其他需求报告','提案审核预演汇报（总经理）,提案分解任务安排与提案讨论会议，针对已确定客户选写策略分析方案','2013-12-07 08:13:23',4,0,0),(94,'网站专题设计方案确定','提案审核预演汇报（总经理）,提案分解任务安排与提案讨论会议，针对已确定客户选写策略分析方案','2013-12-07 08:13:23',4,14,0),(92,'AE预约客户进行提案汇报','提案审核预演汇报（总经理）,提案分解任务安排与提案讨论会议，针对已确定客户选写策略分析方案dddddd','2013-12-07 08:13:23',4,0,0),(87,'完成视觉设计',NULL,'2013-12-06 06:42:56',4,0,0),(88,'完成主要功能的编码工作','提案审核预演汇报（总经理）,提案分解任务安排与提案讨论会议，针对已确定客户选写策略分析方案','2013-12-06 06:42:56',4,0,0),(89,'测试主要功能模块的Bug','提案审核预演汇报（总经理）,提案分解任务安排与提案讨论会议，针对已确定客户选写策略分析方案','2013-12-06 06:42:56',4,2,0),(90,'发布产品到服务器','提案审核预演汇报（总经理）,提案分解任务安排与提案讨论会议，针对已确定客户选写策略分析方案','2013-12-06 06:42:56',4,0,0),(91,'确定立项会议进行任务分配0','提案审核预演汇报（总经理）,提案分解任务安排与提案讨论会议，针对已确定客户选写策略分析方案','2013-12-07 08:13:23',4,0,0),(95,'网站活动方案确定','提案审核预演汇报（总经理）,提案分解任务安排与提案讨论会议，针对已确定客户选写策略分析方案','2013-12-07 08:13:23',4,0,0),(96,'网站专题制作前端设计',NULL,'2013-12-07 08:13:23',4,0,0),(117,'测试单条任务','提案审核预演汇报（总经理）,提案分解任务安排与提案讨论会议，针对已确定客户选写策略分析方案','2013-12-11 02:49:44',4,174,0),(118,'fffffffff','提案审核预演汇报（总经理）,提案分解任务安排与提案讨论会议，针对已确定客户选写策略分析方案','2013-12-11 09:45:03',4,4,0),(119,'ssss','提案审核预演汇报（总经理）,提案分解任务安排与提案讨论会议，针对已确定客户选写策略分析方案','2013-12-11 10:01:10',4,4,0),(120,'rrrr',NULL,'2013-12-11 10:07:39',4,4,0),(121,'sssss','提案审核预演汇报（总经理）,提案分解任务安排与提案讨论会议，针对已确定客户选写策略分析方案','2013-12-11 10:17:46',4,4,0),(122,'wwwwwwww','提案审核预演汇报（总经理）,提案分解任务安排与提案讨论会议，针对已确定客户选写策略分析方案','2013-12-11 10:32:28',4,4,0),(123,'d',NULL,'2013-12-11 10:33:01',4,4,0),(124,'eeeeee','提案审核预演汇报（总经理）,提案分解任务安排与提案讨论会议，针对已确定客户选写策略分析方案','2013-12-11 10:38:20',4,4,0),(125,'w1',NULL,'2013-12-11 11:07:58',4,4,0),(126,'s',NULL,'2013-12-11 11:09:37',4,4,0),(127,'sssss','提案审核预演汇报（总经理）,提案分解任务安排与提案讨论会议，针对已确定客户选写策略分析方案','2013-12-11 11:10:18',4,4,0),(128,'ss','提案审核预演汇报（总经理）,提案分解任务安排与提案讨论会议，针对已确定客户选写策略分析方案','2013-12-11 11:11:06',4,4,0),(129,'ddd',NULL,'2013-12-11 11:14:31',4,4,0),(130,'ssssssssss',NULL,'2013-12-11 11:15:04',4,4,0),(131,'ddddddddddddddddddd',NULL,'2013-12-12 08:28:58',4,4,0);
/*!40000 ALTER TABLE `todo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `todo_history`
--

DROP TABLE IF EXISTS `todo_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `todo_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `content` text NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1=action;2=comment',
  `timeline` datetime DEFAULT NULL,
  `device` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `todo_history`
--

LOCK TABLES `todo_history` WRITE;
/*!40000 ALTER TABLE `todo_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `todo_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `todo_user`
--

DROP TABLE IF EXISTS `todo_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `todo_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `projectid` int(11) NOT NULL,
  `opid` int(11) NOT NULL,
  `is_star` int(11) NOT NULL DEFAULT '0',
  `is_public` tinyint(1) NOT NULL DEFAULT '1',
  `is_follow` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否订阅',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1=added,2=doing,3=done',
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `deadline` datetime DEFAULT NULL,
  `last_action_at` datetime DEFAULT NULL,
  `section_id` int(11) NOT NULL,
  `closed` smallint(6) NOT NULL DEFAULT '0',
  `closed_at` datetime DEFAULT NULL,
  `deleted` enum('Y','N') NOT NULL DEFAULT 'N',
  `goal_id` int(11) NOT NULL,
  `due_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tid` (`tid`,`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=126 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `todo_user`
--

LOCK TABLES `todo_user` WRITE;
/*!40000 ALTER TABLE `todo_user` DISABLE KEYS */;
INSERT INTO `todo_user` VALUES (8,8,4,2,5,0,1,0,1,NULL,'2013-11-19 00:00:00',NULL,'2013-11-19 20:35:52',6,0,NULL,'N',2,NULL,'0000-00-00 00:00:00',NULL),(2,2,4,1,5,0,1,0,1,NULL,'2013-11-19 00:00:00',NULL,'2013-11-19 20:31:30',2,0,NULL,'N',1,NULL,'0000-00-00 00:00:00',NULL),(3,3,4,1,5,0,1,0,1,NULL,'2013-11-19 00:00:00',NULL,'2013-11-19 20:31:46',3,0,NULL,'N',1,NULL,'0000-00-00 00:00:00',NULL),(4,4,4,1,5,0,1,0,1,NULL,'2013-11-19 00:00:00',NULL,'2013-11-19 20:31:55',3,0,NULL,'N',1,NULL,'0000-00-00 00:00:00',NULL),(5,5,4,1,5,0,1,0,1,NULL,'2013-11-19 00:00:00',NULL,'2013-11-19 20:32:04',4,0,NULL,'N',1,NULL,'0000-00-00 00:00:00',NULL),(6,6,4,1,5,0,1,0,1,NULL,'2013-11-19 00:00:00',NULL,'2013-11-19 20:32:12',4,0,NULL,'N',1,NULL,'0000-00-00 00:00:00',NULL),(7,7,4,1,5,0,1,0,1,NULL,'2013-11-19 00:00:00',NULL,'2013-11-19 20:32:21',4,0,NULL,'N',1,NULL,'0000-00-00 00:00:00',NULL),(9,9,4,2,5,0,1,0,1,NULL,'2013-11-19 00:00:00',NULL,'2013-11-19 20:36:12',7,0,NULL,'N',2,NULL,'0000-00-00 00:00:00',NULL),(10,10,4,2,5,0,1,0,1,NULL,'2013-11-19 00:00:00',NULL,'2013-11-19 20:36:33',8,0,NULL,'N',2,NULL,'0000-00-00 00:00:00',NULL),(11,11,4,2,5,0,1,0,1,NULL,'2013-11-19 00:00:00',NULL,'2013-11-19 20:36:50',9,0,NULL,'N',2,NULL,'0000-00-00 00:00:00',NULL),(93,94,4,43,0,0,1,0,1,NULL,NULL,NULL,'2013-12-07 08:13:23',44,1,NULL,'N',43,'2014-01-02 00:00:00','2013-12-07 08:13:23',NULL),(92,93,4,43,0,0,1,0,1,NULL,NULL,NULL,'2013-12-07 08:13:23',43,0,NULL,'N',43,'2014-01-02 00:00:00','2013-12-07 08:13:23',NULL),(91,92,4,43,0,0,1,0,1,NULL,NULL,NULL,'2013-12-07 08:13:23',43,0,NULL,'N',43,NULL,'2013-12-07 08:13:23',NULL),(90,91,4,43,0,0,1,0,1,NULL,NULL,NULL,'2013-12-07 08:13:23',42,1,NULL,'N',43,NULL,'2013-12-07 08:13:23',NULL),(89,90,4,42,0,0,1,0,1,NULL,NULL,NULL,'2013-12-06 06:42:56',40,0,NULL,'N',42,NULL,'2013-12-06 06:42:56',NULL),(88,89,4,42,0,0,1,0,1,NULL,NULL,NULL,'2013-12-06 06:42:56',39,0,NULL,'N',42,NULL,'2013-12-06 06:42:56',NULL),(87,88,4,42,0,0,1,0,1,NULL,NULL,NULL,'2013-12-06 06:42:56',38,0,NULL,'N',42,'2014-01-02 00:00:00','2013-12-06 06:42:56',NULL),(86,87,4,42,0,0,1,0,1,NULL,NULL,NULL,'2013-12-06 06:42:56',37,0,NULL,'N',42,NULL,'2013-12-06 06:42:56',NULL),(94,95,4,43,0,0,1,0,1,NULL,NULL,NULL,'2013-12-07 08:13:23',44,1,NULL,'N',43,NULL,'2013-12-07 08:13:23',NULL),(95,96,4,43,0,0,1,0,1,NULL,NULL,NULL,'2013-12-07 08:13:23',44,0,NULL,'N',43,NULL,'2013-12-07 08:13:23',NULL),(115,121,4,43,0,0,1,0,1,NULL,NULL,NULL,'2013-12-11 10:17:46',41,0,NULL,'N',43,NULL,'2013-12-11 10:17:46',NULL),(114,120,4,43,0,0,1,0,1,NULL,NULL,NULL,'2013-12-11 10:07:39',41,0,NULL,'N',43,NULL,'2013-12-11 10:07:39',NULL),(113,119,4,43,0,0,1,0,1,NULL,NULL,NULL,'2013-12-11 10:01:10',41,0,NULL,'N',43,NULL,'2013-12-11 10:01:10',NULL),(112,118,4,43,0,0,1,0,1,NULL,NULL,NULL,'2013-12-11 09:45:03',41,0,NULL,'N',43,NULL,'2013-12-11 09:45:03',NULL),(111,117,4,42,0,0,1,0,1,NULL,NULL,NULL,'2013-12-11 02:49:44',36,0,NULL,'N',42,'2012-01-12 00:00:00','2013-12-11 02:49:44',NULL),(116,122,4,43,0,0,1,0,1,NULL,NULL,NULL,'2013-12-11 10:32:28',41,0,NULL,'N',43,NULL,'2013-12-11 10:32:28',NULL),(117,123,4,43,0,0,1,0,1,NULL,NULL,NULL,'2013-12-11 10:33:01',41,0,NULL,'N',43,NULL,'2013-12-11 10:33:01',NULL),(118,124,4,43,0,0,1,0,1,NULL,NULL,NULL,'2013-12-11 10:38:20',41,0,NULL,'N',43,NULL,'2013-12-11 10:38:20',NULL),(119,125,4,43,0,0,1,0,1,NULL,NULL,NULL,'2013-12-11 11:07:58',41,0,NULL,'N',43,NULL,'2013-12-11 11:07:58',NULL),(120,126,4,43,0,0,1,0,1,NULL,NULL,NULL,'2013-12-11 11:09:37',41,0,NULL,'N',43,NULL,'2013-12-11 11:09:37',NULL),(121,127,4,43,0,0,1,0,1,NULL,NULL,NULL,'2013-12-11 11:10:18',41,0,NULL,'N',43,NULL,'2013-12-11 11:10:18',NULL),(122,128,4,43,0,0,1,0,1,NULL,NULL,NULL,'2013-12-11 11:11:06',41,0,NULL,'N',43,NULL,'2013-12-11 11:11:06',NULL),(123,129,4,43,0,0,1,0,1,NULL,NULL,NULL,'2013-12-11 11:14:31',41,0,NULL,'N',43,NULL,'2013-12-11 11:14:31',NULL),(124,130,4,43,0,0,1,0,1,NULL,NULL,NULL,'2013-12-11 11:15:04',41,0,NULL,'N',43,NULL,'2013-12-11 11:15:04',NULL),(125,131,4,43,0,0,1,0,1,NULL,NULL,NULL,'2013-12-12 08:28:58',41,0,NULL,'N',43,NULL,'2013-12-12 08:28:58',NULL);
/*!40000 ALTER TABLE `todo_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url`
--

DROP TABLE IF EXISTS `url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url` (
  `url` varchar(255) NOT NULL,
  `code` varchar(16) NOT NULL,
  KEY `code` (`code`),
  KEY `url` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url`
--

LOCK TABLES `url` WRITE;
/*!40000 ALTER TABLE `url` DISABLE KEYS */;
/*!40000 ALTER TABLE `url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'uid',
  `name` varchar(32) NOT NULL,
  `pinyin` varchar(32) DEFAULT NULL,
  `email` varchar(64) NOT NULL,
  `password` varchar(32) NOT NULL COMMENT 'md5后的值',
  `avatar_small` varchar(255) DEFAULT NULL,
  `avatar_normal` varchar(255) DEFAULT NULL,
  `level` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组',
  `timeline` datetime DEFAULT NULL,
  `settings` mediumtext,
  `is_closed` tinyint(1) NOT NULL DEFAULT '0',
  `mobile` varchar(32) DEFAULT NULL,
  `tel` varchar(32) DEFAULT NULL,
  `eid` varchar(32) DEFAULT NULL COMMENT '员工号',
  `weibo` varchar(32) DEFAULT NULL,
  `desp` text,
  `groups` varchar(255) DEFAULT NULL,
  `departmentid` tinyint(3) NOT NULL DEFAULT '0',
  `new_departmentid` int(11) NOT NULL,
  `sex` enum('0','1') NOT NULL DEFAULT '1',
  `birthday` varchar(12) DEFAULT NULL,
  `last_action_at` datetime NOT NULL,
  `user_type` varchar(20) NOT NULL DEFAULT 'member',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`),
  KEY `is_closed` (`is_closed`),
  KEY `groups` (`groups`)
) ENGINE=MyISAM AUTO_INCREMENT=178 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','admin','guangxiao.wang@gmail.com','db00ea4e9e1882ad632891df6271a8','http://apache.teamtoy.com/static/upload/avatar/avatar-1.jpg','',9,'2012-11-26 17:37:03','',0,'15001176744','8967','075511','王大瓜er','PHP工程师',NULL,0,0,'1',NULL,'2013-12-11 10:45:42','member'),(2,'王偌琳','wanglin','wangxiaoguang@hizone.cn','92775986d06ed4e0cfc65c53bc86df',NULL,NULL,1,'2013-08-07 18:09:52',NULL,0,NULL,NULL,NULL,NULL,NULL,'|技术部|',7,7,'1',NULL,'2013-10-21 14:30:38','member'),(3,'王晓光','wangxiaoguang','46698932@qq.com','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,'2013-08-07 18:10:20',NULL,0,NULL,NULL,NULL,NULL,NULL,'|技术部|闪电|',0,0,'1',NULL,'0000-00-00 00:00:00','member'),(4,'test','test','test@hizone.cn','202cb962ac59075b964b07152d234b70',NULL,NULL,9,'2013-08-15 17:08:59',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,11,11,'1',NULL,'2013-12-17 07:12:25','member'),(5,'张梦甜','zhangmengtian','zhangmengtian@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'人事助理',NULL,42,42,'0','5/26','0000-00-00 00:00:00','member'),(6,'宿戊辰','suwuchen','xuwuchen@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'招聘专员',NULL,42,42,'0','9/4','0000-00-00 00:00:00','member'),(7,'李迎','liying','liying@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'薪酬专员',NULL,42,42,'0','6/7','0000-00-00 00:00:00','member'),(8,'马静','majing','majing@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'人事经理',NULL,42,42,'0','9/4','0000-00-00 00:00:00','member'),(9,'赵智','zhaozhi','zhaozhi@hizone.cn','aedc57c29615e59ef87b37d9c2160a',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'总经理',NULL,43,43,'1','8/2','2013-11-08 16:38:09','member'),(10,'陈媛雯','chen','chenyuanwen@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'副总经理',NULL,43,43,'0','10/3','0000-00-00 00:00:00','member'),(11,'赵婷','zhao','zhaoting@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'副总经理',NULL,43,43,'0','5/26','0000-00-00 00:00:00','member'),(12,'赵茜','zhao','zhaoqian@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'办公室主任',NULL,43,43,'0','4/17','0000-00-00 00:00:00','member'),(13,'徐爽爽','xushuangshuang','xushuangshuang@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'行政秘书',NULL,43,43,'0','7/1','0000-00-00 00:00:00','member'),(14,'董鹏喜','dongpengxi','dongpengxi@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'行政助理',NULL,43,43,'1','5/6','0000-00-00 00:00:00','member'),(15,'赵勤','zhaoqin','zhaoqin@hizone.cn','85957723591415b54dd31a86cb9f1f',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'流程控管经理',NULL,44,44,'0','1/1','2013-11-08 16:03:55','member'),(16,'王丽萍','wangliping','wangliping@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'流程控管助理',NULL,44,44,'0','11/30','0000-00-00 00:00:00','member'),(17,'王娜娜','wangnana','wangnana@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'经理',NULL,45,45,'0','4/8','0000-00-00 00:00:00','member'),(18,'梁智行','liangzhixing','liangzhixing@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'助理',NULL,45,45,'1','5/29','0000-00-00 00:00:00','member'),(19,'曹雪','caoxue','caoxue@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'行政助理',NULL,46,46,'0','9/1','0000-00-00 00:00:00','member'),(20,'杜坤','dukun','dukun@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'前台',NULL,46,46,'0','6/13','0000-00-00 00:00:00','member'),(21,'赵蓦聃','zhao','zhaomodan@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'前台',NULL,46,46,'0','11/25','0000-00-00 00:00:00','member'),(22,'廖然','liaoran','liaoran@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'司机',NULL,46,46,'1','10/11','0000-00-00 00:00:00','member'),(23,'温秋晨','wenqiuchen','wenqiuchen@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'司机',NULL,46,46,'1','9/22','0000-00-00 00:00:00','member'),(24,'白雷雷','baileilei','baileilei@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'司机',NULL,46,46,'1','5/10','0000-00-00 00:00:00','member'),(25,'王迪','wangdi','wangdi@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'司机',NULL,46,46,'1','6/18','0000-00-00 00:00:00','member'),(26,'唐国清','tangguoqing','tangguoqing@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'副总经理',NULL,47,47,'1','2/18','0000-00-00 00:00:00','member'),(27,'刘建国','liujianguo','liujianguo@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'副总经理',NULL,47,47,'1','11/5','0000-00-00 00:00:00','member'),(28,'丁丽莹','dingliying','dingliying@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'财务总监',NULL,47,47,'0','5/29','0000-00-00 00:00:00','member'),(29,'石洪斌','shihongbin','shihongbin@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'财务经理',NULL,47,47,'1','4/8','0000-00-00 00:00:00','member'),(30,'翟文佳','diwenjia','zhaiwenjia@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'会计',NULL,47,47,'0','11/20','0000-00-00 00:00:00','member'),(31,'赵媛','zhao','zhaoyuan@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'会计',NULL,47,47,'0','10/22','0000-00-00 00:00:00','member'),(32,'陆艳','luyan','luyan@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'出纳',NULL,47,47,'0','4/26','0000-00-00 00:00:00','member'),(33,'孙溶','sunrong','sunrong@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'出纳',NULL,47,47,'0','1/16','0000-00-00 00:00:00','member'),(34,'石强','shiqiang','shiqiang@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'IT部经理',NULL,48,48,'1','12/30','0000-00-00 00:00:00','member'),(35,'李辰','lichen','lichen@hizone.cn','fab71e36a0eab8dcabad28440f0cc0',NULL,NULL,1,NULL,NULL,1,NULL,NULL,NULL,NULL,'IT专员',NULL,48,48,'1','5/4','0000-00-00 00:00:00','member'),(36,'马莉','mali','mali@hizone.cn','c2c8dcfecc385efb363f5c0be257c8',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'事业部总经理',NULL,31,24,'0','9/8','2013-10-30 11:43:30','member'),(37,'王冰','wangbing','wangbing@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户经理',NULL,31,24,'0','8/1','0000-00-00 00:00:00','member'),(38,'李赛歌','lisaige','lisaige@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户经理',NULL,31,24,'0','9/29','0000-00-00 00:00:00','member'),(39,'左雪峰','zuoxuefeng','zuoxuefeng@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户助理',NULL,31,24,'1','8/1','0000-00-00 00:00:00','member'),(40,'谢媛媛','xie','xieyuanyuan@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户总监',NULL,32,24,'0','3/3','0000-00-00 00:00:00','member'),(41,'刁明','diaoming','diaoming@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'文案',NULL,33,24,'1','11/22','0000-00-00 00:00:00','member'),(42,'孙凤羽','sunfengyu','sunfengyu@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'实习生',NULL,33,24,'0','2/15','0000-00-00 00:00:00','member'),(43,'王虹乂','wanghong','wanghongyi@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'创意总监',NULL,34,24,'1','11/15','0000-00-00 00:00:00','member'),(44,'龙圣文','longshengwen','longshengwen@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'资深设计师',NULL,34,24,'1','6/19','0000-00-00 00:00:00','member'),(45,'彭洪智','penghongzhi','penghongzhi@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'创意总监',NULL,35,24,'1','11/13','0000-00-00 00:00:00','member'),(46,'金唯佳','jinweijia','jinweijia@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'美术指导',NULL,35,24,'1','8/19','0000-00-00 00:00:00','member'),(47,'祝捷','zhujie','zhujie@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'事业部总经理',NULL,36,25,'1','3/26','0000-00-00 00:00:00','member'),(48,'李蔚','liwei','liwei@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户总监',NULL,36,25,'0','7/11','0000-00-00 00:00:00','member'),(49,'张晓童','zhangxiaotong','zhangxiaotong@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户副总监',NULL,36,25,'1','6/5','0000-00-00 00:00:00','member'),(50,'王茹婷','wangru','wangruting@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户经理',NULL,36,25,'0','7/17','0000-00-00 00:00:00','member'),(51,'陈雪娇','chenxuejiao','chenxuejiao@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户主管',NULL,36,25,'0','2/2','0000-00-00 00:00:00','member'),(52,'戴薇','dai','daiwei@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'文案指导',NULL,36,25,'0','8/25','0000-00-00 00:00:00','member'),(53,'唐梦娇','tangmengjiao','tangmengjiao@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'实习生',NULL,36,25,'0','8/3','0000-00-00 00:00:00','member'),(54,'辛颖','xinying','xinying@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'创意总监',NULL,36,25,'0','3/10','0000-00-00 00:00:00','member'),(55,'张洁','zhangjie','zhangjie@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'创意副总监',NULL,36,25,'0','12/22','0000-00-00 00:00:00','member'),(56,'王旖菲','wangfei','wangyifei@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'文案',NULL,37,25,'0','8/26','0000-00-00 00:00:00','member'),(57,'杨明德','yangmingde','yangmingde@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'美术指导',NULL,38,25,'1','7/8','0000-00-00 00:00:00','member'),(58,'刘淑杰','liushujie','liushujie@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'设计师',NULL,38,25,'0','4/27','0000-00-00 00:00:00','member'),(59,'赵星','zhaoxing','zhaoxing@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'资深设计师',NULL,38,25,'0','9/10','0000-00-00 00:00:00','member'),(60,'马新辉','maxinhui','maxinhui@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'美术指导',NULL,40,26,'1','5/9','0000-00-00 00:00:00','member'),(61,'仇会','chouhui','qiuhui@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'美术指导',NULL,40,26,'1','6/25','0000-00-00 00:00:00','member'),(62,'窦怿坤','kun','douyikun@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'设计师',NULL,40,26,'0','3/27','0000-00-00 00:00:00','member'),(63,'张野智','zhangyezhi','zhangyezhi@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'文案指导',NULL,40,26,'1','12/16','0000-00-00 00:00:00','member'),(64,'朱贺飞','zhuhefei','zhuhefei@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'实习生',NULL,40,26,'0','6/26','0000-00-00 00:00:00','member'),(65,'林曦','lin','linxi@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户总监',NULL,39,26,'0','9/4','0000-00-00 00:00:00','member'),(66,'张斯佩','zhangsipei','zhangsipei@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户主管',NULL,39,26,'1','3/5','0000-00-00 00:00:00','member'),(67,'王晓禹','wangxiaoyu','wangxiaoyu@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'高级客户经理',NULL,39,26,'0','5/24','0000-00-00 00:00:00','member'),(68,'韦栋','weidong','weidong@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'资深美术指导',NULL,39,26,'1','10/25','0000-00-00 00:00:00','member'),(69,'韩浩','hanhao','hanhao@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户主管',NULL,39,26,'1','1/8','0000-00-00 00:00:00','member'),(70,'毛乔迁','maoqiaoqian','maoqiaoqian@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户助理',NULL,39,26,'0','4/1','0000-00-00 00:00:00','member'),(71,'常鑫','chang','changxin@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'事业部总监',NULL,41,27,'1','4/16','0000-00-00 00:00:00','member'),(72,'陈杰','chenjie','chenjie@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'创意副总监',NULL,41,27,'1','10/8','0000-00-00 00:00:00','member'),(73,'黄娜','huangna','huangna@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户经理',NULL,41,27,'0','2/3','0000-00-00 00:00:00','member'),(74,'黄琴','huangqin','huangqin@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户主管',NULL,41,27,'0','9/29','0000-00-00 00:00:00','member'),(75,'韩爽','hanshuang','hanshuang@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户助理',NULL,41,27,'0','10/4','0000-00-00 00:00:00','member'),(76,'樊凡','fanfan','fanfan@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'美术指导',NULL,41,27,'1','4/21','0000-00-00 00:00:00','member'),(77,'张媛媛','zhang','zhangyuanyuan@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'文案',NULL,41,27,'0','6/16','0000-00-00 00:00:00','member'),(78,'李晓宇','lixiaoyu','lixiaoyu@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'文案策划',NULL,41,27,'0','5/6','0000-00-00 00:00:00','member'),(79,'邱志远','qiuzhiyuan','qiuzhiyuan@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'实习生',NULL,41,27,'1','11/13','0000-00-00 00:00:00','member'),(80,'张谚焱','zhangyan','zhangyanyan@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'公关事业部总监',NULL,28,28,'0','5/15','0000-00-00 00:00:00','member'),(81,'郭弘梵','guohong','guohongfan@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'公关总监',NULL,28,28,'0','2/9','0000-00-00 00:00:00','member'),(82,'郭芳','guofang','guofang@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'公关经理',NULL,28,28,'0','8/16','0000-00-00 00:00:00','member'),(83,'刘慧','liuhui','liuhui@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'公关主管',NULL,28,28,'0','11/7','0000-00-00 00:00:00','member'),(84,'张敏','zhangmin','zhangmin@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'策划',NULL,28,28,'0','11/12','0000-00-00 00:00:00','member'),(85,'陈霜洁','chenshuangjie','chenshuangjie@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'实习生',NULL,28,28,'0','8/6','0000-00-00 00:00:00','member'),(86,'洪荻','hong','hongdi@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'实习生',NULL,28,28,'0','7/17','0000-00-00 00:00:00','member'),(87,'胡亦晴','huyiqing','huyiqing@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'制片主任',NULL,29,29,'0','11/8','0000-00-00 00:00:00','member'),(88,'张曦','zhang','zhangxi@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'制片',NULL,29,29,'1','6/14','0000-00-00 00:00:00','member'),(89,'田雪','tianxue','tianxue@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'总经理',NULL,30,30,'0','10/10','0000-00-00 00:00:00','member'),(90,'刘坚','liujian','liujian@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'副总经理',NULL,30,30,'1','4/16','0000-00-00 00:00:00','member'),(91,'史慧群','shihuiqun','shihuiqun@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'副总经理',NULL,30,30,'1','4/30','0000-00-00 00:00:00','member'),(92,'姚毅能','yaoyineng','yaoyineng@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'副总经理',NULL,30,30,'1','10/5','0000-00-00 00:00:00','member'),(93,'朱亚辉','zhuyahui','zhuyahui@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'创意群总监',NULL,30,30,'0','2/28','0000-00-00 00:00:00','member'),(94,'马宏桂','mahonggui','mahonggui@hizone.cn','0e7c56177e08ecf8f8f612dc91b602',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'副总经理',NULL,18,18,'1','11/15','2013-10-30 14:32:09','member'),(95,'高文彬','gaowenbin','gaowenbin@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户总监',NULL,18,18,'1','10/19','0000-00-00 00:00:00','member'),(96,'钟舒颖','zhongshuying','zhongshuying@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'高级客户经理',NULL,18,18,'0','9/19','0000-00-00 00:00:00','member'),(97,'刘文杰','liuwenjie','liuwenjie@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户服务经理',NULL,18,18,'1','12/1','0000-00-00 00:00:00','member'),(98,'娄亚男','louyanan','louyanan@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'媒介主管',NULL,18,18,'0','8/5','0000-00-00 00:00:00','member'),(99,'王海云','wanghaiyun','wanghaiyun@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户助理',NULL,18,18,'0','4/6','0000-00-00 00:00:00','member'),(100,'陈思','chensi','chensi@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'实习生',NULL,18,18,'0','3/30','0000-00-00 00:00:00','member'),(101,'王超','wangchao','wangchao@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'副总经理',NULL,19,19,'0','9/6','0000-00-00 00:00:00','member'),(102,'郑威','zhengwei','zhengwei@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'副总经理',NULL,19,19,'1','5/8','0000-00-00 00:00:00','member'),(103,'郭亮','guoliang','guoliang@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'高级客户总监',NULL,19,19,'0','9/29','0000-00-00 00:00:00','member'),(104,'伊会军','yihuijun','yihuijun@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户副总监',NULL,19,19,'1','5/30','0000-00-00 00:00:00','member'),(105,'刘永跃','liuyongyue','liuyongyue@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'高级客户经理',NULL,19,19,'0','10/7','0000-00-00 00:00:00','member'),(106,'王鑫','wang','wangxin@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户主管',NULL,19,19,'1','7/16','0000-00-00 00:00:00','member'),(107,'朱香霖','zhuxianglin','zhuxianglin@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'媒介总监',NULL,19,19,'0','7/21','0000-00-00 00:00:00','member'),(108,'姚志娟','yaozhijuan','yaozhijuan@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'高级媒介经理',NULL,19,19,'0','11/8','0000-00-00 00:00:00','member'),(109,'李静','lijing','lijing@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'媒介总监',NULL,20,20,'0','11/26','0000-00-00 00:00:00','member'),(110,'张睿','zhang','zhangrui@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'媒介总监',NULL,20,20,'0','6/1','0000-00-00 00:00:00','member'),(111,'何光辉','heguanghui','heguanghui@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户总监',NULL,20,20,'1','11/25','0000-00-00 00:00:00','member'),(112,'陈雷','chenlei','chenlei@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'副总经理',NULL,21,21,'1','8/24','0000-00-00 00:00:00','member'),(113,'张彦','zhangyan','zhangyan@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户副总监',NULL,21,21,'0','3/12','0000-00-00 00:00:00','member'),(114,'惠梅丽','huimeili','huimeili@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户主管',NULL,21,21,'0','10/15','0000-00-00 00:00:00','member'),(115,'雷蕾','leilei','leilei@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'媒介经理',NULL,21,21,'0','4/30','0000-00-00 00:00:00','member'),(116,'于跃','yuyue','yuyue@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'实习生',NULL,21,21,'0','2/11','0000-00-00 00:00:00','member'),(117,'苏玥','su','suyue@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'实习生',NULL,21,21,'0','5/1','0000-00-00 00:00:00','member'),(118,'王小玲','wangxiaoling','wangxiaoling@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'媒介执行总监',NULL,22,22,'0','4/9','0000-00-00 00:00:00','member'),(119,'王思宇','wangsiyu','wangsiyu@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'媒介主管',NULL,22,22,'0','5/22','0000-00-00 00:00:00','member'),(120,'王飞','wangfei','wangfei@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'媒介执行',NULL,22,22,'0','5/16','0000-00-00 00:00:00','member'),(121,'胡雪','huxue','huxue@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'媒介执行',NULL,22,22,'0','12/31','0000-00-00 00:00:00','member'),(122,'张旸','zhang','zhangyang@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'媒介执行',NULL,22,22,'0','12/25','0000-00-00 00:00:00','member'),(123,'赵爽','zhaoshuang','zhaoshuang@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'策略总监',NULL,23,23,'0','11/9','0000-00-00 00:00:00','member'),(124,'张祥','zhangxiang','zhangxiang@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'策略副总监',NULL,23,23,'1','11/20','0000-00-00 00:00:00','member'),(125,'刘磊','liulei','liulei@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'策略副总监',NULL,23,23,'1','7/11','0000-00-00 00:00:00','member'),(126,'孔繁阁','kongfange','kongfange@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'高级策略经理',NULL,23,23,'0','1/6','0000-00-00 00:00:00','member'),(127,'徐为','xuwei','xuwei@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'策略经理',NULL,23,23,'1','10/22','0000-00-00 00:00:00','member'),(128,'苏琳','sulin','sulin@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'高级策略主管',NULL,23,23,'0','6/4','0000-00-00 00:00:00','member'),(129,'赵昊','zhao','zhaohao@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'媒介研究主管',NULL,23,23,'0','11/16','0000-00-00 00:00:00','member'),(130,'石玉联','shiyulian','shiyulian@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'媒体部总经理',NULL,16,16,'1','8/16','0000-00-00 00:00:00','member'),(131,'黄萍','huangping','huangping@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'媒体部副总经理',NULL,16,16,'0','11/23','0000-00-00 00:00:00','member'),(132,'李渊博','liyuanbo','liyuanbo@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'创意策划总监',NULL,16,16,'1','6/13','0000-00-00 00:00:00','member'),(133,'王杨','wangyang','wangyang@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'媒介主管',NULL,16,16,'0','2/9','0000-00-00 00:00:00','member'),(134,'张翌军','zhangyijun','zhangyijun@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'媒介助理',NULL,16,16,'0','7/27','0000-00-00 00:00:00','member'),(135,'徐盈盈','xuyingying','xuyingying@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'媒介助理',NULL,16,16,'0','4/21','0000-00-00 00:00:00','member'),(136,'彭静','pengjing','pengjing@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'媒介助理',NULL,16,16,'0','1/1','0000-00-00 00:00:00','member'),(137,'陈毓敏','chenmin','chenyumin@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'总经理',NULL,17,17,'0','3/7','0000-00-00 00:00:00','member'),(138,'刘萍','liuping','liuping@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'高级媒介经理',NULL,10,6,'0','12/4','0000-00-00 00:00:00','member'),(139,'田一涵','tianyihan','tianyihan@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'媒介助理',NULL,10,6,'0','8/13','0000-00-00 00:00:00','member'),(140,'张倩','zhang','zhangqian@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'媒介助理',NULL,10,6,'0','5/15','0000-00-00 00:00:00','member'),(141,'王乐','wangle','wangle@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'媒介助理',NULL,10,6,'0','1/17','0000-00-00 00:00:00','member'),(142,'高婷','gao','gaoting@hizone.cn','e10adc3949ba59abbe56e057f20f883e','','',1,NULL,NULL,0,'','','','','媒介助理','',10,6,'0','8/7','0000-00-00 00:00:00','member'),(143,'冯永晓','fengyongxiao','fengyongxiao@hizone.cn','ebc4f8573fe25e9cb4e16c9ad31e4d',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'事业部总经理',NULL,11,11,'0','8/23','2013-11-08 18:27:09','member'),(144,'马海宁','mahaining','mahaining@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'事业一部总监',NULL,11,11,'0','11/30','0000-00-00 00:00:00','member'),(145,'于晓林','yuxiaolin','yuxiaolin@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户总监',NULL,11,11,'0','3/11','0000-00-00 00:00:00','member'),(146,'张超','zhangchao','zhangchao@hizone.cn','7ea0d07302f2a68b393dc057067c98',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户总监',NULL,11,11,'1','8/22','2013-11-08 14:21:47','member'),(147,'方昱玮','fang','fangyuwei@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户经理',NULL,11,11,'0','4/15','0000-00-00 00:00:00','member'),(148,'李莹','liying','liying1@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户经理',NULL,11,11,'0','4/22','0000-00-00 00:00:00','member'),(149,'赵韵','zhaoyun','zhaoyun@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'策划副总监',NULL,11,11,'0','10/3','0000-00-00 00:00:00','member'),(150,'于野','yuye','yuye@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'网页设计师',NULL,11,11,'1','4/20','0000-00-00 00:00:00','member'),(151,'周宇','zhouyu','zhouyu@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'网页制作',NULL,11,11,'1','6/23','0000-00-00 00:00:00','member'),(152,'何瑶铃','heyaoling','heyaoling@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'程序员',NULL,11,11,'1','8/17','0000-00-00 00:00:00','member'),(153,'叶思强','yesiqiang','yesiqiang@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'文案策划',NULL,11,11,'1','4/17','0000-00-00 00:00:00','member'),(154,'任政威','renzhengwei','renzhengwei@hizone.cn','6da128a8dd4d95fe704d26a73979f5',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'事业部总经理',NULL,12,12,'1','6/29','2013-11-08 11:25:37','member'),(155,'钱立平','qianliping','qianliping@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'高级客户经理',NULL,12,12,'0','6/15','0000-00-00 00:00:00','member'),(156,'班心韬','banxin','banxintao@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户经理',NULL,12,12,'1','4/17','0000-00-00 00:00:00','member'),(157,'宋雅晴','songyaqing','songyaqing@hizone.cn','4f15be279bcbacebe13d5879185e7a',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户执行',NULL,12,12,'0','10/16','0000-00-00 00:00:00','member'),(158,'于鑫','yu','yuxin@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'文案策划',NULL,12,12,'0','1/7','0000-00-00 00:00:00','member'),(159,'王倩','wang','wangqian@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'技术主管',NULL,12,12,'0','11/2','0000-00-00 00:00:00','member'),(160,'赵幼林','zhaoyoulin','zhaoyoulin@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'网页制作',NULL,12,12,'0','6/23','0000-00-00 00:00:00','member'),(161,'王强','wangqiang','wangqiang@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'事业二部总监',NULL,13,13,'1','1/12','0000-00-00 00:00:00','member'),(162,'王静儿','wangjinger','wangjinger@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户经理',NULL,13,13,'0','10/17','0000-00-00 00:00:00','member'),(163,'李克','like','like@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'资深美术指导',NULL,13,13,'1','8/28','0000-00-00 00:00:00','member'),(164,'王左文','wangzuowen','wangzuowen@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'文案策划',NULL,13,13,'1','6/27','0000-00-00 00:00:00','member'),(165,'高配配','gaopeipei','gaopeipei@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户执行',NULL,13,13,'0','5/10','0000-00-00 00:00:00','member'),(166,'徐雅凡','xuyafan','xuyafan@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户总监',NULL,14,14,'0','6/15','0000-00-00 00:00:00','member'),(167,'杨霏','yang','yangfei@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户总监',NULL,14,14,'1','11/24','0000-00-00 00:00:00','member'),(168,'白杨子','baiyangzi','baiyangzi@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户总监',NULL,14,14,'0','3/16','0000-00-00 00:00:00','member'),(169,'田君','tianjun','tianjun@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户经理',NULL,14,14,'0','2/12','0000-00-00 00:00:00','member'),(170,'徐冉','xuran','xuran@hizone.cn','83253df45d998089c1e4bd1974df92',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户经理',NULL,14,14,'0','9/29','0000-00-00 00:00:00','member'),(171,'战楠','zhan','zhannan@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户经理',NULL,14,14,'1','4/20','0000-00-00 00:00:00','member'),(172,'刘珈言','liuyan','liujiayan@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'客户主管',NULL,14,14,'0','10/29','0000-00-00 00:00:00','member'),(173,'张伟','zhangwei','zhangwei@hizone.cn','7a7721d7ae97826c61b73e617c69c2',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'技术总监',NULL,7,7,'1','1/29','0000-00-00 00:00:00','member'),(174,'吴丹','wudan','wudan@hizone.cn','202cb962ac59075b964b07152d234b70',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'高级前端工程师',NULL,7,7,'0','1/2','2013-12-17 07:16:11','member'),(175,'郑洋','zhengyang','zhengyang@hizone.cn','15a563ee0ba408b6bda61fa1be46c8',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'视觉设计师',NULL,7,7,'0','1/31','2013-11-08 14:16:30','member'),(176,'王冉','wangran','wangran@hizone.cn','ca4b57221976968370ca741b858907',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'互动总经理',NULL,9,9,'1','10/14','2013-11-08 19:17:49','member'),(177,'卞丽宏','bianlihong','bianlihong@hizone.cn','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,1,NULL,NULL,0,NULL,NULL,NULL,NULL,'互动副总经理',NULL,9,9,'0','10/15','0000-00-00 00:00:00','member');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_log`
--

DROP TABLE IF EXISTS `user_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `timeline` datetime NOT NULL,
  `action` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_log`
--

LOCK TABLES `user_log` WRITE;
/*!40000 ALTER TABLE `user_log` DISABLE KEYS */;
INSERT INTO `user_log` VALUES (1,4,'2013-11-26 17:19:36','登录成功'),(2,4,'2013-11-26 17:23:14','登录成功'),(3,4,'2013-11-27 09:38:58','登录成功'),(4,4,'2013-11-27 09:41:27','登录成功'),(5,4,'2013-11-27 14:14:18','登录成功'),(6,4,'2013-11-27 14:46:43','登录成功'),(7,4,'2013-11-30 13:04:01','登录成功'),(8,4,'2013-12-02 13:52:18','登录成功'),(9,4,'2013-12-02 13:53:20','登录成功'),(10,4,'2013-12-02 15:03:09','登录成功'),(11,4,'2013-12-02 16:42:33','登录成功'),(12,4,'2013-12-02 18:57:04','登录成功'),(13,4,'2013-12-02 19:07:58','登录成功'),(14,4,'2013-12-02 20:43:38','登录成功'),(15,4,'2013-12-03 09:35:49','登录成功'),(16,4,'2013-12-03 10:47:24','登录成功'),(17,4,'2013-12-04 10:20:11','登录成功'),(18,4,'2013-12-04 11:40:39','登录成功'),(19,4,'2013-12-04 15:24:55','登录成功'),(20,4,'2013-12-04 17:37:54','登录成功'),(21,4,'2013-12-05 09:44:17','登录成功'),(22,4,'2013-12-05 16:54:35','登录成功'),(23,1,'2013-12-06 10:19:15','登录成功'),(24,1,'2013-12-06 11:24:42','登录成功'),(25,1,'2013-12-06 13:46:15','登录成功'),(26,1,'2013-12-06 13:51:47','登录成功'),(27,1,'2013-12-06 16:01:22','登录成功'),(28,1,'2013-12-06 16:12:34','登录成功'),(29,1,'2013-12-06 17:04:33','登录成功'),(30,1,'2013-12-06 17:59:50','登录成功'),(31,1,'2013-12-07 11:38:36','登录成功'),(32,1,'2013-12-07 13:27:47','登录成功'),(33,1,'2013-12-07 14:17:44','登录成功'),(34,1,'2013-12-07 16:25:55','登录成功'),(35,1,'2013-12-10 16:02:58','登录成功'),(36,1,'2013-12-10 17:56:14','登录成功'),(37,1,'2013-12-11 10:45:42','登录成功');
/*!40000 ALTER TABLE `user_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_privilege`
--

DROP TABLE IF EXISTS `user_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_privilege` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `department_ids` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_privilege`
--

LOCK TABLES `user_privilege` WRITE;
/*!40000 ALTER TABLE `user_privilege` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weekly`
--

DROP TABLE IF EXISTS `weekly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weekly` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phases` text NOT NULL,
  `phase` varchar(200) NOT NULL,
  `summary` text NOT NULL,
  `week` varchar(50) NOT NULL,
  `state` tinyint(4) NOT NULL,
  `is_heavy` tinyint(4) NOT NULL,
  `gtime` datetime NOT NULL,
  `ctime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weekly`
--

LOCK TABLES `weekly` WRITE;
/*!40000 ALTER TABLE `weekly` DISABLE KEYS */;
/*!40000 ALTER TABLE `weekly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weekly_times`
--

DROP TABLE IF EXISTS `weekly_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weekly_times` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `yweek` varchar(100) NOT NULL,
  `w_start_time` date NOT NULL,
  `w_end_time` date NOT NULL,
  `s_start_time` date NOT NULL,
  `s_end_time` date NOT NULL,
  `iswrite` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weekly_times`
--

LOCK TABLES `weekly_times` WRITE;
/*!40000 ALTER TABLE `weekly_times` DISABLE KEYS */;
/*!40000 ALTER TABLE `weekly_times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weekly_todo_assoc`
--

DROP TABLE IF EXISTS `weekly_todo_assoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weekly_todo_assoc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wid` int(11) NOT NULL,
  `tid` int(11) NOT NULL,
  `desc` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weekly_todo_assoc`
--

LOCK TABLES `weekly_todo_assoc` WRITE;
/*!40000 ALTER TABLE `weekly_todo_assoc` DISABLE KEYS */;
/*!40000 ALTER TABLE `weekly_todo_assoc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weekly_todos`
--

DROP TABLE IF EXISTS `weekly_todos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weekly_todos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wid` int(11) NOT NULL,
  `tid` int(11) NOT NULL,
  `state` tinyint(4) NOT NULL,
  `isskip` tinyint(4) NOT NULL DEFAULT '1',
  `name` varchar(255) NOT NULL,
  `order_list` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weekly_todos`
--

LOCK TABLES `weekly_todos` WRITE;
/*!40000 ALTER TABLE `weekly_todos` DISABLE KEYS */;
/*!40000 ALTER TABLE `weekly_todos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-12-19  9:57:23
