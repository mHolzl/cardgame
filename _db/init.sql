CREATE TABLE `cardtype` (
  `id` INT unsigned auto_increment PRIMARY KEY,
  `parent_id` INT unsigned,
  `name` VARCHAR(255) NOT NULL,
   CONSTRAINT `fk_cardtype_parent` FOREIGN KEY (`parent_id`) REFERENCES cardtype(`id`)
);

INSERT INTO `cardtype` (`id`, `parent_id`, `name`) VALUES
  (1, NULL, 'land'),
  (2, 1, 'starting_land'),
  (3, 1, 'basic_land'),
  (4, 1, 'distand_land'),
  (5, NULL, 'season'),
  (6, NULL, 'event'),
  (7, NULL, 'endgame_task'),
  (8, NULL, 'monster'),
  (9, NULL, 'personal'),
  (10, 9, 'explorer'),
  (11, 9, 'colector'),
  (12, 9, 'hunter');



CREATE TABLE `landtype` (
  `id` INT unsigned auto_increment PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL
);

INSERT INTO `landtype` (`id`, `name`) VALUES
  (1, 'Jeskyně'),
  (2, 'Hlubiny'),
  (3, 'Povětří'),
  (4, 'Začarovaný hvozd'),
  (5, 'Temnozem'), 
  (6, 'Krajina snů');


CREATE TABLE `cards` (
  `id` INT unsigned auto_increment PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL,
  `title` VARCHAR(255) NOT NULL DEFAULT '',
  `description` TEXT,
  `default_image` VARCHAR(255) NOT NULL,
  `value` INT DEFAULT 0,
  `price` INT DEFAULT 0,
  `rage` INT DEFAULT 0,
  `bonuscard` INT DEFAULT 0,
  `cardtype_id` INT unsigned,
  `landtype_id` INT unsigned,

  CONSTRAINT `fk_cards_cardtype` FOREIGN KEY (`cardtype_id`) REFERENCES cardtype(`id`),
  CONSTRAINT `fk_cards_landtype` FOREIGN KEY (`landtype_id`) REFERENCES landtype(`id`)

);

/* Starting lands*/
INSERT INTO `cards` (`id`,`name`, `title`, `description`, `default_image`, `value`, `cardtype_id`, `landtype_id`) VALUES
  (1, 'Vstup', 'Do jeskyní', '', 'lands/caves_entrance.jpg', 1, 2, 1),
  (2, 'Melčiny', 'Před hlubinou', '', 'lands/waters_entrance.jpg', 1, 2, 2),
  (3, 'Vzdušný proud', 'Do povětří', '', 'lands/air_entrance.jpg', 1, 2, 3),
  (4, 'Stezka', 'Do začarovaného lesa', '', 'lands/woods_entrance.jpg', 1, 2, 4),
  (5, 'Cesta', 'Do Temnozemě', '', 'lands/darklands_entrance.jpg', 1, 2, 5); /* TODO */

/* Basic lands*/
INSERT INTO `cards` (`id`,`name`, `title`, `description`, `default_image`, `value`, `cardtype_id`, `landtype_id`) VALUES
  (6, 'Jeskyně', '', '', 'lands/caves_landscape.jpg', 1, 3, 1),
  (7, 'Hlubiny', '', '', 'lands/waters_landscape.jpg', 1, 3, 2), 
  (8, 'Povětří', '', '', 'lands/air_landscape.jpg', 1, 3, 3),
  (9, 'Začarovaný hvozd', '', '', 'lands/woods_landscape.jpg', 1, 3, 4),
  (10, 'Temnozem', '', '', 'lands/darklands_landscape.jpg', 1, 3, 5), /* TODO */
  (11, 'Krajina snů', '', '', 'lands/dreamlands_landscape.jpg', 3, 2, 6); /* TODO */

