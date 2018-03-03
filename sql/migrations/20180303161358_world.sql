DROP PROCEDURE IF EXISTS add_migration;
delimiter ??
CREATE PROCEDURE `add_migration`()
BEGIN
DECLARE v INT DEFAULT 1;
SET v = (SELECT COUNT(*) FROM `migrations` WHERE `id`='20180303161358');
IF v=0 THEN
INSERT INTO `migrations` VALUES ('20180303161358');
-- Add your query below.


-- Mangletooth does not need EventAI.
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=3430;
UPDATE `creature_template` SET `AIName`='' WHERE `entry`=3430;

-- Some scripts have the same action twice.
UPDATE `creature_ai_scripts` SET `action2_type`=`action3_type`, `action2_param1`=`action3_param1`, `action2_param2`=`action3_param2`, `action2_param3`=`action3_param3`, `action3_type`=0, `action3_param1`=0, `action3_param2`=0, `action3_param3`=0 WHERE (action1_type = action2_type) && (action1_param1 = action2_param1)  && (action1_param2 = action2_param2)  && (action1_param3 = action2_param3) && NOT (comment LIKE "%Summon%");

-- Use flags from DoCastSpellIfCan for SCRIPT_COMMAND_CAST_SPELL.
-- Triggered and interrupt previous cast flags are reversed.
UPDATE `creature_spells_scripts` SET `dataint`=1 WHERE `command`=15 && (`datalong2` & 2);
UPDATE `creature_spells_scripts` SET `dataint`=`dataint` + 2 WHERE `command`=15 && (`datalong2` & 1);
UPDATE `creature_spells_scripts` SET `datalong2`=`dataint`, `dataint`=0 WHERE `command`=15;
UPDATE `creature_movement_scripts` SET `dataint`=1 WHERE `command`=15 && (`datalong2` & 2);
UPDATE `creature_movement_scripts` SET `dataint`=`dataint` + 2 WHERE `command`=15 && (`datalong2` & 1);
UPDATE `creature_movement_scripts` SET `datalong2`=`dataint`, `dataint`=0 WHERE `command`=15;
UPDATE `event_scripts` SET `dataint`=1 WHERE `command`=15 && (`datalong2` & 2);
UPDATE `event_scripts` SET `dataint`=`dataint` + 2 WHERE `command`=15 && (`datalong2` & 1);
UPDATE `event_scripts` SET `datalong2`=`dataint`, `dataint`=0 WHERE `command`=15;
UPDATE `gameobject_scripts` SET `dataint`=1 WHERE `command`=15 && (`datalong2` & 2);
UPDATE `gameobject_scripts` SET `dataint`=`dataint` + 2 WHERE `command`=15 && (`datalong2` & 1);
UPDATE `gameobject_scripts` SET `datalong2`=`dataint`, `dataint`=0 WHERE `command`=15;
UPDATE `gossip_scripts` SET `dataint`=1 WHERE `command`=15 && (`datalong2` & 2);
UPDATE `gossip_scripts` SET `dataint`=`dataint` + 2 WHERE `command`=15 && (`datalong2` & 1);
UPDATE `gossip_scripts` SET `datalong2`=`dataint`, `dataint`=0 WHERE `command`=15;
UPDATE `spell_scripts` SET `dataint`=1 WHERE `command`=15 && (`datalong2` & 2);
UPDATE `spell_scripts` SET `dataint`=`dataint` + 2 WHERE `command`=15 && (`datalong2` & 1);
UPDATE `spell_scripts` SET `datalong2`=`dataint`, `dataint`=0 WHERE `command`=15;
UPDATE `quest_start_scripts` SET `dataint`=1 WHERE `command`=15 && (`datalong2` & 2);
UPDATE `quest_start_scripts` SET `dataint`=`dataint` + 2 WHERE `command`=15 && (`datalong2` & 1);
UPDATE `quest_start_scripts` SET `datalong2`=`dataint`, `dataint`=0 WHERE `command`=15;
UPDATE `quest_end_scripts` SET `dataint`=1 WHERE `command`=15 && (`datalong2` & 2);
UPDATE `quest_end_scripts` SET `dataint`=`dataint` + 2 WHERE `command`=15 && (`datalong2` & 1);
UPDATE `quest_end_scripts` SET `datalong2`=`dataint`, `dataint`=0 WHERE `command`=15;

