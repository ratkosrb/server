-- DELETE FROM `migrations` WHERE `id`='20180209140903';

DROP PROCEDURE IF EXISTS add_migration;
DROP PROCEDURE IF EXISTS `TempValentineGossip`;
delimiter ??
CREATE PROCEDURE `TempValentineGossip`(IN `creature` INT, IN `textid` INT, IN `scriptid1` INT, IN `scriptid2` INT)
BEGIN

	SET @GOSSIPID = (SELECT gossip_menu_id FROM creature_template WHERE entry = `creature`);
	DELETE FROM `gossip_menu` WHERE `entry` = @GOSSIPID and `text_id` IN (8285,8298,8291,8283,8296,8244,8254,8263,8255);
	INSERT INTO `gossip_menu` VALUES 
	(@GOSSIPID, 8285, 454),
	(@GOSSIPID, 8298, 455),
	(@GOSSIPID, 8291, 458),
	(@GOSSIPID, 8283, 459),
	(@GOSSIPID, 8296, 460),
	(@GOSSIPID, textid, 461);
	
	SET @MAXOPTION = (SELECT COALESCE(MAX(id),0) FROM gossip_menu_option WHERE menu_id = @GOSSIPID);
	
	DELETE FROM `gossip_menu_option` WHERE `menu_id` = @GOSSIPID AND `OptionBroadcastTextID` = 11723;
	INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_script_id`, `condition_id`) VALUES 
	(@GOSSIPID, @MAXOPTION + 1, 'Here, I\'d like to give you this token of my love.', 11723, 1, 1, -1, scriptid1, 462),
	(@GOSSIPID, @MAXOPTION + 2, 'Here, I\'d like to give you this token of my love.', 11723, 1, 1, -1, scriptid2, 461);
	
END??
CREATE PROCEDURE `add_migration`()
BEGIN
DECLARE v INT DEFAULT 1;
SET v = (SELECT COUNT(*) FROM `migrations` WHERE `id`='20180209140903');
IF v=0 THEN
INSERT INTO `migrations` VALUES ('20180209140903');
-- Add your query below.

-- Correct broadcast id to one that has both genders.
UPDATE `npc_text` SET `BroadcastTextID0`=11759 WHERE `ID`=8263;
UPDATE `npc_text` SET `BroadcastTextID0`=11724 WHERE `ID`=8244;

-- Amorous timer aura
REPLACE INTO `game_event_creature_data`
SELECT guid, id, 0, 0, 27742, 0, 8 FROM creature c  WHERE c.id in (
    SELECT distinct ct.entry FROM creature_template ct 
	WHERE ct.ScriptName = 'guard_darnassus' OR
	      ct.ScriptName = 'guard_ironforge' OR
	      ct.ScriptName = 'guard_orgrimmar' OR
	      ct.ScriptName = 'guard_stormwind' OR
	      ct.ScriptName = 'guard_bluffwatcher' OR
	      ct.ScriptName = 'guard_undercity' OR
         entry IN (5178,14723,14724,5174,5119,5132,5112,5140,5570,4259,5120,5170,5122,5109,5155,5160,5159,6382,5158,5175,5177,10276,5157,11029,5127,5153,3979,5150,15119,5162,5161,7978,5101,7944,
			5130,5049,5123,5106,5107,5126,5138,5137,5115,5116,5117,2092,1246,10277,11065,11028,1466,1703,5128,5108,5129,5121,5144,5145,5146,7312,5125,5124,4256,4254,5147,5148,5149,10090,9099,2489,
			5141,5142,5143,11406,5110,5151,5637,5156,5165,5166,5167,2790,5169,6291,8681,9984,5154,3842,5100,5163,1274,1356,1365,2695,2737,2786,2916,2918,2943,4081,5605,6031,6114,6120,6169,6175,6178,
			6179,6294,7298,7936,8256,8507,8517,9616,10455,10456,10877,13444,14183,16009,16013,16070,7292,5133,5171,5172,5173,1901,5113,5114,11865,13084,5102,5103,5152,7976,338,1313,1257,14722,5081,
			4981,1307,1346,5509,1321,1305,1311,5512,1324,1298,1297,1646,1291,1299,1339,5483,5482,5520,5504,5505,5506,1318,5519,5499,5511,1317,5518,5564,5567,5384,1304,2327,5494,5493,1302,1285,4974,
			5510,1310,1141,1323,1303,5503,5502,5566,1439,2285,5515,5516,5517,5500,957,11068,11026,11096,1300,1295,1320,5565,1316,1440,2504,1314,5497,5498,1294,1341,1349,331,482,340,9584,277,5514,5513,
			483,14497,5491,5492,2879,1326,2485,376,5484,5489,11397,1275,1308,1351,1309,1350,918,13283,1325,1319,1292,9977,11069,1348,1315,10782,14481,5193,1347,1327,1286,1333,279,297,656,1212,1413,
			1414,1415,1416,1427,1428,1431,1432,1435,1444,1472,1477,1478,1721,1752,2198,2330,2708,2795,3627,3629,4078,4960,5386,5413,6089,6122,6171,6173,6174,6267,6579,11827,11828,11916,14450,1312,461,
			5495,5496,914,5479,5480,11867,1287,1289,7232,1301,4226,14725,4160,4212,4232,4230,4171,4173,4175,4223,4210,4217,4218,4219,4228,11042,4213,11081,4159,2912,4211,4221,4222,4156,4167,4181,4170,
			4241,4161,4216,4204,7999,4138,4146,4205,11041,11070,11083,11050,4236,4225,4233,4177,4169,4164,8665,10089,3561,4165,4090,4091,4092,11401,3562,4220,4753,4172,4163,4214,4215,4240,6292,10056,
			4234,5047,5191,4168,4235,4229,4180,2796,3517,4088,5782,6034,6142,7296,7313,7740,8026,11700,11709,4087,4089,7315,11866,4203,4231,4610,4611,4576,4590,4597,4569,7683,4581,4604,5821,8403,4553,
			4552,5753,4617,4587,2050,4609,4596,4616,11031,4588,11049,4591,4574,4573,4571,4555,4613,5052,4603,4559,4560,5819,4615,4614,14729,11044,4605,11067,4586,223,11048,5820,4589,4558,4566,4567,4568,
			4578,4599,4598,4554,4585,2492,4606,4607,4608,4562,4575,4580,4582,4583,4584,2055,5204,5731,5732,5733,5734,7087,10053,4570,5190,4577,4592,4561,4775,1498,2227,2308,2799,2802,2934,4486,4488,4572,
			5651,5661,5663,5664,5665,5668,5669,5670,5675,5679,5693,5696,5698,5699,5700,5701,5703,5704,5705,5706,5707,5744,5747,6293,6411,6467,6522,6566,7297,7825,8390,8393,10136,10879,11835,10781,5754,
			4563,4564,4565,4593,4594,4595,11870,4600,4601,4602,4556,4557,3010,3007,3019,8364,3016,2999,3015,3003,3092,8358,3027,3026,3033,3034,3036,3012,3009,2998,3011,11084,3004,2798,3029,3028,3017,8362,
			5054,3018,3095,3014,3013,14728,3038,3039,3040,11047,10278,11071,3008,11051,3093,8359,3005,3020,11833,3048,3049,8360,3025,3002,3001,10086,5957,8401,3044,3045,3046,8361,3419,3030,3031,3032,7089,
			10054,3022,3021,5189,8363,8398,2987,3024,3037,3050,3441,3447,3978,4309,4310,4451,4721,4943,5543,5599,5769,5770,5906,6393,6410,8664,9076,9087,3023,3041,3042,3043,11869,2997,3348,7230,3355,
			11017,3369,3356,3331,3410,3315,3316,3400,3399,5815,6986,6987,3346,3413,3347,1383,3345,3412,3365,3363,3373,15116,3333,3332,3342,3313,3350,3370,3322,5812,3405,3404,5994,14726,14727,3352,3406,3407,
			11046,10266,11066,2857,5811,2855,3321,3366,3317,3360,5882,5883,5885,7311,3319,3312,3368,3358,3357,3329,10088,3334,5958,6014,6018,3323,3335,4752,3327,3328,3344,3403,13417,7088,8404,9988,3330,
			3349,14480,5188,3364,7793,3367,5817,4043,3189,3216,3371,3372,3402,4485,5597,5603,5606,5609,5610,5611,5613,5614,5639,5640,5875,5892,5909,5910,6446,7010,7294,7790,7792,7951,8659,9317,9550,14451,
			14498,16007,16012,16076,5816,3359,3324,3325,3326,3353,3354,3408,2704,11868,3314,3361,3409,7231));

-- Guards fix gossip option order
UPDATE `gossip_menu_option` SET `id`=12 WHERE `menu_id`=435 && `option_text`='Class Trainer';
UPDATE `gossip_menu_option` SET `id`=13 WHERE `menu_id`=435 && `option_text`='Profession Trainer';
UPDATE `gossip_menu_option` SET `id`=10 WHERE `menu_id`=2121 && `option_text`='Class Trainer';
UPDATE `gossip_menu_option` SET `id`=11 WHERE `menu_id`=2121 && `option_text`='Profession Trainer';
UPDATE `gossip_menu_option` SET `id`=11 WHERE `menu_id`=1951 && `option_text`='A class trainer';
UPDATE `gossip_menu_option` SET `id`=12 WHERE `menu_id`=1951 && `option_text`='A profession trainer';
UPDATE `gossip_menu_option` SET `id`=10 WHERE `menu_id`=2849 && `option_text`='A class trainer';
UPDATE `gossip_menu_option` SET `id`=11 WHERE `menu_id`=2849 && `option_text`='A profession trainer';


-- Conditions
REPLACE INTO `conditions` VALUES 
(440, 12, 8, 0),      -- Valentines Active
(441, 32, 27741, 0),  -- Source has Love buff
(442, 32, 26869, 0),  -- Source has Amorous buff
(443, 34, 1, 0),      -- Source Gender Female
(444, 34, 0, 0),      -- Source Gender Male
(445, 11, 26682, 0),  -- Player has no Perfume
(446, 11, 26681, 0),  -- Player has no Cologne
(447, 2, 21815, 1),   -- Player has Love Token
(448, 11, 26680, 0),  -- Player has no Adored debuff
(449, 11, 26898, 0),  -- Player has no Heartbroken debuff
(450, 1, 26680, 0),   -- Player has Adored debuff

(451, -2, 441, 442),  -- Source has Love or Amorous buff
(452, -1, 443, 446),  -- Player has no Cologne and source is female
(453, -1, 444, 445),  -- Player has no Perfume and source is male
(454, -1, 451, 452),  -- Love buff and no cologne
(455, -1, 451, 453),  -- Love buff and no perfume
(456, -2, 452, 453),  -- Player has no scent buff
(457, -3, 456, 0),    -- Player has correct scent buff
(458, -1, 451, 457),  -- Love buff and scent buff
(459, -1, 458, 447),  -- Love buff and scent buff and love token
(460, -1, 459, 449),  -- Love buff and scent buff and love token and no heartbroken
(461, -1, 460, 448),  -- Love buff and scent buff and love token and no heartbroken and no adored
(462, -1, 460, 450);  -- Love buff and scent buff and love token and no heartbroken and adored


-- Gossip Scripts
DELETE FROM `gossip_scripts` WHERE `id` in (400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423);
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES 

(400, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Guard - Love is in the Air - Remove Love is in the Air'),
(400, 0, 15, 27242, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Guard - Love is in the Air - Give Pledge of Friendship'),
(400, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Guard - Love is in the Air - Remove Love Token'),
(401, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Guard - Love is in the Air - Remove Love is in the Air'),
(401, 0, 39, 401, 400, 0, 0, 0, 0, 0, 0, 75, 25, 0, 0, 0, 0, 0, 0, 'Stormwind Guard - Love is in the Air - Adored or Heartbroken'),

(402, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Citizen - Love is in the Air - Remove Love is in the Air'),
(402, 0, 15, 27525, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Citizen - Love is in the Air - Give Gift of Friendship'),
(402, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Citizen - Love is in the Air - Remove Love Token'),
(403, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Citizen - Love is in the Air - Remove Love is in the Air'),
(403, 0, 39, 402, 400, 0, 0, 0, 0, 0, 0, 75, 25, 0, 0, 0, 0, 0, 0, 'Stormwind Citizen - Love is in the Air - Adored or Heartbroken'),

(404, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Guard - Love is in the Air - Remove Love is in the Air'),
(404, 0, 15, 27244, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Guard - Love is in the Air - Give Pledge of Friendship'),
(404, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Guard - Love is in the Air - Remove Love Token'),
(405, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Guard - Love is in the Air - Remove Love is in the Air'),
(405, 0, 39, 403, 400, 0, 0, 0, 0, 0, 0, 75, 25, 0, 0, 0, 0, 0, 0, 'Ironforge Guard - Love is in the Air - Adored or Heartbroken'),

(406, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Citizen - Love is in the Air - Remove Love is in the Air'),
(406, 0, 15, 27520, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Citizen - Love is in the Air - Give Gift of Friendship'),
(406, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Citizen - Love is in the Air - Remove Love Token'),
(407, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Citizen - Love is in the Air - Remove Love is in the Air'),
(407, 0, 39, 404, 400, 0, 0, 0, 0, 0, 0, 75, 25, 0, 0, 0, 0, 0, 0, 'Ironforge Citizen - Love is in the Air - Adored or Heartbroken'),

(408, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassus Guard - Love is in the Air - Remove Love is in the Air'),
(408, 0, 15, 27245, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassus Guard - Love is in the Air - Give Pledge of Friendship'),
(408, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassus Guard - Love is in the Air - Remove Love Token'),
(409, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassus Guard - Love is in the Air - Remove Love is in the Air'),
(409, 0, 39, 405, 400, 0, 0, 0, 0, 0, 0, 75, 25, 0, 0, 0, 0, 0, 0, 'Darnassus Guard - Love is in the Air - Adored or Heartbroken'),

(410, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassus Citizen - Love is in the Air - Remove Love is in the Air'),
(410, 0, 15, 27519, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassus Citizen - Love is in the Air - Give Gift of Friendship'),
(410, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassus Citizen - Love is in the Air - Remove Love Token'),
(411, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassus Citizen - Love is in the Air - Remove Love is in the Air'),
(411, 0, 39, 406, 400, 0, 0, 0, 0, 0, 0, 75, 25, 0, 0, 0, 0, 0, 0, 'Darnassus Citizen - Love is in the Air - Adored or Heartbroken'),

(412, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Guard - Love is in the Air - Remove Love is in the Air'),
(412, 0, 15, 27247, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Guard - Love is in the Air - Give Pledge of Friendship'),
(412, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Guard - Love is in the Air - Remove Love Token'),
(413, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Guard - Love is in the Air - Remove Love is in the Air'),
(413, 0, 39, 407, 400, 0, 0, 0, 0, 0, 0, 75, 25, 0, 0, 0, 0, 0, 0, 'Orgrimmar Guard - Love is in the Air - Adored or Heartbroken'),

(414, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Citizen - Love is in the Air - Remove Love is in the Air'),
(414, 0, 15, 27523, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Citizen - Love is in the Air - Give Gift of Friendship'),
(414, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Citizen - Love is in the Air - Remove Love Token'),
(415, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Citizen - Love is in the Air - Remove Love is in the Air'),
(415, 0, 39, 408, 400, 0, 0, 0, 0, 0, 0, 75, 25, 0, 0, 0, 0, 0, 0, 'Orgrimmar Citizen - Love is in the Air - Adored or Heartbroken'),

(416, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Guard - Love is in the Air - Remove Love is in the Air'),
(416, 0, 15, 27246, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Guard - Love is in the Air - Give Pledge of Friendship'),
(416, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Guard - Love is in the Air - Remove Love Token'),
(417, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Guard - Love is in the Air - Remove Love is in the Air'),
(417, 0, 39, 409, 400, 0, 0, 0, 0, 0, 0, 75, 25, 0, 0, 0, 0, 0, 0, 'Undercity Guard - Love is in the Air - Adored or Heartbroken'),

(418, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Citizen - Love is in the Air - Remove Love is in the Air'),
(418, 0, 15, 27529, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Citizen - Love is in the Air - Give Gift of Friendship'),
(418, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Citizen - Love is in the Air - Remove Love Token'),
(419, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Citizen - Love is in the Air - Remove Love is in the Air'),
(419, 0, 39, 410, 400, 0, 0, 0, 0, 0, 0, 75, 25, 0, 0, 0, 0, 0, 0, 'Undercity Citizen - Love is in the Air - Adored or Heartbroken'),

(420, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Thunder Bluff Guard - Love is in the Air - Remove Love is in the Air'),
(420, 0, 15, 27248, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thunder Bluff Guard - Love is in the Air - Give Pledge of Friendship'),
(420, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Thunder Bluff Guard - Love is in the Air - Remove Love Token'),
(421, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Thunder Bluff Guard - Love is in the Air - Remove Love is in the Air'),
(421, 0, 39, 411, 400, 0, 0, 0, 0, 0, 0, 75, 25, 0, 0, 0, 0, 0, 0, 'Thunder Bluff Guard - Love is in the Air - Adored or Heartbroken'),

(422, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Thunder Bluff Citizen - Love is in the Air - Remove Love is in the Air'),
(422, 0, 15, 27524, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thunder Bluff Citizen - Love is in the Air - Give Gift of Friendship'),
(422, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Thunder Bluff Citizen - Love is in the Air - Remove Love Token'),
(423, 0, 14, 27741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Thunder Bluff Citizen - Love is in the Air - Remove Love is in the Air'),
(423, 0, 39, 412, 400, 0, 0, 0, 0, 0, 0, 75, 25, 0, 0, 0, 0, 0, 0, 'Thunder Bluff Citizen - Love is in the Air - Adored or Heartbroken');


-- Event Scripts
DELETE FROM `event_scripts` WHERE `id` in (400,401,402,403,404,405,406,407,408,409,410,411,412);
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `datalong3`, `datalong4`, `buddy_id`, `buddy_radius`, `buddy_type`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`) VALUES 
(400, 0, 15, 26898, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Love is in the Air - Cast Heartbroken'),
(401, 0, 15, 26680, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Guard - Love is in the Air - Cast Adored'),
(401, 0, 15, 27510, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Guard - Love is in the Air - Give Pledge of Adoration'),
(401, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Guard - Love is in the Air - Remove Love Token'),
(402, 0, 15, 26680, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Citizen - Love is in the Air - Cast Adored'),
(402, 0, 15, 27509, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Citizen - Love is in the Air - Give Gift of Adoration'),
(402, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormwind Citizen - Love is in the Air - Remove Love Token'),
(403, 0, 15, 26680, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Guard - Love is in the Air - Cast Adored'),
(403, 0, 15, 27506, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Guard - Love is in the Air - Give Pledge of Adoration'),
(403, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Guard - Love is in the Air - Remove Love Token'),
(404, 0, 15, 26680, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Citizen - Love is in the Air - Cast Adored'),
(404, 0, 15, 27503, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Citizen - Love is in the Air - Give Gift of Adoration'),
(404, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironforge Citizen - Love is in the Air - Remove Love Token'),
(405, 0, 15, 26680, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassus Guard - Love is in the Air - Cast Adored'),
(405, 0, 15, 27504, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassus Guard - Love is in the Air - Give Pledge of Adoration'),
(405, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassus Guard - Love is in the Air - Remove Love Token'),
(406, 0, 15, 26680, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassus Citizen - Love is in the Air - Cast Adored'),
(406, 0, 15, 26901, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassus Citizen - Love is in the Air - Give Gift of Adoration'),
(406, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Darnassus Citizen - Love is in the Air - Remove Love Token'),
(407, 0, 15, 26680, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Guard - Love is in the Air - Cast Adored'),
(407, 0, 15, 27507, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Guard - Love is in the Air - Give Pledge of Adoration'),
(407, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Guard - Love is in the Air - Remove Love Token'),
(408, 0, 15, 26680, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Citizen - Love is in the Air - Cast Adored'),
(408, 0, 15, 27505, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Citizen - Love is in the Air - Give Gift of Adoration'),
(408, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Orgrimmar Citizen - Love is in the Air - Remove Love Token'),
(409, 0, 15, 26680, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Guard - Love is in the Air - Cast Adored'),
(409, 0, 15, 27515, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Guard - Love is in the Air - Give Pledge of Adoration'),
(409, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Guard - Love is in the Air - Remove Love Token'),
(410, 0, 15, 26680, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Citizen - Love is in the Air - Cast Adored'),
(410, 0, 15, 27512, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Citizen - Love is in the Air - Give Gift of Adoration'),
(410, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Undercity Citizen - Love is in the Air - Remove Love Token'),
(411, 0, 15, 26680, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thunder Bluff Guard - Love is in the Air - Cast Adored'),
(411, 0, 15, 27513, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thunder Bluff Guard - Love is in the Air - Give Pledge of Adoration'),
(411, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Thunder Bluff Guard - Love is in the Air - Remove Love Token'),
(412, 0, 15, 26680, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thunder Bluff Citizen - Love is in the Air - Cast Adored'),
(412, 0, 15, 27511, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thunder Bluff Citizen - Love is in the Air - Give Gift of Adoration'),
(412, 0, 40, 21815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Thunder Bluff Citizen - Love is in the Air - Remove Love Token');


-- Fill existing gossip data for creature with gossip_menu_id = 0
SET @pos := 9000;
UPDATE creature_template SET gossip_menu_id = ( SELECT @pos := @pos + 1 ) 
WHERE entry IN (223,279,297,338,340,482,656,957,1141,1212,1246,1257,1274,1275,1285,1286,1287,1289,1291,1292,1294,1295,1297,1298,1299,1300,1301,1303,1304,1305,1307,1308,1309,1310,1311,1312,
      1313,1314,1315,1316,1317,1318,1319,1320,1321,1324,1325,1327,1339,1341,1346,1347,1348,1349,1350,1351,1356,1365,1383,1413,1414,1415,1416,1427,1428,1431,1432,1435,1439,1440,1444,1466,1472,
		1477,1478,1498,1646,1703,1721,1752,2050,2055,2092,2198,2227,2285,2308,2330,2504,2695,2708,2737,2786,2790,2795,2796,2799,2802,2855,2857,2912,2916,2918,2934,2943,2987,2997,2998,2999,3001,
		3002,3003,3004,3005,3007,3008,3009,3010,3011,3012,3013,3014,3015,3016,3017,3018,3019,3020,3021,3022,3023,3024,3025,3026,3027,3028,3029,3037,3050,3092,3093,3095,3189,3312,3313,3314,3315,
		3316,3317,3319,3321,3322,3323,3327,3329,3330,3331,3332,3333,3334,3335,3342,3345,3346,3347,3348,3349,3350,3355,3356,3357,3358,3359,3360,3361,3363,3364,3365,3366,3367,3368,3369,3370,3371,
		3372,3399,3400,3402,3404,3405,3409,3410,3412,3413,3419,3441,3447,3517,3561,3562,3627,3629,3842,3978,3979,4043,4078,4081,4088,4156,4159,4160,4161,4164,4167,4168,4169,4170,4171,4172,4173,
		4175,4177,4180,4181,4203,4204,4210,4212,4213,4216,4220,4221,4222,4223,4225,4226,4228,4229,4230,4231,4232,4233,4234,4235,4236,4240,4241,4254,4256,4259,4309,4310,4451,4485,4486,4552,4553,
		4554,4555,4556,4557,4558,4559,4560,4561,4562,4569,4570,4571,4572,4573,4574,4575,4576,4577,4578,4580,4581,4582,4584,4585,4586,4587,4588,4589,4590,4592,4596,4597,4598,4599,4600,4601,4602,
		4603,4604,4605,4609,4610,4611,4613,4614,4615,4616,4617,4721,4752,4753,4775,4943,4960,4974,4981,5047,5049,5052,5054,5081,5100,5101,5102,5103,5106,5107,5108,5109,5110,5112,5119,5120,5121,
		5122,5123,5124,5125,5126,5127,5128,5129,5130,5132,5133,5137,5138,5140,5151,5152,5153,5154,5155,5156,5157,5158,5159,5160,5161,5162,5163,5169,5170,5174,5175,5177,5178,5188,5189,5190,5191,
		5193,5204,5384,5386,5413,5482,5483,5493,5499,5500,5502,5503,5509,5510,5511,5512,5513,5514,5518,5519,5543,5564,5565,5566,5567,5570,5597,5599,5603,5605,5606,5609,5610,5611,5613,5614,5637,
		5639,5640,5651,5661,5663,5664,5665,5668,5669,5670,5675,5679,5693,5696,5698,5699,5700,5701,5703,5704,5705,5706,5707,5731,5732,5733,5734,5744,5747,5754,5769,5770,5782,5811,5812,5816,5817,
		5819,5820,5821,5875,5892,5906,5909,5910,6031,6034,6089,6114,6120,6122,6142,6169,6171,6173,6174,6175,6178,6179,6267,6291,6292,6293,6294,6393,6410,6411,6446,6467,6522,6579,6986,6987,
		7010,7087,7088,7089,7230,7231,7232,7292,7294,7296,7297,7298,7313,7683,7740,7790,7792,7793,7825,7936,7944,7951,7976,7978,7999,8026,8256,8358,8359,8360,8361,8362,8363,8364,8390,8393,8398,
		8401,8403,8404,8507,8517,8659,8664,8665,8681,9076,9087,9099,9317,9550,9584,9616,9977,9984,9988,10053,10054,10056,10136,10266,10276,10277,10278,10455,10456,10781,10782,10877,10879,11017,
		11026,11028,11031,11041,11042,11044,11046,11047,11048,11049,11050,11051,11065,11066,11067,11068,11069,11070,11071,11081,11083,11084,11096,11700,11709,11827,11828,11833,11835,11916,13444,
		14183,14450,14451,14480,14481,14497,14498,14722,14723,14724,14725,14726,14727,14728,14729,16007,16009,16012,16013,16070,16076);

REPLACE INTO `gossip_menu`
select distinct ct.gossip_menu_id, n.textid, 0 from npc_gossip n
inner join creature c on c.guid = n.npc_guid
inner join creature_template ct on c.id = ct.entry
where ct.gossip_menu_id <> 0 and ct.entry in (223,279,297,338,340,482,656,957,1141,1212,1246,1257,1274,1275,1285,1286,1287,1289,1291,1292,1294,1295,1297,1298,1299,1300,1301,1303,1304,1305,1307,1308,1309,1310,1311,1312,
      1313,1314,1315,1316,1317,1318,1319,1320,1321,1324,1325,1327,1339,1341,1346,1347,1348,1349,1350,1351,1356,1365,1383,1413,1414,1415,1416,1427,1428,1431,1432,1435,1439,1440,1444,1466,1472,
		1477,1478,1498,1646,1703,1721,1752,2050,2055,2092,2198,2227,2285,2308,2330,2504,2695,2708,2737,2786,2790,2795,2796,2799,2802,2855,2857,2912,2916,2918,2934,2943,2987,2997,2998,2999,3001,
		3002,3003,3004,3005,3007,3008,3009,3010,3011,3012,3013,3014,3015,3016,3017,3018,3019,3020,3021,3022,3023,3024,3025,3026,3027,3028,3029,3037,3050,3092,3093,3095,3189,3312,3313,3314,3315,
		3316,3317,3319,3321,3322,3323,3327,3329,3330,3331,3332,3333,3334,3335,3342,3345,3346,3347,3348,3349,3350,3355,3356,3357,3358,3359,3360,3361,3363,3364,3365,3366,3367,3368,3369,3370,3371,
		3372,3399,3400,3402,3404,3405,3409,3410,3412,3413,3419,3441,3447,3517,3561,3562,3627,3629,3842,3978,3979,4043,4078,4081,4088,4156,4159,4160,4161,4164,4167,4168,4169,4170,4171,4172,4173,
		4175,4177,4180,4181,4203,4204,4210,4212,4213,4216,4220,4221,4222,4223,4225,4226,4228,4229,4230,4231,4232,4233,4234,4235,4236,4240,4241,4254,4256,4259,4309,4310,4451,4485,4486,4552,4553,
		4554,4555,4556,4557,4558,4559,4560,4561,4562,4569,4570,4571,4572,4573,4574,4575,4576,4577,4578,4580,4581,4582,4584,4585,4586,4587,4588,4589,4590,4592,4596,4597,4598,4599,4600,4601,4602,
		4603,4604,4605,4609,4610,4611,4613,4614,4615,4616,4617,4721,4752,4753,4775,4943,4960,4974,4981,5047,5049,5052,5054,5081,5100,5101,5102,5103,5106,5107,5108,5109,5110,5112,5119,5120,5121,
		5122,5123,5124,5125,5126,5127,5128,5129,5130,5132,5133,5137,5138,5140,5151,5152,5153,5154,5155,5156,5157,5158,5159,5160,5161,5162,5163,5169,5170,5174,5175,5177,5178,5188,5189,5190,5191,
		5193,5204,5384,5386,5413,5482,5483,5493,5499,5500,5502,5503,5509,5510,5511,5512,5513,5514,5518,5519,5543,5564,5565,5566,5567,5570,5597,5599,5603,5605,5606,5609,5610,5611,5613,5614,5637,
		5639,5640,5651,5661,5663,5664,5665,5668,5669,5670,5675,5679,5693,5696,5698,5699,5700,5701,5703,5704,5705,5706,5707,5731,5732,5733,5734,5744,5747,5754,5769,5770,5782,5811,5812,5816,5817,
		5819,5820,5821,5875,5892,5906,5909,5910,6031,6034,6089,6114,6120,6122,6142,6169,6171,6173,6174,6175,6178,6179,6267,6291,6292,6293,6294,6393,6410,6411,6446,6467,6522,6579,6986,6987,
		7010,7087,7088,7089,7230,7231,7232,7292,7294,7296,7297,7298,7313,7683,7740,7790,7792,7793,7825,7936,7944,7951,7976,7978,7999,8026,8256,8358,8359,8360,8361,8362,8363,8364,8390,8393,8398,
		8401,8403,8404,8507,8517,8659,8664,8665,8681,9076,9087,9099,9317,9550,9584,9616,9977,9984,9988,10053,10054,10056,10136,10266,10276,10277,10278,10455,10456,10781,10782,10877,10879,11017,
		11026,11028,11031,11041,11042,11044,11046,11047,11048,11049,11050,11051,11065,11066,11067,11068,11069,11070,11071,11081,11083,11084,11096,11700,11709,11827,11828,11833,11835,11916,13444,
		14183,14450,14451,14480,14481,14497,14498,14722,14723,14724,14725,14726,14727,14728,14729,16007,16009,16012,16013,16070,16076);
		
-- Questgiver menu options
REPLACE INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`) 
SELECT gossip_menu_id, 0, 0, 'GOSSIP_OPTION_QUESTGIVER', 0, 2, 2 FROM creature_template WHERE entry IN (223,279,297,338,482,656,1141,1212,1274,1309,1356,1365,1416,1427,1428,1431,1432,1435,1439,1440,1444,
		2227,2285,2308,2504,2695,2708,2786,2790,2855,2857,2912,2916,2918,2934,2987,2998,2999,3002,3003,3005,3007,3008,3009,3010,3012,3014,3016,3017,3025,3026,3027,3028,3029,3050,3189,3312,3313,3327,3332,
		3333,3346,3350,3355,3356,3363,3364,3365,3366,3367,3368,3369,3399,3400,3402,3405,3412,3413,3419,3441,3447,3517,3842,3978,3979,4078,4081,4088,4156,4159,4160,4167,4168,4169,4170,4181,4204,4210,4212,
		4216,4221,4222,4223,4225,4226,4228,4229,4230,4241,4256,4259,4309,4310,4451,4485,4486,4552,4553,4554,4555,4556,4561,4571,4573,4574,4576,4577,4578,4581,4582,4584,4586,4587,4588,4589,4590,4596,4597,
		4599,4605,4609,4610,4611,4615,4617,4721,4775,4943,4960,5081,5112,5140,5154,5159,5161,5162,5163,5174,5204,5384,5386,5413,5512,5518,5543,5566,5570,5599,5605,5611,5637,5639,5640,5651,5675,5679,5693,
		5769,5770,5782,5811,5817,5875,5892,5906,5909,5910,6031,6034,6089,6114,6120,6122,6142,6169,6171,6173,6174,6175,6178,6179,6292,6293,6294,6393,6410,6411,6446,6467,6522,6579,6986,6987,7010,7087,7088,
		7089,7292,7313,7683,7740,7790,7792,7793,7825,7936,7944,7978,7999,8026,8256,8359,8362,8363,8364,8390,8393,8401,8403,8404,8507,8517,8659,8664,9076,9087,9317,9550,9616,10136,10278,10781,10782,10877,
		10879,11017,11028,11031,11041,11042,11044,11047,11048,11049,11050,11051,11067,11070,11071,11081,11083,11084,11700,11709,11827,11828,11833,11835,13444,14183,14450,14451,14480,14481,14722,14723,14724,
		14725,14726,14727,14728,14729,16007,16009,16012,16013,1466,1498,1646,1703,1721,2050,2055,2092,2198);

-- Vendor menu options
REPLACE INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`) 
SELECT gossip_menu_id, 1, 1, 'I want to browse your goods.', 3370, 3, 4 FROM creature_template WHERE entry IN (340,1257,1275,1285,1286,1287,1289,1291,1294,1295,1297,1298,1299,1301,1303,1304,1305,1307,1308,1309,
		1310,1311,1312,1313,1314,1315,1316,1318,1319,1320,1321,1324,1325,1339,1341,1347,1348,1349,1350,1351,2997,2999,3002,3003,3005,3010,3012,3014,3015,3016,3017,3018,3019,3020,3021,3022,3023,3025,3027,3029,
		3092,3093,3095,3312,3313,3314,3315,3316,3317,3319,3321,3322,3323,3329,3330,3331,3333,3334,3335,3342,3346,3348,3349,3350,3356,3358,3359,3360,3361,3364,3366,3367,3368,3369,3400,3405,3409,3410,3413,3561,
		3562,4043,4164,4167,4168,4169,4170,4171,4172,4173,4175,4177,4180,4181,4203,4216,4220,4221,4222,4223,4225,4226,4228,4229,4230,4231,4232,4233,4234,4235,4236,4240,4241,4256,4259,4553,4554,4555,4556,4557,
		4558,4559,4560,4561,4562,4569,4570,4571,4574,4575,4577,4580,4581,4585,4587,4589,4590,4592,4597,4599,4600,4601,4602,4603,4604,4610,4615,4617,4775,4981,5049,5052,5100,5101,5102,5103,5106,5107,5108,5109,
		5110,5112,5119,5120,5121,5122,5123,5124,5125,5126,5128,5129,5132,5133,5138,5140,5151,5152,5154,5155,5156,5158,5160,5162,5163,5169,5170,5175,5178,5188,5189,5190,5191,5193,5483,5503,5509,5510,5512,5514,
		5519,5565,5570,5611,5754,5812,5816,5817,5819,5820,5821,7231,7683,7976,7978,8358,8359,8360,8361,8362,8363,8364,8398,8401,8403,8404,8665,8681,9087,9099,14450,14480,14481);

-- Trainer menu options
REPLACE INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`) 
SELECT gossip_menu_id, 3, 3, 'Train me.', 3266, 5, 16 FROM creature_template WHERE entry IN (223,957,1246,1292,1300,1317,1346,1383,1466,1703,2802,2855,2857,2998,3001,3004,3007,3008,3009,
		3011,3013,3026,3028,3327,3332,3345,3347,3355,3357,3363,3365,3399,3404,3412,4156,4159,4160,4204,4210,4212,4213,4254,4552,4573,4576,4578,4582,4584,4586,4588,4596,4598,4605,4609,4611,4614,4616,4752,4753,
		5127,5137,5153,5157,5159,5161,5174,5177,5482,5493,5499,5500,5502,5511,5513,5518,5564,5566,5567,5811,6291,6292,7087,7088,7089,7230,7231,7232,7944,8665,9584,10266,10276,10277,10278,11017,11026,11028,
		11031,11041,11042,11044,11046,11047,11048,11049,11050,11051,11065,11066,11067,11068,11070,11071,11081,11083,11084,11096);

-- Guild creation menu options
REPLACE INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`) 
SELECT gossip_menu_id,  8, 7, 'How do I form a guild?', 3413, 10, 512 FROM creature_template WHERE entry IN (3370,4161,4613,4974,5054,5130);
REPLACE INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`) 
SELECT gossip_menu_id,  9, 8, 'I want to create a guild crest.', 3415, 11, 1024 FROM creature_template WHERE entry IN (3370,4161,4613,4974,5049,5052,5054,5130,5188,5189,5190,5191,5193);

-- Stable menu options
REPLACE INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`) 
SELECT gossip_menu_id,  12, 0, 'I\'d like to stable my pet here.', 30181, 14, 8192 FROM creature_template WHERE entry IN (9977,9984,9988,10053,10054,10056,11069);

-- Armorer menu options
REPLACE INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `OptionBroadcastTextID`, `option_id`, `npc_option_npcflag`) 
SELECT gossip_menu_id,  13, 1, 'GOSSIP_OPTION_ARMORER', 3370, 15, 16384 FROM creature_template WHERE entry IN (1287,1289,1291,1294,1295,1297,1298,1299,1309,1310,1312,1314,1315,1319,1320,1324,1339,1341,
		1348,1349,1350,2997,2999,3015,3018,3019,3020,3021,3022,3023,3092,3093,3095,3314,3315,3316,3317,3319,3321,3322,3330,3331,3349,3356,3359,3360,3361,4043,4164,4173,4203,4231,4240,4259,4556,4557,4558,
		4559,4560,4569,4570,4580,4592,4597,4600,4601,4602,4603,4604,5102,5103,5106,5107,5108,5119,5120,5121,5122,5123,5125,5126,5129,5133,5152,5155,5156,5170,5509,5510,5512,5754,5812,5816,5819,5820,5821,
		7976,8358,8359,8360,8398);



-- Fill Guards and Citizens gossip entries

-- 8285   I'd talk to you if you smelled better. Cologne would be nice.
-- 8298   I'd like you better if you would apply some perfume.
-- 8291   What, you don't have a token to give me?
-- 8283   You look like you've had your heart broken.
-- 8296   It looks like you've already found love.
-- 8244   We've been so wrapped up in this war
-- 8254   You work with machines for so long
-- 8263   We orcs are usually a private people
-- 8255   When you have lived as long as I

-- First param is creature template id
-- Second param is text id of text shown when ready to give adoration gift
-- Third param is gossip_scripts entry that gives gift of friendship
-- Fourth param is gossip_scripts entry that gives gift of adoration

CALL TempValentineGossip(68,8244,400,401);     -- Stormwind Guard
CALL TempValentineGossip(5624,8255,416,417);   -- Undercity Guard
CALL TempValentineGossip(3296,8263,412,413);   -- Orgrimmar Guard
CALL TempValentineGossip(4262,8244,408,409);   -- Darnassus Guard
CALL TempValentineGossip(5595,8254,404,405);   -- Ironforge Guard
CALL TempValentineGossip(3084,8244,420,421);   -- Thunder Bluff Guard


-- Stormwind Citizens
CALL TempValentineGossip(338,8244,402,403);
CALL TempValentineGossip(1313,8244,402,403);
CALL TempValentineGossip(1257,8244,402,403);
CALL TempValentineGossip(14722,8244,402,403);
CALL TempValentineGossip(5081,8244,402,403);
CALL TempValentineGossip(4981,8244,402,403);
CALL TempValentineGossip(1307,8244,402,403);
CALL TempValentineGossip(1346,8244,402,403);
CALL TempValentineGossip(5509,8244,402,403);
CALL TempValentineGossip(1321,8244,402,403);
CALL TempValentineGossip(1305,8244,402,403);
CALL TempValentineGossip(1311,8244,402,403);
CALL TempValentineGossip(5512,8244,402,403);
CALL TempValentineGossip(1324,8244,402,403);
CALL TempValentineGossip(1298,8244,402,403);
CALL TempValentineGossip(1297,8244,402,403);
CALL TempValentineGossip(1646,8244,402,403);
CALL TempValentineGossip(1291,8244,402,403);
CALL TempValentineGossip(1299,8244,402,403);
CALL TempValentineGossip(1339,8244,402,403);
CALL TempValentineGossip(5483,8244,402,403);
CALL TempValentineGossip(5482,8244,402,403);
CALL TempValentineGossip(5520,8244,402,403);
CALL TempValentineGossip(5504,8244,402,403);
CALL TempValentineGossip(5505,8244,402,403);
CALL TempValentineGossip(5506,8244,402,403);
CALL TempValentineGossip(1318,8244,402,403);
CALL TempValentineGossip(5519,8244,402,403);
CALL TempValentineGossip(5499,8244,402,403);
CALL TempValentineGossip(5511,8244,402,403);
CALL TempValentineGossip(1317,8244,402,403);
CALL TempValentineGossip(5518,8244,402,403);
CALL TempValentineGossip(5564,8244,402,403);
CALL TempValentineGossip(5567,8244,402,403);
CALL TempValentineGossip(5384,8244,402,403);
CALL TempValentineGossip(1304,8244,402,403);
CALL TempValentineGossip(2327,8244,402,403);
CALL TempValentineGossip(5494,8244,402,403);
CALL TempValentineGossip(5493,8244,402,403);
CALL TempValentineGossip(1302,8244,402,403);
CALL TempValentineGossip(1285,8244,402,403);
CALL TempValentineGossip(4974,8244,402,403);
CALL TempValentineGossip(5510,8244,402,403);
CALL TempValentineGossip(1310,8244,402,403);
CALL TempValentineGossip(1141,8244,402,403);
CALL TempValentineGossip(1323,8244,402,403);
CALL TempValentineGossip(1303,8244,402,403);
CALL TempValentineGossip(5503,8244,402,403);
CALL TempValentineGossip(5502,8244,402,403);
CALL TempValentineGossip(5566,8244,402,403);
CALL TempValentineGossip(1439,8244,402,403);
CALL TempValentineGossip(2285,8244,402,403);
CALL TempValentineGossip(5515,8244,402,403);
CALL TempValentineGossip(5516,8244,402,403);
CALL TempValentineGossip(5517,8244,402,403);
CALL TempValentineGossip(5500,8244,402,403);
CALL TempValentineGossip(957,8244,402,403);
CALL TempValentineGossip(11068,8244,402,403);
CALL TempValentineGossip(11026,8244,402,403);
CALL TempValentineGossip(11096,8244,402,403);
CALL TempValentineGossip(1300,8244,402,403);
CALL TempValentineGossip(1295,8244,402,403);
CALL TempValentineGossip(1320,8244,402,403);
CALL TempValentineGossip(5565,8244,402,403);
CALL TempValentineGossip(1316,8244,402,403);
CALL TempValentineGossip(1440,8244,402,403);
CALL TempValentineGossip(2504,8244,402,403);
CALL TempValentineGossip(1314,8244,402,403);
CALL TempValentineGossip(5497,8244,402,403);
CALL TempValentineGossip(5498,8244,402,403);
CALL TempValentineGossip(1294,8244,402,403);
CALL TempValentineGossip(1341,8244,402,403);
CALL TempValentineGossip(1349,8244,402,403);
CALL TempValentineGossip(331,8244,402,403);
CALL TempValentineGossip(482,8244,402,403);
CALL TempValentineGossip(340,8244,402,403);
CALL TempValentineGossip(9584,8244,402,403);
CALL TempValentineGossip(277,8244,402,403);
CALL TempValentineGossip(5514,8244,402,403);
CALL TempValentineGossip(5513,8244,402,403);
CALL TempValentineGossip(483,8244,402,403);
CALL TempValentineGossip(14497,8244,402,403);
CALL TempValentineGossip(5491,8244,402,403);
CALL TempValentineGossip(5492,8244,402,403);
CALL TempValentineGossip(2879,8244,402,403);
CALL TempValentineGossip(1326,8244,402,403);
CALL TempValentineGossip(2485,8244,402,403);
CALL TempValentineGossip(376,8244,402,403);
CALL TempValentineGossip(5484,8244,402,403);
CALL TempValentineGossip(5489,8244,402,403);
CALL TempValentineGossip(11397,8244,402,403);
CALL TempValentineGossip(1275,8244,402,403);
CALL TempValentineGossip(1308,8244,402,403);
CALL TempValentineGossip(1351,8244,402,403);
CALL TempValentineGossip(1309,8244,402,403);
CALL TempValentineGossip(1350,8244,402,403);
CALL TempValentineGossip(918,8244,402,403);
CALL TempValentineGossip(13283,8244,402,403);
CALL TempValentineGossip(1325,8244,402,403);
CALL TempValentineGossip(1319,8244,402,403);
CALL TempValentineGossip(1292,8244,402,403);
CALL TempValentineGossip(9977,8244,402,403);
CALL TempValentineGossip(11069,8244,402,403);
CALL TempValentineGossip(1348,8244,402,403);
CALL TempValentineGossip(1315,8244,402,403);
CALL TempValentineGossip(10782,8244,402,403);
CALL TempValentineGossip(14481,8244,402,403);
CALL TempValentineGossip(5193,8244,402,403);
CALL TempValentineGossip(1347,8244,402,403);
CALL TempValentineGossip(1327,8244,402,403);
CALL TempValentineGossip(1286,8244,402,403);
CALL TempValentineGossip(1333,8244,402,403);
CALL TempValentineGossip(279,8244,402,403);
CALL TempValentineGossip(297,8244,402,403);
CALL TempValentineGossip(656,8244,402,403);
CALL TempValentineGossip(1212,8244,402,403);
CALL TempValentineGossip(1413,8244,402,403);
CALL TempValentineGossip(1414,8244,402,403);
CALL TempValentineGossip(1415,8244,402,403);
CALL TempValentineGossip(1416,8244,402,403);
CALL TempValentineGossip(1427,8244,402,403);
CALL TempValentineGossip(1428,8244,402,403);
CALL TempValentineGossip(1431,8244,402,403);
CALL TempValentineGossip(1432,8244,402,403);
CALL TempValentineGossip(1435,8244,402,403);
CALL TempValentineGossip(1444,8244,402,403);
CALL TempValentineGossip(1472,8244,402,403);
CALL TempValentineGossip(1477,8244,402,403);
CALL TempValentineGossip(1478,8244,402,403);
CALL TempValentineGossip(1721,8244,402,403);
CALL TempValentineGossip(1752,8244,402,403);
CALL TempValentineGossip(2198,8244,402,403);
CALL TempValentineGossip(2330,8244,402,403);
CALL TempValentineGossip(2708,8244,402,403);
CALL TempValentineGossip(2795,8244,402,403);
CALL TempValentineGossip(3627,8244,402,403);
CALL TempValentineGossip(3629,8244,402,403);
CALL TempValentineGossip(4078,8244,402,403);
CALL TempValentineGossip(4960,8244,402,403);
CALL TempValentineGossip(5386,8244,402,403);
CALL TempValentineGossip(5413,8244,402,403);
CALL TempValentineGossip(6089,8244,402,403);
CALL TempValentineGossip(6122,8244,402,403);
CALL TempValentineGossip(6171,8244,402,403);
CALL TempValentineGossip(6173,8244,402,403);
CALL TempValentineGossip(6174,8244,402,403);
CALL TempValentineGossip(6267,8244,402,403);
CALL TempValentineGossip(6579,8244,402,403);
CALL TempValentineGossip(11827,8244,402,403);
CALL TempValentineGossip(11828,8244,402,403);
CALL TempValentineGossip(11916,8244,402,403);
CALL TempValentineGossip(14450,8244,402,403);
CALL TempValentineGossip(1312,8244,402,403);
CALL TempValentineGossip(461,8244,402,403);
CALL TempValentineGossip(5495,8244,402,403);
CALL TempValentineGossip(5496,8244,402,403);
CALL TempValentineGossip(914,8244,402,403);
CALL TempValentineGossip(5479,8244,402,403);
CALL TempValentineGossip(5480,8244,402,403);
CALL TempValentineGossip(11867,8244,402,403);
CALL TempValentineGossip(1287,8244,402,403);
CALL TempValentineGossip(1289,8244,402,403);
CALL TempValentineGossip(7232,8244,402,403);
CALL TempValentineGossip(1301,8244,402,403);

-- Ironforge Citizens
CALL TempValentineGossip(5178,8254,406,407);
CALL TempValentineGossip(14723,8254,406,407);
CALL TempValentineGossip(14724,8254,406,407);
CALL TempValentineGossip(5174,8254,406,407);
CALL TempValentineGossip(5119,8254,406,407);
CALL TempValentineGossip(5132,8254,406,407);
CALL TempValentineGossip(5112,8254,406,407);
CALL TempValentineGossip(5140,8254,406,407);
CALL TempValentineGossip(5570,8254,406,407);
CALL TempValentineGossip(4259,8254,406,407);
CALL TempValentineGossip(5120,8254,406,407);
CALL TempValentineGossip(5170,8254,406,407);
CALL TempValentineGossip(5122,8254,406,407);
CALL TempValentineGossip(5109,8254,406,407);
CALL TempValentineGossip(5155,8254,406,407);
CALL TempValentineGossip(5160,8254,406,407);
CALL TempValentineGossip(5159,8254,406,407);
CALL TempValentineGossip(6382,8254,406,407);
CALL TempValentineGossip(5158,8254,406,407);
CALL TempValentineGossip(5175,8254,406,407);
CALL TempValentineGossip(5177,8254,406,407);
CALL TempValentineGossip(10276,8254,406,407);
CALL TempValentineGossip(5157,8254,406,407);
CALL TempValentineGossip(11029,8254,406,407);
CALL TempValentineGossip(5127,8254,406,407);
CALL TempValentineGossip(5153,8254,406,407);
CALL TempValentineGossip(3979,8254,406,407);
CALL TempValentineGossip(5150,8254,406,407);
CALL TempValentineGossip(15119,8254,406,407);
CALL TempValentineGossip(5162,8254,406,407);
CALL TempValentineGossip(5161,8254,406,407);
CALL TempValentineGossip(7978,8254,406,407);
CALL TempValentineGossip(5101,8254,406,407);
CALL TempValentineGossip(7944,8254,406,407);
CALL TempValentineGossip(5130,8254,406,407);
CALL TempValentineGossip(5049,8254,406,407);
CALL TempValentineGossip(5123,8254,406,407);
CALL TempValentineGossip(5106,8254,406,407);
CALL TempValentineGossip(5107,8254,406,407);
CALL TempValentineGossip(5126,8254,406,407);
CALL TempValentineGossip(5138,8254,406,407);
CALL TempValentineGossip(5137,8254,406,407);
CALL TempValentineGossip(5115,8254,406,407);
CALL TempValentineGossip(5116,8254,406,407);
CALL TempValentineGossip(5117,8254,406,407);
CALL TempValentineGossip(2092,8254,406,407);
CALL TempValentineGossip(1246,8254,406,407);
CALL TempValentineGossip(10277,8254,406,407);
CALL TempValentineGossip(11065,8254,406,407);
CALL TempValentineGossip(11028,8254,406,407);
CALL TempValentineGossip(1466,8254,406,407);
CALL TempValentineGossip(1703,8254,406,407);
CALL TempValentineGossip(5128,8254,406,407);
CALL TempValentineGossip(5108,8254,406,407);
CALL TempValentineGossip(5129,8254,406,407);
CALL TempValentineGossip(5121,8254,406,407);
CALL TempValentineGossip(5144,8254,406,407);
CALL TempValentineGossip(5145,8254,406,407);
CALL TempValentineGossip(5146,8254,406,407);
CALL TempValentineGossip(7312,8254,406,407);
CALL TempValentineGossip(5125,8254,406,407);
CALL TempValentineGossip(5124,8254,406,407);
CALL TempValentineGossip(4256,8254,406,407);
CALL TempValentineGossip(4254,8254,406,407);
CALL TempValentineGossip(5147,8254,406,407);
CALL TempValentineGossip(5148,8254,406,407);
CALL TempValentineGossip(5149,8254,406,407);
CALL TempValentineGossip(10090,8254,406,407);
CALL TempValentineGossip(9099,8254,406,407);
CALL TempValentineGossip(2489,8254,406,407);
CALL TempValentineGossip(5141,8254,406,407);
CALL TempValentineGossip(5142,8254,406,407);
CALL TempValentineGossip(5143,8254,406,407);
CALL TempValentineGossip(11406,8254,406,407);
CALL TempValentineGossip(5110,8254,406,407);
CALL TempValentineGossip(5151,8254,406,407);
CALL TempValentineGossip(5637,8254,406,407);
CALL TempValentineGossip(5156,8254,406,407);
CALL TempValentineGossip(5165,8254,406,407);
CALL TempValentineGossip(5166,8254,406,407);
CALL TempValentineGossip(5167,8254,406,407);
CALL TempValentineGossip(2790,8254,406,407);
CALL TempValentineGossip(5169,8254,406,407);
CALL TempValentineGossip(6291,8254,406,407);
CALL TempValentineGossip(8681,8254,406,407);
CALL TempValentineGossip(9984,8254,406,407);
CALL TempValentineGossip(5154,8254,406,407);
CALL TempValentineGossip(3842,8254,406,407);
CALL TempValentineGossip(5100,8254,406,407);
CALL TempValentineGossip(5163,8254,406,407);
CALL TempValentineGossip(1274,8254,406,407);
CALL TempValentineGossip(1356,8254,406,407);
CALL TempValentineGossip(1365,8254,406,407);
CALL TempValentineGossip(2695,8254,406,407);
CALL TempValentineGossip(2737,8254,406,407);
CALL TempValentineGossip(2786,8254,406,407);
CALL TempValentineGossip(2916,8254,406,407);
CALL TempValentineGossip(2918,8254,406,407);
CALL TempValentineGossip(2943,8254,406,407);
CALL TempValentineGossip(4081,8254,406,407);
CALL TempValentineGossip(5605,8254,406,407);
CALL TempValentineGossip(6031,8254,406,407);
CALL TempValentineGossip(6114,8254,406,407);
CALL TempValentineGossip(6120,8254,406,407);
CALL TempValentineGossip(6169,8254,406,407);
CALL TempValentineGossip(6175,8254,406,407);
CALL TempValentineGossip(6178,8254,406,407);
CALL TempValentineGossip(6179,8254,406,407);
CALL TempValentineGossip(6294,8254,406,407);
CALL TempValentineGossip(7298,8254,406,407);
CALL TempValentineGossip(7936,8254,406,407);
CALL TempValentineGossip(8256,8254,406,407);
CALL TempValentineGossip(8507,8254,406,407);
CALL TempValentineGossip(8517,8254,406,407);
CALL TempValentineGossip(9616,8254,406,407);
CALL TempValentineGossip(10455,8254,406,407);
CALL TempValentineGossip(10456,8254,406,407);
CALL TempValentineGossip(10877,8254,406,407);
CALL TempValentineGossip(13444,8254,406,407);
CALL TempValentineGossip(14183,8254,406,407);
CALL TempValentineGossip(16009,8254,406,407);
CALL TempValentineGossip(16013,8254,406,407);
CALL TempValentineGossip(16070,8254,406,407);
CALL TempValentineGossip(7292,8254,406,407);
CALL TempValentineGossip(5133,8254,406,407);
CALL TempValentineGossip(5171,8254,406,407);
CALL TempValentineGossip(5172,8254,406,407);
CALL TempValentineGossip(5173,8254,406,407);
CALL TempValentineGossip(1901,8254,406,407);
CALL TempValentineGossip(5113,8254,406,407);
CALL TempValentineGossip(5114,8254,406,407);
CALL TempValentineGossip(11865,8254,406,407);
CALL TempValentineGossip(13084,8254,406,407);
CALL TempValentineGossip(5102,8254,406,407);
CALL TempValentineGossip(5103,8254,406,407);
CALL TempValentineGossip(5152,8254,406,407);
CALL TempValentineGossip(7976,8254,406,407);

-- Darnassus Citizens
CALL TempValentineGossip(4226,8244,410,411);
CALL TempValentineGossip(14725,8244,410,411);
CALL TempValentineGossip(4160,8244,410,411);
CALL TempValentineGossip(4212,8244,410,411);
CALL TempValentineGossip(4232,8244,410,411);
CALL TempValentineGossip(4230,8244,410,411);
CALL TempValentineGossip(4171,8244,410,411);
CALL TempValentineGossip(4173,8244,410,411);
CALL TempValentineGossip(4175,8244,410,411);
CALL TempValentineGossip(4223,8244,410,411);
CALL TempValentineGossip(4210,8244,410,411);
CALL TempValentineGossip(4217,8244,410,411);
CALL TempValentineGossip(4218,8244,410,411);
CALL TempValentineGossip(4219,8244,410,411);
CALL TempValentineGossip(4228,8244,410,411);
CALL TempValentineGossip(11042,8244,410,411);
CALL TempValentineGossip(4213,8244,410,411);
CALL TempValentineGossip(11081,8244,410,411);
CALL TempValentineGossip(4159,8244,410,411);
CALL TempValentineGossip(2912,8244,410,411);
CALL TempValentineGossip(4211,8244,410,411);
CALL TempValentineGossip(4221,8244,410,411);
CALL TempValentineGossip(4222,8244,410,411);
CALL TempValentineGossip(4156,8244,410,411);
CALL TempValentineGossip(4167,8244,410,411);
CALL TempValentineGossip(4181,8244,410,411);
CALL TempValentineGossip(4170,8244,410,411);
CALL TempValentineGossip(4241,8244,410,411);
CALL TempValentineGossip(4161,8244,410,411);
CALL TempValentineGossip(4216,8244,410,411);
CALL TempValentineGossip(4204,8244,410,411);
CALL TempValentineGossip(7999,8244,410,411);
CALL TempValentineGossip(4138,8244,410,411);
CALL TempValentineGossip(4146,8244,410,411);
CALL TempValentineGossip(4205,8244,410,411);
CALL TempValentineGossip(11041,8244,410,411);
CALL TempValentineGossip(11070,8244,410,411);
CALL TempValentineGossip(11083,8244,410,411);
CALL TempValentineGossip(11050,8244,410,411);
CALL TempValentineGossip(4236,8244,410,411);
CALL TempValentineGossip(4225,8244,410,411);
CALL TempValentineGossip(4233,8244,410,411);
CALL TempValentineGossip(4177,8244,410,411);
CALL TempValentineGossip(4169,8244,410,411);
CALL TempValentineGossip(4164,8244,410,411);
CALL TempValentineGossip(8665,8244,410,411);
CALL TempValentineGossip(10089,8244,410,411);
CALL TempValentineGossip(3561,8244,410,411);
CALL TempValentineGossip(4165,8244,410,411);
CALL TempValentineGossip(4090,8244,410,411);
CALL TempValentineGossip(4091,8244,410,411);
CALL TempValentineGossip(4092,8244,410,411);
CALL TempValentineGossip(11401,8244,410,411);
CALL TempValentineGossip(3562,8244,410,411);
CALL TempValentineGossip(4220,8244,410,411);
CALL TempValentineGossip(4753,8244,410,411);
CALL TempValentineGossip(4172,8244,410,411);
CALL TempValentineGossip(4163,8244,410,411);
CALL TempValentineGossip(4214,8244,410,411);
CALL TempValentineGossip(4215,8244,410,411);
CALL TempValentineGossip(4240,8244,410,411);
CALL TempValentineGossip(6292,8244,410,411);
CALL TempValentineGossip(10056,8244,410,411);
CALL TempValentineGossip(4234,8244,410,411);
CALL TempValentineGossip(5047,8244,410,411);
CALL TempValentineGossip(5191,8244,410,411);
CALL TempValentineGossip(4168,8244,410,411);
CALL TempValentineGossip(4235,8244,410,411);
CALL TempValentineGossip(4229,8244,410,411);
CALL TempValentineGossip(4180,8244,410,411);
CALL TempValentineGossip(2796,8244,410,411);
CALL TempValentineGossip(3517,8244,410,411);
CALL TempValentineGossip(4088,8244,410,411);
CALL TempValentineGossip(5782,8244,410,411);
CALL TempValentineGossip(6034,8244,410,411);
CALL TempValentineGossip(6142,8244,410,411);
CALL TempValentineGossip(7296,8244,410,411);
CALL TempValentineGossip(7313,8244,410,411);
CALL TempValentineGossip(7740,8244,410,411);
CALL TempValentineGossip(8026,8244,410,411);
CALL TempValentineGossip(11700,8244,410,411);
CALL TempValentineGossip(11709,8244,410,411);
CALL TempValentineGossip(4087,8244,410,411);
CALL TempValentineGossip(4089,8244,410,411);
CALL TempValentineGossip(7315,8244,410,411);
CALL TempValentineGossip(11866,8244,410,411);
CALL TempValentineGossip(4203,8244,410,411);
CALL TempValentineGossip(4231,8244,410,411);

-- Orgrimmar Citizens
CALL TempValentineGossip(3348,8263,414,415);
CALL TempValentineGossip(7230,8263,414,415);
CALL TempValentineGossip(3355,8263,414,415);
CALL TempValentineGossip(11017,8263,414,415);
CALL TempValentineGossip(3369,8263,414,415);
CALL TempValentineGossip(3356,8263,414,415);
CALL TempValentineGossip(3331,8263,414,415);
CALL TempValentineGossip(3410,8263,414,415);
CALL TempValentineGossip(3315,8263,414,415);
CALL TempValentineGossip(3316,8263,414,415);
CALL TempValentineGossip(3400,8263,414,415);
CALL TempValentineGossip(3399,8263,414,415);
CALL TempValentineGossip(5815,8263,414,415);
CALL TempValentineGossip(6986,8263,414,415);
CALL TempValentineGossip(6987,8263,414,415);
CALL TempValentineGossip(3346,8263,414,415);
CALL TempValentineGossip(3413,8263,414,415);
CALL TempValentineGossip(3347,8263,414,415);
CALL TempValentineGossip(1383,8263,414,415);
CALL TempValentineGossip(3345,8263,414,415);
CALL TempValentineGossip(3412,8263,414,415);
CALL TempValentineGossip(3365,8263,414,415);
CALL TempValentineGossip(3363,8263,414,415);
CALL TempValentineGossip(3373,8263,414,415);
CALL TempValentineGossip(15116,8263,414,415);
CALL TempValentineGossip(3333,8263,414,415);
CALL TempValentineGossip(3332,8263,414,415);
CALL TempValentineGossip(3342,8263,414,415);
CALL TempValentineGossip(3313,8263,414,415);
CALL TempValentineGossip(3350,8263,414,415);
CALL TempValentineGossip(3370,8263,414,415);
CALL TempValentineGossip(3322,8263,414,415);
CALL TempValentineGossip(5812,8263,414,415);
CALL TempValentineGossip(3405,8263,414,415);
CALL TempValentineGossip(3404,8263,414,415);
CALL TempValentineGossip(5994,8263,414,415);
CALL TempValentineGossip(14726,8263,414,415);
CALL TempValentineGossip(14727,8263,414,415);
CALL TempValentineGossip(3352,8263,414,415);
CALL TempValentineGossip(3406,8263,414,415);
CALL TempValentineGossip(3407,8263,414,415);
CALL TempValentineGossip(11046,8263,414,415);
CALL TempValentineGossip(10266,8263,414,415);
CALL TempValentineGossip(11066,8263,414,415);
CALL TempValentineGossip(2857,8263,414,415);
CALL TempValentineGossip(5811,8263,414,415);
CALL TempValentineGossip(2855,8263,414,415);
CALL TempValentineGossip(3321,8263,414,415);
CALL TempValentineGossip(3366,8263,414,415);
CALL TempValentineGossip(3317,8263,414,415);
CALL TempValentineGossip(3360,8263,414,415);
CALL TempValentineGossip(5882,8263,414,415);
CALL TempValentineGossip(5883,8263,414,415);
CALL TempValentineGossip(5885,8263,414,415);
CALL TempValentineGossip(7311,8263,414,415);
CALL TempValentineGossip(3319,8263,414,415);
CALL TempValentineGossip(3312,8263,414,415);
CALL TempValentineGossip(3368,8263,414,415);
CALL TempValentineGossip(3358,8263,414,415);
CALL TempValentineGossip(3357,8263,414,415);
CALL TempValentineGossip(3329,8263,414,415);
CALL TempValentineGossip(10088,8263,414,415);
CALL TempValentineGossip(3334,8263,414,415);
CALL TempValentineGossip(5958,8263,414,415);
CALL TempValentineGossip(6014,8263,414,415);
CALL TempValentineGossip(6018,8263,414,415);
CALL TempValentineGossip(3323,8263,414,415);
CALL TempValentineGossip(3335,8263,414,415);
CALL TempValentineGossip(4752,8263,414,415);
CALL TempValentineGossip(3327,8263,414,415);
CALL TempValentineGossip(3328,8263,414,415);
CALL TempValentineGossip(3344,8263,414,415);
CALL TempValentineGossip(3403,8263,414,415);
CALL TempValentineGossip(13417,8263,414,415);
CALL TempValentineGossip(7088,8263,414,415);
CALL TempValentineGossip(8404,8263,414,415);
CALL TempValentineGossip(9988,8263,414,415);
CALL TempValentineGossip(3330,8263,414,415);
CALL TempValentineGossip(3349,8263,414,415);
CALL TempValentineGossip(14480,8263,414,415);
CALL TempValentineGossip(5188,8263,414,415);
CALL TempValentineGossip(3364,8263,414,415);
CALL TempValentineGossip(7793,8263,414,415);
CALL TempValentineGossip(3367,8263,414,415);
CALL TempValentineGossip(5817,8263,414,415);
CALL TempValentineGossip(4043,8263,414,415);
CALL TempValentineGossip(3189,8263,414,415);
CALL TempValentineGossip(3216,8263,414,415);
CALL TempValentineGossip(3371,8263,414,415);
CALL TempValentineGossip(3372,8263,414,415);
CALL TempValentineGossip(3402,8263,414,415);
CALL TempValentineGossip(4485,8263,414,415);
CALL TempValentineGossip(5597,8263,414,415);
CALL TempValentineGossip(5603,8263,414,415);
CALL TempValentineGossip(5606,8263,414,415);
CALL TempValentineGossip(5609,8263,414,415);
CALL TempValentineGossip(5610,8263,414,415);
CALL TempValentineGossip(5611,8263,414,415);
CALL TempValentineGossip(5613,8263,414,415);
CALL TempValentineGossip(5614,8263,414,415);
CALL TempValentineGossip(5639,8263,414,415);
CALL TempValentineGossip(5640,8263,414,415);
CALL TempValentineGossip(5875,8263,414,415);
CALL TempValentineGossip(5892,8263,414,415);
CALL TempValentineGossip(5909,8263,414,415);
CALL TempValentineGossip(5910,8263,414,415);
CALL TempValentineGossip(6446,8263,414,415);
CALL TempValentineGossip(7010,8263,414,415);
CALL TempValentineGossip(7294,8263,414,415);
CALL TempValentineGossip(7790,8263,414,415);
CALL TempValentineGossip(7792,8263,414,415);
CALL TempValentineGossip(7951,8263,414,415);
CALL TempValentineGossip(8659,8263,414,415);
CALL TempValentineGossip(9317,8263,414,415);
CALL TempValentineGossip(9550,8263,414,415);
CALL TempValentineGossip(14451,8263,414,415);
CALL TempValentineGossip(14498,8263,414,415);
CALL TempValentineGossip(16007,8263,414,415);
CALL TempValentineGossip(16012,8263,414,415);
CALL TempValentineGossip(16076,8263,414,415);
CALL TempValentineGossip(5816,8263,414,415);
CALL TempValentineGossip(3359,8263,414,415);
CALL TempValentineGossip(3324,8263,414,415);
CALL TempValentineGossip(3325,8263,414,415);
CALL TempValentineGossip(3326,8263,414,415);
CALL TempValentineGossip(3353,8263,414,415);
CALL TempValentineGossip(3354,8263,414,415);
CALL TempValentineGossip(3408,8263,414,415);
CALL TempValentineGossip(2704,8263,414,415);
CALL TempValentineGossip(11868,8263,414,415);
CALL TempValentineGossip(3314,8263,414,415);
CALL TempValentineGossip(3361,8263,414,415);
CALL TempValentineGossip(3409,8263,414,415);
CALL TempValentineGossip(7231,8263,414,415);

-- Undercity Citizens
CALL TempValentineGossip(4610,8255,418,419);
CALL TempValentineGossip(4611,8255,418,419);
CALL TempValentineGossip(4576,8255,418,419);
CALL TempValentineGossip(4590,8255,418,419);
CALL TempValentineGossip(4597,8255,418,419);
CALL TempValentineGossip(4569,8255,418,419);
CALL TempValentineGossip(7683,8255,418,419);
CALL TempValentineGossip(4581,8255,418,419);
CALL TempValentineGossip(4604,8255,418,419);
CALL TempValentineGossip(5821,8255,418,419);
CALL TempValentineGossip(8403,8255,418,419);
CALL TempValentineGossip(4553,8255,418,419);
CALL TempValentineGossip(4552,8255,418,419);
CALL TempValentineGossip(5753,8255,418,419);
CALL TempValentineGossip(4617,8255,418,419);
CALL TempValentineGossip(4587,8255,418,419);
CALL TempValentineGossip(2050,8255,418,419);
CALL TempValentineGossip(4609,8255,418,419);
CALL TempValentineGossip(4596,8255,418,419);
CALL TempValentineGossip(4616,8255,418,419);
CALL TempValentineGossip(11031,8255,418,419);
CALL TempValentineGossip(4588,8255,418,419);
CALL TempValentineGossip(11049,8255,418,419);
CALL TempValentineGossip(4591,8255,418,419);
CALL TempValentineGossip(4574,8255,418,419);
CALL TempValentineGossip(4573,8255,418,419);
CALL TempValentineGossip(4571,8255,418,419);
CALL TempValentineGossip(4555,8255,418,419);
CALL TempValentineGossip(4613,8255,418,419);
CALL TempValentineGossip(5052,8255,418,419);
CALL TempValentineGossip(4603,8255,418,419);
CALL TempValentineGossip(4559,8255,418,419);
CALL TempValentineGossip(4560,8255,418,419);
CALL TempValentineGossip(5819,8255,418,419);
CALL TempValentineGossip(4615,8255,418,419);
CALL TempValentineGossip(4614,8255,418,419);
CALL TempValentineGossip(14729,8255,418,419);
CALL TempValentineGossip(11044,8255,418,419);
CALL TempValentineGossip(4605,8255,418,419);
CALL TempValentineGossip(11067,8255,418,419);
CALL TempValentineGossip(4586,8255,418,419);
CALL TempValentineGossip(223,8255,418,419);
CALL TempValentineGossip(11048,8255,418,419);
CALL TempValentineGossip(5820,8255,418,419);
CALL TempValentineGossip(4589,8255,418,419);
CALL TempValentineGossip(4558,8255,418,419);
CALL TempValentineGossip(4566,8255,418,419);
CALL TempValentineGossip(4567,8255,418,419);
CALL TempValentineGossip(4568,8255,418,419);
CALL TempValentineGossip(4578,8255,418,419);
CALL TempValentineGossip(4599,8255,418,419);
CALL TempValentineGossip(4598,8255,418,419);
CALL TempValentineGossip(4554,8255,418,419);
CALL TempValentineGossip(4585,8255,418,419);
CALL TempValentineGossip(2492,8255,418,419);
CALL TempValentineGossip(4606,8255,418,419);
CALL TempValentineGossip(4607,8255,418,419);
CALL TempValentineGossip(4608,8255,418,419);
CALL TempValentineGossip(4562,8255,418,419);
CALL TempValentineGossip(4575,8255,418,419);
CALL TempValentineGossip(4580,8255,418,419);
CALL TempValentineGossip(4582,8255,418,419);
CALL TempValentineGossip(4583,8255,418,419);
CALL TempValentineGossip(4584,8255,418,419);
CALL TempValentineGossip(2055,8255,418,419);
CALL TempValentineGossip(5204,8255,418,419);
CALL TempValentineGossip(5731,8255,418,419);
CALL TempValentineGossip(5732,8255,418,419);
CALL TempValentineGossip(5733,8255,418,419);
CALL TempValentineGossip(5734,8255,418,419);
CALL TempValentineGossip(7087,8255,418,419);
CALL TempValentineGossip(10053,8255,418,419);
CALL TempValentineGossip(4570,8255,418,419);
CALL TempValentineGossip(5190,8255,418,419);
CALL TempValentineGossip(4577,8255,418,419);
CALL TempValentineGossip(4592,8255,418,419);
CALL TempValentineGossip(4561,8255,418,419);
CALL TempValentineGossip(4775,8255,418,419);
CALL TempValentineGossip(1498,8255,418,419);
CALL TempValentineGossip(2227,8255,418,419);
CALL TempValentineGossip(2308,8255,418,419);
CALL TempValentineGossip(2799,8255,418,419);
CALL TempValentineGossip(2802,8255,418,419);
CALL TempValentineGossip(2934,8255,418,419);
CALL TempValentineGossip(4486,8255,418,419);
CALL TempValentineGossip(4488,8255,418,419);
CALL TempValentineGossip(4572,8255,418,419);
CALL TempValentineGossip(5651,8255,418,419);
CALL TempValentineGossip(5661,8255,418,419);
CALL TempValentineGossip(5663,8255,418,419);
CALL TempValentineGossip(5664,8255,418,419);
CALL TempValentineGossip(5665,8255,418,419);
CALL TempValentineGossip(5668,8255,418,419);
CALL TempValentineGossip(5669,8255,418,419);
CALL TempValentineGossip(5670,8255,418,419);
CALL TempValentineGossip(5675,8255,418,419);
CALL TempValentineGossip(5679,8255,418,419);
CALL TempValentineGossip(5693,8255,418,419);
CALL TempValentineGossip(5696,8255,418,419);
CALL TempValentineGossip(5698,8255,418,419);
CALL TempValentineGossip(5699,8255,418,419);
CALL TempValentineGossip(5700,8255,418,419);
CALL TempValentineGossip(5701,8255,418,419);
CALL TempValentineGossip(5703,8255,418,419);
CALL TempValentineGossip(5704,8255,418,419);
CALL TempValentineGossip(5705,8255,418,419);
CALL TempValentineGossip(5706,8255,418,419);
CALL TempValentineGossip(5707,8255,418,419);
CALL TempValentineGossip(5744,8255,418,419);
CALL TempValentineGossip(5747,8255,418,419);
CALL TempValentineGossip(6293,8255,418,419);
CALL TempValentineGossip(6411,8255,418,419);
CALL TempValentineGossip(6467,8255,418,419);
CALL TempValentineGossip(6522,8255,418,419);
CALL TempValentineGossip(6566,8255,418,419);
CALL TempValentineGossip(7297,8255,418,419);
CALL TempValentineGossip(7825,8255,418,419);
CALL TempValentineGossip(8390,8255,418,419);
CALL TempValentineGossip(8393,8255,418,419);
CALL TempValentineGossip(10136,8255,418,419);
CALL TempValentineGossip(10879,8255,418,419);
CALL TempValentineGossip(11835,8255,418,419);
CALL TempValentineGossip(10781,8255,418,419);
CALL TempValentineGossip(5754,8255,418,419);
CALL TempValentineGossip(4563,8255,418,419);
CALL TempValentineGossip(4564,8255,418,419);
CALL TempValentineGossip(4565,8255,418,419);
CALL TempValentineGossip(4593,8255,418,419);
CALL TempValentineGossip(4594,8255,418,419);
CALL TempValentineGossip(4595,8255,418,419);
CALL TempValentineGossip(11870,8255,418,419);
CALL TempValentineGossip(4600,8255,418,419);
CALL TempValentineGossip(4601,8255,418,419);
CALL TempValentineGossip(4602,8255,418,419);
CALL TempValentineGossip(4556,8255,418,419);
CALL TempValentineGossip(4557,8255,418,419);

-- Thunder Bluff Citizens
CALL TempValentineGossip(3010,8244,422,423);
CALL TempValentineGossip(3007,8244,422,423);
CALL TempValentineGossip(3019,8244,422,423);
CALL TempValentineGossip(8364,8244,422,423);
CALL TempValentineGossip(3016,8244,422,423);
CALL TempValentineGossip(2999,8244,422,423);
CALL TempValentineGossip(3015,8244,422,423);
CALL TempValentineGossip(3003,8244,422,423);
CALL TempValentineGossip(3092,8244,422,423);
CALL TempValentineGossip(8358,8244,422,423);
CALL TempValentineGossip(3027,8244,422,423);
CALL TempValentineGossip(3026,8244,422,423);
CALL TempValentineGossip(3033,8244,422,423);
CALL TempValentineGossip(3034,8244,422,423);
CALL TempValentineGossip(3036,8244,422,423);
CALL TempValentineGossip(3012,8244,422,423);
CALL TempValentineGossip(3009,8244,422,423);
CALL TempValentineGossip(2998,8244,422,423);
CALL TempValentineGossip(3011,8244,422,423);
CALL TempValentineGossip(11084,8244,422,423);
CALL TempValentineGossip(3004,8244,422,423);
CALL TempValentineGossip(2798,8244,422,423);
CALL TempValentineGossip(3029,8244,422,423);
CALL TempValentineGossip(3028,8244,422,423);
CALL TempValentineGossip(3017,8244,422,423);
CALL TempValentineGossip(8362,8244,422,423);
CALL TempValentineGossip(5054,8244,422,423);
CALL TempValentineGossip(3018,8244,422,423);
CALL TempValentineGossip(3095,8244,422,423);
CALL TempValentineGossip(3014,8244,422,423);
CALL TempValentineGossip(3013,8244,422,423);
CALL TempValentineGossip(14728,8244,422,423);
CALL TempValentineGossip(3038,8244,422,423);
CALL TempValentineGossip(3039,8244,422,423);
CALL TempValentineGossip(3040,8244,422,423);
CALL TempValentineGossip(11047,8244,422,423);
CALL TempValentineGossip(10278,8244,422,423);
CALL TempValentineGossip(11071,8244,422,423);
CALL TempValentineGossip(3008,8244,422,423);
CALL TempValentineGossip(11051,8244,422,423);
CALL TempValentineGossip(3093,8244,422,423);
CALL TempValentineGossip(8359,8244,422,423);
CALL TempValentineGossip(3005,8244,422,423);
CALL TempValentineGossip(3020,8244,422,423);
CALL TempValentineGossip(11833,8244,422,423);
CALL TempValentineGossip(3048,8244,422,423);
CALL TempValentineGossip(3049,8244,422,423);
CALL TempValentineGossip(8360,8244,422,423);
CALL TempValentineGossip(3025,8244,422,423);
CALL TempValentineGossip(3002,8244,422,423);
CALL TempValentineGossip(3001,8244,422,423);
CALL TempValentineGossip(10086,8244,422,423);
CALL TempValentineGossip(5957,8244,422,423);
CALL TempValentineGossip(8401,8244,422,423);
CALL TempValentineGossip(3044,8244,422,423);
CALL TempValentineGossip(3045,8244,422,423);
CALL TempValentineGossip(3046,8244,422,423);
CALL TempValentineGossip(8361,8244,422,423);
CALL TempValentineGossip(3419,8244,422,423);
CALL TempValentineGossip(3030,8244,422,423);
CALL TempValentineGossip(3031,8244,422,423);
CALL TempValentineGossip(3032,8244,422,423);
CALL TempValentineGossip(7089,8244,422,423);
CALL TempValentineGossip(10054,8244,422,423);
CALL TempValentineGossip(3022,8244,422,423);
CALL TempValentineGossip(3021,8244,422,423);
CALL TempValentineGossip(5189,8244,422,423);
CALL TempValentineGossip(8363,8244,422,423);
CALL TempValentineGossip(8398,8244,422,423);
CALL TempValentineGossip(2987,8244,422,423);
CALL TempValentineGossip(3024,8244,422,423);
CALL TempValentineGossip(3037,8244,422,423);
CALL TempValentineGossip(3050,8244,422,423);
CALL TempValentineGossip(3441,8244,422,423);
CALL TempValentineGossip(3447,8244,422,423);
CALL TempValentineGossip(3978,8244,422,423);
CALL TempValentineGossip(4309,8244,422,423);
CALL TempValentineGossip(4310,8244,422,423);
CALL TempValentineGossip(4451,8244,422,423);
CALL TempValentineGossip(4721,8244,422,423);
CALL TempValentineGossip(4943,8244,422,423);
CALL TempValentineGossip(5543,8244,422,423);
CALL TempValentineGossip(5599,8244,422,423);
CALL TempValentineGossip(5769,8244,422,423);
CALL TempValentineGossip(5770,8244,422,423);
CALL TempValentineGossip(5906,8244,422,423);
CALL TempValentineGossip(6393,8244,422,423);
CALL TempValentineGossip(6410,8244,422,423);
CALL TempValentineGossip(8664,8244,422,423);
CALL TempValentineGossip(9076,8244,422,423);
CALL TempValentineGossip(9087,8244,422,423);
CALL TempValentineGossip(3023,8244,422,423);
CALL TempValentineGossip(3041,8244,422,423);
CALL TempValentineGossip(3042,8244,422,423);
CALL TempValentineGossip(3043,8244,422,423);
CALL TempValentineGossip(11869,8244,422,423);
CALL TempValentineGossip(2997,8244,422,423);


-- Add citizen LoS detection
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry` in (5178,14723,14724,5174,5119,5132,5112,5140,5570,4259,5120,5170,5122,5109,5155,5160,5159,6382,5158,5175,5177,10276,5157,11029,5127,
			5130,5049,5123,5106,5107,5126,5138,5137,5115,5116,5117,2092,1246,10277,11065,11028,1466,1703,5128,5108,5129,5121,5144,5145,5146,7312,5125,5124,4256,4254,5147,5148,5149,10090,9099,2489,
			5141,5142,5143,11406,5110,5151,5637,5156,5165,5166,5167,2790,5169,6291,8681,9984,5154,3842,5100,5163,1274,1356,1365,2695,2737,2786,2916,2918,2943,4081,5605,6031,6114,6120,6169,6175,6178,
			6179,6294,7298,7936,8256,8507,8517,9616,10455,10456,10877,13444,14183,16009,16013,16070,7292,5133,5171,5172,5173,1901,5113,5114,11865,13084,5102,5103,5152,7976,338,1313,1257,14722,5081,
			4981,1307,1346,5509,1321,1305,1311,5512,1324,1298,1297,1646,1291,1299,1339,5483,5482,5520,5504,5505,5506,1318,5519,5499,5511,1317,5518,5564,5567,5384,1304,2327,5494,5493,1302,1285,4974,
			5510,1310,1141,1323,1303,5503,5502,5566,1439,2285,5515,5516,5517,5500,957,11068,11026,11096,1300,1295,1320,5565,1316,1440,2504,1314,5497,5498,1294,1341,1349,331,482,340,9584,277,5514,5513,
			483,14497,5491,5492,2879,1326,2485,376,5484,5489,11397,1275,1308,1351,1309,1350,918,13283,1325,1319,1292,9977,11069,1348,1315,10782,14481,5193,1347,1327,1286,1333,279,297,656,1212,1413,
			1414,1415,1416,1427,1428,1431,1432,1435,1444,1472,1477,1478,1721,1752,2198,2330,2708,2795,3627,3629,4078,4960,5386,5413,6089,6122,6171,6173,6174,6267,6579,11827,11828,11916,14450,1312,461,
			5495,5496,914,5479,5480,11867,1287,1289,7232,1301,4226,14725,4160,4212,4232,4230,4171,4173,4175,4223,4210,4217,4218,4219,4228,11042,4213,11081,4159,2912,4211,4221,4222,4156,4167,4181,4170,
			4241,4161,4216,4204,7999,4138,4146,4205,11041,11070,11083,11050,4236,4225,4233,4177,4169,4164,8665,10089,3561,4165,4090,4091,4092,11401,3562,4220,4753,4172,4163,4214,4215,4240,6292,10056,
			4234,5047,5191,4168,4235,4229,4180,2796,3517,4088,5782,6034,6142,7296,7313,7740,8026,11700,11709,4087,4089,7315,11866,4203,4231,4610,4611,4576,4590,4597,4569,7683,4581,4604,5821,8403,4553,
			4552,5753,4617,4587,2050,4609,4596,4616,11031,4588,11049,4591,4574,4573,4571,4555,4613,5052,4603,4559,4560,5819,4615,4614,14729,11044,4605,11067,4586,223,11048,5820,4589,4558,4566,4567,4568,
			4578,4599,4598,4554,4585,2492,4606,4607,4608,4562,4575,4580,4582,4583,4584,2055,5204,5731,5732,5733,5734,7087,10053,4570,5190,4577,4592,4561,4775,1498,2227,2308,2799,2802,2934,4486,4488,4572,
			5651,5661,5663,5664,5665,5668,5669,5670,5675,5679,5693,5696,5698,5699,5700,5701,5703,5704,5705,5706,5707,5744,5747,6293,6411,6467,6522,6566,7297,7825,8390,8393,10136,10879,11835,10781,5754,
			4563,4564,4565,4593,4594,4595,11870,4600,4601,4602,4556,4557,3010,3007,3019,8364,3016,2999,3015,3003,3092,8358,3027,3026,3033,3034,3036,3012,3009,2998,3011,11084,3004,2798,3029,3028,3017,8362,
			5054,3018,3095,3014,3013,14728,3038,3039,3040,11047,10278,11071,3008,11051,3093,8359,3005,3020,11833,3048,3049,8360,3025,3002,3001,10086,5957,8401,3044,3045,3046,8361,3419,3030,3031,3032,7089,
			10054,3022,3021,5189,8363,8398,2987,3024,3037,3050,3441,3447,3978,4309,4310,4451,4721,4943,5543,5599,5769,5770,5906,6393,6410,8664,9076,9087,3023,3041,3042,3043,11869,2997,3348,7230,3355,
			11017,3369,3356,3331,3410,3315,3316,3400,3399,5815,6986,6987,3346,3413,3347,1383,3345,3412,3365,3363,3373,15116,3333,3332,3342,3313,3350,3370,3322,5812,3405,3404,5994,14726,14727,3352,3406,3407,
			11046,10266,11066,2857,5811,2855,3321,3366,3317,3360,5882,5883,5885,7311,3319,3312,3368,3358,3357,3329,10088,3334,5958,6014,6018,3323,3335,4752,3327,3328,3344,3403,13417,7088,8404,9988,3330,
			3349,14480,5188,3364,7793,3367,5817,4043,3189,3216,3371,3372,3402,4485,5597,5603,5606,5609,5610,5611,5613,5614,5639,5640,5875,5892,5909,5910,6446,7010,7294,7790,7792,7951,8659,9317,9550,14451,
			14498,16007,16012,16076,5816,3359,3324,3325,3326,3353,3354,3408,2704,11868,3314,3361,3409,7231,5153,3979,5150,15119,5162,5161,7978,5101,7944);


SET @pos := 3001000;
REPLACE INTO `creature_ai_scripts` 
SELECT ( SELECT @pos := @pos + 1 ), entry, 458, 10, 0, 100, 1, 1, 50, 3000, 3000, 11, 27741, 0, 0, 17, 147, 1, 0, 0, 0, 0, 0, 'Love is in the Air Event - Cast Love aura and turn on gossip NPC_FLAG'
FROM creature_template WHERE entry IN (5178,14723,14724,5174,5119,5132,5112,5140,5570,4259,5120,5170,5122,5109,5155,5160,5159,6382,5158,5175,5177,10276,5157,11029,5127,
			5130,5049,5123,5106,5107,5126,5138,5137,5115,5116,5117,2092,1246,10277,11065,11028,1466,1703,5128,5108,5129,5121,5144,5145,5146,7312,5125,5124,4256,4254,5147,5148,5149,10090,9099,2489,
			5141,5142,5143,11406,5110,5151,5637,5156,5165,5166,5167,2790,5169,6291,8681,9984,5154,3842,5100,5163,1274,1356,1365,2695,2737,2786,2916,2918,2943,4081,5605,6031,6114,6120,6169,6175,6178,
			6179,6294,7298,7936,8256,8507,8517,9616,10455,10456,10877,13444,14183,16009,16013,16070,7292,5133,5171,5172,5173,1901,5113,5114,11865,13084,5102,5103,5152,7976,338,1313,1257,14722,5081,
			4981,1307,1346,5509,1321,1305,1311,5512,1324,1298,1297,1646,1291,1299,1339,5483,5482,5520,5504,5505,5506,1318,5519,5499,5511,1317,5518,5564,5567,5384,1304,2327,5494,5493,1302,1285,4974,
			5510,1310,1141,1323,1303,5503,5502,5566,1439,2285,5515,5516,5517,5500,957,11068,11026,11096,1300,1295,1320,5565,1316,1440,2504,1314,5497,5498,1294,1341,1349,331,482,340,9584,277,5514,5513,
			483,14497,5491,5492,2879,1326,2485,376,5484,5489,11397,1275,1308,1351,1309,1350,918,13283,1325,1319,1292,9977,11069,1348,1315,10782,14481,5193,1347,1327,1286,1333,279,297,656,1212,1413,
			1414,1415,1416,1427,1428,1431,1432,1435,1444,1472,1477,1478,1721,1752,2198,2330,2708,2795,3627,3629,4078,4960,5386,5413,6089,6122,6171,6173,6174,6267,6579,11827,11828,11916,14450,1312,461,
			5495,5496,914,5479,5480,11867,1287,1289,7232,1301,4226,14725,4160,4212,4232,4230,4171,4173,4175,4223,4210,4217,4218,4219,4228,11042,4213,11081,4159,2912,4211,4221,4222,4156,4167,4181,4170,
			4241,4161,4216,4204,7999,4138,4146,4205,11041,11070,11083,11050,4236,4225,4233,4177,4169,4164,8665,10089,3561,4165,4090,4091,4092,11401,3562,4220,4753,4172,4163,4214,4215,4240,6292,10056,
			4234,5047,5191,4168,4235,4229,4180,2796,3517,4088,5782,6034,6142,7296,7313,7740,8026,11700,11709,4087,4089,7315,11866,4203,4231,4610,4611,4576,4590,4597,4569,7683,4581,4604,5821,8403,4553,
			4552,5753,4617,4587,2050,4609,4596,4616,11031,4588,11049,4591,4574,4573,4571,4555,4613,5052,4603,4559,4560,5819,4615,4614,14729,11044,4605,11067,4586,223,11048,5820,4589,4558,4566,4567,4568,
			4578,4599,4598,4554,4585,2492,4606,4607,4608,4562,4575,4580,4582,4583,4584,2055,5204,5731,5732,5733,5734,7087,10053,4570,5190,4577,4592,4561,4775,1498,2227,2308,2799,2802,2934,4486,4488,4572,
			5651,5661,5663,5664,5665,5668,5669,5670,5675,5679,5693,5696,5698,5699,5700,5701,5703,5704,5705,5706,5707,5744,5747,6293,6411,6467,6522,6566,7297,7825,8390,8393,10136,10879,11835,10781,5754,
			4563,4564,4565,4593,4594,4595,11870,4600,4601,4602,4556,4557,3010,3007,3019,8364,3016,2999,3015,3003,3092,8358,3027,3026,3033,3034,3036,3012,3009,2998,3011,11084,3004,2798,3029,3028,3017,8362,
			5054,3018,3095,3014,3013,14728,3038,3039,3040,11047,10278,11071,3008,11051,3093,8359,3005,3020,11833,3048,3049,8360,3025,3002,3001,10086,5957,8401,3044,3045,3046,8361,3419,3030,3031,3032,7089,
			10054,3022,3021,5189,8363,8398,2987,3024,3037,3050,3441,3447,3978,4309,4310,4451,4721,4943,5543,5599,5769,5770,5906,6393,6410,8664,9076,9087,3023,3041,3042,3043,11869,2997,3348,7230,3355,
			11017,3369,3356,3331,3410,3315,3316,3400,3399,5815,6986,6987,3346,3413,3347,1383,3345,3412,3365,3363,3373,15116,3333,3332,3342,3313,3350,3370,3322,5812,3405,3404,5994,14726,14727,3352,3406,3407,
			11046,10266,11066,2857,5811,2855,3321,3366,3317,3360,5882,5883,5885,7311,3319,3312,3368,3358,3357,3329,10088,3334,5958,6014,6018,3323,3335,4752,3327,3328,3344,3403,13417,7088,8404,9988,3330,
			3349,14480,5188,3364,7793,3367,5817,4043,3189,3216,3371,3372,3402,4485,5597,5603,5606,5609,5610,5611,5613,5614,5639,5640,5875,5892,5909,5910,6446,7010,7294,7790,7792,7951,8659,9317,9550,14451,
			14498,16007,16012,16076,5816,3359,3324,3325,3326,3353,3354,3408,2704,11868,3314,3361,3409,7231,5153,3979,5150,15119,5162,5161,7978,5101,7944);


-- Items 10 day duration, Extra flags y / n?
UPDATE `item_template` SET `Duration`=864000, `ExtraFlags`=1 WHERE entry in (21812,22239,22236,22238,22237,22218);

-- Delete Black dress from forbidden list
DELETE FROM `forbidden_items` WHERE `entry`=22279;


-- End of migration.
END IF;
END??
delimiter ; 
CALL add_migration();
DROP PROCEDURE IF EXISTS add_migration;
DROP PROCEDURE IF EXISTS `TempValentineGossip`;