/* Distand lands*/
INSERT INTO `cards` (`id`,`name`, `title`, `description`, `default_image`, `value`, `price`, `cardtype_id`, `landtype_id`) VALUES
  (12, 'Jeskyně', 'Houbová sluj', '', 'lands/caves_fungus_cavern.jpg', 2, 1, 3, 1),
  (13, 'Jeskyně', 'Velká síň', '', 'lands/caves_great_cavern.jpg', 2, 1, 3, 1),
  (14, 'Jeskyně', 'Lávová pole', '', 'lands/caves_landscape.jpg', 3, 2, 3, 1), /* TODO */

  (15, 'Hlubiny', 'Korálový příkop', '', 'lands/waters_coral_trench.jpg', 2, 1, 3, 2),
  (16, 'Hlubiny', 'Ztracená galeona', '', 'lands/waters_shipwreck.jpg', 2, 1, 3, 2),
  (17, 'Hlubiny', 'Zatopený palác', '', 'lands/waters_flooded_palace.jpg', 3, 2, 3, 2), 

  (18, 'Povětří', 'Planoucí vulkán', '', 'lands/air_vulcano.jpg', 2, 1, 3, 3),
  (19, 'Povětří', 'Schodiště bohů ', '', 'lands/air_stairs_of_gods.jpg', 2, 1, 3, 3),
  (20, 'Povětří', 'Zámek v oblacích', '', 'lands/air_cloud_castle.jpg', 3, 2, 3, 3), 

  (21, 'Začarovaný hvozd', 'Tajemné rozcestí', '', 'lands/woods_crossroads.jpg', 2, 1, 3, 4), 
  (22, 'Začarovaný hvozd', 'Opuštěná svatyně', '', 'lands/woods_sanctuary.jpg', 2, 1, 3, 4), 
  (23, 'Začarovaný hvozd', 'Strom života', '', 'lands/woods_treeoflife.jpg', 3, 2, 3, 4),

  (24, 'Temnozem', 'Močály smrti', '', 'lands/darklands_entrance.jpg', 2, 1, 3, 5), /* TODO */
  (25, 'Temnozem', 'Pevnost prokletých', '', 'lands/darklands_entrance.jpg', 2, 1, 3, 5), /* TODO */
  (26, 'Temnozem', 'Brána do podsvětí', '', 'lands/darklands_entrance.jpg', 3, 2, 3, 5); /* TODO */

/* Season cards */
INSERT INTO `cards` (`id`,`name`, `title`, `description`, `default_image`, `value`, `cardtype_id`, `landtype_id`) VALUES
  (27, 'Sezóna jeskyní', '', '', 'seasons/basic_season.jpg', 3, 5, 1),
  (28, 'Sezóna hlubin', '', '', 'seasons/basic_season.jpg', 3, 5, 2),
  (29, 'Sezóna povětří', '', '', 'seasons/basic_season.jpg', 3, 5, 3),
  (30, 'Sezóna začarovaného hvozdu', '', '', 'seasons/basic_season.jpg', 3, 5, 4),
  (31, 'Sezóna Temnozemě', '', '', 'seasons/basic_season.jpg', 3, 5, 5),
  (32, 'Sezóna snů', '', '', 'seasons/basic_season.jpg', 3, 5, 6),
  (33, 'Sezóna běsnění', '', '', 'seasons/basic_season.jpg', 3, 5, NULL);

/* Personal cards */
INSERT INTO `cards` (`id`,`name`, `title`, `description`, `default_image`, `value`, `rage`, `price`, `cardtype_id`, `landtype_id`) VALUES
  (34, 'Jensen A. Winchester', 'Elitní lovec', 'Za každou sezónu můžete ignorovat 1 symbol běsnění.', 'personal/hunter.jpg', NULL, 1, 2 , 12, NULL),
  (35, 'Michonne Fraserová', 'Elitní lovkyně', 'Za každou sezónu můžete ignorovat 1 symbol běsnění.', 'personal/hunter.jpg', NULL, 1, 2 , 12, NULL),
  (36, 'Emilie Hrdličková', 'Nebojácná průzkumnice', '<b>Neznámý kraj:</b> Při zahrání určete, který kraj představuje.', 'personal/exporer.jpg', 1, NULL, 2 , 10, NULL),
  (37, 'Květa Hošek', 'Nebojácná průzkumnice', '<b>Neznámý kraj:</b> Při zahrání určete, který kraj představuje.', 'personal/exporer.jpg', 1, NULL, 2 , 10, NULL),
  (38, 'Jiří Kolděna', 'Nebojácný průzkumník', '<b>Neznámý kraj:</b> Při zahrání určete, který kraj představuje.', 'personal/exporer.jpg', 1, NULL, 2 , 10, NULL),
  (39, 'Pan Dřibán', 'Nebojácný průzkumník', '<b>Neznámý kraj:</b> Při zahrání určete, který kraj představuje.', 'personal/exporer.jpg', 1, NULL, 2 , 10, NULL),

  (40, 'Zoja Hmlová', 'Odbornice na Jeskyně', 'Kdykoliv zahrajete obludu z Jeskyní, získáte 2 tolary.', 'personal/colector.jpg', 2, NULL, 3 , 11, 1),
  (41, 'Yvetta Šnorchlová', 'Odbornice na Hlubiny', 'Kdykoliv zahrajete obludu z Hlubin, získáte 2 tolary.', 'personal/deepwaters_colector.jpg', 2, NULL, 3 , 11, 2),
  (42, 'Karel Wankel', 'Odborník na Povětří', 'Kdykoliv zahrajete obludu z Povětří, získáte 2 tolary.', 'personal/air_colector.jpg', 2, NULL, 3 , 11, 3),
  (43, 'Robin Wood', 'Odborník na Začarovaný les', 'Kdykoliv zahrajete obludu ze Začarovaného lesa, získáte 2 tolary.', 'personal/woods_colector.jpg', 2, NULL, 3 , 11, 4),
  (44, 'Johnatan Darker', 'Odborník na Temnozem', 'Kdykoliv zahrajete obludu z Temnozemě, získáte 2 tolary.', 'personal/colector.jpg', 2, NULL, 3 , 11, 5),

  (45, 'Marcus D. “Jemňous”', 'Krotitel oblud', 'Za každý symbol běsnění obludy, kterou zahrajete získáte 1 tolar.', 'personal/colector.jpg', 1, NULL, 2 , 11, NULL),
  (46, 'Rosie Ward', 'Pořadatel', 'Za každou kartu události, kterou zahrajete, získáte 1 tolar.', 'personal/event_colector.jpg', 1, NULL, 3 , 11, NULL);

