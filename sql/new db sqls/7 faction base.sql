-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Server version:               5.5.53 - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL Версия:              9.3.0.4998
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table mangos.faction
CREATE TABLE IF NOT EXISTS `faction` (
  `ID` smallint(3) unsigned NOT NULL DEFAULT '0',
  `reputationListID` mediumint(9) NOT NULL DEFAULT '0',
  `baseRepRaceMask1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `baseRepRaceMask2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `baseRepRaceMask3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `baseRepRaceMask4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `baseRepClassMask1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `baseRepClassMask2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `baseRepClassMask3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `baseRepClassMask4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `baseRepValue1` mediumint(9) NOT NULL DEFAULT '0',
  `baseRepValue2` mediumint(9) NOT NULL DEFAULT '0',
  `baseRepValue3` mediumint(9) NOT NULL DEFAULT '0',
  `baseRepValue4` mediumint(9) NOT NULL DEFAULT '0',
  `reputationFlags1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `reputationFlags2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `reputationFlags3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `reputationFlags4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `team` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `name1` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `name2` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `name3` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `name4` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `name5` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `name6` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `name7` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `name8` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description1` varchar(512) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description2` varchar(512) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description3` varchar(512) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description4` varchar(512) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description5` varchar(512) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description6` varchar(512) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description7` varchar(512) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description8` varchar(512) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
