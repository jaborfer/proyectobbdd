-- MySQL Script generated by MySQL Workbench
-- 03/13/16 17:54:34
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema elDesvanDeMika
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `elDesvanDeMika` ;

-- -----------------------------------------------------
-- Schema elDesvanDeMika
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `elDesvanDeMika` DEFAULT CHARACTER SET utf8 ;
USE `elDesvanDeMika` ;

-- -----------------------------------------------------
-- Table `elDesvanDeMika`.`CLIENTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elDesvanDeMika`.`CLIENTE` ;

CREATE TABLE IF NOT EXISTS `elDesvanDeMika`.`CLIENTE` (
  `idCLIENTE` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(25) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Telefono` INT(9) NOT NULL,
  `whatsup` TINYINT(1) NULL DEFAULT 1,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCLIENTE`),
  UNIQUE INDEX `idCLIENTE_UNIQUE` (`idCLIENTE` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `elDesvanDeMika`.`PEDIDO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elDesvanDeMika`.`PEDIDO` ;

CREATE TABLE IF NOT EXISTS `elDesvanDeMika`.`PEDIDO` (
  `N pedido` INT NOT NULL,
  `Fecha_Pedido` DATE NOT NULL,
  `fecha_entrega` DATE NULL,
  `Precio` DECIMAL(4,2) NOT NULL,
  `CLIENTE_idCLIENTE` INT NOT NULL,
  PRIMARY KEY (`N pedido`),
  UNIQUE INDEX `N pedido_UNIQUE` (`N pedido` ASC),
  INDEX `fk_PEDIDO_CLIENTE_idx` (`CLIENTE_idCLIENTE` ASC),
  CONSTRAINT `fk_PEDIDO_CLIENTE`
    FOREIGN KEY (`CLIENTE_idCLIENTE`)
    REFERENCES `elDesvanDeMika`.`CLIENTE` (`idCLIENTE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `elDesvanDeMika`.`MANUALIDAD`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elDesvanDeMika`.`MANUALIDAD` ;

CREATE TABLE IF NOT EXISTS `elDesvanDeMika`.`MANUALIDAD` (
  `Nombre` VARCHAR(30) NOT NULL,
  `Tiempo` TINYINT(4) NULL,
  `Foto` MEDIUMBLOB NULL,
  `Observaciones` VARCHAR(75) NULL,
  PRIMARY KEY (`Nombre`),
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `elDesvanDeMika`.`LINEAS_PEDIDO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elDesvanDeMika`.`LINEAS_PEDIDO` ;

CREATE TABLE IF NOT EXISTS `elDesvanDeMika`.`LINEAS_PEDIDO` (
  `PEDIDO_N pedido` INT NOT NULL,
  `MANUALIDAD_Nombre` VARCHAR(30) NOT NULL,
  `Cantidad` TINYINT(4) NOT NULL,
  PRIMARY KEY (`PEDIDO_N pedido`, `MANUALIDAD_Nombre`),
  INDEX `fk_PEDIDO_has_MANUALIDAD_MANUALIDAD1_idx` (`MANUALIDAD_Nombre` ASC),
  INDEX `fk_PEDIDO_has_MANUALIDAD_PEDIDO1_idx` (`PEDIDO_N pedido` ASC),
  CONSTRAINT `fk_PEDIDO_has_MANUALIDAD_PEDIDO1`
    FOREIGN KEY (`PEDIDO_N pedido`)
    REFERENCES `elDesvanDeMika`.`PEDIDO` (`N pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PEDIDO_has_MANUALIDAD_MANUALIDAD1`
    FOREIGN KEY (`MANUALIDAD_Nombre`)
    REFERENCES `elDesvanDeMika`.`MANUALIDAD` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `elDesvanDeMika`.`COMPONENTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elDesvanDeMika`.`COMPONENTE` ;

CREATE TABLE IF NOT EXISTS `elDesvanDeMika`.`COMPONENTE` (
  `Nombre` VARCHAR(25) NOT NULL,
  `precio_unidad` DECIMAL(4,2) NULL,
  PRIMARY KEY (`Nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `elDesvanDeMika`.`PROVEEDOR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elDesvanDeMika`.`PROVEEDOR` ;

CREATE TABLE IF NOT EXISTS `elDesvanDeMika`.`PROVEEDOR` (
  `Nombre` VARCHAR(20) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `telefono` INT(9) NULL,
  `Persona_Contacto` VARCHAR(30) NULL,
  PRIMARY KEY (`Nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `elDesvanDeMika`.`MATERIAL`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elDesvanDeMika`.`MATERIAL` ;

CREATE TABLE IF NOT EXISTS `elDesvanDeMika`.`MATERIAL` (
  `Nombre` VARCHAR(30) NOT NULL,
  `Color` VARCHAR(15) NOT NULL,
  `Subcolor` VARCHAR(15) NOT NULL,
  `PROVEEDOR_Nombre` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Nombre`, `Color`, `Subcolor`),
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC),
  UNIQUE INDEX `Color_UNIQUE` (`Color` ASC),
  UNIQUE INDEX `Subcolor_UNIQUE` (`Subcolor` ASC),
  INDEX `fk_MATERIAL_PROVEEDOR1_idx` (`PROVEEDOR_Nombre` ASC),
  CONSTRAINT `fk_MATERIAL_PROVEEDOR1`
    FOREIGN KEY (`PROVEEDOR_Nombre`)
    REFERENCES `elDesvanDeMika`.`PROVEEDOR` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `elDesvanDeMika`.`FORMADO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elDesvanDeMika`.`FORMADO` ;

CREATE TABLE IF NOT EXISTS `elDesvanDeMika`.`FORMADO` (
  `MATERIAL_Nombre` VARCHAR(30) NOT NULL,
  `MATERIAL_Color` VARCHAR(15) NOT NULL,
  `MATERIAL_Subcolor` VARCHAR(15) NOT NULL,
  `COMPONENTE_Nombre` VARCHAR(25) NOT NULL,
  `cantidad` TINYINT(4) NOT NULL,
  PRIMARY KEY (`MATERIAL_Nombre`, `MATERIAL_Color`, `MATERIAL_Subcolor`, `COMPONENTE_Nombre`),
  INDEX `fk_MATERIAL_has_COMPONENTE_COMPONENTE1_idx` (`COMPONENTE_Nombre` ASC),
  INDEX `fk_MATERIAL_has_COMPONENTE_MATERIAL1_idx` (`MATERIAL_Nombre` ASC, `MATERIAL_Color` ASC, `MATERIAL_Subcolor` ASC),
  CONSTRAINT `fk_MATERIAL_has_COMPONENTE_MATERIAL1`
    FOREIGN KEY (`MATERIAL_Nombre` , `MATERIAL_Color` , `MATERIAL_Subcolor`)
    REFERENCES `elDesvanDeMika`.`MATERIAL` (`Nombre` , `Color` , `Subcolor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MATERIAL_has_COMPONENTE_COMPONENTE1`
    FOREIGN KEY (`COMPONENTE_Nombre`)
    REFERENCES `elDesvanDeMika`.`COMPONENTE` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `elDesvanDeMika`.`TELA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elDesvanDeMika`.`TELA` ;

CREATE TABLE IF NOT EXISTS `elDesvanDeMika`.`TELA` (
  `estampado` VARCHAR(20) NOT NULL,
  `Tejido` VARCHAR(25) NULL,
  `MATERIAL_Nombre` VARCHAR(30) NOT NULL,
  `MATERIAL_Color` VARCHAR(15) NOT NULL,
  `MATERIAL_Subcolor` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`estampado`, `MATERIAL_Nombre`, `MATERIAL_Color`, `MATERIAL_Subcolor`),
  INDEX `fk_TELA_MATERIAL1_idx` (`MATERIAL_Nombre` ASC, `MATERIAL_Color` ASC, `MATERIAL_Subcolor` ASC),
  CONSTRAINT `fk_TELA_MATERIAL1`
    FOREIGN KEY (`MATERIAL_Nombre` , `MATERIAL_Color` , `MATERIAL_Subcolor`)
    REFERENCES `elDesvanDeMika`.`MATERIAL` (`Nombre` , `Color` , `Subcolor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `elDesvanDeMika`.`FIELTRO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elDesvanDeMika`.`FIELTRO` ;

CREATE TABLE IF NOT EXISTS `elDesvanDeMika`.`FIELTRO` (
  `Grosor` TINYINT(4) NOT NULL,
  `MATERIAL_Nombre` VARCHAR(30) NOT NULL,
  `MATERIAL_Color` VARCHAR(15) NOT NULL,
  `MATERIAL_Subcolor` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Grosor`, `MATERIAL_Nombre`, `MATERIAL_Color`, `MATERIAL_Subcolor`),
  INDEX `fk_FIELTRO_MATERIAL1_idx` (`MATERIAL_Nombre` ASC, `MATERIAL_Color` ASC, `MATERIAL_Subcolor` ASC),
  CONSTRAINT `fk_FIELTRO_MATERIAL1`
    FOREIGN KEY (`MATERIAL_Nombre` , `MATERIAL_Color` , `MATERIAL_Subcolor`)
    REFERENCES `elDesvanDeMika`.`MATERIAL` (`Nombre` , `Color` , `Subcolor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `elDesvanDeMika`.`ARCILLA POLIMERICA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elDesvanDeMika`.`ARCILLA POLIMERICA` ;

CREATE TABLE IF NOT EXISTS `elDesvanDeMika`.`ARCILLA POLIMERICA` (
  `Cocida` INT NOT NULL,
  `MATERIAL_Nombre` VARCHAR(30) NOT NULL,
  `MATERIAL_Color` VARCHAR(15) NOT NULL,
  `MATERIAL_Subcolor` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`MATERIAL_Nombre`, `MATERIAL_Color`, `MATERIAL_Subcolor`, `Cocida`),
  CONSTRAINT `fk_ARCILLA POLIMERICA_MATERIAL1`
    FOREIGN KEY (`MATERIAL_Nombre` , `MATERIAL_Color` , `MATERIAL_Subcolor`)
    REFERENCES `elDesvanDeMika`.`MATERIAL` (`Nombre` , `Color` , `Subcolor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `elDesvanDeMika`.`UTILERIA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elDesvanDeMika`.`UTILERIA` ;

CREATE TABLE IF NOT EXISTS `elDesvanDeMika`.`UTILERIA` (
  `MATERIAL_Nombre` VARCHAR(30) NOT NULL,
  `MATERIAL_Color` VARCHAR(15) NOT NULL,
  `MATERIAL_Subcolor` VARCHAR(15) NOT NULL,
  `Clase` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`MATERIAL_Nombre`, `MATERIAL_Color`, `MATERIAL_Subcolor`, `Clase`),
  CONSTRAINT `fk_MATERIAL_MATERIAL1`
    FOREIGN KEY (`MATERIAL_Nombre` , `MATERIAL_Color` , `MATERIAL_Subcolor`)
    REFERENCES `elDesvanDeMika`.`MATERIAL` (`Nombre` , `Color` , `Subcolor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `elDesvanDeMika`.`ABALORIO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elDesvanDeMika`.`ABALORIO` ;

CREATE TABLE IF NOT EXISTS `elDesvanDeMika`.`ABALORIO` (
  `Material` VARCHAR(15) NOT NULL,
  `Forma` VARCHAR(15) NOT NULL,
  `Tamaño` VARCHAR(15) NULL,
  `MATERIAL_Nombre` VARCHAR(30) NOT NULL,
  `MATERIAL_Color` VARCHAR(15) NOT NULL,
  `MATERIAL_Subcolor` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Material`, `Forma`, `MATERIAL_Nombre`, `MATERIAL_Color`, `MATERIAL_Subcolor`),
  INDEX `fk_ABALORIO_MATERIAL1_idx` (`MATERIAL_Nombre` ASC, `MATERIAL_Color` ASC, `MATERIAL_Subcolor` ASC),
  CONSTRAINT `fk_ABALORIO_MATERIAL1`
    FOREIGN KEY (`MATERIAL_Nombre` , `MATERIAL_Color` , `MATERIAL_Subcolor`)
    REFERENCES `elDesvanDeMika`.`MATERIAL` (`Nombre` , `Color` , `Subcolor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `elDesvanDeMika`.`COMPONENTE_has_MANUALIDAD`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elDesvanDeMika`.`COMPONENTE_has_MANUALIDAD` ;

CREATE TABLE IF NOT EXISTS `elDesvanDeMika`.`COMPONENTE_has_MANUALIDAD` (
  `COMPONENTE_Nombre` VARCHAR(25) NOT NULL,
  `COMPONENTE_MANUALIDAD_Nombre` VARCHAR(30) NOT NULL,
  `MANUALIDAD_Nombre` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`COMPONENTE_Nombre`, `COMPONENTE_MANUALIDAD_Nombre`, `MANUALIDAD_Nombre`),
  INDEX `fk_COMPONENTE_has_MANUALIDAD_MANUALIDAD1_idx` (`MANUALIDAD_Nombre` ASC),
  INDEX `fk_COMPONENTE_has_MANUALIDAD_COMPONENTE1_idx` (`COMPONENTE_Nombre` ASC, `COMPONENTE_MANUALIDAD_Nombre` ASC),
  CONSTRAINT `fk_COMPONENTE_has_MANUALIDAD_COMPONENTE1`
    FOREIGN KEY (`COMPONENTE_Nombre`)
    REFERENCES `elDesvanDeMika`.`COMPONENTE` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COMPONENTE_has_MANUALIDAD_MANUALIDAD1`
    FOREIGN KEY (`MANUALIDAD_Nombre`)
    REFERENCES `elDesvanDeMika`.`MANUALIDAD` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `elDesvanDeMika`.`MANUALIDAD_has_COMPONENTE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `elDesvanDeMika`.`MANUALIDAD_has_COMPONENTE` ;

CREATE TABLE IF NOT EXISTS `elDesvanDeMika`.`MANUALIDAD_has_COMPONENTE` (
  `MANUALIDAD_Nombre` VARCHAR(30) NOT NULL,
  `COMPONENTE_Nombre` VARCHAR(25) NOT NULL,
  `Cantidad` TINYINT(4) NOT NULL,
  PRIMARY KEY (`MANUALIDAD_Nombre`, `COMPONENTE_Nombre`),
  INDEX `fk_MANUALIDAD_has_COMPONENTE_COMPONENTE1_idx` (`COMPONENTE_Nombre` ASC),
  INDEX `fk_MANUALIDAD_has_COMPONENTE_MANUALIDAD1_idx` (`MANUALIDAD_Nombre` ASC),
  CONSTRAINT `fk_MANUALIDAD_has_COMPONENTE_MANUALIDAD1`
    FOREIGN KEY (`MANUALIDAD_Nombre`)
    REFERENCES `elDesvanDeMika`.`MANUALIDAD` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MANUALIDAD_has_COMPONENTE_COMPONENTE1`
    FOREIGN KEY (`COMPONENTE_Nombre`)
    REFERENCES `elDesvanDeMika`.`COMPONENTE` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
GRANT USAGE ON *.* TO desvan;
 DROP USER desvan;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'desvan' IDENTIFIED BY 'mika';

GRANT ALL ON `elDesvanDeMika`.* TO 'desvan';
GRANT SELECT ON TABLE `elDesvanDeMika`.* TO 'desvan';
GRANT SELECT, INSERT, TRIGGER ON TABLE `elDesvanDeMika`.* TO 'desvan';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `elDesvanDeMika`.* TO 'desvan';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