/* Monster cards - caves */
INSERT INTO `cards` (`id`,`name`, `default_image`, `price`, `value`, `rage`, `bonuscard`, `cardtype_id`, `landtype_id`) VALUES
  (47, 'Červor', 'monsters/caves_worm.jpg', 1, 3, 0, 0, 8, 1),
  (48, 'Houba masožravá', 'monsters/default_monster.png', 1, 1, 0, 1, 8, 1),
  (49, 'Bazilišek', 'monsters/caves_basilisk.jpg', 1, 5, 1, 0, 8, 1),
  (50, 'Vlkopýr', 'monsters/caves_batwolf.jpg', 2, 6, 0, 0, 8, 1),
  (51, 'Sklípkan bahenní', 'monsters/caves_mudspider.jpg', 2, 4, 0, 1, 8, 1),
  (52, 'Olgoj Chorchoj', 'monsters/caves_olgojchorchoj.jpg', 2, 8, 1, 0, 8, 1),
  (53, 'Jeskynní troll', 'monsters/caves_troll.jpg', 3, 11, 1, 0, 8, 1),
  (54, 'Balrog', 'monsters/caves_balrog.jpg', 3, 13, 2, 0, 8, 1),
  (55, 'Magmonstrum', 'monsters/caves_magmamonster.jpg', 4, 16, 2, 0, 8, 1);

/* Monster cards - deepwaters */
INSERT INTO `cards` (`id`,`name`, `default_image`, `price`, `value`, `rage`, `bonuscard`, `cardtype_id`, `landtype_id`) VALUES
  (56, 'Rybstvo', 'monsters/deepwaters_fishfolk.jpg', 1, 3, 0, 0, 8, 2),
  (57, 'Kelpie', 'monsters/deepwaters_kelpie.jpg', 1, 1, 0, 1, 8, 2),
  (58, 'Krabouk', 'monsters/deepwaters_crabspider.jpg', 1, 5, 1, 0, 8, 2),
  (59, 'Korýšolam', 'monsters/default_monster.png', 2, 6, 0, 0, 8, 2),
  (60, 'Měsíční žralok', 'monsters/deepwaters_moonshark.jpg', 2, 4, 0, 1, 8, 2),
  (61, 'Kostihlav mořský', 'monsters/deepwaters_seabonehead.jpg', 2, 8, 1, 0, 8, 2),
  (62, 'Mořský obr', 'monsters/deepwaters_seagiant.jpg', 3, 11, 1, 0, 8, 2),
  (63, 'Kraken', 'monsters/deepwaters_kraken.jpg', 3, 13, 2, 0, 8, 2),
  (64, 'Leviathan', 'monsters/deepwaters_leviathan.jpg', 4, 16, 2, 0, 8, 2);

