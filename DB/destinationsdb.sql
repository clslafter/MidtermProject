-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema destinationsdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `destinationsdb` ;

-- -----------------------------------------------------
-- Schema destinationsdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `destinationsdb` DEFAULT CHARACTER SET utf8 ;
USE `destinationsdb` ;

-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(100) NULL,
  `city` VARCHAR(45) NULL,
  `state_province` VARCHAR(45) NULL,
  `zip` VARCHAR(10) NULL,
  `country` VARCHAR(45) NULL,
  `latitude` DOUBLE NULL,
  `longitude` DOUBLE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `role` VARCHAR(45) NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  `address_id` INT NOT NULL,
  `created_date` DATETIME NULL,
  `image_url` VARCHAR(1000) NULL,
  `bio` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_address1_idx` (`address_id` ASC),
  UNIQUE INDEX `user_name_UNIQUE` (`username` ASC),
  CONSTRAINT `fk_user_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `destination`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `destination` ;

CREATE TABLE IF NOT EXISTS `destination` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `description` VARCHAR(2000) NULL,
  `website_url` VARCHAR(100) NULL,
  `user_id` INT NOT NULL,
  `address_id` INT NOT NULL,
  `create_date` DATETIME NULL,
  `last_edited` DATETIME NULL,
  `image_url` VARCHAR(1000) NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `fk_destination_user1_idx` (`user_id` ASC),
  INDEX `fk_destination_address1_idx` (`address_id` ASC),
  CONSTRAINT `fk_destination_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_destination_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `review` ;

CREATE TABLE IF NOT EXISTS `review` (
  `comment` TEXT NOT NULL,
  `rating` INT NULL,
  `image_url` VARCHAR(300) NULL,
  `destination_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `review_date` DATETIME NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  INDEX `fk_review_destination1_idx` (`destination_id` ASC),
  INDEX `fk_review_user1_idx` (`user_id` ASC),
  PRIMARY KEY (`destination_id`, `user_id`),
  CONSTRAINT `fk_review_destination1`
    FOREIGN KEY (`destination_id`)
    REFERENCES `destination` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category` ;

CREATE TABLE IF NOT EXISTS `category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `currency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `currency` ;

CREATE TABLE IF NOT EXISTS `currency` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `destination_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `destination_category` ;

