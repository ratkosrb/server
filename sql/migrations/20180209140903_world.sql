DROP PROCEDURE IF EXISTS add_migration;
delimiter ??
CREATE PROCEDURE `add_migration`()
BEGIN
DECLARE v INT DEFAULT 1;
SET v = (SELECT COUNT(*) FROM `migrations` WHERE `id`='20180209140903');
IF v=0 THEN
INSERT INTO `migrations` VALUES ('20180209140903');
-- Add your query below.


-- Event introduced in February 2006 - Patch 1.9
UPDATE `quest_template` SET `patch`=7 WHERE `entry` in (9029,8898,8899,8901,8902,8897,8903,9024,9025,9026,9027,9028,8900,8904,8979,8980,8982,8983,8984,8981);
UPDATE `creature_questrelation` SET `patch`=7 WHERE `quest` in (9029,8898,8899,8901,8902,8897,8903,9024,9025,9026,9027,9028,8900,8904,8979,8980,8982,8983,8984,8981);
UPDATE `creature_involvedrelation` SET `patch`=7 WHERE quest in (9029,8898,8899,8901,8902,8897,8903,9024,9025,9026,9027,9028,8900,8904,8979,8980,8982,8983,8984,8981);
UPDATE `item_template` SET `patch`=7 WHERE `entry` in (22281,22282,22277,22278,22280,22276,22279);

-- Alliance quest chain
REPLACE INTO `creature_questrelation` (`id`, `quest`, `patch`) VALUES (16105, 9027, 7);
REPLACE INTO `creature_questrelation` (`id`, `quest`, `patch`) VALUES (279, 9025, 7);
DELETE FROM `creature_questrelation` WHERE `quest`=9027;
REPLACE INTO `creature_questrelation` (`id`, `quest`, `patch`) VALUES (6740, 9027, 7);
UPDATE `quest_template` SET `PrevQuestId`=8903 WHERE  `entry`=9024 AND `patch`=7;
UPDATE `quest_template` SET `PrevQuestId`=9024, `NextQuestInChain`=9026 WHERE  `entry`=9025 AND `patch`=7;
UPDATE `quest_template` SET `RequiredRaces`=77, `PrevQuestId`=9025 WHERE  `entry`=9026 AND `patch`=7;
UPDATE `quest_template` SET `PrevQuestId`=9026 WHERE  `entry`=9027 AND `patch`=7;
UPDATE `quest_template` SET `NextQuestId`=9029, `ExclusiveGroup`=9028, `NextQuestInChain`=0 WHERE  `entry`=9028 AND `patch`=7;
REPLACE INTO `npc_vendor` (`entry`, `item`) VALUES (6740, 21833),(6740, 21815),(6740, 21829);
UPDATE `item_template` SET `spellcharges_1`=-10 WHERE  `entry`=21829;