/* Monster cards - air */
INSERT INTO `cards` (`id`,`name`, `default_image`, `price`, `value`, `rage`, `bonuscard`, `cardtype_id`, `landtype_id`) VALUES
  (65, 'Poletucha', 'monsters/air_flyer.jpg', 1, 3, 0, 0, 8, 3),
  (66, 'Křídloň', 'monsters/air_wingling.jpg', 1, 1, 0, 1, 8, 3),
  (67, 'Harpyje', 'monsters/air_harpy.jpg', 1, 5, 1, 0, 8, 3),
  (68, 'Fénix', 'monsters/air_phoenix.jpg', 2, 6, 0, 0, 8, 3),
  (69, 'Vševidoucí světice', 'monsters/air_allseeing_saint.jpg', 2, 4, 0, 1, 8, 3),
  (70, 'Gryf', 'monsters/air_grifin.jpg', 2, 8, 1, 0, 8, 3),
  (71, 'Saň', 'monsters/air_dragon.jpg', 3, 11, 1, 0, 8, 3),
  (72, 'Pavouk náhorní', 'monsters/air_hillspider.jpg', 3, 13, 2, 0, 8, 3),
  (73, 'Quetzalcóatl', 'monsters/default_monster.png', 4, 16, 2, 0, 8, 3);

/* Monster cards - forest */
INSERT INTO `cards` (`id`,`name`, `default_image`, `price`, `value`, `rage`, `bonuscard`, `cardtype_id`, `landtype_id`) VALUES
  (74, 'Jezinka', 'monsters/default_monster.png', 1, 3, 0, 0, 8, 4),
  (75, 'Jožin', 'monsters/default_monster.png', 1, 1, 0, 1, 8, 4),
  (76, 'Pavouk stromový', 'monsters/default_monster.png', 1, 5, 1, 0, 8, 4),
  (77, 'Hejkal', 'monsters/default_monster.png', 2, 6, 0, 0, 8, 4),
  (78, 'Lestie', 'monsters/default_monster.png', 2, 4, 0, 1, 8, 4),
  (79, 'Zlobr', 'monsters/default_monster.png', 2, 8, 1, 0, 8, 4),
  (80, 'Ent', 'monsters/default_monster.png', 3, 11, 1, 0, 8, 4),
  (81, 'Zmej', 'monsters/default_monster.png', 3, 13, 2, 0, 8, 4),
  (82, 'Wendigo', 'monsters/default_monster.png', 4, 16, 2, 0, 8, 4);

/* Monster cards - Darklands */
INSERT INTO `cards` (`id`,`name`, `default_image`, `price`, `value`, `rage`, `bonuscard`, `cardtype_id`, `landtype_id`) VALUES
  (83, 'Ghúl', 'monsters/default_monster.png', 1, 3, 0, 0, 8, 5),
  (84, 'Stínová puma', 'monsters/default_monster.png', 1, 1, 0, 1, 8, 5),
  (85, 'Půlnoční troll', 'monsters/default_monster.png', 1, 5, 1, 0, 8, 5),
  (86, 'Dýmon', 'monsters/default_monster.png', 2, 6, 0, 0, 8, 5),
  (87, 'Zlověstník', 'monsters/default_monster.png', 2, 4, 0, 1, 8, 5),
  (88, 'Dybuk', 'monsters/default_monster.png', 2, 8, 1, 0, 8, 5),
  (89, 'Žarantule', 'monsters/default_monster.png', 3, 11, 1, 0, 8, 5),
  (90, 'Padlý anděl', 'monsters/default_monster.png', 3, 13, 2, 0, 8, 5),
  (91, 'Fantom noci', 'monsters/default_monster.png', 4, 16, 2, 0, 8, 5);

/* Monster cards - Dreamlands */
INSERT INTO `cards` (`id`,`name`, `default_image`, `price`, `value`, `rage`, `bonuscard`, `cardtype_id`, `landtype_id`) VALUES
  (92, 'Vřískoun', 'monsters/default_monster.png', 3, 4, 0, 0, 8, 6),
  (93, 'Sukuba', 'monsters/default_monster.png', 4, 3, 0, 1, 8, 6),
  (94, 'Noční můra', 'monsters/default_monster.png', 5, 6, 0, 0, 8, 6),
  (95, 'Požírač snů', 'monsters/default_monster.png', 6, 5, 0, 1, 8, 6),
  (96, 'Měsíční netvor', 'monsters/default_monster.png', 7, 10, 1, 0, 8, 6),
  (97, 'Sekáč podsvětní', 'monsters/default_monster.png', 8, 13, 0, 2, 8, 6),
  (98, 'Belzebub', 'monsters/default_monster.png', 9, 10, 2, 2, 8, 6),
  (99, 'Prastarý', 'monsters/dreamlands_greatoldone.jpg', 10, 13, 3, 2, 8, 6);


