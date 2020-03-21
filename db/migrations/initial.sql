-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Table `country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `country` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `iso_3166_code` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(500) NOT NULL,
  `description` TEXT NOT NULL,
  `country_id` INT UNSIGNED NULL,
  `type` ENUM('SLACK', 'DISCORD', 'TELEGRAM', 'OTHER') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_group_country1_idx` (`country_id` ASC),
  CONSTRAINT `fk_group_country1`
    FOREIGN KEY (`country_id`)
    REFERENCES `country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `service_link`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `service_link` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `text` VARCHAR(255) NOT NULL,
  `url` VARCHAR(500) NOT NULL,
  `group_id` INT UNSIGNED NOT NULL,
  `type` ENUM('SLACK', 'TELEGRAM', 'DISCORD', 'TWITTER', 'FACEBOOK', 'INSTAGRAM', 'TRELLO', 'WEBSITE') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_link_group1_idx` (`group_id` ASC),
  CONSTRAINT `fk_link_group1`
    FOREIGN KEY (`group_id`)
    REFERENCES `group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `topic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `topic` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `topic` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group_topic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `group_topic` (
  `topic_id` INT UNSIGNED NOT NULL,
  `group_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`topic_id`, `group_id`),
  INDEX `fk_topic_has_group_group1_idx` (`group_id` ASC),
  INDEX `fk_topic_has_group_topic1_idx` (`topic_id` ASC),
  CONSTRAINT `fk_topic_has_group_topic1`
    FOREIGN KEY (`topic_id`)
    REFERENCES `topic` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_topic_has_group_group1`
    FOREIGN KEY (`group_id`)
    REFERENCES `group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
