DROP PROCEDURE IF EXISTS add_migration;
delimiter ??
CREATE PROCEDURE `add_migration`()
BEGIN
DECLARE v INT DEFAULT 1;
SET v = (SELECT COUNT(*) FROM `migrations` WHERE `id`='20180224160415');
IF v=0 THEN
INSERT INTO `migrations` VALUES ('20180224160415');
-- Add your query below.


REPLACE INTO `spell_effect_mod` VALUES (14814, 0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 8, -1, -1, -1, -1, -1, -1, 'Throw Dark Iron Ale targetting');
REPLACE INTO `spell_effect_mod` VALUES (14823, 2, 3, -1, -1, -1, -1, 1, -1, -1, -1, -1, -1, 1, -1, -1, -1, -1, -1, -1, 'Dark Iron Ale dummy effect');
REPLACE INTO `spell_mod` VALUES (14823, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 0, -1, -1, -1, -1, 0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 0, -1, -1, 'BRD Drinking: Not Passive');
REPLACE INTO `spell_script_target` (`entry`, `type`, `targetEntry`) VALUES (14813, 1, 9547),(14813, 1, 9554),(14813, 1, 9545),(14813, 1, 15429),(14813, 1, 14867),(14813, 1, 14871),(14813, 1, 14878);
UPDATE `gameobject_template` SET `displayId`=3151, `data2`=20, `data4`=0, `data5`=70000 WHERE `entry`=165578;

DELETE FROM `event_scripts` WHERE `id`=10001;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES 
(10001, 0, 1, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'BRD Bar Patron - Drink Emote'),
(10001, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 10167, 0, 0, 0, 0, 0, 0, 0, 'BRD Bar Patron - Text Emote'),
(10001, 3, 15, 14823, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'BRD Bar Patron - Cast Drinking');

REPLACE INTO `creature_ai_scripts` VALUES 
(954703, 9547, 0, 29, 0, 100, 1, 8, 1, 0, 0, 50, 10001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Guzzling Patron - Drink Dark Iron Ale'),
(954502, 9545, 0, 29, 0, 100, 1, 8, 1, 0, 0, 50, 10001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Grim Patron - Drink Dark Iron Ale'),
(955404, 9554, 0, 29, 0, 100, 1, 8, 1, 0, 0, 50, 10001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hammered Patron - Drink Dark Iron Ale');


UPDATE `creature_template` SET `ScriptName`='npc_oozeling_jubjub' WHERE entry in  (14867,15429,14878);
UPDATE `creature_template` SET `gossip_menu_id`=14871, `npcflag`=1, `ScriptName`='npc_morja' WHERE `entry`=14871;

REPLACE INTO `conditions` (`condition_entry`, `type`, `value1`, `value2`) VALUES (14871, 31, 147, 2);
REPLACE INTO `gossip_menu` VALUES (14871, 7400, 0),(14871, 7401, 14871);
REPLACE INTO `npc_text` (`ID`, `BroadcastTextID0`, `Probability0`) VALUES (7401, 10169, 1);
UPDATE `creature` SET `modelid`=0, `spawntimesecsmin`=300, `spawntimesecsmax`=300 WHERE `guid`=54428;
REPLACE INTO `creature` VALUES (54427, 14867, 0, 0, 0, -9549.04, 38.9258, 59.2559, 3.58223, 300, 300, 0, 0, 166, 0, 0, 0, 0, 0, 0, 10);
REPLACE INTO `game_event_creature` (`guid`, `event`) VALUES (54427, 4);
REPLACE INTO `spell_script_target` (`entry`, `type`, `targetEntry`) VALUES (23845, 1, 14867);
UPDATE `quest_template` SET `RewSpellCast`=23852 WHERE `entry`=7946;


-- End of migration.
END IF;
END??
delimiter ; 
CALL add_migration();
DROP PROCEDURE IF EXISTS add_migration;