CREATE TABLE `deck_preset` (
  `id` INT unsigned auto_increment PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT
);
INSERT INTO `deck_preset` (`id`, `name`, `description` ) VALUES
  (1, 'Základní hra - Tutorial', 'Úplně základní varianta hry, zaměřená na lov monster. Obsahuje jen karty lokací, monster a událostí. Karty personálu a úkolů jsou z balíčku vyjmuté.'),
  (2, 'Klasická hra', 'Balíček sestavený tak jak odpovídá základní variantě hry.');



CREATE TABLE `deck_preset_cards` (
  `id` INT unsigned auto_increment PRIMARY KEY,
  `deck_preset_id` INT unsigned  NOT NULL,
  `card_id` INT unsigned NOT NULL,
  `card_count` INT unsigned  NOT NULL,

  CONSTRAINT `fk_deck_preset_cards_deckpresset` FOREIGN KEY (`deck_preset_id`) REFERENCES deck_preset(`id`),
  CONSTRAINT `fk_deck_preset_cards_card` FOREIGN KEY (`card_id`) REFERENCES cards(`id`)
);

/* Starting lands */
INSERT INTO `deck_preset_cards` (`deck_preset_id`, `card_id`, `card_count`) VALUES
  (1, 1, 2),
  (1, 2, 2),
  (1, 3, 2),
  (1, 4, 2),
  (1, 5, 2);

/* Basic landy 6-11, 10x */
INSERT INTO `deck_preset_cards` (`deck_preset_id`, `card_id`, `card_count`) VALUES
  (1, 6, 10),
  (1, 7, 10),
  (1, 8, 10),
  (1, 9, 10),
  (1, 10, 10),
  (1, 11, 10);

/* Distand landy 12-26, 1x */
INSERT INTO `deck_preset_cards` (`deck_preset_id`, `card_id`, `card_count`) VALUES
  (1, 12, 1),
  (1, 13, 1),
  (1, 14, 1),
  
  (1, 15, 1),
  (1, 16, 1),
  (1, 17, 1),

  (1, 18, 1),
  (1, 19, 1),
  (1, 20, 1),
  
  (1, 21, 1),
  (1, 22, 1),
  (1, 23, 1),
  
  (1, 24, 1),
  (1, 25, 1),
  (1, 26, 1);

/* Sezóny*/
INSERT INTO `deck_preset_cards` (`deck_preset_id`, `card_id`, `card_count`) VALUES
  (1, 27, 1),
  (1, 28, 1),
  (1, 29, 1),
  (1, 30, 1),
  (1, 31, 1),
  (1, 32, 1),
  (1, 33, 1);

/* Personál 34-46, 1x */
INSERT INTO `deck_preset_cards` (`deck_preset_id`, `card_id`, `card_count`) VALUES
  (1, 34, 1),
  (1, 35, 1),
  (1, 36, 1),
  (1, 37, 1),
  (1, 38, 1),
  (1, 39, 1),
  (1, 40, 1),
  (1, 41, 1),
  (1, 42, 1),
  (1, 43, 1),
  (1, 44, 1),
  (1, 45, 1),
  (1, 46, 1);

/* Monsters - Caves, 47 -55 */
INSERT INTO `deck_preset_cards` (`deck_preset_id`, `card_id`, `card_count`) VALUES
  (1, 47, 4),
  (1, 48, 1),
  (1, 49, 1),
  (1, 50, 2),
  (1, 51, 1),
  (1, 52, 1),
  (1, 53, 2),
  (1, 54, 1),
  (1, 55, 1);

/* Monsters - Deepwaters */
INSERT INTO `deck_preset_cards` (`deck_preset_id`, `card_id`, `card_count`) VALUES
  (1, 56, 4),
  (1, 57, 1),
  (1, 58, 1),
  (1, 59, 2),
  (1, 60, 1),
  (1, 61, 1),
  (1, 62, 2),
  (1, 63, 1),
  (1, 64, 1);

/* Monsters - Air */
INSERT INTO `deck_preset_cards` (`deck_preset_id`, `card_id`, `card_count`) VALUES
  (1, 65, 4),
  (1, 66, 1),
  (1, 67, 1),
  (1, 68, 2),
  (1, 69, 1),
  (1, 70, 1),
  (1, 71, 2),
  (1, 72, 1),
  (1, 73, 1);

