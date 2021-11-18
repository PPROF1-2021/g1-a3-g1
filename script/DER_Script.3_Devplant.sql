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
  `password` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NULL,
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
  PRIMARY KEY (`idPlantas`),
  INDEX `fk_planta_cliente_idx` (`idCliente` ASC) ,
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
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

/* DML */

/* Insertar Datos */

INSERT INTO Localidad ( provincia, ciudad)
VALUES ('Cordoba','Rio cuarto');
INSERT INTO Localidad ( provincia, ciudad)
VALUES ('Cordoba','Córdoba');
INSERT INTO Localidad ( provincia, ciudad)
VALUES ('Cordoba','Carlos Paz');

clientesINSERT INTO Clientes (usuarioEmail, password, nombre, apellido, telefono, idLocalidad, fechaNacimiento)
VALUES ('juan@gmail.com', '123456', 'Juan', 'Canepa', "+543516451231", 1,'1992-09-04');
INSERT INTO Clientes (usuarioEmail, password, nombre, apellido, telefono, idLocalidad, fechaNacimiento)
VALUES ('lucia@gmail.com', '789123', 'Lucía', 'Gonzalez', "+543516751621", 2,'1996-12-07');
INSERT INTO Clientes (usuarioEmail, password, nombre, apellido, telefono, idLocalidad, fechaNacimiento)
VALUES ('florencia@gmail.com', '456789', 'Florencia', 'Lopez', "+543516135285", 3,'1994-02-10');

INSERT INTO TipoCuidado(idTipoCuidado, descripcion)
VALUES (1,'Podar');
INSERT INTO TipoCuidado(idTipoCuidado, descripcion)
VALUES (2,'Regar');
INSERT INTO TipoCuidado(idTipoCuidado, descripcion)
VALUES (3,'Transplantar');

INSERT INTO Cuidados(idCuidados, idPlantas, idTipoCuidado, periodicidad)
VALUES (1, 1, 3, '2');
INSERT INTO Cuidados(idCuidados, idPlantas, idTipoCuidado, periodicidad)
VALUES (2, 3, 2, '1');
INSERT INTO Cuidados(idCuidados, idPlantas, idTipoCuidado, periodicidad)
VALUES (3, 2, 1, '4');

INSERT INTO TipoPlantas (idTipoPlantas, descripcion)
VALUES (1 ,'Planta de exterior');
INSERT INTO TipoPlantas (idTipoPlantas, descripcion)
VALUES (2 ,'Planta de interior');

INSERT INTO Plantas(idPlantas, nombrePlanta, idTipoPlanta, idCliente)
VALUES (1, 'Margarita', 1, 1);
INSERT INTO Plantas(idPlantas, nombrePlanta, idTipoPlanta, idCliente)
VALUES (2, 'Sansevieria', 2, 2);
INSERT INTO Plantas(idPlantas, nombrePlanta, idTipoPlanta, idCliente)
VALUES (3, 'Rosa', 1, 3);


/* Cosultar resultado */

SELECT * FROM Clientes
WHERE nombre='Juan' AND password='123456';

SELECT nombrePlanta FROM Plantas
WHERE idPlantas='3';

SELECT nombre, apellido FROM Clientes
WHERE usuarioEmail='juan@gmail.com' AND password='123456';

/* Modificar Datos */

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