-- Switched TARGET_T_SELF with TARGET_T_PROVIDED_TARGET (previously TARGET_T_ACTION_INVOKER).
UPDATE `creature_spells` SET `castTarget_1`=6 WHERE `spellId_1`!=0 && `castTarget_1`=0;
UPDATE `creature_spells` SET `castTarget_2`=6 WHERE `spellId_2`!=0 && `castTarget_2`=0;
UPDATE `creature_spells` SET `castTarget_3`=6 WHERE `spellId_3`!=0 && `castTarget_3`=0;
UPDATE `creature_spells` SET `castTarget_4`=6 WHERE `spellId_4`!=0 && `castTarget_4`=0;
UPDATE `creature_spells` SET `castTarget_5`=6 WHERE `spellId_5`!=0 && `castTarget_5`=0;
UPDATE `creature_spells` SET `castTarget_6`=6 WHERE `spellId_6`!=0 && `castTarget_6`=0;
UPDATE `creature_spells` SET `castTarget_7`=6 WHERE `spellId_7`!=0 && `castTarget_7`=0;
UPDATE `creature_spells` SET `castTarget_8`=6 WHERE `spellId_8`!=0 && `castTarget_8`=0;

-- SCRIPT_COMMAND_TEMP_SUMMON_CREATURE set attack target to TARGET_T_SELF (none).
UPDATE `creature_spells_scripts` SET `dataint3`=6 WHERE `command`=10;
UPDATE `creature_movement_scripts` SET `dataint3`=6 WHERE `command`=10;
UPDATE `event_scripts` SET `dataint3`=6 WHERE `command`=10;
UPDATE `gameobject_scripts` SET `dataint3`=6 WHERE `command`=10;
UPDATE `gossip_scripts` SET `dataint3`=6 WHERE `command`=10;
UPDATE `spell_scripts` SET `dataint3`=6 WHERE `command`=10;
UPDATE `quest_start_scripts` SET `dataint3`=6 WHERE `command`=10;
UPDATE `quest_end_scripts` SET `dataint3`=6 WHERE `command`=10;

-- SCRIPT_COMMAND_TEMP_SUMMON_CREATURE set despawn type to TEMPSUMMON_TIMED_OR_DEAD_DESPAWN.
UPDATE `creature_spells_scripts` SET `dataint4`=1 WHERE `command`=10;
UPDATE `creature_movement_scripts` SET `dataint4`=1 WHERE `command`=10;
UPDATE `event_scripts` SET `dataint4`=1 WHERE `command`=10;
UPDATE `gameobject_scripts` SET `dataint4`=1 WHERE `command`=10;
UPDATE `gossip_scripts` SET `dataint4`=1 WHERE `command`=10;
UPDATE `spell_scripts` SET `dataint4`=1 WHERE `command`=10;
UPDATE `quest_start_scripts` SET `dataint4`=1 WHERE `command`=10;
UPDATE `quest_end_scripts` SET `dataint4`=1 WHERE `command`=10;

