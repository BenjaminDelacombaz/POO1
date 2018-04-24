-- MySQL Workbench Synchronization
-- Generated: 2018-02-08 08:59
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Kevin.JORDIL

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `ecommerce` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `ecommerce`.`clients` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NULL DEFAULT NULL,
  `lastname` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ecommerce`.`products` (
  `id` INT(11) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `price` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ecommerce`.`orders` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NULL DEFAULT NULL,
  `shipped_at` DATETIME NULL DEFAULT NULL,
  `status` INT(11) NULL DEFAULT NULL,
  `client_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_orders_clients1_idx` (`client_id` ASC),
  CONSTRAINT `fk_orders_clients1`
    FOREIGN KEY (`client_id`)
    REFERENCES `ecommerce`.`clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ecommerce`.`order_items` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `quantity` INT(11) NULL DEFAULT NULL,
  `item_price` FLOAT(11) NULL DEFAULT NULL,
  `order_id` INT(11) NOT NULL,
  `product_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `order_id`, `product_id`),
  INDEX `fk_order_items_orders1_idx` (`order_id` ASC),
  INDEX `fk_order_items_products1_idx` (`product_id` ASC),
  CONSTRAINT `fk_order_items_orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `ecommerce`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_items_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `ecommerce`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ecommerce`.`categories` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ecommerce`.`categories_products` (
  `product_id` INT(11) NOT NULL,
  `categorie_id` INT(11) NOT NULL,
  PRIMARY KEY (`product_id`, `categorie_id`),
  INDEX `fk_products_has_categories_categories1_idx` (`categorie_id` ASC),
  INDEX `fk_products_has_categories_products_idx` (`product_id` ASC),
  CONSTRAINT `fk_products_has_categories_products`
    FOREIGN KEY (`product_id`)
    REFERENCES `ecommerce`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_has_categories_categories1`
    FOREIGN KEY (`categorie_id`)
    REFERENCES `ecommerce`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
