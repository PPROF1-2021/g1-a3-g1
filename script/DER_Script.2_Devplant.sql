-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DER_Devplant
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DER_Devplant
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DER_Devplant` DEFAULT CHARACTER SET utf8 ;
USE `DER_Devplant` ;

-- -----------------------------------------------------
-- Table `DER_Devplant`.`Localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DER_Devplant`.`Localidad` (
  `idLocalidad` INT NOT NULL AUTO_INCREMENT,
  `provincia` VARCHAR(45) NOT NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idLocalidad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DER_Devplant`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DER_Devplant`.`Clientes` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `usuarioEmail` VARCHAR(45) NOT NULL,
  `passsword` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `telefono`  INT NULL,
  `idLocalidad` INT NOT NULL,
  `fechaNacimiento` DATE NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX ` fk_Clientes_localidad_idx` (`idLocalidad` ASC) ,
  CONSTRAINT ` fk_Clientes_localidad`
    FOREIGN KEY (`idLocalidad`)
    REFERENCES `DER_Devplant`.`Localidad` (`idLocalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DER_Devplant`.`TipoPlantas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DER_Devplant`.`TipoPlantas` (
  `idTipoPlantas` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipoPlantas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DER_Devplant`.`TipoCuidado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DER_Devplant`.`TipoCuidado` (
  `idTipoCuidado` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipoCuidado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DER_Devplant`.`Cuidados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DER_Devplant`.`Cuidados` (
  `idCuidados` INT NOT NULL AUTO_INCREMENT,
  `idPlantas` INT NOT NULL,
  `idTipoCuidado` INT NOT NULL,
  `periodicidad` INT NOT NULL,
  PRIMARY KEY (`idCuidados`),
  INDEX `fk_cuidado_tipo_idx` (`idTipoCuidado` ASC) ,
  CONSTRAINT `fk_cuidado_tipo`
    FOREIGN KEY (`idTipoCuidado`)
    REFERENCES `DER_Devplant`.`TipoCuidado` (`idTipoCuidado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DER_Devplant`.`CuidadosPlantas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DER_Devplant`.`CuidadosPlantas` (
  `idCuidadosPlantas` INT NOT NULL AUTO_INCREMENT,
  `idPlantas` INT NOT NULL,
  `idCuidados` INT NOT NULL,
  PRIMARY KEY (`idCuidadosPlantas`),
  INDEX `plantas_fk_idx` (`idPlantas` ASC) ,
  INDEX `cuidados_fk_idx` (`idCuidados` ASC) ,
  CONSTRAINT `plantas_fk`
    FOREIGN KEY (`idPlantas`)
    REFERENCES `DER_Devplant`.`Plantas` (`idPlantas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cuidados_fk`
    FOREIGN KEY (`idCuidados`)
    REFERENCES `DER_Devplant`.`Cuidados` (`idCuidados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DER_Devplant`.`Plantas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DER_Devplant`.`Plantas` (
  `idPlantas` INT NOT NULL AUTO_INCREMENT,
  `nombrePlanta` VARCHAR(45) NOT NULL,
  `idTipoPlanta` INT NOT NULL,
  `idCliente` INT NOT NULL,
  `idCuidadosPlantas` INT NOT NULL,
  PRIMARY KEY (`idPlantas`),
  INDEX `fk_planta_cliente_idx` (`idCliente` ASC) ,
  INDEX `fk_planta_cuidadosPlantas_idx` (`idCuidadosPlantas` ASC),
  INDEX `fk_planta_tipo_idx` (`idTipoPlanta` ASC) ,
  CONSTRAINT `fk_planta_tipo`
    FOREIGN KEY (`idTipoPlanta`)
    REFERENCES `DER_Devplant`.`TipoPlantas` (`idTipoPlantas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_planta_cliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `DER_Devplant`.`Clientes` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_planta_cuidadosPlantas`
    FOREIGN KEY (`idCuidadosPlantas`)
    REFERENCES `DER_Devplant`.`CuidadosPlantas` (`idCuidadosPlantas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

ALTER TABLE `der_devplant`.`clientes` 
ADD COLUMN `fechaBaja` DATETIME NULL AFTER `fechaNacimiento`;

ALTER TABLE `der_devplant`.`cuidados` 
ADD COLUMN `fechaBaja` DATETIME NULL AFTER `periodicidad`;

ALTER TABLE `der_devplant`.`localidad` 
ADD COLUMN `fechaBaja` DATETIME NULL AFTER `ciudad`;

ALTER TABLE `der_devplant`.`plantas` 
ADD COLUMN `fechaBaja` DATETIME NULL AFTER `idCliente`;

ALTER TABLE `der_devplant`.`tipocuidado` 
ADD COLUMN `fechaBaja` DATETIME NULL AFTER `descripcion`;

ALTER TABLE `der_devplant`.`tipoplantas` 
ADD COLUMN `fechaBaja` DATETIME NULL AFTER `descripcion`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;