-- SCRIPT_COMMAND_TEMP_SUMMON_CREATURE move flags to dataint.
UPDATE `creature_spells_scripts` SET `dataint`=`dataint`+2, `data_flags`=`data_flags`-16 WHERE `command`=10 && (`data_flags` & 16);
UPDATE `creature_spells_scripts` SET `dataint`=`dataint`+4, `data_flags`=`data_flags`-32 WHERE `command`=10 && (`data_flags` & 32);
UPDATE `creature_spells_scripts` SET `dataint`=`dataint`+8, `data_flags`=`data_flags`-64 WHERE `command`=10 && (`data_flags` & 64);
UPDATE `creature_movement_scripts` SET `dataint`=`dataint`+2, `data_flags`=`data_flags`-16 WHERE `command`=10 && (`data_flags` & 16);
UPDATE `creature_movement_scripts` SET `dataint`=`dataint`+4, `data_flags`=`data_flags`-32 WHERE `command`=10 && (`data_flags` & 32);
UPDATE `creature_movement_scripts` SET `dataint`=`dataint`+8, `data_flags`=`data_flags`-64 WHERE `command`=10 && (`data_flags` & 64);
UPDATE `event_scripts` SET `dataint`=`dataint`+2, `data_flags`=`data_flags`-16 WHERE `command`=10 && (`data_flags` & 16);
UPDATE `event_scripts` SET `dataint`=`dataint`+4, `data_flags`=`data_flags`-32 WHERE `command`=10 && (`data_flags` & 32);
UPDATE `event_scripts` SET `dataint`=`dataint`+8, `data_flags`=`data_flags`-64 WHERE `command`=10 && (`data_flags` & 64);
UPDATE `gameobject_scripts` SET `dataint`=`dataint`+2, `data_flags`=`data_flags`-16 WHERE `command`=10 && (`data_flags` & 16);
UPDATE `gameobject_scripts` SET `dataint`=`dataint`+4, `data_flags`=`data_flags`-32 WHERE `command`=10 && (`data_flags` & 32);
UPDATE `gameobject_scripts` SET `dataint`=`dataint`+8, `data_flags`=`data_flags`-64 WHERE `command`=10 && (`data_flags` & 64);
UPDATE `gossip_scripts` SET `dataint`=`dataint`+2, `data_flags`=`data_flags`-16 WHERE `command`=10 && (`data_flags` & 16);
UPDATE `gossip_scripts` SET `dataint`=`dataint`+4, `data_flags`=`data_flags`-32 WHERE `command`=10 && (`data_flags` & 32);
UPDATE `gossip_scripts` SET `dataint`=`dataint`+8, `data_flags`=`data_flags`-64 WHERE `command`=10 && (`data_flags` & 64);
UPDATE `spell_scripts` SET `dataint`=`dataint`+2, `data_flags`=`data_flags`-16 WHERE `command`=10 && (`data_flags` & 16);
UPDATE `spell_scripts` SET `dataint`=`dataint`+4, `data_flags`=`data_flags`-32 WHERE `command`=10 && (`data_flags` & 32);
UPDATE `spell_scripts` SET `dataint`=`dataint`+8, `data_flags`=`data_flags`-64 WHERE `command`=10 && (`data_flags` & 64);
UPDATE `quest_start_scripts` SET `dataint`=`dataint`+2, `data_flags`=`data_flags`-16 WHERE `command`=10 && (`data_flags` & 16);
UPDATE `quest_start_scripts` SET `dataint`=`dataint`+4, `data_flags`=`data_flags`-32 WHERE `command`=10 && (`data_flags` & 32);
UPDATE `quest_start_scripts` SET `dataint`=`dataint`+8, `data_flags`=`data_flags`-64 WHERE `command`=10 && (`data_flags` & 64);
UPDATE `quest_end_scripts` SET `dataint`=`dataint`+2, `data_flags`=`data_flags`-16 WHERE `command`=10 && (`data_flags` & 16);
UPDATE `quest_end_scripts` SET `dataint`=`dataint`+4, `data_flags`=`data_flags`-32 WHERE `command`=10 && (`data_flags` & 32);
UPDATE `quest_end_scripts` SET `dataint`=`dataint`+8, `data_flags`=`data_flags`-64 WHERE `command`=10 && (`data_flags` & 64);

-- This table is no longer needed.
DROP TABLE `creature_ai_summons`;

-- Rename events table.
RENAME TABLE `creature_ai_scripts` TO `creature_ai_events`;

-- Add script id columns to events table.
ALTER TABLE `creature_ai_events`
	ADD COLUMN `action1_script` INT(11) UNSIGNED NOT NULL DEFAULT '0' AFTER `event_param4`,
	ADD COLUMN `action2_script` INT(11) UNSIGNED NOT NULL DEFAULT '0' AFTER `action1_script`,
	ADD COLUMN `action3_script` INT(11) UNSIGNED NOT NULL DEFAULT '0' AFTER `action2_script`,
	DROP COLUMN `action1_type`,
	DROP COLUMN `action1_param1`,
	DROP COLUMN `action1_param2`,
	DROP COLUMN `action1_param3`,
	DROP COLUMN `action2_type`,
	DROP COLUMN `action2_param1`,
	DROP COLUMN `action2_param2`,
	DROP COLUMN `action2_param3`,
	DROP COLUMN `action3_type`,
	DROP COLUMN `action3_param1`,
	DROP COLUMN `action3_param2`,
	DROP COLUMN `action3_param3`;

-- Add new scripts table.
CREATE TABLE IF NOT EXISTS `creature_ai_scripts` (
  `id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `delay` int(10) unsigned NOT NULL DEFAULT '0',
  `command` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `datalong2` int(10) unsigned NOT NULL DEFAULT '0',
  `datalong3` int(10) unsigned NOT NULL DEFAULT '0',
  `datalong4` int(10) unsigned NOT NULL DEFAULT '0',
  `buddy_id` int(10) unsigned NOT NULL DEFAULT '0',
  `buddy_radius` int(10) unsigned NOT NULL DEFAULT '0',
  `buddy_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `data_flags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dataint` int(11) NOT NULL DEFAULT '0',
  `dataint2` int(11) NOT NULL DEFAULT '0',
  `dataint3` int(11) NOT NULL DEFAULT '0',
  `dataint4` int(11) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `o` float NOT NULL DEFAULT '0',
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `comments` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- End of migration.
END IF;
END??
delimiter ; 
CALL add_migration();
DROP PROCEDURE IF EXISTS add_migration;
