-- MySQL dump 10.13  Distrib 8.0.20, for Linux (x86_64)
--
-- Host: localhost    Database: project
-- ------------------------------------------------------
-- Server version	8.0.20

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
-- Table structure for table `cms_assetindexdata`
--

DROP TABLE IF EXISTS `cms_assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_assetindexdata` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int NOT NULL,
  `uri` text,
  `size` bigint unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `cms_assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `cms_assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `cms_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_assetindexdata`
--

LOCK TABLES `cms_assetindexdata` WRITE;
/*!40000 ALTER TABLE `cms_assetindexdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_assetindexdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_assets`
--

DROP TABLE IF EXISTS `cms_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_assets` (
  `id` int NOT NULL,
  `volumeId` int DEFAULT NULL,
  `folderId` int NOT NULL,
  `uploaderId` int DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int unsigned DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `size` bigint unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `cms_assets_folderId_idx` (`folderId`),
  KEY `cms_assets_volumeId_idx` (`volumeId`),
  KEY `cms_assets_uploaderId_fk` (`uploaderId`),
  CONSTRAINT `cms_assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `cms_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_assets_id_fk` FOREIGN KEY (`id`) REFERENCES `cms_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_assets_uploaderId_fk` FOREIGN KEY (`uploaderId`) REFERENCES `cms_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cms_assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `cms_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_assets`
--

LOCK TABLES `cms_assets` WRITE;
/*!40000 ALTER TABLE `cms_assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_assettransformindex`
--

DROP TABLE IF EXISTS `cms_assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_assettransformindex` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assetId` int NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_assettransformindex`
--

LOCK TABLES `cms_assettransformindex` WRITE;
/*!40000 ALTER TABLE `cms_assettransformindex` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_assettransformindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_assettransforms`
--

DROP TABLE IF EXISTS `cms_assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_assettransforms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int unsigned DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `cms_assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_assettransforms`
--

LOCK TABLES `cms_assettransforms` WRITE;
/*!40000 ALTER TABLE `cms_assettransforms` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_assettransforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_categories`
--

DROP TABLE IF EXISTS `cms_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_categories` (
  `id` int NOT NULL,
  `groupId` int NOT NULL,
  `parentId` int DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_categories_groupId_idx` (`groupId`),
  KEY `cms_categories_parentId_fk` (`parentId`),
  CONSTRAINT `cms_categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `cms_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_categories_id_fk` FOREIGN KEY (`id`) REFERENCES `cms_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `cms_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_categories`
--

LOCK TABLES `cms_categories` WRITE;
/*!40000 ALTER TABLE `cms_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_categorygroups`
--

DROP TABLE IF EXISTS `cms_categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_categorygroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_categorygroups_name_idx` (`name`),
  KEY `cms_categorygroups_handle_idx` (`handle`),
  KEY `cms_categorygroups_structureId_idx` (`structureId`),
  KEY `cms_categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `cms_categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `cms_categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `cms_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cms_categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `cms_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_categorygroups`
--

LOCK TABLES `cms_categorygroups` WRITE;
/*!40000 ALTER TABLE `cms_categorygroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_categorygroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_categorygroups_sites`
--

DROP TABLE IF EXISTS `cms_categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_categorygroups_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `siteId` int NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `cms_categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `cms_categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `cms_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `cms_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_categorygroups_sites`
--

LOCK TABLES `cms_categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `cms_categorygroups_sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_changedattributes`
--

DROP TABLE IF EXISTS `cms_changedattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_changedattributes` (
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `cms_changedattributes_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `cms_changedattributes_siteId_fk` (`siteId`),
  KEY `cms_changedattributes_userId_fk` (`userId`),
  CONSTRAINT `cms_changedattributes_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `cms_elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms_changedattributes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `cms_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms_changedattributes_userId_fk` FOREIGN KEY (`userId`) REFERENCES `cms_users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_changedattributes`
--

LOCK TABLES `cms_changedattributes` WRITE;
/*!40000 ALTER TABLE `cms_changedattributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_changedattributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_changedfields`
--

DROP TABLE IF EXISTS `cms_changedfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_changedfields` (
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `fieldId` int NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `cms_changedfields_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `cms_changedfields_siteId_fk` (`siteId`),
  KEY `cms_changedfields_fieldId_fk` (`fieldId`),
  KEY `cms_changedfields_userId_fk` (`userId`),
  CONSTRAINT `cms_changedfields_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `cms_elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms_changedfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `cms_fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms_changedfields_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `cms_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms_changedfields_userId_fk` FOREIGN KEY (`userId`) REFERENCES `cms_users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_changedfields`
--

LOCK TABLES `cms_changedfields` WRITE;
/*!40000 ALTER TABLE `cms_changedfields` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_changedfields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_content`
--

DROP TABLE IF EXISTS `cms_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_content` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `cms_content_siteId_idx` (`siteId`),
  KEY `cms_content_title_idx` (`title`),
  CONSTRAINT `cms_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `cms_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `cms_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_content`
--

LOCK TABLES `cms_content` WRITE;
/*!40000 ALTER TABLE `cms_content` DISABLE KEYS */;
INSERT INTO `cms_content` VALUES (1,1,1,NULL,'2020-05-04 07:16:43','2020-05-04 07:16:43','26962281-cabb-4515-800b-13dc9eabfd4e'),(2,2,1,'Home','2020-05-04 07:18:22','2020-05-04 07:18:22','166eafd7-b919-4d3c-93dd-204406fed12d'),(3,3,1,'Home','2020-05-04 07:18:22','2020-05-04 07:18:22','e7db1395-4f1b-40b9-a7a9-ca379c1838f0');
/*!40000 ALTER TABLE `cms_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_craftidtokens`
--

DROP TABLE IF EXISTS `cms_craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_craftidtokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `cms_craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `cms_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_craftidtokens`
--

LOCK TABLES `cms_craftidtokens` WRITE;
/*!40000 ALTER TABLE `cms_craftidtokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_deprecationerrors`
--

DROP TABLE IF EXISTS `cms_deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_deprecationerrors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint unsigned DEFAULT NULL,
  `message` text,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_deprecationerrors`
--

LOCK TABLES `cms_deprecationerrors` WRITE;
/*!40000 ALTER TABLE `cms_deprecationerrors` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_drafts`
--

DROP TABLE IF EXISTS `cms_drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_drafts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sourceId` int DEFAULT NULL,
  `creatorId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `trackChanges` tinyint(1) NOT NULL DEFAULT '0',
  `dateLastMerged` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_drafts_creatorId_fk` (`creatorId`),
  KEY `cms_drafts_sourceId_fk` (`sourceId`),
  CONSTRAINT `cms_drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `cms_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cms_drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `cms_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_drafts`
--

LOCK TABLES `cms_drafts` WRITE;
/*!40000 ALTER TABLE `cms_drafts` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_drafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_elementindexsettings`
--

DROP TABLE IF EXISTS `cms_elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_elementindexsettings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_elementindexsettings`
--

LOCK TABLES `cms_elementindexsettings` WRITE;
/*!40000 ALTER TABLE `cms_elementindexsettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_elements`
--

DROP TABLE IF EXISTS `cms_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_elements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `draftId` int DEFAULT NULL,
  `revisionId` int DEFAULT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_elements_dateDeleted_idx` (`dateDeleted`),
  KEY `cms_elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `cms_elements_type_idx` (`type`),
  KEY `cms_elements_enabled_idx` (`enabled`),
  KEY `cms_elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `cms_elements_archived_dateDeleted_draftId_revisionId_idx` (`archived`,`dateDeleted`,`draftId`,`revisionId`),
  KEY `cms_elements_draftId_fk` (`draftId`),
  KEY `cms_elements_revisionId_fk` (`revisionId`),
  CONSTRAINT `cms_elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `cms_drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `cms_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cms_elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `cms_revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_elements`
--

LOCK TABLES `cms_elements` WRITE;
/*!40000 ALTER TABLE `cms_elements` DISABLE KEYS */;
INSERT INTO `cms_elements` VALUES (1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2020-05-04 07:16:43','2020-05-04 07:16:43',NULL,'42faa32a-0d6a-41ea-a50b-d23fb506e4bc'),(2,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2020-05-04 07:18:22','2020-05-04 07:18:22',NULL,'4d7580b1-0b0a-4d92-b7a6-6ebb1dcb429c'),(3,NULL,1,NULL,'craft\\elements\\Entry',1,0,'2020-05-04 07:18:22','2020-05-04 07:18:22',NULL,'7382635e-ba1d-4753-854d-cfb23ab67a43');
/*!40000 ALTER TABLE `cms_elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_elements_sites`
--

DROP TABLE IF EXISTS `cms_elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_elements_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `cms_elements_sites_siteId_idx` (`siteId`),
  KEY `cms_elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `cms_elements_sites_enabled_idx` (`enabled`),
  KEY `cms_elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `cms_elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `cms_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `cms_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_elements_sites`
--

LOCK TABLES `cms_elements_sites` WRITE;
/*!40000 ALTER TABLE `cms_elements_sites` DISABLE KEYS */;
INSERT INTO `cms_elements_sites` VALUES (1,1,1,NULL,NULL,1,'2020-05-04 07:16:43','2020-05-04 07:16:43','7cdbf992-6445-463a-85ab-d3c5a6e95f40'),(2,2,1,'home','__home__',1,'2020-05-04 07:18:22','2020-05-04 07:18:22','60151cce-eebb-49cd-8067-885b05fe08d3'),(3,3,1,'home','__home__',1,'2020-05-04 07:18:22','2020-05-04 07:18:22','cd3ee733-81ad-4a7a-92c5-5116c942c9e1');
/*!40000 ALTER TABLE `cms_elements_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_entries`
--

DROP TABLE IF EXISTS `cms_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_entries` (
  `id` int NOT NULL,
  `sectionId` int NOT NULL,
  `parentId` int DEFAULT NULL,
  `typeId` int NOT NULL,
  `authorId` int DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_entries_postDate_idx` (`postDate`),
  KEY `cms_entries_expiryDate_idx` (`expiryDate`),
  KEY `cms_entries_authorId_idx` (`authorId`),
  KEY `cms_entries_sectionId_idx` (`sectionId`),
  KEY `cms_entries_typeId_idx` (`typeId`),
  KEY `cms_entries_parentId_fk` (`parentId`),
  CONSTRAINT `cms_entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `cms_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_entries_id_fk` FOREIGN KEY (`id`) REFERENCES `cms_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `cms_entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cms_entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `cms_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `cms_entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_entries`
--

LOCK TABLES `cms_entries` WRITE;
/*!40000 ALTER TABLE `cms_entries` DISABLE KEYS */;
INSERT INTO `cms_entries` VALUES (2,1,NULL,1,NULL,'2020-05-04 07:18:00',NULL,NULL,'2020-05-04 07:18:22','2020-05-04 07:18:22','c3886257-3ca9-4117-97f2-06cf0c484c88'),(3,1,NULL,1,NULL,'2020-05-04 07:18:00',NULL,NULL,'2020-05-04 07:18:22','2020-05-04 07:18:22','caed5d68-6f0f-442e-8986-6671edb54026');
/*!40000 ALTER TABLE `cms_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_entrytypes`
--

DROP TABLE IF EXISTS `cms_entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_entrytypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sectionId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `cms_entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `cms_entrytypes_sectionId_idx` (`sectionId`),
  KEY `cms_entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `cms_entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `cms_entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `cms_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cms_entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `cms_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_entrytypes`
--

LOCK TABLES `cms_entrytypes` WRITE;
/*!40000 ALTER TABLE `cms_entrytypes` DISABLE KEYS */;
INSERT INTO `cms_entrytypes` VALUES (1,1,NULL,'Home','home',0,NULL,'{section.name|raw}',1,'2020-05-04 07:18:22','2020-05-04 07:18:22',NULL,'a43275d4-73eb-4faa-8ed2-0d937b376691');
/*!40000 ALTER TABLE `cms_entrytypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_fieldgroups`
--

DROP TABLE IF EXISTS `cms_fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_fieldgroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_fieldgroups`
--

LOCK TABLES `cms_fieldgroups` WRITE;
/*!40000 ALTER TABLE `cms_fieldgroups` DISABLE KEYS */;
INSERT INTO `cms_fieldgroups` VALUES (1,'Common','2020-05-04 07:16:43','2020-05-04 07:16:43','883ccb03-4728-4bb1-8464-bfd9e00f74c8');
/*!40000 ALTER TABLE `cms_fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_fieldlayoutfields`
--

DROP TABLE IF EXISTS `cms_fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_fieldlayoutfields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `layoutId` int NOT NULL,
  `tabId` int NOT NULL,
  `fieldId` int NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `cms_fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `cms_fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `cms_fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `cms_fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `cms_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `cms_fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `cms_fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_fieldlayoutfields`
--

LOCK TABLES `cms_fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `cms_fieldlayoutfields` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_fieldlayouts`
--

DROP TABLE IF EXISTS `cms_fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_fieldlayouts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `cms_fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_fieldlayouts`
--

LOCK TABLES `cms_fieldlayouts` WRITE;
/*!40000 ALTER TABLE `cms_fieldlayouts` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_fieldlayouttabs`
--

DROP TABLE IF EXISTS `cms_fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_fieldlayouttabs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `layoutId` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `cms_fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `cms_fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `cms_fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_fieldlayouttabs`
--

LOCK TABLES `cms_fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `cms_fieldlayouttabs` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_fields`
--

DROP TABLE IF EXISTS `cms_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_fields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `cms_fields_groupId_idx` (`groupId`),
  KEY `cms_fields_context_idx` (`context`),
  CONSTRAINT `cms_fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `cms_fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_fields`
--

LOCK TABLES `cms_fields` WRITE;
/*!40000 ALTER TABLE `cms_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_globalsets`
--

DROP TABLE IF EXISTS `cms_globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_globalsets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_globalsets_name_idx` (`name`),
  KEY `cms_globalsets_handle_idx` (`handle`),
  KEY `cms_globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `cms_globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `cms_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cms_globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `cms_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_globalsets`
--

LOCK TABLES `cms_globalsets` WRITE;
/*!40000 ALTER TABLE `cms_globalsets` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_globalsets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_gqlschemas`
--

DROP TABLE IF EXISTS `cms_gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_gqlschemas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text,
  `isPublic` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_gqlschemas`
--

LOCK TABLES `cms_gqlschemas` WRITE;
/*!40000 ALTER TABLE `cms_gqlschemas` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_gqltokens`
--

DROP TABLE IF EXISTS `cms_gqltokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_gqltokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_gqltokens_accessToken_unq_idx` (`accessToken`),
  UNIQUE KEY `cms_gqltokens_name_unq_idx` (`name`),
  KEY `cms_gqltokens_schemaId_fk` (`schemaId`),
  CONSTRAINT `cms_gqltokens_schemaId_fk` FOREIGN KEY (`schemaId`) REFERENCES `cms_gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_gqltokens`
--

LOCK TABLES `cms_gqltokens` WRITE;
/*!40000 ALTER TABLE `cms_gqltokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_gqltokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_info`
--

DROP TABLE IF EXISTS `cms_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `configMap` mediumtext,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_info`
--

LOCK TABLES `cms_info` WRITE;
/*!40000 ALTER TABLE `cms_info` DISABLE KEYS */;
INSERT INTO `cms_info` VALUES (1,'3.4.17.1','3.4.10',0,'[]','5RPacvRNzjFO','2020-05-04 07:16:43','2020-05-04 07:16:43','35337129-72c9-466a-9529-bd5733ab81ef');
/*!40000 ALTER TABLE `cms_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_matrixblocks`
--

DROP TABLE IF EXISTS `cms_matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_matrixblocks` (
  `id` int NOT NULL,
  `ownerId` int NOT NULL,
  `fieldId` int NOT NULL,
  `typeId` int NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_matrixblocks_ownerId_idx` (`ownerId`),
  KEY `cms_matrixblocks_fieldId_idx` (`fieldId`),
  KEY `cms_matrixblocks_typeId_idx` (`typeId`),
  KEY `cms_matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `cms_matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `cms_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `cms_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `cms_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `cms_matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_matrixblocks`
--

LOCK TABLES `cms_matrixblocks` WRITE;
/*!40000 ALTER TABLE `cms_matrixblocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_matrixblocktypes`
--

DROP TABLE IF EXISTS `cms_matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_matrixblocktypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `cms_matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `cms_matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `cms_matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `cms_matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `cms_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `cms_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_matrixblocktypes`
--

LOCK TABLES `cms_matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `cms_matrixblocktypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_migrations`
--

DROP TABLE IF EXISTS `cms_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pluginId` int DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_migrations_pluginId_idx` (`pluginId`),
  KEY `cms_migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `cms_migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `cms_plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_migrations`
--

LOCK TABLES `cms_migrations` WRITE;
/*!40000 ALTER TABLE `cms_migrations` DISABLE KEYS */;
INSERT INTO `cms_migrations` VALUES (1,NULL,'app','Install','2020-05-04 07:16:43','2020-05-04 07:16:43','2020-05-04 07:16:43','101c4d24-67a9-45fc-b1c6-2c01c78e4fe6'),(2,NULL,'app','m150403_183908_migrations_table_changes','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','eece7870-fa10-4b49-be88-75643538ccce'),(3,NULL,'app','m150403_184247_plugins_table_changes','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','2a9e34cf-ca4d-4430-a7d6-a3993b3fb1fc'),(4,NULL,'app','m150403_184533_field_version','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','e1e10142-f1b5-4ef8-967e-64518e85e62d'),(5,NULL,'app','m150403_184729_type_columns','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','a37bcc13-2471-4aa1-ae2e-bfde555804d4'),(6,NULL,'app','m150403_185142_volumes','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','d525d85a-66da-43e0-959a-e6986119f741'),(7,NULL,'app','m150428_231346_userpreferences','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','ad1f40ba-d066-4765-913a-b49766b6948d'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','4b4ede53-a471-47a7-991b-5079a3e0cbe3'),(9,NULL,'app','m150617_213829_update_email_settings','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','683225a3-c0bb-4705-a5aa-90e21c05d72e'),(10,NULL,'app','m150721_124739_templatecachequeries','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','12f9513f-d5ac-4a37-ad12-969096ff22ce'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','8de7513d-d8ba-454b-94a9-f1a0a5c1821e'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','b1ce1dbe-b2ed-41f9-ba61-6b124c6543d6'),(13,NULL,'app','m151002_095935_volume_cache_settings','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','6179bc98-517e-4c09-9e3e-3e8925aa5804'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','95f74440-ce57-488a-8e75-a8e306832d8e'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','1677ff1f-2635-4a5a-a993-87f9b69ed1ca'),(16,NULL,'app','m151209_000000_move_logo','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','e0bc82a2-19db-4878-9d26-85d6df0c99e4'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','ae63fc64-40b3-4359-bc2d-bbe959451833'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','a435ffa8-191e-42e6-b0e0-4c3406a69161'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','1388801d-4e18-489f-9ff6-50475e804cb6'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','19530577-152e-4efe-81a8-cd58f5d5b9e1'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','9a8754d6-3db7-4f32-8755-b1e17a15d6c4'),(22,NULL,'app','m160727_194637_column_cleanup','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','cb415e3a-c28b-49e0-881b-897fc5743a8d'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','0a9b65ce-b18d-473e-b578-41a09ee1154f'),(24,NULL,'app','m160807_144858_sites','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','90dcccc6-378f-4495-a4b9-dc648734e585'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','d2ba8daf-3f46-4e68-9c7c-837e65f25484'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','80ddb1fc-be35-41ad-bfd5-788d1078c2ae'),(27,NULL,'app','m160912_230520_require_entry_type_id','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','5c0fcf77-3047-4552-8edb-c698f464cf9f'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','4d156c24-5406-4356-ba90-b76295cb2497'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','88a5efef-b962-46ea-b3ef-9b3cc41a59b6'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','a72ecf41-e6d8-48e2-9245-afb1ef05982f'),(31,NULL,'app','m160925_113941_route_uri_parts','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','532dea1f-0199-48fd-99e9-565a005c3a70'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','6e5c083b-5dbd-4a8f-ba6c-ebae3d84064e'),(33,NULL,'app','m161007_130653_update_email_settings','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','fd4c2e9e-c978-4f16-b017-65f79de42e96'),(34,NULL,'app','m161013_175052_newParentId','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','4ca4763c-8da3-4c93-8265-bc1264115154'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','9b4fece7-90eb-43c1-b498-70930ac8a9ab'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','f516cffa-b545-4732-90d6-882e298a6632'),(37,NULL,'app','m161025_000000_fix_char_columns','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','944a9dca-567a-4ce0-941c-656001974f67'),(38,NULL,'app','m161029_124145_email_message_languages','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','91429442-6673-432d-a3b1-9906589779ca'),(39,NULL,'app','m161108_000000_new_version_format','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','fa1fd88e-ad40-4021-8e61-3a581d8a2c19'),(40,NULL,'app','m161109_000000_index_shuffle','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','00560cd0-c1ab-441f-ad7d-111e31274cd4'),(41,NULL,'app','m161122_185500_no_craft_app','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','765978d0-afdf-4d0f-8a6b-dc7ad7e2d79f'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','de2b973e-9d6a-468a-82fc-5dc2670b0f52'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','e1078c72-cff8-4a16-8c23-01ccf347847a'),(44,NULL,'app','m170114_161144_udates_permission','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','1f051212-b105-4068-9e16-0646ab80eacc'),(45,NULL,'app','m170120_000000_schema_cleanup','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','4f364abb-d8fe-4710-beb5-2f3bd1c272fd'),(46,NULL,'app','m170126_000000_assets_focal_point','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','5faf7a29-4c48-4882-8a8a-70b58908c001'),(47,NULL,'app','m170206_142126_system_name','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','bdd14e8b-bade-4fa9-8aa5-3072ecf29cc2'),(48,NULL,'app','m170217_044740_category_branch_limits','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','9ae23afe-fc58-4d53-b6c2-c2e9e5647109'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','574da196-18b7-4b71-a8b2-f2bee7581ee7'),(50,NULL,'app','m170223_224012_plain_text_settings','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','b2b8b830-c614-4315-b5ac-fe11947c8564'),(51,NULL,'app','m170227_120814_focal_point_percentage','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','71bfa2cc-e740-4756-b197-1d16f9db1b09'),(52,NULL,'app','m170228_171113_system_messages','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','5f86a71a-04e2-4a6b-953e-707a70c95aef'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','6db04338-5277-4464-8020-5a6dc3b78bfa'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','3c6f345e-f3b7-444f-a348-b4ec5a8e7d79'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','2df6dae2-5577-47e8-b124-1db7b83d66b2'),(56,NULL,'app','m170612_000000_route_index_shuffle','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','228ac991-3d31-42ee-92bd-3d3be1ee3eea'),(57,NULL,'app','m170621_195237_format_plugin_handles','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','d044ac64-30d0-4004-89d2-f8f7261637d1'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','6ed0ff17-f63b-48db-942b-baf3f32de904'),(59,NULL,'app','m170630_161028_deprecation_changes','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','113ac016-ace0-4f6e-b1fc-15f3a8eb3fb8'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','26b47824-0ba3-4c1a-9804-7889a68bee3a'),(61,NULL,'app','m170704_134916_sites_tables','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','67535f4e-476f-4344-ae8d-3e93761ec17c'),(62,NULL,'app','m170706_183216_rename_sequences','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','641480df-10d3-4071-be5e-1bd64d49cca7'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','f673e603-4d75-4af9-81f0-868e62670e73'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','908f0ef9-be30-41c4-b1b9-5b43c54164a1'),(65,NULL,'app','m170810_201318_create_queue_table','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','37a4e8ff-7502-4f51-bddd-3450935af48e'),(66,NULL,'app','m170903_192801_longblob_for_queue_jobs','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','2e44eaa1-4a6b-4b36-9929-f37b66a5966b'),(67,NULL,'app','m170914_204621_asset_cache_shuffle','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','ab54671b-97c5-40c0-bd02-a5aa9f271478'),(68,NULL,'app','m171011_214115_site_groups','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','6bc277dc-1fd3-423d-a95f-975421d79481'),(69,NULL,'app','m171012_151440_primary_site','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','46b830ab-a9d0-44d5-bb2a-44d422a16198'),(70,NULL,'app','m171013_142500_transform_interlace','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','7ce32598-48b8-43bf-8be6-c92d09f6e152'),(71,NULL,'app','m171016_092553_drop_position_select','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','29f8bbb7-08b6-472e-bd5e-39902083146c'),(72,NULL,'app','m171016_221244_less_strict_translation_method','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','61d9a4dc-cbcc-4948-bda1-e22b58790681'),(73,NULL,'app','m171107_000000_assign_group_permissions','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','73dfcd07-fab0-4a82-8cff-2ffa264011fa'),(74,NULL,'app','m171117_000001_templatecache_index_tune','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','34fb6449-be8a-4e55-9aa7-12bf3b169604'),(75,NULL,'app','m171126_105927_disabled_plugins','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','22bd2ecc-6e37-4ff0-b88f-407f0b501690'),(76,NULL,'app','m171130_214407_craftidtokens_table','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','53294d84-a2ea-4db5-9433-b119c7ff2f9f'),(77,NULL,'app','m171202_004225_update_email_settings','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','2650137d-5620-4dec-8b40-38b07c774c49'),(78,NULL,'app','m171204_000001_templatecache_index_tune_deux','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','eefe4581-a3fc-4f2a-bc6b-81f057ae816a'),(79,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','5f8b00c6-7a18-4823-9af8-54530615e3f8'),(80,NULL,'app','m171218_143135_longtext_query_column','2020-05-04 07:16:44','2020-05-04 07:16:44','2020-05-04 07:16:44','48efeb86-3dcf-40c1-9848-3db6a8ef5d13'),(81,NULL,'app','m171231_055546_environment_variables_to_aliases','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','439e72a9-e01a-48df-9017-5e003ee19e64'),(82,NULL,'app','m180113_153740_drop_users_archived_column','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','9505e23a-315a-4391-ae26-bff4f574e93f'),(83,NULL,'app','m180122_213433_propagate_entries_setting','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','e1cfe688-c872-41ae-98be-3ec580990bc1'),(84,NULL,'app','m180124_230459_fix_propagate_entries_values','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','c4be74b3-1e74-45f8-9c19-ca5572cd0f24'),(85,NULL,'app','m180128_235202_set_tag_slugs','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','afb73834-b9d3-40b5-8fe9-986116ee0385'),(86,NULL,'app','m180202_185551_fix_focal_points','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','1907c473-6b82-44a8-b7ab-6d65e90f0cea'),(87,NULL,'app','m180217_172123_tiny_ints','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','9aafb253-56b8-4c90-b8b5-fc98bbc5ad84'),(88,NULL,'app','m180321_233505_small_ints','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','b78c3b92-df85-478e-8023-d1b0909d7228'),(89,NULL,'app','m180328_115523_new_license_key_statuses','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','c75b45df-d504-4744-8238-04086a315299'),(90,NULL,'app','m180404_182320_edition_changes','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','a859ff8b-44e1-4317-9292-462bd71bda04'),(91,NULL,'app','m180411_102218_fix_db_routes','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','3a9d6dc8-3fce-4bef-9427-4bb68d6fb454'),(92,NULL,'app','m180416_205628_resourcepaths_table','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','cfdb012b-5ec6-4e7a-b1b7-ffad8bc65533'),(93,NULL,'app','m180418_205713_widget_cleanup','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','43fa4042-470b-4798-b23e-787cfcf26491'),(94,NULL,'app','m180425_203349_searchable_fields','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','acda9c9b-c62a-4a5f-8966-33b4d10ca476'),(95,NULL,'app','m180516_153000_uids_in_field_settings','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','84e343e9-6674-46bb-8c06-72bb43f7f221'),(96,NULL,'app','m180517_173000_user_photo_volume_to_uid','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','4eb58f9f-2f25-4249-95bc-a76503c5cce0'),(97,NULL,'app','m180518_173000_permissions_to_uid','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','0a1da31c-a5f9-4d7e-ba7d-8d01d1d5a9d2'),(98,NULL,'app','m180520_173000_matrix_context_to_uids','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','0ca1b1a1-17b6-43cf-b05e-24fc7a3274e2'),(99,NULL,'app','m180521_172900_project_config_table','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','e45a6496-27ae-4dd3-b681-58dd14ebb95d'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','5d5ed02d-fc76-4a76-a479-ba22fff4d7a5'),(101,NULL,'app','m180731_162030_soft_delete_sites','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','d9d525ee-8092-40b1-9ca0-13699f3350c7'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','35ebb456-f48b-4a96-877f-64bedf084b3e'),(103,NULL,'app','m180810_214439_soft_delete_elements','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','9235b696-e773-4af6-985c-aa7ab68f3548'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','6e91de8e-5bfd-47a6-a341-ab0ab842b6cd'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','df5fe4f6-9c84-4a5f-8b79-608b421fcd7a'),(106,NULL,'app','m180904_112109_permission_changes','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','ac8440d5-29ba-4d52-871c-aa607f90edd2'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','d2d9ae4a-6c61-410d-b300-090e748f89de'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','52159878-cc6e-4ee9-aee6-993f9ca2f129'),(109,NULL,'app','m181016_183648_set_default_user_settings','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','6db819dc-0e17-45d6-907e-9a291beba977'),(110,NULL,'app','m181017_225222_system_config_settings','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','427c7b06-a0c1-45bc-85a9-180a02dd7954'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','33e11889-2f83-4501-9ab2-92dfec485620'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','15074534-fb2d-42bc-9109-6579e8a5e5f0'),(113,NULL,'app','m181112_203955_sequences_table','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','031c5fca-f09d-4da7-afde-b08be083376e'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','e89c2bbb-4c06-451a-9909-d55ba9bb3ce8'),(115,NULL,'app','m181128_193942_fix_project_config','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','99817faa-719c-4e62-950e-81615c7f982c'),(116,NULL,'app','m181130_143040_fix_schema_version','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','469dcb71-ea22-470e-8c7c-4382e2bd8bbe'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','06bea183-6cdf-43fa-8e72-69f527aa4e06'),(118,NULL,'app','m181213_102500_config_map_aliases','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','d6c2dee0-9d9c-49f7-bcf3-f03814dc0547'),(119,NULL,'app','m181217_153000_fix_structure_uids','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','9b7998f3-59ae-4eb4-9495-32aaa8a94118'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','58dd4309-47c1-458c-bf3a-c9229ea4feec'),(121,NULL,'app','m190108_110000_cleanup_project_config','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','d4242537-54d8-4c3f-bc9e-f2bb46109fb0'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','a5247600-9a6b-4384-b1ae-5355ebe5d4ef'),(123,NULL,'app','m190109_172845_fix_colspan','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','598ca74f-1460-484d-bead-49993c365340'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','6d472239-a3bb-4594-beee-cd2f1fc46e39'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','baadb3c2-1ebe-4cbf-8eef-2b65e8d0e210'),(126,NULL,'app','m190112_124737_fix_user_settings','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','fa5713f4-f0d0-4f47-b60b-228e821e474e'),(127,NULL,'app','m190112_131225_fix_field_layouts','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','d6f5979b-b10c-42af-b346-9e50fa5b3f95'),(128,NULL,'app','m190112_201010_more_soft_deletes','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','de832be2-e1c5-4eb1-b23f-708a0ba07d30'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','f7c2b43c-56c9-45c7-8844-3517780517ac'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','eb44454d-6894-4db8-b6bc-c7910afea7eb'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','b420ac91-26a7-4742-8f53-2508950ca9da'),(132,NULL,'app','m190128_181422_cleanup_volume_folders','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','ad106aa1-c493-463d-bbde-4ad6087f6e41'),(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','a5176a07-0d03-431e-adeb-c91ee414ddc7'),(134,NULL,'app','m190208_140000_reset_project_config_mapping','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','ee4f3c0a-3aee-4fba-a7a7-8462717bf171'),(135,NULL,'app','m190218_143000_element_index_settings_uid','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','045dae60-a224-48e5-ab08-86ebaf0d8d02'),(136,NULL,'app','m190312_152740_element_revisions','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','a6f89cd1-3054-4c9e-b17a-1c65ca6d1bb8'),(137,NULL,'app','m190327_235137_propagation_method','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','302d3f95-cd31-4609-9e31-61355f757b6e'),(138,NULL,'app','m190401_223843_drop_old_indexes','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','6b23b955-f1a5-4874-8d2f-ec27d57d1d46'),(139,NULL,'app','m190416_014525_drop_unique_global_indexes','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','c46ebdbb-5b52-4933-9ab9-301aedc4673e'),(140,NULL,'app','m190417_085010_add_image_editor_permissions','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','5216a08d-1208-46d3-b576-c9dedb474308'),(141,NULL,'app','m190502_122019_store_default_user_group_uid','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','9ef9e09e-ef6f-4b4a-af0c-b786061413d1'),(142,NULL,'app','m190504_150349_preview_targets','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','a57db764-cc5a-4f74-afcd-66048e39e726'),(143,NULL,'app','m190516_184711_job_progress_label','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','a692d1aa-6d7c-422f-bcbe-810cb468c6e0'),(144,NULL,'app','m190523_190303_optional_revision_creators','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','e3efe04c-f3dc-4968-8f1f-bb8453779698'),(145,NULL,'app','m190529_204501_fix_duplicate_uids','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','efb9843a-2f36-4961-a0db-c9435033ceeb'),(146,NULL,'app','m190605_223807_unsaved_drafts','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','44e95892-9da8-4f10-a67f-03764b316a6c'),(147,NULL,'app','m190607_230042_entry_revision_error_tables','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','f7621623-a9ee-4d1f-8792-4f9051019f27'),(148,NULL,'app','m190608_033429_drop_elements_uid_idx','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','6f0332ed-c24c-40df-a3dc-ed73a61bc402'),(149,NULL,'app','m190617_164400_add_gqlschemas_table','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','7e7a6f35-7a32-4490-90f8-6751eaca98fd'),(150,NULL,'app','m190624_234204_matrix_propagation_method','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','358c9764-fa47-48ba-add3-78ad421c1399'),(151,NULL,'app','m190711_153020_drop_snapshots','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','a9eafef5-f2bf-4913-8251-e132c6fabd58'),(152,NULL,'app','m190712_195914_no_draft_revisions','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','402a3858-bba8-4dd1-ae46-cb07ffb38b05'),(153,NULL,'app','m190723_140314_fix_preview_targets_column','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','266ce53c-209c-43f4-b82a-9fd623925920'),(154,NULL,'app','m190820_003519_flush_compiled_templates','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','e903448f-fd7d-4262-83cb-98ad97923c39'),(155,NULL,'app','m190823_020339_optional_draft_creators','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','e6a0949c-cd68-4f72-aa7b-b9d4e400ef22'),(156,NULL,'app','m190913_152146_update_preview_targets','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','510ec2fc-291b-4c8d-adec-7dcbdc64bcc9'),(157,NULL,'app','m191107_122000_add_gql_project_config_support','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','e89e5e11-bde2-41d6-8ce8-cfb077a07d93'),(158,NULL,'app','m191204_085100_pack_savable_component_settings','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','20c4f0a3-e7ea-4bef-9f4e-20bce4501c23'),(159,NULL,'app','m191206_001148_change_tracking','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','49448977-c5ce-4ac8-9161-e4853f9e0060'),(160,NULL,'app','m191216_191635_asset_upload_tracking','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','ffc109cf-4b20-4d9d-ba6b-833b44b37678'),(161,NULL,'app','m191222_002848_peer_asset_permissions','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','a98d4413-d272-48a7-a0bc-e3e1a6eca4e0'),(162,NULL,'app','m200127_172522_queue_channels','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','ac22f506-0587-4c7d-a0fc-6226a8dfe34f'),(163,NULL,'app','m200211_175048_truncate_element_query_cache','2020-05-04 07:16:45','2020-05-04 07:16:45','2020-05-04 07:16:45','b4504cc6-6da1-4321-8662-87f417ac4bc2'),(164,NULL,'app','m200213_172522_new_elements_index','2020-05-04 07:16:46','2020-05-04 07:16:46','2020-05-04 07:16:46','483a9878-636c-4c04-b153-e4031b57f7a8'),(165,NULL,'app','m200228_195211_long_deprecation_messages','2020-05-04 07:16:46','2020-05-04 07:16:46','2020-05-04 07:16:46','4a5013b7-5eae-4f47-95e1-56d69a5a04ab'),(166,2,'plugin','m180430_204710_remove_old_plugins','2020-05-04 07:17:53','2020-05-04 07:17:53','2020-05-04 07:17:53','b2678c4b-2e56-4e7d-b2c8-3dc2323f4e89'),(167,2,'plugin','Install','2020-05-04 07:17:53','2020-05-04 07:17:53','2020-05-04 07:17:53','cd0ec98c-3425-4809-b5ea-8bff9ae31e01'),(168,2,'plugin','m190225_003922_split_cleanup_html_settings','2020-05-04 07:17:53','2020-05-04 07:17:53','2020-05-04 07:17:53','393de35e-2528-4e9e-b2ae-ee7b9d76daa4');
/*!40000 ALTER TABLE `cms_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_plugins`
--

DROP TABLE IF EXISTS `cms_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_plugins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_plugins`
--

LOCK TABLES `cms_plugins` WRITE;
/*!40000 ALTER TABLE `cms_plugins` DISABLE KEYS */;
INSERT INTO `cms_plugins` VALUES (1,'expanded-singles','1.1.2','1.0.0','unknown',NULL,'2020-05-04 07:17:38','2020-05-04 07:17:38','2020-05-04 07:17:56','14fd313f-0b86-4aca-a5fe-c59628dc9066'),(2,'redactor','2.6.1','2.3.0','unknown',NULL,'2020-05-04 07:17:53','2020-05-04 07:17:53','2020-05-04 07:17:56','0823e82e-d3c9-4c0f-9d6a-9529310c2aad');
/*!40000 ALTER TABLE `cms_plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_projectconfig`
--

DROP TABLE IF EXISTS `cms_projectconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_projectconfig`
--

LOCK TABLES `cms_projectconfig` WRITE;
/*!40000 ALTER TABLE `cms_projectconfig` DISABLE KEYS */;
INSERT INTO `cms_projectconfig` VALUES ('dateModified','1588576818'),('email.fromEmail','\"webmatser@benfeather.dev\"'),('email.fromName','\"Craft CMS\"'),('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"'),('fieldGroups.883ccb03-4728-4bb1-8464-bfd9e00f74c8.name','\"Common\"'),('plugins.expanded-singles.edition','\"standard\"'),('plugins.expanded-singles.enabled','true'),('plugins.expanded-singles.schemaVersion','\"1.0.0\"'),('plugins.redactor.edition','\"standard\"'),('plugins.redactor.enabled','true'),('plugins.redactor.schemaVersion','\"2.3.0\"'),('sections.ca71188c-277c-46e7-975d-eda2886a5bc6.enableVersioning','true'),('sections.ca71188c-277c-46e7-975d-eda2886a5bc6.entryTypes.a43275d4-73eb-4faa-8ed2-0d937b376691.handle','\"home\"'),('sections.ca71188c-277c-46e7-975d-eda2886a5bc6.entryTypes.a43275d4-73eb-4faa-8ed2-0d937b376691.hasTitleField','false'),('sections.ca71188c-277c-46e7-975d-eda2886a5bc6.entryTypes.a43275d4-73eb-4faa-8ed2-0d937b376691.name','\"Home\"'),('sections.ca71188c-277c-46e7-975d-eda2886a5bc6.entryTypes.a43275d4-73eb-4faa-8ed2-0d937b376691.sortOrder','1'),('sections.ca71188c-277c-46e7-975d-eda2886a5bc6.entryTypes.a43275d4-73eb-4faa-8ed2-0d937b376691.titleFormat','\"{section.name|raw}\"'),('sections.ca71188c-277c-46e7-975d-eda2886a5bc6.entryTypes.a43275d4-73eb-4faa-8ed2-0d937b376691.titleLabel','null'),('sections.ca71188c-277c-46e7-975d-eda2886a5bc6.handle','\"home\"'),('sections.ca71188c-277c-46e7-975d-eda2886a5bc6.name','\"Home\"'),('sections.ca71188c-277c-46e7-975d-eda2886a5bc6.propagationMethod','\"all\"'),('sections.ca71188c-277c-46e7-975d-eda2886a5bc6.siteSettings.3b1f3df8-1db2-492c-ad15-604d6da55014.enabledByDefault','true'),('sections.ca71188c-277c-46e7-975d-eda2886a5bc6.siteSettings.3b1f3df8-1db2-492c-ad15-604d6da55014.hasUrls','true'),('sections.ca71188c-277c-46e7-975d-eda2886a5bc6.siteSettings.3b1f3df8-1db2-492c-ad15-604d6da55014.template','\"index\"'),('sections.ca71188c-277c-46e7-975d-eda2886a5bc6.siteSettings.3b1f3df8-1db2-492c-ad15-604d6da55014.uriFormat','\"__home__\"'),('sections.ca71188c-277c-46e7-975d-eda2886a5bc6.type','\"single\"'),('siteGroups.1e714bfe-af5a-4381-bf4b-c86ee212a1ac.name','\"Craft CMS\"'),('sites.3b1f3df8-1db2-492c-ad15-604d6da55014.baseUrl','\"http://localhost:8000\"'),('sites.3b1f3df8-1db2-492c-ad15-604d6da55014.handle','\"default\"'),('sites.3b1f3df8-1db2-492c-ad15-604d6da55014.hasUrls','true'),('sites.3b1f3df8-1db2-492c-ad15-604d6da55014.language','\"en\"'),('sites.3b1f3df8-1db2-492c-ad15-604d6da55014.name','\"Craft CMS\"'),('sites.3b1f3df8-1db2-492c-ad15-604d6da55014.primary','true'),('sites.3b1f3df8-1db2-492c-ad15-604d6da55014.siteGroup','\"1e714bfe-af5a-4381-bf4b-c86ee212a1ac\"'),('sites.3b1f3df8-1db2-492c-ad15-604d6da55014.sortOrder','1'),('system.edition','\"solo\"'),('system.live','true'),('system.name','\"Craft CMS\"'),('system.schemaVersion','\"3.4.10\"'),('system.timeZone','\"America/Los_Angeles\"'),('users.allowPublicRegistration','false'),('users.defaultGroup','null'),('users.photoSubpath','\"\"'),('users.photoVolumeUid','null'),('users.requireEmailVerification','true'),('volumes.e499ecca-7863-4664-8a2d-b8365aaaf995.handle','\"uploads\"'),('volumes.e499ecca-7863-4664-8a2d-b8365aaaf995.hasUrls','true'),('volumes.e499ecca-7863-4664-8a2d-b8365aaaf995.name','\"Uploads\"'),('volumes.e499ecca-7863-4664-8a2d-b8365aaaf995.settings.path','\"@webroot/uploads\"'),('volumes.e499ecca-7863-4664-8a2d-b8365aaaf995.sortOrder','1'),('volumes.e499ecca-7863-4664-8a2d-b8365aaaf995.type','\"craft\\\\volumes\\\\Local\"'),('volumes.e499ecca-7863-4664-8a2d-b8365aaaf995.url','\"@web/uploads\"');
/*!40000 ALTER TABLE `cms_projectconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_queue`
--

DROP TABLE IF EXISTS `cms_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_queue` (
  `id` int NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int NOT NULL,
  `ttr` int NOT NULL,
  `delay` int NOT NULL DEFAULT '0',
  `priority` int unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int DEFAULT NULL,
  `progress` smallint NOT NULL DEFAULT '0',
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `cms_queue_channel_fail_timeUpdated_timePushed_idx` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `cms_queue_channel_fail_timeUpdated_delay_idx` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_queue`
--

LOCK TABLES `cms_queue` WRITE;
/*!40000 ALTER TABLE `cms_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_relations`
--

DROP TABLE IF EXISTS `cms_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_relations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldId` int NOT NULL,
  `sourceId` int NOT NULL,
  `sourceSiteId` int DEFAULT NULL,
  `targetId` int NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `cms_relations_sourceId_idx` (`sourceId`),
  KEY `cms_relations_targetId_idx` (`targetId`),
  KEY `cms_relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `cms_relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `cms_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `cms_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `cms_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cms_relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `cms_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_relations`
--

LOCK TABLES `cms_relations` WRITE;
/*!40000 ALTER TABLE `cms_relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_resourcepaths`
--

DROP TABLE IF EXISTS `cms_resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_resourcepaths`
--

LOCK TABLES `cms_resourcepaths` WRITE;
/*!40000 ALTER TABLE `cms_resourcepaths` DISABLE KEYS */;
INSERT INTO `cms_resourcepaths` VALUES ('15fb24ba','@app/web/assets/craftsupport/dist'),('1b54a604','@craft/web/assets/editsection/dist'),('1b69887b','@app/web/assets/updateswidget/dist'),('23a6a0b3','@app/web/assets/pluginstore/dist'),('240fa89b','@lib/vue'),('25d3ca15','@app/web/assets/recententries/dist'),('2901e9','@craft/web/assets/feed/dist'),('3334ba7','@lib/jquery-ui'),('389eed98','@app/web/assets/cp/dist'),('3f3c3cad','@craft/web/assets/craftsupport/dist'),('4185a626','@app/web/assets/feed/dist'),('4d9ad002','@lib/velocity'),('51bd7fea','@lib/jquery.payment'),('5c15277f','@bower/jquery/dist'),('73858c8a','@lib/element-resize-detector'),('796a2722','@craft/web/assets/dashboard/dist'),('82ee1335','@craft/web/assets/cp/dist'),('84c1367c','@lib/selectize'),('8b952348','@craft/web/assets/pluginstore/dist'),('8ead72f6','@lib/xregexp'),('9890caa4','@craft/web/assets/updateswidget/dist'),('9e40bee','@lib/axios'),('a62a88ca','@craft/web/assets/recententries/dist'),('afe9ce95','@craft/web/assets/updater/dist'),('b3cda44','@app/web/assets/updater/dist'),('c8571a06','@lib/fileupload'),('d0bf1bf8','@lib/picturefill'),('d59d2db3','@lib/prismjs'),('d71b273a','@lib/jquery-touch-events'),('d81c2bff','@craft/web/assets/utilities/dist'),('de1a3ba9','@lib/d3'),('eda72c2f','@lib/garnishjs'),('f10ac929','@craft/web/assets/admintable/dist'),('f8e1f811','@lib/fabric'),('fb93a3d4','@app/web/assets/dashboard/dist');
/*!40000 ALTER TABLE `cms_resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_revisions`
--

DROP TABLE IF EXISTS `cms_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_revisions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sourceId` int NOT NULL,
  `creatorId` int DEFAULT NULL,
  `num` int NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `cms_revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `cms_revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `cms_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cms_revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `cms_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_revisions`
--

LOCK TABLES `cms_revisions` WRITE;
/*!40000 ALTER TABLE `cms_revisions` DISABLE KEYS */;
INSERT INTO `cms_revisions` VALUES (1,2,1,1,NULL);
/*!40000 ALTER TABLE `cms_revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_searchindex`
--

DROP TABLE IF EXISTS `cms_searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_searchindex` (
  `elementId` int NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int NOT NULL,
  `siteId` int NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `cms_searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_searchindex`
--

LOCK TABLES `cms_searchindex` WRITE;
/*!40000 ALTER TABLE `cms_searchindex` DISABLE KEYS */;
INSERT INTO `cms_searchindex` VALUES (1,'username',0,1,' admin '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' webmatser benfeather dev '),(1,'slug',0,1,''),(2,'title',0,1,' home '),(2,'slug',0,1,' home ');
/*!40000 ALTER TABLE `cms_searchindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_sections`
--

DROP TABLE IF EXISTS `cms_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_sections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_sections_handle_idx` (`handle`),
  KEY `cms_sections_name_idx` (`name`),
  KEY `cms_sections_structureId_idx` (`structureId`),
  KEY `cms_sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `cms_sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `cms_structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_sections`
--

LOCK TABLES `cms_sections` WRITE;
/*!40000 ALTER TABLE `cms_sections` DISABLE KEYS */;
INSERT INTO `cms_sections` VALUES (1,NULL,'Home','home','single',1,'all',NULL,'2020-05-04 07:18:22','2020-05-04 07:18:22',NULL,'ca71188c-277c-46e7-975d-eda2886a5bc6');
/*!40000 ALTER TABLE `cms_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_sections_sites`
--

DROP TABLE IF EXISTS `cms_sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_sections_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sectionId` int NOT NULL,
  `siteId` int NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `cms_sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `cms_sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `cms_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `cms_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_sections_sites`
--

LOCK TABLES `cms_sections_sites` WRITE;
/*!40000 ALTER TABLE `cms_sections_sites` DISABLE KEYS */;
INSERT INTO `cms_sections_sites` VALUES (1,1,1,1,'__home__','index',1,'2020-05-04 07:18:22','2020-05-04 07:18:22','c616f807-635e-408d-b621-12fdeb8df920');
/*!40000 ALTER TABLE `cms_sections_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_sequences`
--

DROP TABLE IF EXISTS `cms_sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_sequences` (
  `name` varchar(255) NOT NULL,
  `next` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_sequences`
--

LOCK TABLES `cms_sequences` WRITE;
/*!40000 ALTER TABLE `cms_sequences` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_sequences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_sessions`
--

DROP TABLE IF EXISTS `cms_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_sessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_sessions_uid_idx` (`uid`),
  KEY `cms_sessions_token_idx` (`token`),
  KEY `cms_sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `cms_sessions_userId_idx` (`userId`),
  CONSTRAINT `cms_sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `cms_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_sessions`
--

LOCK TABLES `cms_sessions` WRITE;
/*!40000 ALTER TABLE `cms_sessions` DISABLE KEYS */;
INSERT INTO `cms_sessions` VALUES (1,1,'4PNNqNYxAsKrAlggdFiuG7YGci1abFrJmlzSUFBsKnhgXYSheXf1rDYPiP3guDvIszJVI0CaaMv_SJVzYSe4oceSROOG_TTTaKLa','2020-05-04 07:16:43','2020-05-04 07:20:46','19e4cb0a-1645-4979-a572-eb8aa54cd089');
/*!40000 ALTER TABLE `cms_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_shunnedmessages`
--

DROP TABLE IF EXISTS `cms_shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_shunnedmessages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `cms_shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `cms_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_shunnedmessages`
--

LOCK TABLES `cms_shunnedmessages` WRITE;
/*!40000 ALTER TABLE `cms_shunnedmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_sitegroups`
--

DROP TABLE IF EXISTS `cms_sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_sitegroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_sitegroups`
--

LOCK TABLES `cms_sitegroups` WRITE;
/*!40000 ALTER TABLE `cms_sitegroups` DISABLE KEYS */;
INSERT INTO `cms_sitegroups` VALUES (1,'Craft CMS','2020-05-04 07:16:43','2020-05-04 07:16:43',NULL,'1e714bfe-af5a-4381-bf4b-c86ee212a1ac');
/*!40000 ALTER TABLE `cms_sitegroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_sites`
--

DROP TABLE IF EXISTS `cms_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_sites_dateDeleted_idx` (`dateDeleted`),
  KEY `cms_sites_handle_idx` (`handle`),
  KEY `cms_sites_sortOrder_idx` (`sortOrder`),
  KEY `cms_sites_groupId_fk` (`groupId`),
  CONSTRAINT `cms_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `cms_sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_sites`
--

LOCK TABLES `cms_sites` WRITE;
/*!40000 ALTER TABLE `cms_sites` DISABLE KEYS */;
INSERT INTO `cms_sites` VALUES (1,1,1,'Craft CMS','default','en',1,'http://localhost:8000',1,'2020-05-04 07:16:43','2020-05-04 07:16:43',NULL,'3b1f3df8-1db2-492c-ad15-604d6da55014');
/*!40000 ALTER TABLE `cms_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_structureelements`
--

DROP TABLE IF EXISTS `cms_structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_structureelements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int NOT NULL,
  `elementId` int DEFAULT NULL,
  `root` int unsigned DEFAULT NULL,
  `lft` int unsigned NOT NULL,
  `rgt` int unsigned NOT NULL,
  `level` smallint unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `cms_structureelements_root_idx` (`root`),
  KEY `cms_structureelements_lft_idx` (`lft`),
  KEY `cms_structureelements_rgt_idx` (`rgt`),
  KEY `cms_structureelements_level_idx` (`level`),
  KEY `cms_structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `cms_structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `cms_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `cms_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_structureelements`
--

LOCK TABLES `cms_structureelements` WRITE;
/*!40000 ALTER TABLE `cms_structureelements` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_structureelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_structures`
--

DROP TABLE IF EXISTS `cms_structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_structures` (
  `id` int NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_structures`
--

LOCK TABLES `cms_structures` WRITE;
/*!40000 ALTER TABLE `cms_structures` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_structures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_systemmessages`
--

DROP TABLE IF EXISTS `cms_systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_systemmessages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `cms_systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_systemmessages`
--

LOCK TABLES `cms_systemmessages` WRITE;
/*!40000 ALTER TABLE `cms_systemmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_systemmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_taggroups`
--

DROP TABLE IF EXISTS `cms_taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_taggroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_taggroups_name_idx` (`name`),
  KEY `cms_taggroups_handle_idx` (`handle`),
  KEY `cms_taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `cms_taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `cms_taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `cms_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_taggroups`
--

LOCK TABLES `cms_taggroups` WRITE;
/*!40000 ALTER TABLE `cms_taggroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_taggroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_tags`
--

DROP TABLE IF EXISTS `cms_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_tags` (
  `id` int NOT NULL,
  `groupId` int NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_tags_groupId_idx` (`groupId`),
  CONSTRAINT `cms_tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `cms_taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_tags_id_fk` FOREIGN KEY (`id`) REFERENCES `cms_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_tags`
--

LOCK TABLES `cms_tags` WRITE;
/*!40000 ALTER TABLE `cms_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_templatecacheelements`
--

DROP TABLE IF EXISTS `cms_templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_templatecacheelements` (
  `cacheId` int NOT NULL,
  `elementId` int NOT NULL,
  KEY `cms_templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `cms_templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `cms_templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `cms_templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `cms_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_templatecacheelements`
--

LOCK TABLES `cms_templatecacheelements` WRITE;
/*!40000 ALTER TABLE `cms_templatecacheelements` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_templatecacheelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_templatecachequeries`
--

DROP TABLE IF EXISTS `cms_templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_templatecachequeries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cacheId` int NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `cms_templatecachequeries_type_idx` (`type`),
  CONSTRAINT `cms_templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `cms_templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_templatecachequeries`
--

LOCK TABLES `cms_templatecachequeries` WRITE;
/*!40000 ALTER TABLE `cms_templatecachequeries` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_templatecachequeries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_templatecaches`
--

DROP TABLE IF EXISTS `cms_templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_templatecaches` (
  `id` int NOT NULL AUTO_INCREMENT,
  `siteId` int NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `cms_templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `cms_templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `cms_templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `cms_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_templatecaches`
--

LOCK TABLES `cms_templatecaches` WRITE;
/*!40000 ALTER TABLE `cms_templatecaches` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_templatecaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_tokens`
--

DROP TABLE IF EXISTS `cms_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint unsigned DEFAULT NULL,
  `usageCount` tinyint unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_tokens_token_unq_idx` (`token`),
  KEY `cms_tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_tokens`
--

LOCK TABLES `cms_tokens` WRITE;
/*!40000 ALTER TABLE `cms_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_usergroups`
--

DROP TABLE IF EXISTS `cms_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_usergroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `cms_usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_usergroups`
--

LOCK TABLES `cms_usergroups` WRITE;
/*!40000 ALTER TABLE `cms_usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_usergroups_users`
--

DROP TABLE IF EXISTS `cms_usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_usergroups_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `userId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `cms_usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `cms_usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `cms_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `cms_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_usergroups_users`
--

LOCK TABLES `cms_usergroups_users` WRITE;
/*!40000 ALTER TABLE `cms_usergroups_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_userpermissions`
--

DROP TABLE IF EXISTS `cms_userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_userpermissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_userpermissions`
--

LOCK TABLES `cms_userpermissions` WRITE;
/*!40000 ALTER TABLE `cms_userpermissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_userpermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_userpermissions_usergroups`
--

DROP TABLE IF EXISTS `cms_userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_userpermissions_usergroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permissionId` int NOT NULL,
  `groupId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `cms_userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `cms_userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `cms_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `cms_userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_userpermissions_usergroups`
--

LOCK TABLES `cms_userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `cms_userpermissions_usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_userpermissions_users`
--

DROP TABLE IF EXISTS `cms_userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_userpermissions_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permissionId` int NOT NULL,
  `userId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `cms_userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `cms_userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `cms_userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `cms_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_userpermissions_users`
--

LOCK TABLES `cms_userpermissions_users` WRITE;
/*!40000 ALTER TABLE `cms_userpermissions_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_userpreferences`
--

DROP TABLE IF EXISTS `cms_userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_userpreferences` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `cms_userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `cms_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_userpreferences`
--

LOCK TABLES `cms_userpreferences` WRITE;
/*!40000 ALTER TABLE `cms_userpreferences` DISABLE KEYS */;
INSERT INTO `cms_userpreferences` VALUES (1,'{\"language\":\"en\"}');
/*!40000 ALTER TABLE `cms_userpreferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_users`
--

DROP TABLE IF EXISTS `cms_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_users` (
  `id` int NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_users_uid_idx` (`uid`),
  KEY `cms_users_verificationCode_idx` (`verificationCode`),
  KEY `cms_users_email_idx` (`email`),
  KEY `cms_users_username_idx` (`username`),
  KEY `cms_users_photoId_fk` (`photoId`),
  CONSTRAINT `cms_users_id_fk` FOREIGN KEY (`id`) REFERENCES `cms_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `cms_assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_users`
--

LOCK TABLES `cms_users` WRITE;
/*!40000 ALTER TABLE `cms_users` DISABLE KEYS */;
INSERT INTO `cms_users` VALUES (1,'admin',NULL,NULL,NULL,'webmatser@benfeather.dev','$2y$13$6APa9eknuzI5Ro0ms1LR0eUIx1x.MNnYxOJYEogrpKN.h9atWDH2K',1,0,0,0,'2020-05-04 07:16:43',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2020-05-04 07:16:43','2020-05-04 07:16:43','2020-05-04 07:16:47','92204d17-7714-488e-960e-b68e0d8e5968');
/*!40000 ALTER TABLE `cms_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_volumefolders`
--

DROP TABLE IF EXISTS `cms_volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_volumefolders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parentId` int DEFAULT NULL,
  `volumeId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `cms_volumefolders_parentId_idx` (`parentId`),
  KEY `cms_volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `cms_volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `cms_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `cms_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_volumefolders`
--

LOCK TABLES `cms_volumefolders` WRITE;
/*!40000 ALTER TABLE `cms_volumefolders` DISABLE KEYS */;
INSERT INTO `cms_volumefolders` VALUES (1,NULL,1,'Uploads','','2020-05-04 07:20:18','2020-05-04 07:20:18','2e89d667-be73-44e3-b5c7-0cd676027db2'),(2,NULL,NULL,'Temporary source',NULL,'2020-05-04 07:20:41','2020-05-04 07:20:41','d4d29862-e8f5-4316-9fe6-30bd3df26384'),(3,2,NULL,'user_1','user_1/','2020-05-04 07:20:41','2020-05-04 07:20:41','acb62ceb-a479-4eba-afd7-08709cc4acea');
/*!40000 ALTER TABLE `cms_volumefolders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_volumes`
--

DROP TABLE IF EXISTS `cms_volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_volumes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_volumes_name_idx` (`name`),
  KEY `cms_volumes_handle_idx` (`handle`),
  KEY `cms_volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `cms_volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `cms_volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `cms_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_volumes`
--

LOCK TABLES `cms_volumes` WRITE;
/*!40000 ALTER TABLE `cms_volumes` DISABLE KEYS */;
INSERT INTO `cms_volumes` VALUES (1,NULL,'Uploads','uploads','craft\\volumes\\Local',1,'@web/uploads','{\"path\":\"@webroot/uploads\"}',1,'2020-05-04 07:20:18','2020-05-04 07:20:18',NULL,'e499ecca-7863-4664-8a2d-b8365aaaf995');
/*!40000 ALTER TABLE `cms_volumes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_widgets`
--

DROP TABLE IF EXISTS `cms_widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_widgets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `colspan` tinyint DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cms_widgets_userId_idx` (`userId`),
  CONSTRAINT `cms_widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `cms_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_widgets`
--

LOCK TABLES `cms_widgets` WRITE;
/*!40000 ALTER TABLE `cms_widgets` DISABLE KEYS */;
INSERT INTO `cms_widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2020-05-04 07:16:47','2020-05-04 07:16:47','15c14156-f4bc-49b2-8397-6f4576135470'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2020-05-04 07:16:47','2020-05-04 07:16:47','02847d70-ea1b-435e-ba7a-8f0948bf418f'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2020-05-04 07:16:47','2020-05-04 07:16:47','95bde5fa-ca74-4f13-a61e-26288f0cb165'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2020-05-04 07:16:47','2020-05-04 07:16:47','d1d18d6e-3abd-425b-82c4-7d1b75705a9f');
/*!40000 ALTER TABLE `cms_widgets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-04  7:21:41
