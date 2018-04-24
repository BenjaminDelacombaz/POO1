-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema POO1EX2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema POO1EX2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `POO1EX2` DEFAULT CHARACTER SET utf8 ;
USE `POO1EX2` ;

-- -----------------------------------------------------
-- Table `POO1EX2`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `POO1EX2`.`clients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NULL,
  `lastname` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `POO1EX2`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `POO1EX2`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `price` INT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `POO1EX2`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `POO1EX2`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `products_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_categories_products1_idx` (`products_id` ASC),
  CONSTRAINT `fk_categories_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `POO1EX2`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `POO1EX2`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `POO1EX2`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NULL,
  `shipped_at` DATETIME NULL,
  `status` VARCHAR(45) NULL,
  `clients_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_orders_clients_idx` (`clients_id` ASC),
  CONSTRAINT `fk_orders_clients`
    FOREIGN KEY (`clients_id`)
    REFERENCES `POO1EX2`.`clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `POO1EX2`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `POO1EX2`.`order_items` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantity` INT NULL,
  `item_price` VARCHAR(45) NULL,
  `orders_id` INT NOT NULL,
  `products_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_items_orders1_idx` (`orders_id` ASC),
  INDEX `fk_order_items_products1_idx` (`products_id` ASC),
  CONSTRAINT `fk_order_items_orders1`
    FOREIGN KEY (`orders_id`)
    REFERENCES `POO1EX2`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_items_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `POO1EX2`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
