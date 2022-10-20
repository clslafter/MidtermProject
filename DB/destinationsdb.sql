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
-- Table `currency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `currency` ;

CREATE TABLE IF NOT EXISTS `currency` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pricing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pricing` ;

CREATE TABLE IF NOT EXISTS `pricing` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `free` TINYINT NOT NULL,
  `veteran` DOUBLE NULL,
  `senior` DOUBLE NULL,
  `adult` DOUBLE NULL,
  `child` DOUBLE NULL,
  `other` VARCHAR(200) NULL,
  `currency_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pricing_currency1_idx` (`currency_id` ASC),
  CONSTRAINT `fk_pricing_currency1`
    FOREIGN KEY (`currency_id`)
    REFERENCES `currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


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
  `image_url` VARCHAR(300) NULL,
  `website_url` VARCHAR(100) NULL,
  `pricing_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `fk_destination_pricing1_idx` (`pricing_id` ASC),
  INDEX `fk_destination_user1_idx` (`user_id` ASC),
  INDEX `fk_destination_address1_idx` (`address_id` ASC),
  CONSTRAINT `fk_destination_pricing1`
    FOREIGN KEY (`pricing_id`)
    REFERENCES `pricing` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
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
  `id` INT NOT NULL AUTO_INCREMENT,
  `comment` TEXT NOT NULL,
  `rating` INT NOT NULL,
  `reaction` INT NULL,
  `image_url` VARCHAR(300) NULL,
  `destination_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_review_destination1_idx` (`destination_id` ASC),
  INDEX `fk_review_user1_idx` (`user_id` ASC),
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

SET SQL_MODE = '';
DROP USER IF EXISTS direuser@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'direuser'@'localhost' IDENTIFIED BY 'direuser';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'direuser'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `currency`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `currency` (`id`, `name`) VALUES (1, 'USD');
INSERT INTO `currency` (`id`, `name`) VALUES (2, 'Sol');

COMMIT;


-- -----------------------------------------------------
-- Data for table `pricing`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `pricing` (`id`, `free`, `veteran`, `senior`, `adult`, `child`, `other`, `currency_id`) VALUES (1, 0, NULL, NULL, 15.00, NULL, NULL, 1);
INSERT INTO `pricing` (`id`, `free`, `veteran`, `senior`, `adult`, `child`, `other`, `currency_id`) VALUES (2, 0, NULL, NULL, 20.5, NULL, NULL, 2);
INSERT INTO `pricing` (`id`, `free`, `veteran`, `senior`, `adult`, `child`, `other`, `currency_id`) VALUES (3, 0, NULL, NULL, 49.99, NULL, NULL, 1);

COMMIT;


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
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `enabled`, `address_id`) VALUES (1, 'admin', 'dire', 'admin@server.com', 'Dire', 'Cannibal', 'admin', 1, 1);
INSERT INTO `user` (`id`, `username`, `password`, `email`, `first_name`, `last_name`, `role`, `enabled`, `address_id`) VALUES (2, 'normaluser', '1234', 'user@server.com', 'Normal', 'User', 'normal', 1, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `destination`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `destination` (`id`, `name`, `description`, `image_url`, `website_url`, `pricing_id`, `user_id`, `address_id`) VALUES (1, 'Grand Canyon', 'Grand Canyon National Park, in Arizona, is home to much of the immense Grand Canyon, with its layered bands of red rock revealing millions of years of geological history.', 'https://www.nps.gov/grca/planyourvisit/images/mather-point-2021.jpg?maxwidth=1200&maxheight=1200&autorotate=false', 'https://www.nps.gov/grca/index.htm', 1, 1, 2);
INSERT INTO `destination` (`id`, `name`, `description`, `image_url`, `website_url`, `pricing_id`, `user_id`, `address_id`) VALUES (2, 'Machu Picchu', 'Incan citadel set high in the Andes Mountains in Peru', 'https://www.machupicchu.org/location_of_machu_picchu.htm', 'https://www.machupicchu.org/img/machu-picchu-ma-1.jpg', 2, 1, 3);
INSERT INTO `destination` (`id`, `name`, `description`, `image_url`, `website_url`, `pricing_id`, `user_id`, `address_id`) VALUES (3, 'Elitch Gardens', 'Big fun in Denver with roller coasters, water park, and more!', 'https://www.elitchgardens.com/wp-content/uploads/2022/02/theme-park.jpg', 'https://www.elitchgardens.com/', 3, 2, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `review`
-- -----------------------------------------------------
START TRANSACTION;
USE `destinationsdb`;
INSERT INTO `review` (`id`, `comment`, `rating`, `reaction`, `image_url`, `destination_id`, `user_id`) VALUES (1, 'The Grand Canyon is great!', 5, NULL, 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Canyon_River_Tree_%28165872763%29.jpeg/576px-Canyon_River_Tree_%28165872763%29.jpeg', 1, 1);
INSERT INTO `review` (`id`, `comment`, `rating`, `reaction`, `image_url`, `destination_id`, `user_id`) VALUES (2, 'Machu Picchu is super cool', 4, NULL, 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Before_Machu_Picchu.jpg/600px-Before_Machu_Picchu.jpg', 2, 1);
INSERT INTO `review` (`id`, `comment`, `rating`, `reaction`, `image_url`, `destination_id`, `user_id`) VALUES (3, 'Filler text for Elitch Gardens review', 3, NULL, NULL, 3, 1);

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