CREATE TABLE IF NOT EXISTS `destination_category` (
  `destination_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`destination_id`, `category_id`),
  INDEX `fk_destination_category_destination_idx` (`destination_id` ASC),
  INDEX `fk_destination_category_category1_idx` (`category_id` ASC),
  CONSTRAINT `fk_destination_category_destination`
    FOREIGN KEY (`destination_id`)
    REFERENCES `destination` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_destination_category_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `review_reaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `review_reaction` ;

CREATE TABLE IF NOT EXISTS `review_reaction` (
  `user_id` INT NOT NULL,
  `reaction` TINYINT NOT NULL,
  `reaction_date` DATETIME NOT NULL,
  `review_destination_id` INT NOT NULL,
  `review_user_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `review_destination_id`, `review_user_id`),
  INDEX `fk_review_reaction_review1_idx` (`review_destination_id` ASC, `review_user_id` ASC),
  CONSTRAINT `fk_review_reaction_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_reaction_review1`
    FOREIGN KEY (`review_destination_id` , `review_user_id`)
    REFERENCES `review` (`destination_id` , `user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `review_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `review_comment` ;

CREATE TABLE IF NOT EXISTS `review_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comment` TEXT NULL,
  `created_date` DATETIME NULL,
  `user_id` INT NOT NULL,
  `in_reply_to_id` INT NULL,
  `review_destination_id` INT NOT NULL,
  `review_user_id` INT NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`, `review_destination_id`, `review_user_id`),
  INDEX `fk_review_comment_user1_idx` (`user_id` ASC),
  INDEX `fk_review_comment_review_comment1_idx` (`in_reply_to_id` ASC),
  INDEX `fk_review_comment_review1_idx` (`review_destination_id` ASC, `review_user_id` ASC),
  CONSTRAINT `fk_review_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_comment_review_comment1`
    FOREIGN KEY (`in_reply_to_id`)
    REFERENCES `review_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_comment_review1`
    FOREIGN KEY (`review_destination_id` , `review_user_id`)
    REFERENCES `review` (`destination_id` , `user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `destination_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `destination_comment` ;

CREATE TABLE IF NOT EXISTS `destination_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comment` TEXT NULL,
  `created_date` DATETIME NULL,
  `user_id` INT NOT NULL,
  `in_reply_to_id` INT NULL,
  `destination_id` INT NOT NULL,
  `enabled` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_review_comment_user1_idx` (`user_id` ASC),
  INDEX `fk_review_comment_review_comment1_idx` (`in_reply_to_id` ASC),
  INDEX `fk_review_comment_copy1_destination1_idx` (`destination_id` ASC),
  CONSTRAINT `fk_review_comment_user10`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_comment_review_comment10`
    FOREIGN KEY (`in_reply_to_id`)
    REFERENCES `destination_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_comment_copy1_destination1`
    FOREIGN KEY (`destination_id`)
    REFERENCES `destination` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `destination_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `destination_image` ;

CREATE TABLE IF NOT EXISTS `destination_image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image_url` VARCHAR(1000) NOT NULL,
  `caption` VARCHAR(1000) NULL,
  `image_date` DATETIME NULL,
  `destination_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_destination_image_destination1_idx` (`destination_id` ASC),
  INDEX `fk_destination_image_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_destination_image_destination1`
    FOREIGN KEY (`destination_id`)
    REFERENCES `destination` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_destination_image_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `feature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `feature` ;

CREATE TABLE IF NOT EXISTS `feature` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(1000) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `feature_destination`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `feature_destination` ;

CREATE TABLE IF NOT EXISTS `feature_destination` (
  `feature_id` INT NOT NULL,
  `destination_id` INT NOT NULL,
  PRIMARY KEY (`feature_id`, `destination_id`),
  INDEX `fk_feature_has_destination_destination1_idx` (`destination_id` ASC),
  INDEX `fk_feature_has_destination_feature1_idx` (`feature_id` ASC),
  CONSTRAINT `fk_feature_has_destination_feature1`
    FOREIGN KEY (`feature_id`)
    REFERENCES `feature` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_feature_has_destination_destination1`
    FOREIGN KEY (`destination_id`)
    REFERENCES `destination` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pricing_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pricing_type` ;

CREATE TABLE IF NOT EXISTS `pricing_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `price` ;

CREATE TABLE IF NOT EXISTS `price` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(7,2) NULL,
  `destination_id` INT NOT NULL,
  `pricing_type_id` INT NOT NULL,
  `currency_id` INT NOT NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_table1_destination1_idx` (`destination_id` ASC),
  INDEX `fk_table1_pricing_type1_idx` (`pricing_type_id` ASC),
  INDEX `fk_price_currency1_idx` (`currency_id` ASC),
  CONSTRAINT `fk_table1_destination1`
    FOREIGN KEY (`destination_id`)
    REFERENCES `destination` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_pricing_type1`
    FOREIGN KEY (`pricing_type_id`)
    REFERENCES `pricing_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_price_currency1`
    FOREIGN KEY (`currency_id`)
    REFERENCES `currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS direuser@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'direuser'@'localhost' IDENTIFIED BY 'direuser';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'direuser'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `address`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `address` (`id`, `street`, `city`, `state_province`, `zip`, `country`, `latitude`, `longitude`) VALUES (2, '20 South Entrance Road', 'Grand Canyon', 'AZ', '86023', 'USA', NULL, NULL);
INSERT INTO `address` (`id`, `street`, `city`, `state_province`, `zip`, `country`, `latitude`, `longitude`) VALUES (3, NULL, NULL, NULL, '08680', 'Peru', NULL, NULL);
INSERT INTO `address` (`id`, `street`, `city`, `state_province`, `zip`, `country`, `latitude`, `longitude`) VALUES (4, '2000 Elitch Cir', 'Denver', 'CO', '80204', 'USA', NULL, NULL);
INSERT INTO `address` (`id`, `street`, `city`, `state_province`, `zip`, `country`, `latitude`, `longitude`) VALUES (1, '123 Main', 'Parker', 'CO', '80134', 'USA', NULL, NULL);
INSERT INTO `address` (`id`, `street`, `city`, `state_province`, `zip`, `country`, `latitude`, `longitude`) VALUES (5, '456 Maple', 'New Orleans', 'LA', '70032', 'USA', NULL, NULL);
INSERT INTO `address` (`id`, `street`, `city`, `state_province`, `zip`, `country`, `latitude`, `longitude`) VALUES (6, '200 E Colfax Ave', 'Denver', 'CO', '80203', 'USA', NULL, NULL);
INSERT INTO `address` (`id`, `street`, `city`, `state_province`, `zip`, `country`, `latitude`, `longitude`) VALUES (7, '1300 Perdido St', 'New Orleans', 'LA', '70112', 'USA', NULL, NULL);
INSERT INTO `address` (`id`, `street`, `city`, `state_province`, `zip`, `country`, `latitude`, `longitude`) VALUES (8, '20120 Mainstreet', 'Parker', 'CO', '80138', 'USA', NULL, NULL);
INSERT INTO `address` (`id`, `street`, `city`, `state_province`, `zip`, `country`, `latitude`, `longitude`) VALUES (9, ' 6715 W Colfax Ave', 'Lakewood ', 'CO', '80214', 'USA', NULL, NULL);
INSERT INTO `address` (`id`, `street`, `city`, `state_province`, `zip`, `country`, `latitude`, `longitude`) VALUES (10, '900 E 11th St', 'Austin', 'TX', '78792', 'USA', NULL, NULL);
INSERT INTO `address` (`id`, `street`, `city`, `state_province`, `zip`, `country`, `latitude`, `longitude`) VALUES (11, '597 NM-597', 'Teec Nos Pos', 'AZ', '86514', 'USA', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `enabled`, `address_id`, `created_date`, `image_url`, `bio`) VALUES (1, 'admin', 'dire', 'admin@server.com', 'Dire', 'Cannibal', 'admin', 1, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `enabled`, `address_id`, `created_date`, `image_url`, `bio`) VALUES (2, 'normaluser', '1234', 'jdoe@server.com', 'John', 'Doe', 'normal', 1, 5, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `enabled`, `address_id`, `created_date`, `image_url`, `bio`) VALUES (3, 'anewman', 'Aspen', 'fake@server.com', 'Aspen', 'Newman', 'admin', 1, 6, '2022-10-20 12:00:00', NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `enabled`, `address_id`, `created_date`, `image_url`, `bio`) VALUES (4, 'cslafter', 'Celicia', 'notreal@server.com', 'Celicia', 'Slafter', 'admin', 1, 7, '2022-10-20 12:00:00', NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `enabled`, `address_id`, `created_date`, `image_url`, `bio`) VALUES (5, 'jingram', 'Josh', 'words@host.com', 'Josh', 'Ingram', 'admin', 1, 8, '2022-10-20 12:00:00', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `destination`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `destination` (`id`, `name`, `description`, `website_url`, `user_id`, `address_id`, `create_date`, `last_edited`, `image_url`, `enabled`) VALUES (1, 'Grand Canyon', 'Grand Canyon National Park, in Arizona, is home to much of the immense Grand Canyon, with its layered bands of red rock revealing millions of years of geological history.', 'https://www.nps.gov/grca/index.htm', 1, 2, '2022-10-20 14:00:00', NULL, 'https://cdn1.coolworks.com/production/clients/6184/pictures/23635/content/Grand_Canyon_resize.png', 1);
INSERT INTO `destination` (`id`, `name`, `description`, `website_url`, `user_id`, `address_id`, `create_date`, `last_edited`, `image_url`, `enabled`) VALUES (2, 'Machu Picchu', 'Incan citadel set high in the Andes Mountains in Peru', 'https://www.machupicchu.org/', 1, 3, '2022-10-20 14:01:00', NULL, 'https://images.ctfassets.net/cnu0m8re1exe/6Xf1pu8Tv0tPTAiPjOs0es/13b2238fd3ea11fd658ad71596d28abd/shutterstock_1387848629.jpg?fm=jpg&fl=progressive&w=660&h=433&fit=fill', 1);
INSERT INTO `destination` (`id`, `name`, `description`, `website_url`, `user_id`, `address_id`, `create_date`, `last_edited`, `image_url`, `enabled`) VALUES (3, 'Elitch Gardens', 'Big fun in Denver with roller coasters, water park, and more!', 'https://www.elitchgardens.com/', 2, 4, '2022-10-20 14:02:00', NULL, 'https://media.9news.com/assets/KUSA/images/7845f8f6-e43f-4181-8470-2a9ce52aa8f5/7845f8f6-e43f-4181-8470-2a9ce52aa8f5_1140x641.jpg', 1);
INSERT INTO `destination` (`id`, `name`, `description`, `website_url`, `user_id`, `address_id`, `create_date`, `last_edited`, `image_url`, `enabled`) VALUES (4, 'Casa Bonita', 'Mex eats & pageantry such as divers plunging into a pool below a 30-ft. waterfall & puppet shows', 'https://www.casabonitadenver.com/', 3, 9, '2022-10-22-11:30:00', '2022-10-22 11:32:00', 'https://d.newsweek.com/en/full/1775673/colorado-casa-bonita-restaurant.webp?w=790&f=084db42ee07f3a2b3eab9e5b33a1b675', 1);
INSERT INTO `destination` (`id`, `name`, `description`, `website_url`, `user_id`, `address_id`, `create_date`, `last_edited`, `image_url`, `enabled`) VALUES (5, 'Franklin Barbecue', 'Can a restaurant be a tourist attraction?  Absolutely.  Long lines form early for brisket, pulled pork & other smoked meats at this bustling spot.', 'https://franklinbbq.com/', 5, 10, '2022-10-22 11:33:00', '2022-10-22 11:35:00', 'https://media.bizj.us/view/img/4591511/franklinbarbecue-2*750xx5760-3246-0-592.jpg', 1);
INSERT INTO `destination` (`id`, `name`, `description`, `website_url`, `user_id`, `address_id`, `create_date`, `last_edited`, `image_url`, `enabled`) VALUES (6, 'Four Corners', 'The intersection of four US states; Arizona, Colorado, New Mexico and Utah.', 'https://navajonationparks.org/tribal-parks/four-corners-monument/', 4, 11, '2022-10-22 11:45:00', '2022-10-22 11:46:00', 'https://assets.simpleviewinc.com/simpleview/image/upload/c_fill,h_635,q_60,w_1060/v1/clients/utahddm/52ab002618_d66704e7-fcb8-446a-a97e-8f9ca6b5f9a3.jpg', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `review`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `review` (`comment`, `rating`, `image_url`, `destination_id`, `user_id`, `review_date`, `enabled`) VALUES ('This is a Review: The Grand Canyon is great!', 5, 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Canyon_River_Tree_%28165872763%29.jpeg/576px-Canyon_River_Tree_%28165872763%29.jpeg', 1, 1, '2022-10-20 14:00:00', DEFAULT);
INSERT INTO `review` (`comment`, `rating`, `image_url`, `destination_id`, `user_id`, `review_date`, `enabled`) VALUES ('This is a Review: Machu Picchu is super cool', 4, 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Before_Machu_Picchu.jpg/600px-Before_Machu_Picchu.jpg', 2, 1, '2022-10-20 14:01:00', DEFAULT);
INSERT INTO `review` (`comment`, `rating`, `image_url`, `destination_id`, `user_id`, `review_date`, `enabled`) VALUES ('This is a Review: Filler text for Elitch Gardens review', 3, NULL, 3, 2, '2022-10-20 14:02:00', DEFAULT);
INSERT INTO `review` (`comment`, `rating`, `image_url`, `destination_id`, `user_id`, `review_date`, `enabled`) VALUES ('This is a Review: It was too hot, I generally prefer indoor destinations. ', 2, NULL, 1, 2, '2022-10-22 11:00:00', DEFAULT);
INSERT INTO `review` (`comment`, `rating`, `image_url`, `destination_id`, `user_id`, `review_date`, `enabled`) VALUES ('This is a Review: Simply amazing, be sure to give yourself enough time to really explore.', 4, NULL, 1, 5, '2022-10-22 12:00:00', DEFAULT);
INSERT INTO `review` (`comment`, `rating`, `image_url`, `destination_id`, `user_id`, `review_date`, `enabled`) VALUES ('This is a Review: Looks like this Colorado icon is temporarily closed.  Was a lot of fun last time I went.  The cliff divers are really cool.', 4, NULL, 4, 3, '2022-10-22 12:25:00', DEFAULT);
INSERT INTO `review` (`comment`, `rating`, `image_url`, `destination_id`, `user_id`, `review_date`, `enabled`) VALUES ('This is a Reveiw: Simply the best BBQ in Texas, and therefore, the world.  Don\'t let the long lines scare you away.  Arrive early and bring a chair.  ', 5, NULL, 5, 5, '2022-10-22 11:34:00', DEFAULT);
INSERT INTO `review` (`comment`, `rating`, `image_url`, `destination_id`, `user_id`, `review_date`, `enabled`) VALUES ('This is a Review: The four corners is a really unique place.  I could simultaneously stand in four states.', 4, NULL, 6, 4, '2022-10-22 11:45:30', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `category`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `category` (`id`, `name`) VALUES (1, 'natural');
INSERT INTO `category` (`id`, `name`) VALUES (2, 'historic');
INSERT INTO `category` (`id`, `name`) VALUES (3, 'amusement');
INSERT INTO `category` (`id`, `name`) VALUES (4, 'resort');
INSERT INTO `category` (`id`, `name`) VALUES (5, 'entertainment');
INSERT INTO `category` (`id`, `name`) VALUES (6, 'exhibit');
INSERT INTO `category` (`id`, `name`) VALUES (7, 'shopping');
INSERT INTO `category` (`id`, `name`) VALUES (8, 'dining');

COMMIT;


-- -----------------------------------------------------
-- Data for table `currency`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `currency` (`id`, `name`) VALUES (1, 'USD');
INSERT INTO `currency` (`id`, `name`) VALUES (2, 'Sol');

COMMIT;


-- -----------------------------------------------------
-- Data for table `destination_category`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `destination_category` (`destination_id`, `category_id`) VALUES (1, 1);
INSERT INTO `destination_category` (`destination_id`, `category_id`) VALUES (1, 2);
INSERT INTO `destination_category` (`destination_id`, `category_id`) VALUES (2, 2);
INSERT INTO `destination_category` (`destination_id`, `category_id`) VALUES (3, 3);
INSERT INTO `destination_category` (`destination_id`, `category_id`) VALUES (3, 5);
INSERT INTO `destination_category` (`destination_id`, `category_id`) VALUES (3, 8);
INSERT INTO `destination_category` (`destination_id`, `category_id`) VALUES (4, 8);
INSERT INTO `destination_category` (`destination_id`, `category_id`) VALUES (4, 5);
INSERT INTO `destination_category` (`destination_id`, `category_id`) VALUES (5, 8);
INSERT INTO `destination_category` (`destination_id`, `category_id`) VALUES (6, 1);
INSERT INTO `destination_category` (`destination_id`, `category_id`) VALUES (6, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `review_reaction`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `review_reaction` (`user_id`, `reaction`, `reaction_date`, `review_destination_id`, `review_user_id`) VALUES (2, 1, '2022-10-20 14:02:03', 1, 1);
INSERT INTO `review_reaction` (`user_id`, `reaction`, `reaction_date`, `review_destination_id`, `review_user_id`) VALUES (5, 0, '2022-10-22-11:15:00', 1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `review_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `review_comment` (`id`, `comment`, `created_date`, `user_id`, `in_reply_to_id`, `review_destination_id`, `review_user_id`, `enabled`) VALUES (1, '#1 This is a Review Comment - Thanks for the review of the Grand Canyon.  I can\'t wait to go there.', '2022-10-20 14:01:30', 2, NULL, 1, 1, 1);
INSERT INTO `review_comment` (`id`, `comment`, `created_date`, `user_id`, `in_reply_to_id`, `review_destination_id`, `review_user_id`, `enabled`) VALUES (2, '#2 This is a Reply to Review Comment #1, lots of words', '2022-10-20 14:05:00', 1, 1, 1, 1, 1);
INSERT INTO `review_comment` (`id`, `comment`, `created_date`, `user_id`, `in_reply_to_id`, `review_destination_id`, `review_user_id`, `enabled`) VALUES (3, '#3 This ia a review comment: Were you surprised that it was hot?', '2022-10-22 11:05:00', 5, NULL, 1, 2, 1);
INSERT INTO `review_comment` (`id`, `comment`, `created_date`, `user_id`, `in_reply_to_id`, `review_destination_id`, `review_user_id`, `enabled`) VALUES (4, '#4 This is a reply to review comment #3:  No, I just didn\'t think it would be as hot as it was.', '2022-10-22 11:10:00', 2, 3, 1, 2, 1);
INSERT INTO `review_comment` (`id`, `comment`, `created_date`, `user_id`, `in_reply_to_id`, `review_destination_id`, `review_user_id`, `enabled`) VALUES (5, '#5 This is a Reply to Review Comment #1', '2022-10-20 14:30:30', 3, 1, 1, 1, 1);
INSERT INTO `review_comment` (`id`, `comment`, `created_date`, `user_id`, `in_reply_to_id`, `review_destination_id`, `review_user_id`, `enabled`) VALUES (6, '#6 This is a Reply to Reply #2', '2022-10-21 19:00:00', 4, 2, 1, 1, 1);
INSERT INTO `review_comment` (`id`, `comment`, `created_date`, `user_id`, `in_reply_to_id`, `review_destination_id`, `review_user_id`, `enabled`) VALUES (7, '#7 This is a Reply to Reply #6', '2022-10-21 22:00:00', 1, 6, 1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `destination_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `destination_comment` (`id`, `comment`, `created_date`, `user_id`, `in_reply_to_id`, `destination_id`, `enabled`) VALUES (1, 'This is a Destination Comment:  OMG, This place looks amazing!', '2022-10-20 14:01:00', 2, NULL, 1, 1);
INSERT INTO `destination_comment` (`id`, `comment`, `created_date`, `user_id`, `in_reply_to_id`, `destination_id`, `enabled`) VALUES (2, 'This is a sample Reply to Destination Comment:  It is, you should really try to go if you can.', '2022-10-20 14:01:15', 1, 1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `destination_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `destination_image` (`id`, `image_url`, `caption`, `image_date`, `destination_id`, `user_id`) VALUES (1, 'https://cdn.britannica.com/86/94286-050-B15C8449/Moonrise-mesa-Grand-Canyon-National-Park-Arizona.jpg', 'This is the Grand Canyon', '2022-10-23- 12:00:00', 1, 1);
INSERT INTO `destination_image` (`id`, `image_url`, `caption`, `image_date`, `destination_id`, `user_id`) VALUES (2, 'https://content.r9cdn.net/rimg/dimg/4c/ac/7e6077e1-city-45618-165ce416a23.jpg?crop=true&width=1020&height=498', 'Check out this llama', NULL, 2, 2);
INSERT INTO `destination_image` (`id`, `image_url`, `caption`, `image_date`, `destination_id`, `user_id`) VALUES (3, 'https://media.9news.com/assets/KUSA/images/e4c5b3a9-cd33-4e3c-92ca-7d953c78b300/e4c5b3a9-cd33-4e3c-92ca-7d953c78b300_1140x641.jpg', 'The waterpark is a lot of fun!', NULL, 3, 2);
INSERT INTO `destination_image` (`id`, `image_url`, `caption`, `image_date`, `destination_id`, `user_id`) VALUES (4, 'https://media.9news.com/assets/KUSA/images/699a150f-eb1f-47ef-a5ff-84210d8f25c1/699a150f-eb1f-47ef-a5ff-84210d8f25c1_1140x641.jpg', 'Wee!', NULL, 3, 2);
INSERT INTO `destination_image` (`id`, `image_url`, `caption`, `image_date`, `destination_id`, `user_id`) VALUES (5, 'https://gray-kktv-prod.cdn.arcpublishing.com/resizer/01MD7WB3VRaDDHaSoV-CbKlb7wc=/1200x675/smart/filters:quality(85)/cloudfront-us-east-1.images.arcpublishing.com/gray/3DROCPT4FNHUZJSKPJ737PTMKM.jpg', 'Tables with a view.', NULL, 4, 2);
INSERT INTO `destination_image` (`id`, `image_url`, `caption`, `image_date`, `destination_id`, `user_id`) VALUES (6, 'https://www.femalefoodie.com/wp-content/uploads/2018/05/franklin-bbq-7.jpg', 'Sample plate', NULL, 5, 5);
INSERT INTO `destination_image` (`id`, `image_url`, `caption`, `image_date`, `destination_id`, `user_id`) VALUES (7, 'https://d3qvqlc701gzhm.cloudfront.net/full/ce17039904255c80698351a2ffaefa9939f2e3092ca2ef980f09553cceb41c66.jpg', 'The Colorado River', '2022-10-24 12:45:00', 1, 5);
INSERT INTO `destination_image` (`id`, `image_url`, `caption`, `image_date`, `destination_id`, `user_id`) VALUES (8, 'https://d3qvqlc701gzhm.cloudfront.net/full/e86f403fa75b4eaf902c1a292abcc3b173ad6889d62e6013bac82c1fa57bc025.jpg', 'What an overlook!', '2022-10-24 12:46:00', 1, 4);
INSERT INTO `destination_image` (`id`, `image_url`, `caption`, `image_date`, `destination_id`, `user_id`) VALUES (9, 'https://d3qvqlc701gzhm.cloudfront.net/full/dddaccbbd2500a39a67c43b20f706ab97cd74a94ff3d8c420b7ddba068623b90.jpg', 'Beautiful!!!', '2022-10-24 12:47:00', 1, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `feature`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (1, 'Handicapped Parking', 'reserved, close-in parking for those with appropriate placards or plates');
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (2, 'Restrooms', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (3, 'Air Conditioning', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `feature_destination`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `feature_destination` (`feature_id`, `destination_id`) VALUES (1, 1);
INSERT INTO `feature_destination` (`feature_id`, `destination_id`) VALUES (2, 1);
INSERT INTO `feature_destination` (`feature_id`, `destination_id`) VALUES (1, 3);
INSERT INTO `feature_destination` (`feature_id`, `destination_id`) VALUES (2, 3);
INSERT INTO `feature_destination` (`feature_id`, `destination_id`) VALUES (1, 4);
INSERT INTO `feature_destination` (`feature_id`, `destination_id`) VALUES (2, 4);
INSERT INTO `feature_destination` (`feature_id`, `destination_id`) VALUES (1, 5);
INSERT INTO `feature_destination` (`feature_id`, `destination_id`) VALUES (2, 5);
INSERT INTO `feature_destination` (`feature_id`, `destination_id`) VALUES (1, 6);
INSERT INTO `feature_destination` (`feature_id`, `destination_id`) VALUES (2, 6);
INSERT INTO `feature_destination` (`feature_id`, `destination_id`) VALUES (3, 4);
INSERT INTO `feature_destination` (`feature_id`, `destination_id`) VALUES (3, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `pricing_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `pricing_type` (`id`, `name`, `description`) VALUES (1, 'Free', NULL);
INSERT INTO `pricing_type` (`id`, `name`, `description`) VALUES (2, 'Veteran', '');
INSERT INTO `pricing_type` (`id`, `name`, `description`) VALUES (3, 'Senior', '');
INSERT INTO `pricing_type` (`id`, `name`, `description`) VALUES (4, 'Adult', NULL);
INSERT INTO `pricing_type` (`id`, `name`, `description`) VALUES (5, 'Child', NULL);
INSERT INTO `pricing_type` (`id`, `name`, `description`) VALUES (6, 'Carload', '');
INSERT INTO `pricing_type` (`id`, `name`, `description`) VALUES (7, 'Motorcycle ', '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `price`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `price` (`id`, `amount`, `destination_id`, `pricing_type_id`, `currency_id`, `description`) VALUES (1, 49.99, 3, 4, 1, NULL);
INSERT INTO `price` (`id`, `amount`, `destination_id`, `pricing_type_id`, `currency_id`, `description`) VALUES (2, 154.00, 2, 4, 2, NULL);
INSERT INTO `price` (`id`, `amount`, `destination_id`, `pricing_type_id`, `currency_id`, `description`) VALUES (3, 8.00, 6, 4, 1, 'flat fee for all guests, National Park Passes do not apply');
INSERT INTO `price` (`id`, `amount`, `destination_id`, `pricing_type_id`, `currency_id`, `description`) VALUES (4, 35.00, 1, 6, 1, 'dmits one single, private, non-commercial vehicle and all its passengers, up to a 15 person passenger van.');
INSERT INTO `price` (`id`, `amount`, `destination_id`, `pricing_type_id`, `currency_id`, `description`) VALUES (5, 20.00, 1, 4, 1, NULL);
INSERT INTO `price` (`id`, `amount`, `destination_id`, `pricing_type_id`, `currency_id`, `description`) VALUES (6, NULL, 1 , 1, 1, 'For children 15 and under');
INSERT INTO `price` (`id`, `amount`, `destination_id`, `pricing_type_id`, `currency_id`, `description`) VALUES (7, 30.00, 1, 7, 1, 'Admits one single, private, non-commercial motorcycle and its passenger(s).');

COMMIT;

