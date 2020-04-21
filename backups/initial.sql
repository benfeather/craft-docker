-- MySQL dump 10.13  Distrib 8.0.19, for Linux (x86_64)
--
-- Host: localhost    Database: project
-- ------------------------------------------------------
-- Server version	8.0.19

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_content`
--

LOCK TABLES `cms_content` WRITE;
/*!40000 ALTER TABLE `cms_content` DISABLE KEYS */;
INSERT INTO `cms_content` VALUES (1,1,1,NULL,'2020-04-20 08:08:31','2020-04-20 08:08:31','00da0497-991f-42ff-8f7e-c032c27de3ca');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_elements`
--

LOCK TABLES `cms_elements` WRITE;
/*!40000 ALTER TABLE `cms_elements` DISABLE KEYS */;
INSERT INTO `cms_elements` VALUES (1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2020-04-20 08:08:31','2020-04-20 08:08:31',NULL,'41a31345-1cc3-4e39-92e3-146546ecc14b');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_elements_sites`
--

LOCK TABLES `cms_elements_sites` WRITE;
/*!40000 ALTER TABLE `cms_elements_sites` DISABLE KEYS */;
INSERT INTO `cms_elements_sites` VALUES (1,1,1,NULL,NULL,1,'2020-04-20 08:08:31','2020-04-20 08:08:31','cd552d17-57be-4fbc-863f-17b6395f432e');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_entrytypes`
--

LOCK TABLES `cms_entrytypes` WRITE;
/*!40000 ALTER TABLE `cms_entrytypes` DISABLE KEYS */;
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
INSERT INTO `cms_fieldgroups` VALUES (1,'Common','2020-04-20 08:08:31','2020-04-20 08:08:31','bcd0e092-3aa3-4ddf-825a-f98ffc41ebb0');
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
INSERT INTO `cms_info` VALUES (1,'3.4.15','3.4.10',0,'[]','SxLdKBREWLL5','2020-04-20 08:08:31','2020-04-20 08:08:31','5b880dd2-0e78-4299-ab95-34d00c935789');
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
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_migrations`
--

LOCK TABLES `cms_migrations` WRITE;
/*!40000 ALTER TABLE `cms_migrations` DISABLE KEYS */;
INSERT INTO `cms_migrations` VALUES (1,NULL,'app','Install','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','f0cbe638-403d-4841-aa17-369368b54f6e'),(2,NULL,'app','m150403_183908_migrations_table_changes','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','ee025b0d-969c-48af-b08a-b6ff910e2c12'),(3,NULL,'app','m150403_184247_plugins_table_changes','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','d4b939aa-29ab-4593-8821-a6f0657e0df0'),(4,NULL,'app','m150403_184533_field_version','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','cd0f1d6a-9a0c-46e8-aa0f-99946005c7e0'),(5,NULL,'app','m150403_184729_type_columns','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','c65ae977-a4a9-498d-9f53-86aab25a66d3'),(6,NULL,'app','m150403_185142_volumes','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','f1865954-05ab-498f-9b0b-fac5665cafdd'),(7,NULL,'app','m150428_231346_userpreferences','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','7274c788-f465-429b-b18a-50cb6379cb61'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','383163cc-a520-4ead-91cb-d7e87b96515e'),(9,NULL,'app','m150617_213829_update_email_settings','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','46d1c582-41d5-422f-af97-39c5ab6e7beb'),(10,NULL,'app','m150721_124739_templatecachequeries','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','e8743efe-5311-453d-9e0d-d47b08280d90'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','216600c5-8930-4bf3-89df-96015d6ed8f5'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','a5682607-4c4d-45b0-bab1-bdb8bd6de7cd'),(13,NULL,'app','m151002_095935_volume_cache_settings','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','1863a13c-5c90-4974-80c5-a16255508e19'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','6cd6dc18-79bb-47db-84f2-71dfdef94f99'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','f6c2dcc8-4cb8-409d-a61c-b02dc2b4c68a'),(16,NULL,'app','m151209_000000_move_logo','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','8be37cc2-93ef-45a0-b281-d7d4ee8a5283'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','997dc56e-cbfd-4473-a8f4-a3709612559e'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','4bd4d8bd-1541-4c24-a5a5-e8a1733e6625'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','06148eec-d785-4634-bdd1-0f100649537a'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','056a55ac-9c47-4164-af5f-c65298fc335d'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','e090a5da-6a3b-43f6-913d-316babaac39f'),(22,NULL,'app','m160727_194637_column_cleanup','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','6e2bf528-981a-4caa-b1b7-37cc383cde8d'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','f7ebbe27-e05f-40f1-9c15-2b71b2e54aec'),(24,NULL,'app','m160807_144858_sites','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','62123639-8d74-4fff-a19f-1e10b412c077'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','bd22c538-c6de-4dd0-a2fc-b4ab0e90bf98'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','660af31d-ee7e-4b20-b0ee-3aa4d971d72b'),(27,NULL,'app','m160912_230520_require_entry_type_id','2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:31','279ffb36-90e8-4c6c-a3ed-d0658938e917'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','8eccb048-81a9-4ae8-a363-5e58a48aab1d'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','098669c1-0223-41ff-abd8-6b832d00e23c'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','db162d10-9e4e-4347-b55e-f12905ef99f3'),(31,NULL,'app','m160925_113941_route_uri_parts','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','7023d3bc-85d9-46e8-9b64-47517a8d186e'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','29ddf380-f81c-4761-8fde-1861993b9744'),(33,NULL,'app','m161007_130653_update_email_settings','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','c2014294-bca9-4e56-bfaf-2d4c207bd4dc'),(34,NULL,'app','m161013_175052_newParentId','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','f9220752-000a-4f3b-844e-28a817dd31a8'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','361c8170-22a9-4d5d-8211-c1df26f0c58b'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','206c32d0-17c7-4e16-bfba-633281af63f2'),(37,NULL,'app','m161025_000000_fix_char_columns','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','c9bfada3-1348-49e9-a752-11fddaac1d01'),(38,NULL,'app','m161029_124145_email_message_languages','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','51913bd1-727c-4bb8-8fbd-924ce8a717bb'),(39,NULL,'app','m161108_000000_new_version_format','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','ffd3dfc2-f16a-419d-80b7-bec0105b98b6'),(40,NULL,'app','m161109_000000_index_shuffle','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','35c2c477-8eee-4960-a01c-d0f1a4f18f21'),(41,NULL,'app','m161122_185500_no_craft_app','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','85a658cc-e187-4472-bd60-b38b638a426e'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','fe912a65-15c1-49c1-b1a0-ef221d6fe29b'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','fabd22a7-4fd8-486f-948c-3eb14c4135ef'),(44,NULL,'app','m170114_161144_udates_permission','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','5e28f1d3-b39b-4e18-b8af-8b4fb51d9ce7'),(45,NULL,'app','m170120_000000_schema_cleanup','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','657db65e-2ada-441e-a5d2-b34d889601e3'),(46,NULL,'app','m170126_000000_assets_focal_point','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','e58c94d0-c724-467f-98a3-af7d0e40b34c'),(47,NULL,'app','m170206_142126_system_name','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','3a7141a7-b149-4864-9acd-4143ff109ffb'),(48,NULL,'app','m170217_044740_category_branch_limits','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','485a3dea-66a3-4923-aa91-d2ca13d96363'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','27a74f01-0715-4bc9-b760-996b11a1e5e0'),(50,NULL,'app','m170223_224012_plain_text_settings','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','f685c846-7fe5-45a0-bb91-ef064e83b4d2'),(51,NULL,'app','m170227_120814_focal_point_percentage','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','2c785a8f-c521-40a4-bc5d-440a09ca4012'),(52,NULL,'app','m170228_171113_system_messages','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','d4c08c35-48a9-4a55-9c2a-d9d596723503'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','5aa9a8ee-d2eb-43b7-8aae-8c4bb93e0097'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','da2ed58b-547b-4411-b254-ffc9c65fb0a4'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','849abdff-7c35-4f23-8118-0974986d3dab'),(56,NULL,'app','m170612_000000_route_index_shuffle','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','68554392-70d4-4914-8ee7-30d95656e9ef'),(57,NULL,'app','m170621_195237_format_plugin_handles','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','80074dcc-0fcf-4621-8c32-f8abd98479ad'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','1e4e959a-cd82-4901-820f-27d477999a54'),(59,NULL,'app','m170630_161028_deprecation_changes','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','0e77e46d-b20e-4a41-9d09-c8e824b3eb5a'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','2e91fcce-d3d9-44a7-bf65-6769062b7569'),(61,NULL,'app','m170704_134916_sites_tables','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','5d42db19-a2e9-4279-9c6c-e13328d00c47'),(62,NULL,'app','m170706_183216_rename_sequences','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','c45d0781-8fdc-4938-91ca-a6f4f35313e9'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','c3c9b282-05a8-4d04-9db7-7eb3036137ce'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','42925f02-3095-48ca-bccf-69461b3cf5d4'),(65,NULL,'app','m170810_201318_create_queue_table','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','a685148a-1140-4288-861a-572600b27736'),(66,NULL,'app','m170903_192801_longblob_for_queue_jobs','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','8d9c5ac9-f130-4451-98c6-5b47e24b67e4'),(67,NULL,'app','m170914_204621_asset_cache_shuffle','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','0a474e6f-6fc2-414a-9a8a-0bcdd0558e39'),(68,NULL,'app','m171011_214115_site_groups','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','c92a23ea-6c7a-4bbd-90ce-5adadebcfffe'),(69,NULL,'app','m171012_151440_primary_site','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','7255a889-e5d8-48b4-aa62-b3f1ae6846f8'),(70,NULL,'app','m171013_142500_transform_interlace','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','9fea3d2d-8289-466e-95c5-d4826224cf97'),(71,NULL,'app','m171016_092553_drop_position_select','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','ae0a3020-4799-45ad-9c54-9da8bdec51b2'),(72,NULL,'app','m171016_221244_less_strict_translation_method','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','369fd960-5ef3-45f6-b3a8-7ec839e54200'),(73,NULL,'app','m171107_000000_assign_group_permissions','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','8c6d047c-d632-43e5-84fb-c77e14e1713f'),(74,NULL,'app','m171117_000001_templatecache_index_tune','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','63911072-9fad-4ce9-83b6-9a5ed1b3cd24'),(75,NULL,'app','m171126_105927_disabled_plugins','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','d80573ab-cabb-4dcd-8eb5-050375d3db8a'),(76,NULL,'app','m171130_214407_craftidtokens_table','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','1a54140b-8584-4551-a4f7-a0b7159734aa'),(77,NULL,'app','m171202_004225_update_email_settings','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','311bd001-3124-4764-a730-6e58eb3f7b6a'),(78,NULL,'app','m171204_000001_templatecache_index_tune_deux','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','c402c0ac-9790-40d6-9e0b-2e8b3e71f2f0'),(79,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','48c5d821-397d-4f00-ba2b-8db6c1c3ffc1'),(80,NULL,'app','m171218_143135_longtext_query_column','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','a7590f08-ece1-4537-8f75-ec8d2ff45212'),(81,NULL,'app','m171231_055546_environment_variables_to_aliases','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','4cda03eb-0f7a-41a8-9c2c-5c455c7ba0c5'),(82,NULL,'app','m180113_153740_drop_users_archived_column','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','f5a86dbf-bedf-42c3-8605-0d51454314ea'),(83,NULL,'app','m180122_213433_propagate_entries_setting','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','66320bfc-7b36-4d09-ada9-d8909b982e5a'),(84,NULL,'app','m180124_230459_fix_propagate_entries_values','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','5127aad7-d565-4e6f-b5cf-f4babd067a69'),(85,NULL,'app','m180128_235202_set_tag_slugs','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','5ba6771d-cd0a-4504-b87c-fd8a50a4e771'),(86,NULL,'app','m180202_185551_fix_focal_points','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','477b812a-373d-4177-8177-85985649e477'),(87,NULL,'app','m180217_172123_tiny_ints','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','62276054-5d86-427a-a8c9-94cd48bcf7fb'),(88,NULL,'app','m180321_233505_small_ints','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','d0dbfaa8-c3ac-47b4-9e1b-f7a5583e2d64'),(89,NULL,'app','m180328_115523_new_license_key_statuses','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','0fa89827-4cf5-40b2-86e5-71072db11e11'),(90,NULL,'app','m180404_182320_edition_changes','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','2bd4a906-9eca-4010-8bbd-1099683eb874'),(91,NULL,'app','m180411_102218_fix_db_routes','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','169fb9a2-01cf-45da-be9c-0d9a6acc1f14'),(92,NULL,'app','m180416_205628_resourcepaths_table','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','dd41b74a-5bc7-48a5-856e-66b7f1a1c253'),(93,NULL,'app','m180418_205713_widget_cleanup','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','5de69e60-4768-49e6-afc0-985b2cc0a2df'),(94,NULL,'app','m180425_203349_searchable_fields','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','10402c7f-af1e-481e-b266-c82f06f37a00'),(95,NULL,'app','m180516_153000_uids_in_field_settings','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','baab115d-4dba-46c5-abac-be98d185cc64'),(96,NULL,'app','m180517_173000_user_photo_volume_to_uid','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','66b7292a-9a5c-48db-ab8e-8317afbf1462'),(97,NULL,'app','m180518_173000_permissions_to_uid','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','7e18bc7d-9e17-4448-a3ce-fde7fd1ba116'),(98,NULL,'app','m180520_173000_matrix_context_to_uids','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','ce0e7158-0696-4605-8c79-553c17026e7f'),(99,NULL,'app','m180521_172900_project_config_table','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','381463dc-85e0-493a-b69d-2175a06cd703'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','280cdd89-88b3-4e8f-8c17-8aabcffbe886'),(101,NULL,'app','m180731_162030_soft_delete_sites','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','f4dff877-7b53-46a9-a988-7b8b3cd9ccbf'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','7f99febe-1835-4e22-8019-a759f91cd284'),(103,NULL,'app','m180810_214439_soft_delete_elements','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','6b50422a-daaa-4918-a308-1e45efa6527a'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','f0cd923e-654a-4d84-9398-3686d1e3338a'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','95398ba6-c06b-4348-b712-682ed5d09df9'),(106,NULL,'app','m180904_112109_permission_changes','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','394b6a4e-74d8-48b9-ae77-ed467367dc30'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','14166e5f-451a-4231-bf26-6488ee51e3bb'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','7dd1f547-64db-4922-ae99-ce8357e847fb'),(109,NULL,'app','m181016_183648_set_default_user_settings','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','fa04fc5d-5e11-4121-b9c1-88efa250eec7'),(110,NULL,'app','m181017_225222_system_config_settings','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','92781e07-77bb-42a6-a09f-93d5d00936ac'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','4cd86c02-52a1-4c8f-bbe9-f292bd1afcb6'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','892f1fd6-869c-4e66-b532-098749b63208'),(113,NULL,'app','m181112_203955_sequences_table','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','05b62dde-4ce3-49e6-844b-e954f6a27ddf'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','f6a613fe-dc50-46bd-8b93-dd3d995edee1'),(115,NULL,'app','m181128_193942_fix_project_config','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','b62d6253-7ca6-4763-9b93-861e088c5c24'),(116,NULL,'app','m181130_143040_fix_schema_version','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','a7c61a5a-394f-4d0c-aae2-1ceb234982c4'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','9f176c10-a2e0-4f2b-84da-4cd2ebc02806'),(118,NULL,'app','m181213_102500_config_map_aliases','2020-04-20 08:08:32','2020-04-20 08:08:32','2020-04-20 08:08:32','0aabddfb-b3d5-4753-aedd-f2515173ac6b'),(119,NULL,'app','m181217_153000_fix_structure_uids','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','fb2b85c7-a6f9-4183-9e45-6b0b03dc31f8'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','bce4a0c5-2c86-47d5-9eff-2411bfb043b1'),(121,NULL,'app','m190108_110000_cleanup_project_config','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','c2810fdb-c82b-4b76-b5e9-15f032c22ccb'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','167fcf77-3189-4c5a-b0f1-5a4525682d62'),(123,NULL,'app','m190109_172845_fix_colspan','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','d78b0126-28c0-4861-a6f6-422b8cac81c8'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','3f8540e5-7bb6-4e27-9930-d1af9b95a51a'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','720cf233-f03d-46bb-94aa-12d363bbee57'),(126,NULL,'app','m190112_124737_fix_user_settings','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','280e7a95-cddc-42fd-b0c2-4fdc16c12a48'),(127,NULL,'app','m190112_131225_fix_field_layouts','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','eab0bcdd-4c3d-4c00-8027-ca71079b0c38'),(128,NULL,'app','m190112_201010_more_soft_deletes','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','a7f004c4-6482-40fd-b330-15232a47d909'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','5d30ca52-8b41-41c2-af1a-35a5b4d8b2c2'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','ed77164d-96e8-4e89-911f-8a13c810e8c8'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','90be3023-1539-4160-ad25-4855b5f911ff'),(132,NULL,'app','m190128_181422_cleanup_volume_folders','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','ed748d14-68f7-49d9-9625-0a0fbcceb0d1'),(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','ed88545c-11e4-45cd-b2a8-c5fb4e2dc7f4'),(134,NULL,'app','m190208_140000_reset_project_config_mapping','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','719b0ae5-e82b-4e3e-87de-cef8b75ea4d5'),(135,NULL,'app','m190218_143000_element_index_settings_uid','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','d8de3c0f-eb60-42c7-a03d-d9e055e544c5'),(136,NULL,'app','m190312_152740_element_revisions','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','b7885d4b-0a46-4623-aa09-4055360f634e'),(137,NULL,'app','m190327_235137_propagation_method','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','77eeb62c-3194-4f65-bd1e-9654451e9b8b'),(138,NULL,'app','m190401_223843_drop_old_indexes','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','4be6ee4f-5088-448c-a33b-9b06045da7b4'),(139,NULL,'app','m190416_014525_drop_unique_global_indexes','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','0620809e-c0e7-442d-a7fb-2bbd215642c7'),(140,NULL,'app','m190417_085010_add_image_editor_permissions','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','1679dd0a-0e17-4701-b8b3-24bf8d3fcebd'),(141,NULL,'app','m190502_122019_store_default_user_group_uid','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','e4eb3444-8815-4a3a-8f5e-420e1c64e2e4'),(142,NULL,'app','m190504_150349_preview_targets','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','0ba786e9-2531-4580-987f-c781c94d0a2f'),(143,NULL,'app','m190516_184711_job_progress_label','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','a05f1874-02ce-4ca9-957c-201dbd9b9c64'),(144,NULL,'app','m190523_190303_optional_revision_creators','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','8ec29cb4-0287-43e0-b1c8-55e503022dd3'),(145,NULL,'app','m190529_204501_fix_duplicate_uids','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','9d9b4643-3fae-427b-af89-0a4306ecb9b5'),(146,NULL,'app','m190605_223807_unsaved_drafts','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','dcbf6a9c-f54d-468a-b1ef-837068a8529f'),(147,NULL,'app','m190607_230042_entry_revision_error_tables','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','750970ea-0906-4179-bd81-9359dc430563'),(148,NULL,'app','m190608_033429_drop_elements_uid_idx','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','a75fb20e-9293-43ef-b6cb-d486e7e9584c'),(149,NULL,'app','m190617_164400_add_gqlschemas_table','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','86c0c088-36fc-4d64-9b85-d1e8ffd78d44'),(150,NULL,'app','m190624_234204_matrix_propagation_method','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','ab400bfb-4948-4e59-aee0-c3e23511d7d9'),(151,NULL,'app','m190711_153020_drop_snapshots','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','22770d66-bec2-43d9-98bc-86eb99e52ce6'),(152,NULL,'app','m190712_195914_no_draft_revisions','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','e9acbc90-4dcb-4163-8f20-8c0f6df022d0'),(153,NULL,'app','m190723_140314_fix_preview_targets_column','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','17be97b7-9f0f-4e9e-a785-19110fe647f2'),(154,NULL,'app','m190820_003519_flush_compiled_templates','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','f00ca3cb-1c19-495b-bd7b-1533a5d2ff8e'),(155,NULL,'app','m190823_020339_optional_draft_creators','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','bc40605e-6270-4cbe-93b8-d930434a896e'),(156,NULL,'app','m190913_152146_update_preview_targets','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','56774e25-3f65-4192-8d3d-28c2e41d713b'),(157,NULL,'app','m191107_122000_add_gql_project_config_support','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','9c8899d3-1a95-488f-8f2f-97b568ba7022'),(158,NULL,'app','m191204_085100_pack_savable_component_settings','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','47167c50-4903-4050-ae6f-92f86b9b075b'),(159,NULL,'app','m191206_001148_change_tracking','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','14a57e8c-d837-4eeb-9014-577b6b8b0a5f'),(160,NULL,'app','m191216_191635_asset_upload_tracking','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','3c8d7443-0a4a-493f-a03e-c9c0c9c1bf95'),(161,NULL,'app','m191222_002848_peer_asset_permissions','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','d9793c25-4ef4-4dde-9bc9-fd44dd013c6f'),(162,NULL,'app','m200127_172522_queue_channels','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','379a0125-fd66-4e52-8a87-90d617586427'),(163,NULL,'app','m200211_175048_truncate_element_query_cache','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','d64026be-6fba-4f20-8de4-be2c9b5f330b'),(164,NULL,'app','m200213_172522_new_elements_index','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','90f788f8-b902-43b1-bdd7-f1d70c71b793'),(165,NULL,'app','m200228_195211_long_deprecation_messages','2020-04-20 08:08:33','2020-04-20 08:08:33','2020-04-20 08:08:33','72be9ae8-920a-414e-b7d0-eb42f907e7f7');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_plugins`
--

LOCK TABLES `cms_plugins` WRITE;
/*!40000 ALTER TABLE `cms_plugins` DISABLE KEYS */;
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
INSERT INTO `cms_projectconfig` VALUES ('dateModified','1587370111'),('email.fromEmail','\"webmaster@benfeather.dev\"'),('email.fromName','\"Craft CMS\"'),('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"'),('fieldGroups.bcd0e092-3aa3-4ddf-825a-f98ffc41ebb0.name','\"Common\"'),('siteGroups.394d835a-c397-418d-be02-82f8cf2ad28c.name','\"Craft CMS\"'),('sites.04cbbc4e-0549-4c41-b0cc-100aa6d9b487.baseUrl','\"http://localhost\"'),('sites.04cbbc4e-0549-4c41-b0cc-100aa6d9b487.handle','\"default\"'),('sites.04cbbc4e-0549-4c41-b0cc-100aa6d9b487.hasUrls','true'),('sites.04cbbc4e-0549-4c41-b0cc-100aa6d9b487.language','\"en\"'),('sites.04cbbc4e-0549-4c41-b0cc-100aa6d9b487.name','\"Craft CMS\"'),('sites.04cbbc4e-0549-4c41-b0cc-100aa6d9b487.primary','true'),('sites.04cbbc4e-0549-4c41-b0cc-100aa6d9b487.siteGroup','\"394d835a-c397-418d-be02-82f8cf2ad28c\"'),('sites.04cbbc4e-0549-4c41-b0cc-100aa6d9b487.sortOrder','1'),('system.edition','\"solo\"'),('system.live','true'),('system.name','\"Craft CMS\"'),('system.schemaVersion','\"3.4.10\"'),('system.timeZone','\"America/Los_Angeles\"'),('users.allowPublicRegistration','false'),('users.defaultGroup','null'),('users.photoSubpath','\"\"'),('users.photoVolumeUid','null'),('users.requireEmailVerification','true');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
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
INSERT INTO `cms_resourcepaths` VALUES ('231d8f76','@bower/jquery/dist'),('25ed0700','@app/web/assets/utilities/dist'),('2eb5d7e3','@lib/jquery.payment'),('3292780b','@lib/velocity'),('3e8d0e2f','@app/web/assets/feed/dist'),('47964591','@app/web/assets/cp/dist'),('5adb621c','@app/web/assets/recententries/dist'),('64612072','@app/web/assets/updateswidget/dist'),('6af38cb3','@app/web/assets/craftsupport/dist'),('76eca3e7','@lib/axios'),('7c3be3ae','@lib/jquery-ui'),('849b0bdd','@app/web/assets/dashboard/dist'),('87e95018','@lib/fabric'),('92af8426','@lib/garnishjs'),('a11293a0','@lib/d3'),('a8138f33','@lib/jquery-touch-events'),('afb7b3f1','@lib/picturefill'),('b75fb20f','@lib/fileupload'),('c8d2483','@lib/element-resize-detector'),('f1a5daff','@lib/xregexp'),('fbc99e75','@lib/selectize');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_revisions`
--

LOCK TABLES `cms_revisions` WRITE;
/*!40000 ALTER TABLE `cms_revisions` DISABLE KEYS */;
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
INSERT INTO `cms_searchindex` VALUES (1,'username',0,1,' admin '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' webmaster benfeather dev '),(1,'slug',0,1,'');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_sections`
--

LOCK TABLES `cms_sections` WRITE;
/*!40000 ALTER TABLE `cms_sections` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_sections_sites`
--

LOCK TABLES `cms_sections_sites` WRITE;
/*!40000 ALTER TABLE `cms_sections_sites` DISABLE KEYS */;
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
INSERT INTO `cms_sessions` VALUES (1,1,'4l1JxTl23w8HHwKkZ5gCuZvg-x69twSaQ78QJ1-M0-ll6IHc8iyJR04foL5q5EyMk4bF-TJZ62P3YeaIZY0xT2LyHQwk5NKBeh8O','2020-04-20 08:08:31','2020-04-20 08:08:43','92470d99-b956-481f-a72a-a47ea0d13132');
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
INSERT INTO `cms_sitegroups` VALUES (1,'Craft CMS','2020-04-20 08:08:31','2020-04-20 08:08:31',NULL,'394d835a-c397-418d-be02-82f8cf2ad28c');
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
INSERT INTO `cms_sites` VALUES (1,1,1,'Craft CMS','default','en',1,'http://localhost',1,'2020-04-20 08:08:31','2020-04-20 08:08:31',NULL,'04cbbc4e-0549-4c41-b0cc-100aa6d9b487');
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
INSERT INTO `cms_users` VALUES (1,'admin',NULL,NULL,NULL,'webmaster@benfeather.dev','$2y$13$IEbig9wZOBs5f62XWJiU.O8uTneLeAKxl4zalG5PjaIRtXpGAEPxC',1,0,0,0,'2020-04-20 08:08:31',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2020-04-20 08:08:31','2020-04-20 08:08:31','2020-04-20 08:08:34','eff4e35b-cb2c-4197-b212-ee61f313a807');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_volumefolders`
--

LOCK TABLES `cms_volumefolders` WRITE;
/*!40000 ALTER TABLE `cms_volumefolders` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_volumes`
--

LOCK TABLES `cms_volumes` WRITE;
/*!40000 ALTER TABLE `cms_volumes` DISABLE KEYS */;
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
INSERT INTO `cms_widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2020-04-20 08:08:34','2020-04-20 08:08:34','b50a4d38-3b67-45fe-aeda-5042456cb0c4'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2020-04-20 08:08:34','2020-04-20 08:08:34','f57bb315-f21a-4846-899b-7b730fc1dfd2'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2020-04-20 08:08:34','2020-04-20 08:08:34','db08c4ba-a365-4910-ae66-d983615064e1'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2020-04-20 08:08:34','2020-04-20 08:08:34','83a928f9-2a8c-4505-ab5b-f612c284ebee');
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

-- Dump completed on 2020-04-20  8:08:57