-- Cauldron and quest
REPLACE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `faction`, `flags`, `size`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `mingold`, `maxgold`, `ScriptName`) 
VALUES (181073, 2, 216, 'Fragrant Cauldron', 35, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');
REPLACE INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecsmin`, `spawntimesecsmax`, `animprogress`, `state`) 
VALUES (121618, 181073, 0, 87.6351, -1724.96, 220.192, 1.88655, 0, 0, 0.809484, 0.587141, 25, 25, 0, 1);
REPLACE INTO `gameobject_questrelation` (`id`, `quest`, `patch`) VALUES (181073, 9029, 7);
REPLACE INTO `gameobject_involvedrelation` (`id`, `quest`, `patch`) VALUES (181073, 9029, 7);


-- Horde quest chain
REPLACE INTO `quest_template` (`entry`, `patch`, `ZoneOrSort`, `MinLevel`, `QuestLevel`, `RequiredRaces`, `QuestFlags`, `NextQuestInChain`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `ReqItemId1`, `ReqItemCount1`) 
VALUES (8904, 7, -22, 1, 60, 178, 8, 8979, 'Dangerous Love', 'There\'s something unnatural about this epidemic of love. It\'s disgusting, and as it lowers our defenses, it could be a threat to the all of us.$B$BIt\'s bad enough that so many of our people are caught up in this ridiculous behavior. But I think that it has spread even to our guardians, who should be immune to such things.$B$BFind one of our guardians and see if they\'ve been caught up in this foolishness.', 'Get a Guardian\'s Moldy Card and bring it to Fenstad Argyle in the Undercity.', 'So it is true. This is unbelievable. How could this have happened? Let me think for a moment. There must be a reason behind this.', 'Was I right to worry? Have our idiot guardians been overcome?', 22145, 1);
UPDATE `quest_template` SET `PrevQuestId`=8904, `NextQuestInChain`=8980 WHERE  `entry`=8979 AND `patch`=7;
UPDATE `quest_template` SET `RequiredRaces`=178, `PrevQuestId`=8979 WHERE  `entry`=8980 AND `patch`=7;
UPDATE `quest_template` SET `PrevQuestId`=8980 WHERE  `entry`=8982 AND `patch`=7;
UPDATE `quest_template` SET `PrevQuestId`=8982 WHERE  `entry`=8983 AND `patch`=7;
UPDATE `quest_template` SET `NextQuestId`=9029, `ExclusiveGroup`=9028, `NextQuestInChain`=0 WHERE  `entry`=8984 AND `patch`=7;
REPLACE INTO `creature_questrelation` (`id`, `quest`, `patch`) VALUES (16108, 8904, 7);
REPLACE INTO `creature_involvedrelation` (`id`, `quest`, `patch`) VALUES (16108, 8904, 7);
REPLACE INTO `creature_questrelation` (`id`, `quest`, `patch`) VALUES (5204, 8980, 7);
REPLACE INTO `creature_questrelation` (`id`, `quest`, `patch`) VALUES (6741, 8983, 7);
REPLACE INTO `npc_vendor` (`entry`, `item`) VALUES (6741, 21833),(6741, 21815),(6741, 21829);


-- Kwee Peddlefeet and Gift Giving
REPLACE INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecsmin`, `spawntimesecsmax`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `spawnFlags`, `visibilitymod`, `patch_min`, `patch_max`) VALUES 
(60100, 16075, 0, 0, 0, -8441.77, 328.147, 122.58, 2.27215, 25, 25, 0, 0, 5000, 0, 0, 0, 0, 0, 0, 10),
(60101, 16075, 0, 0, 0, -4862.71, -1018.52, 505.715, 5.36062, 25, 25, 0, 0, 5000, 0, 0, 0, 0, 0, 0, 10),
(60102, 16075, 1, 0, 0, 9664.87, 2527.76, 1360, 5.60141, 25, 25, 0, 0, 5000, 0, 0, 0, 0, 0, 0, 10),
(60103, 16075, 1, 0, 0, 1915.43, -4126.12, 42.9818, 5.43255, 25, 25, 0, 0, 5000, 0, 0, 0, 0, 0, 0, 10),
(60104, 16075, 1, 0, 0, -1217.04, -108.192, 163.443, 1.44889, 25, 25, 0, 0, 5000, 0, 0, 0, 0, 0, 0, 10),
(60105, 16075, 0, 0, 0, 1288.51, 316.449, -57.3209, 1.34163, 25, 25, 0, 0, 5000, 0, 0, 0, 0, 0, 0, 10);
REPLACE INTO `game_event_creature` (`guid`, `event`) VALUES 
(60100, 8),(60101, 8),(60102, 8),(60103, 8),(60104, 8),(60105, 8);
UPDATE `quest_template` SET `RequiredRaces`=178, `OfferRewardText`='Wonderful! Wonderful! I will add this to the pile of other gifts.$B$BI didn\'t expect so many! You must truly love your leaders.$B$BNow, let me just add one more to the count...', `RequestItemsText`='Have you come to deliver a present of love and adoration to your favorite leader?' WHERE `entry`=8981;
REPLACE INTO `quest_template` (`entry`, `patch`, `Method`, `ZoneOrSort`, `MinLevel`, `QuestLevel`, `RequiredRaces`, `QuestFlags`, `Title`, `OfferRewardText`, `RequestItemsText`, `EndText`, `ReqItemId1`, `ReqItemCount1`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewItemId1`, `RewItemCount1`, `RewSpellCast`, `CompleteEmote`) 
VALUES (8993, 7, 0, -22, 1, 60, 77, 8, 'Gift Giving', 'Wonderful! Wonderful! I will add this to the pile of other gifts.$B$BI didn\'t expect so many! You must truly love your leaders.$B$BNow, let me just add one more to the count...', 'Have you come to deliver a present of love and adoration to your favorite leader?', NULL, 22262, 1, 22218, 22200, 5, 5, 21812, 1, 27663, 1);
REPLACE INTO `creature_questrelation` (`id`, `quest`, `patch`) VALUES (16075, 8981, 7),(16075, 8993, 7);
REPLACE INTO `creature_involvedrelation` (`id`, `quest`, `patch`) VALUES (16075, 8981, 7),(16075, 8993, 7);
UPDATE `creature_template` SET `npcflag`=2, `AIName`='EventAI' WHERE `entry`=16075;
UPDATE `quest_template` SET `SpecialFlags`=1 WHERE `entry` in (8981,8993);
DELETE FROM `creature_ai_scripts` WHERE  `creature_id`=16075;
INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES 
(1607501, 16075, 22, 0, 100, 1, 58, 0, 0, 0, 11, 27572, 6, 32, 0, 0, 0, 0, 0, 0, 0, 0, 'Kwee Peddlefeet - Cast Smitten on Receive Kiss Emote');


-- Pledges and Gifts
UPDATE `item_loot_template` SET `ChanceOrQuestChance`=100 WHERE `item`=22259;
UPDATE `item_loot_template` SET `ChanceOrQuestChance`=25 WHERE `item`=21812;
UPDATE `item_loot_template` SET `ChanceOrQuestChance`=20 WHERE `item`=22218;
UPDATE `item_loot_template` SET `ChanceOrQuestChance`=10 WHERE `item`=22261;
UPDATE `item_loot_template` SET `ChanceOrQuestChance`=10 WHERE `item`=21813;
UPDATE `item_loot_template` SET `ChanceOrQuestChance`=1 WHERE `item`=22235;
UPDATE `item_loot_template` SET `ChanceOrQuestChance`=1 WHERE `item`=22279;
UPDATE `item_template` SET `spellcharges_1`=-5, `stackable`=1 WHERE `entry`=22200;
REPLACE INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`) VALUES 
(21975, 22200, 15),(22154, 22200, 15),(22155, 22200, 15),(22156, 22200, 15),(22157, 22200, 15),(22158, 22200, 15),
(21981, 22200, 15),(21980, 22200, 15),(21979, 22200, 15),(22164, 22200, 15),(22166, 22200, 15),(22165, 22200, 15),
(21979, 22235, 1),(22155, 22235, 1),(22158, 22235, 1);
UPDATE `item_loot_template` SET `ChanceOrQuestChance`=50 WHERE `item` in (22119,22123,22117,22122,22121,22120);
UPDATE `item_loot_template` SET `ChanceOrQuestChance`=80 WHERE `entry`=21979 AND `item`=21960;
UPDATE `item_loot_template` SET `ChanceOrQuestChance`=80 WHERE `entry`=21980 AND `item`=22173;
UPDATE `item_loot_template` SET `ChanceOrQuestChance`=80 WHERE `entry`=22164 AND `item`=22175;
UPDATE `item_loot_template` SET `ChanceOrQuestChance`=80 WHERE `entry`=21981 AND `item`=22176;
UPDATE `item_loot_template` SET `ChanceOrQuestChance`=80 WHERE `entry`=22165 AND `item`=22177;
UPDATE `item_loot_template` SET `ChanceOrQuestChance`=80 WHERE `entry`=22166 AND `item`=22174;
UPDATE `item_loot_template` SET `groupid`=1 WHERE `entry` in (22178,22160,22159,22161,22163,22162);
REPLACE INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`) VALUES 
(22178, 22143, 50, 1),(22160, 22141, 50, 1),(22159, 22140, 50, 1),
(22161, 22142, 50, 1),(22163, 22145, 50, 1),(22162, 22144, 50, 1);
UPDATE `item_template` SET `spellcharges_1`=-1 WHERE `entry`=22261;
UPDATE `creature_template` SET `ScriptName`='npc_target_dummy' WHERE `entry`=16111;
REPLACE INTO `spell_disabled` (`entry`) VALUES (27661); -- Disable Love Fool spell

-- Guards and Citizens
UPDATE `creature_model_info` SET `gender`=1 WHERE `modelid`=5446;

-- Correct broadcast id to one that has both genders.
UPDATE `npc_text` SET `BroadcastTextID0`=11759 WHERE `ID`=8263;
UPDATE `npc_text` SET `BroadcastTextID0`=11724 WHERE `ID`=8244;

-- Valentine Event Active
INSERT INTO `conditions` VALUES (440, 12, 8, 0);
-- Source Gender Female
INSERT INTO `conditions` VALUES (441, 34, 1, 0);
-- Source Gender Male
INSERT INTO `conditions` VALUES (442, 34, 0, 0);
-- Target Not Have Aura Cologne
INSERT INTO `conditions` VALUES (443, 11, 26681, 0);
-- Target Not Have Aura Perfume
INSERT INTO `conditions` VALUES (444, 11, 26682, 0);
-- Target Not Have Item Love Token
INSERT INTO `conditions` VALUES (445, 16, 21815, 1);
-- Target Have Aura Adored
INSERT INTO `conditions` VALUES (446, 1, 26680, 0);
-- Target Have Aura Heartbroken
INSERT INTO `conditions` VALUES (447, 1, 26898, 0);

-- Female Guard No Cologne
INSERT INTO `conditions` VALUES (448, -1, 441, 443);
INSERT INTO `conditions` VALUES (449, -1, 440, 448);
-- Male Guard No Perfume
INSERT INTO `conditions` VALUES (450, -1, 442, 444);
INSERT INTO `conditions` VALUES (451, -1, 440, 450);
-- No Token
INSERT INTO `conditions` VALUES (452, -1, 440, 445);
-- Adored
INSERT INTO `conditions` VALUES (453, -3, 448, 0);
INSERT INTO `conditions` VALUES (454, -3, 450, 0);
INSERT INTO `conditions` VALUES (455, -3, 452, 0);
INSERT INTO `conditions` VALUES (456, -1, 453, 454);
INSERT INTO `conditions` VALUES (457, -1, 455, 456);
INSERT INTO `conditions` VALUES (458, -1, 440, 457);
INSERT INTO `conditions` VALUES (459, -1, 446, 458);
-- Heartbroken
INSERT INTO `conditions` VALUES (460, -1, 440, 447);
-- Normal
INSERT INTO `conditions` VALUES (461, 11, 26680, 0);
INSERT INTO `conditions` VALUES (462, 11, 26898, 0);
INSERT INTO `conditions` VALUES (463, -1, 461, 462);
INSERT INTO `conditions` VALUES (464, -1, 463, 458);

-- Stormwind City Guard
-- Fix gossip option order.
UPDATE `gossip_menu_option` SET `id`=12 WHERE `menu_id`=435 && `id`=14;
UPDATE `gossip_menu_option` SET `id`=13 WHERE `menu_id`=435 && `id`=15;
-- Female Guard No Cologne
INSERT INTO `gossip_menu` VALUES (435, 8285, 449);
-- Male Guard No Perfume
INSERT INTO `gossip_menu` VALUES (435, 8298, 451);
-- No Token
INSERT INTO `gossip_menu` VALUES (435, 8286, 452);
-- Adored
INSERT INTO `gossip_menu` VALUES (435, 8296, 459);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `BoxBroadcastTextID`, `condition_id`) VALUES (435, 14, 0, 'Here, I\'d like to give you this token of my love.', 11723, 1, 1, -1, 0, 400, 0, 0, NULL, 0, 459);
DELETE FROM `gossip_scripts` WHERE `id`=400;
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (400, 0, 15, 27242, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Guard - Love is in the Air - Give Adored Gift');
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (400, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Guard - Love is in the Air - Remove Love Token');
-- Heartbroken
INSERT INTO `gossip_menu` VALUES (435, 8283, 460);
-- Normal
INSERT INTO `gossip_menu` VALUES (435, 8244, 464);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `BoxBroadcastTextID`, `condition_id`) VALUES (435, 15, 0, 'Here, I\'d like to give you this token of my love.', 11723, 1, 1, -1, 0, 401, 0, 0, NULL, 0, 464);
DELETE FROM `gossip_scripts` WHERE `id`=401;
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (401, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Guard - Love is in the Air - Remove Love Token');
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (401, 0, 39, 402, 403, 0, 0, 0, 0, 0, 0, 75, 25, 0, 0, 0, 0, 0, 0, 'Stormwind Guard - Love is in the Air - Adored or Heartbroken');
DELETE FROM `event_scripts` WHERE `id`=402;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (402, 0, 15, 26680, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Guard - Love is in the Air - Cast Adored');
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (402, 0, 15, 27510, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Guard - Love is in the Air - Give Normal Gift');
DELETE FROM `event_scripts` WHERE `id`=403;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (403, 0, 15, 26898, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Love is in the Air - Cast Heartbroken');

-- Ironforge Guard
UPDATE `gossip_menu_option` SET `id`=10 WHERE `menu_id`=2121 && `id`=11;
UPDATE `gossip_menu_option` SET `id`=11 WHERE `menu_id`=2121 && `id`=12;
-- Male Guard No Perfume
INSERT INTO `gossip_menu` VALUES (2121, 8298, 451);
-- No Token
INSERT INTO `gossip_menu` VALUES (2121, 8286, 452);
-- Adored
INSERT INTO `gossip_menu` VALUES (2121, 8296, 459);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `BoxBroadcastTextID`, `condition_id`) VALUES (2121, 12, 0, 'Here, I\'d like to give you this token of my love.', 11723, 1, 1, -1, 0, 404, 0, 0, NULL, 0, 459);
DELETE FROM `gossip_scripts` WHERE `id`=404;
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (404, 0, 15, 27244, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Guard - Love is in the Air - Give Adored Gift');
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (404, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Guard - Love is in the Air - Remove Love Token');
-- Heartbroken
INSERT INTO `gossip_menu` VALUES (2121, 8283, 460);
-- Normal
INSERT INTO `gossip_menu` VALUES (2121, 8254, 464);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `BoxBroadcastTextID`, `condition_id`) VALUES (2121, 13, 0, 'Here, I\'d like to give you this token of my love.', 11723, 1, 1, -1, 0, 405, 0, 0, NULL, 0, 464);
DELETE FROM `gossip_scripts` WHERE `id`=405;
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (405, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Guard - Love is in the Air - Remove Love Token');
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (405, 0, 39, 406, 403, 0, 0, 0, 0, 0, 0, 75, 25, 0, 0, 0, 0, 0, 0, 'Ironforge Guard - Love is in the Air - Adored or Heartbroken');
DELETE FROM `event_scripts` WHERE `id`=406;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (406, 0, 15, 26680, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Guard - Love is in the Air - Cast Adored');
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (406, 0, 15, 27506, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Guard - Love is in the Air - Give Normal Gift');

-- Darnassus Sentinel
-- Female Guard No Cologne
INSERT INTO `gossip_menu` VALUES (2352, 8285, 449);
-- No Token
INSERT INTO `gossip_menu` VALUES (2352, 8286, 452);
-- Adored
INSERT INTO `gossip_menu` VALUES (2352, 8296, 459);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `BoxBroadcastTextID`, `condition_id`) VALUES (2352, 11, 0, 'Here, I\'d like to give you this token of my love.', 11723, 1, 1, -1, 0, 407, 0, 0, NULL, 0, 459);
DELETE FROM `gossip_scripts` WHERE `id`=407;
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (407, 0, 15, 27245, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassus Sentinel - Love is in the Air - Give Adored Gift');
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (407, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassus Sentinel - Love is in the Air - Remove Love Token');
-- Heartbroken
INSERT INTO `gossip_menu` VALUES (2352, 8283, 460);
-- Normal
INSERT INTO `gossip_menu` VALUES (2352, 8255, 464);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `BoxBroadcastTextID`, `condition_id`) VALUES (2352, 12, 0, 'Here, I\'d like to give you this token of my love.', 11723, 1, 1, -1, 0, 408, 0, 0, NULL, 0, 464);
DELETE FROM `gossip_scripts` WHERE `id`=408;
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (408, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassus Sentinel - Love is in the Air - Remove Love Token');
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (408, 0, 39, 409, 403, 0, 0, 0, 0, 0, 0, 75, 25, 0, 0, 0, 0, 0, 0, 'Darnassus Sentinel - Love is in the Air - Adored or Heartbroken');
DELETE FROM `event_scripts` WHERE `id`=409;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (409, 0, 15, 26680, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassus Sentinel - Love is in the Air - Cast Adored');
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (409, 0, 15, 27504, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassus Sentinel - Love is in the Air - Give Normal Gift');

-- Orgrimmar Grunt
UPDATE `gossip_menu_option` SET `id`=11 WHERE `menu_id`=1951 && `id`=12;
UPDATE `gossip_menu_option` SET `id`=12 WHERE `menu_id`=1951 && `id`=13;
-- Female Guard No Cologne
INSERT INTO `gossip_menu` VALUES (1951, 8285, 449);
-- Male Guard No Perfume
INSERT INTO `gossip_menu` VALUES (1951, 8298, 451);
-- No Token
INSERT INTO `gossip_menu` VALUES (1951, 8286, 452);
-- Adored
INSERT INTO `gossip_menu` VALUES (1951, 8296, 459);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `BoxBroadcastTextID`, `condition_id`) VALUES (1951, 13, 0, 'Here, I\'d like to give you this token of my love.', 11723, 1, 1, -1, 0, 410, 0, 0, NULL, 0, 459);
DELETE FROM `gossip_scripts` WHERE `id`=410;
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (410, 0, 15, 27247, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - Love is in the Air - Give Adored Gift');
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (410, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - Love is in the Air - Remove Love Token');
-- Heartbroken
INSERT INTO `gossip_menu` VALUES (1951, 8283, 460);
-- Normal
INSERT INTO `gossip_menu` VALUES (1951, 8263, 464);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `BoxBroadcastTextID`, `condition_id`) VALUES (1951, 14, 0, 'Here, I\'d like to give you this token of my love.', 11723, 1, 1, -1, 0, 411, 0, 0, NULL, 0, 464);
DELETE FROM `gossip_scripts` WHERE `id`=411;
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (411, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - Love is in the Air - Remove Love Token');
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (411, 0, 39, 412, 403, 0, 0, 0, 0, 0, 0, 75, 25, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - Love is in the Air - Adored or Heartbroken');
DELETE FROM `event_scripts` WHERE `id`=412;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (412, 0, 15, 26680, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - Love is in the Air - Cast Adored');
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (412, 0, 15, 27507, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Grunt - Love is in the Air - Give Normal Gift');

-- Undercity Guardian
UPDATE `gossip_menu_option` SET `id`=10 WHERE `menu_id`=2849 && `id`=12;
UPDATE `gossip_menu_option` SET `id`=11 WHERE `menu_id`=2849 && `id`=13;
-- Male Guard No Perfume
INSERT INTO `gossip_menu` VALUES (2849, 8298, 451);
-- No Token
INSERT INTO `gossip_menu` VALUES (2849, 8286, 452);
-- Adored
INSERT INTO `gossip_menu` VALUES (2849, 8296, 459);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `BoxBroadcastTextID`, `condition_id`) VALUES (2849, 12, 0, 'Here, I\'d like to give you this token of my love.', 11723, 1, 1, -1, 0, 413, 0, 0, NULL, 0, 459);
DELETE FROM `gossip_scripts` WHERE `id`=413;
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (413, 0, 15, 27246, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Guardian - Love is in the Air - Give Adored Gift');
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (413, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Guardian - Love is in the Air - Remove Love Token');
-- Heartbroken
INSERT INTO `gossip_menu` VALUES (2849, 8283, 460);
-- Normal
INSERT INTO `gossip_menu` VALUES (2849, 8270, 464);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `BoxBroadcastTextID`, `condition_id`) VALUES (2849, 13, 0, 'Here, I\'d like to give you this token of my love.', 11723, 1, 1, -1, 0, 414, 0, 0, NULL, 0, 464);
DELETE FROM `gossip_scripts` WHERE `id`=414;
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (414, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Guardian - Love is in the Air - Remove Love Token');
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (414, 0, 39, 415, 403, 0, 0, 0, 0, 0, 0, 75, 25, 0, 0, 0, 0, 0, 0, 'Undercity Guardian - Love is in the Air - Adored or Heartbroken');
DELETE FROM `event_scripts` WHERE `id`=415;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (415, 0, 15, 26680, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Guardian - Love is in the Air - Cast Adored');
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (415, 0, 15, 27515, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Guardian - Love is in the Air - Give Normal Gift');

-- Bluffwatcher
-- Female Guard No Cologne
INSERT INTO `gossip_menu` VALUES (721, 8285, 449);
-- Male Guard No Perfume
INSERT INTO `gossip_menu` VALUES (721, 8298, 451);
-- No Token
INSERT INTO `gossip_menu` VALUES (721, 8286, 452);
-- Adored
INSERT INTO `gossip_menu` VALUES (721, 8296, 459);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `BoxBroadcastTextID`, `condition_id`) VALUES (721, 11, 0, 'Here, I\'d like to give you this token of my love.', 11723, 1, 1, -1, 0, 416, 0, 0, NULL, 0, 459);
DELETE FROM `gossip_scripts` WHERE `id`=416;
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (416, 0, 15, 27248, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bluffwatcher - Love is in the Air - Give Adored Gift');
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (416, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bluffwatcher - Love is in the Air - Remove Love Token');
-- Heartbroken
INSERT INTO `gossip_menu` VALUES (721, 8283, 460);
-- Normal
INSERT INTO `gossip_menu` VALUES (721, 8244, 464);
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`, `BoxBroadcastTextID`, `condition_id`) VALUES (721, 12, 0, 'Here, I\'d like to give you this token of my love.', 11723, 1, 1, -1, 0, 417, 0, 0, NULL, 0, 464);
DELETE FROM `gossip_scripts` WHERE `id`=417;
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (417, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bluffwatcher - Love is in the Air - Remove Love Token');
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (417, 0, 39, 418, 403, 0, 0, 0, 0, 0, 0, 75, 25, 0, 0, 0, 0, 0, 0, 'Bluffwatcher - Love is in the Air - Adored or Heartbroken');
DELETE FROM `event_scripts` WHERE `id`=418;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (418, 0, 15, 26680, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bluffwatcher - Love is in the Air - Cast Adored');
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES (418, 0, 15, 27513, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bluffwatcher - Love is in the Air - Give Normal Gift');


-- End of migration.
END IF;
END??
delimiter ; 
CALL add_migration();
DROP PROCEDURE IF EXISTS add_migration;