/* Monsters - Forest */
INSERT INTO `deck_preset_cards` (`deck_preset_id`, `card_id`, `card_count`) VALUES
  (1, 74, 4),
  (1, 75, 1),
  (1, 76, 1),
  (1, 77, 2),
  (1, 78, 1),
  (1, 79, 1),
  (1, 80, 2),
  (1, 81, 1),
  (1, 82, 1);
  
/* Monsters - Darklands */
INSERT INTO `deck_preset_cards` (`deck_preset_id`, `card_id`, `card_count`) VALUES
  (1, 83, 4),
  (1, 84, 1),
  (1, 85, 1),
  (1, 86, 2),
  (1, 87, 1),
  (1, 88, 1),
  (1, 89, 2),
  (1, 90, 1),
  (1, 91, 1);

/* Monsters - Dreamlands */
INSERT INTO `deck_preset_cards` (`deck_preset_id`, `card_id`, `card_count`) VALUES
  (1, 92, 1),
  (1, 93, 1),
  (1, 94, 1),
  (1, 95, 1),
  (1, 96, 1),
  (1, 97, 1),
  (1, 98, 1),
  (1, 99, 1);
  
CREATE TABLE `player` (
  `id` INT unsigned auto_increment PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL
);
INSERT INTO `player` (`id`, `name`) VALUES
  (1, 'Arnoštek'),
  (2, 'Helenka'),
  (3, 'Pepíček');

CREATE TABLE `game` (
  `id` INT unsigned auto_increment PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL,
  `deck_preset_id` INT unsigned  NOT NULL,
  `seasons_rounds` INT unsigned  NOT NULL,
  `player1_id` INT unsigned NOT NULL,
  `player2_id` INT unsigned NOT NULL,
  `player3_id` INT unsigned default NULL,
  `player4_id` INT unsigned default NULL,
  `player5_id` INT unsigned default NULL,

  CONSTRAINT `fk_game_deckpreset` FOREIGN KEY (`deck_preset_id`) REFERENCES deck_preset_cards(`id`),
  CONSTRAINT `fk_game_player1` FOREIGN KEY (`player1_id`) REFERENCES player(`id`),
  CONSTRAINT `fk_game_player2` FOREIGN KEY (`player2_id`) REFERENCES player(`id`),
  CONSTRAINT `fk_game_player3` FOREIGN KEY (`player3_id`) REFERENCES player(`id`),
  CONSTRAINT `fk_game_player4` FOREIGN KEY (`player4_id`) REFERENCES player(`id`),
  CONSTRAINT `fk_game_player5` FOREIGN KEY (`player5_id`) REFERENCES player(`id`)
);

INSERT INTO `game` (`id`, `name`, `deck_preset_id`, `seasons_rounds`, `player1_id`, `player2_id`, `player3_id` ) VALUES
  (1, 'Testovací hra', 1, 3, 1, 2, 3);


CREATE TABLE `deck_ingame_cards_position` (
  `id` INT unsigned auto_increment PRIMARY KEY,
  `position_name` VARCHAR(255) NOT NULL
);

INSERT INTO `deck_ingame_cards_position` (`id`, `position_name`) VALUES
  (1, 'ingame_deck'),
  (2, 'discard'),
  (3, 'stored_cards'),
  (4, 'placed_cards'),
  (5, 'bestiary'),
  (6, 'round1_hand'),
  (7, 'round2_hand'),
  (8, 'round3_hand'),
  (9, 'round4_hand'),
  (10, 'round5_hand'),
  (11, 'round6_hand'),
  (12, 'round7_hand'),
  (13, 'round8_hand'),
  (14, 'player_library');
  

CREATE TABLE `deck_ingame_cards` (
  `id` INT unsigned auto_increment PRIMARY KEY,
  `game_id` INT unsigned NOT NULL,
  `card_id` INT unsigned NOT NULL,
  `card_position_id` INT unsigned  NOT NULL,
  `player_id` INT unsigned  NOT NULL,

  CONSTRAINT `fk_deck_ingame_cards_game` FOREIGN KEY (`game_id`) REFERENCES game(`id`),
  CONSTRAINT `fk_deck_ingame_cards_cards` FOREIGN KEY (`card_id`) REFERENCES cards(`id`),
  CONSTRAINT `fk_deck_ingame_cards_cardposition` FOREIGN KEY (`card_position_id`) REFERENCES deck_ingame_cards_position(`id`),
  CONSTRAINT `fk_deck_ingame_cards_player` FOREIGN KEY (`player_id`) REFERENCES player(`id`)
);