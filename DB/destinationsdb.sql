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
  `description` TEXT NULL,
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
  `rating` INT NOT NULL,
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

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `enabled`, `address_id`, `created_date`, `image_url`, `bio`) VALUES (1, 'admin', 'dire', 'admin@server.com', 'Dire', 'Cannibal', 'admin', 1, 1, NULL, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `enabled`, `address_id`, `created_date`, `image_url`, `bio`) VALUES (2, 'normaluser', '1234', 'user@server.com', 'Normal', 'User', 'normal', 1, 5, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `destination`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `destination` (`id`, `name`, `description`, `website_url`, `user_id`, `address_id`, `create_date`, `last_edited`, `image_url`, `enabled`) VALUES (1, 'Grand Canyon', 'Grand Canyon National Park, in Arizona, is home to much of the immense Grand Canyon, with its layered bands of red rock revealing millions of years of geological history.', 'https://www.nps.gov/grca/index.htm', 1, 2, '2022-10-20 14:00:00', NULL, 'https://cdn1.coolworks.com/production/clients/6184/pictures/23635/content/Grand_Canyon_resize.png', 1);
INSERT INTO `destination` (`id`, `name`, `description`, `website_url`, `user_id`, `address_id`, `create_date`, `last_edited`, `image_url`, `enabled`) VALUES (2, 'Machu Picchu', 'Incan citadel set high in the Andes Mountains in Peru', 'https://www.machupicchu.org/img/machu-picchu-ma-1.jpg', 1, 3, '2022-10-20 14:01:00', NULL, 'https://images.ctfassets.net/cnu0m8re1exe/6Xf1pu8Tv0tPTAiPjOs0es/13b2238fd3ea11fd658ad71596d28abd/shutterstock_1387848629.jpg?fm=jpg&fl=progressive&w=660&h=433&fit=fill', 1);
INSERT INTO `destination` (`id`, `name`, `description`, `website_url`, `user_id`, `address_id`, `create_date`, `last_edited`, `image_url`, `enabled`) VALUES (3, 'Elitch Gardens', 'Big fun in Denver with roller coasters, water park, and more!', 'https://www.elitchgardens.com/', 2, 4, '2022-10-20 14:02:00', NULL, 'https://media.9news.com/assets/KUSA/images/7845f8f6-e43f-4181-8470-2a9ce52aa8f5/7845f8f6-e43f-4181-8470-2a9ce52aa8f5_1140x641.jpg', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `review`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `review` (`comment`, `rating`, `image_url`, `destination_id`, `user_id`, `review_date`, `enabled`) VALUES ('This is a Review: The Grand Canyon is great!', 5, 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Canyon_River_Tree_%28165872763%29.jpeg/576px-Canyon_River_Tree_%28165872763%29.jpeg', 1, 1, '2022-10-20 14:00:00', DEFAULT);
INSERT INTO `review` (`comment`, `rating`, `image_url`, `destination_id`, `user_id`, `review_date`, `enabled`) VALUES ('This is a Review: Machu Picchu is super cool', 4, 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Before_Machu_Picchu.jpg/600px-Before_Machu_Picchu.jpg', 2, 1, '2022-10-20 14:01:00', DEFAULT);
INSERT INTO `review` (`comment`, `rating`, `image_url`, `destination_id`, `user_id`, `review_date`, `enabled`) VALUES ('This is a Review: Filler text for Elitch Gardens review', 3, NULL, 3, 2, '2022-10-20 14:02:00', DEFAULT);

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

COMMIT;


-- -----------------------------------------------------
-- Data for table `review_reaction`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `review_reaction` (`user_id`, `reaction`, `reaction_date`, `review_destination_id`, `review_user_id`) VALUES (2, 1, '2022-10-20 14:02:03', 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `review_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `review_comment` (`id`, `comment`, `created_date`, `user_id`, `in_reply_to_id`, `review_destination_id`, `review_user_id`, `enabled`) VALUES (1, 'This is a Review Comment - Thanks for the review of the Grand Canyon.  I can\'t wait to go there.', '2022-10-20 14:01:30', 2, NULL, 1, 1, 1);
INSERT INTO `review_comment` (`id`, `comment`, `created_date`, `user_id`, `in_reply_to_id`, `review_destination_id`, `review_user_id`, `enabled`) VALUES (2, 'This is a Reply to Review Comment, lots of words', '2022-10-20 14:05:00', 1, 1, 1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `destination_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `destination_comment` (`id`, `comment`, `created_date`, `user_id`, `in_reply_to_id`, `destination_id`, `enabled`) VALUES (1, 'This is a Destination Comment:  Blah from user 2', '2022-10-20 14:01:00', 2, NULL, 1, 1);
INSERT INTO `destination_comment` (`id`, `comment`, `created_date`, `user_id`, `in_reply_to_id`, `destination_id`, `enabled`) VALUES (2, 'This is a sample Reply to Destination Comment:  Blah blah from user 1', '2022-10-20 14:01:15', 1, 1, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `destination_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `destination_image` (`id`, `image_url`, `caption`, `image_date`, `destination_id`, `user_id`) VALUES (1, 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.britannica.com%2Fplace%2FGrand-Canyon-National-Park&psig=AOvVaw1jfHWlh84MCffrFsGkwuCW&ust=1666404017001000&source=images&cd=vfe&ved=0CAkQjRxqFwoTCOD0tvCc8PoCFQAAAAAdAAAAABAD', 'This is the Grand Canyon', NULL, 1, 1);
INSERT INTO `destination_image` (`id`, `image_url`, `caption`, `image_date`, `destination_id`, `user_id`) VALUES (2, 'https://content.r9cdn.net/rimg/dimg/4c/ac/7e6077e1-city-45618-165ce416a23.jpg?crop=true&width=1020&height=498', 'Check out this llama', NULL, 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `feature`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (1, 'Handicapped Parking', 'reserved, close-in parking for those with appropriate placards or plates');
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (2, 'Restrooms', NULL);
INSERT INTO `feature` (`id`, `name`, `description`) VALUES (DEFAULT, NULL, NULL);

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

COMMIT;


-- -----------------------------------------------------
-- Data for table `pricing_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `pricing_type` (`id`, `name`, `description`) VALUES (1, 'Free', NULL);
INSERT INTO `pricing_type` (`id`, `name`, `description`) VALUES (2, 'Veteran', 'With vaild ID');
INSERT INTO `pricing_type` (`id`, `name`, `description`) VALUES (3, 'Senior', '65 and over');
INSERT INTO `pricing_type` (`id`, `name`, `description`) VALUES (4, 'Adult', NULL);
INSERT INTO `pricing_type` (`id`, `name`, `description`) VALUES (5, 'Child', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `price`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `price` (`id`, `amount`, `destination_id`, `pricing_type_id`, `currency_id`, `description`) VALUES (1, 49.99, 3, 4, 1, NULL);
INSERT INTO `price` (`id`, `amount`, `destination_id`, `pricing_type_id`, `currency_id`, `description`) VALUES (2, 154, 2, 4, 2, NULL);

COMMIT;

