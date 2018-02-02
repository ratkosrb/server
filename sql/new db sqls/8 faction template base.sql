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

-- Dumping structure for table mangos.faction_template
CREATE TABLE IF NOT EXISTS `faction_template` (
  `ID` smallint(4) unsigned NOT NULL DEFAULT '0',
  `factionId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `factionFlags` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ourMask` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `friendlyMask` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `hostileMask` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `enemyFaction1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `enemyFaction2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `enemyFaction3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `enemyFaction4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `friendFaction1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `friendFaction2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `friendFaction3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `friendFaction4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
