-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hotelHangares
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hotelHangares
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hotelHangares` DEFAULT CHARACTER SET utf8 ;
USE `hotelHangares` ;

-- -----------------------------------------------------
-- Table `hotelHangares`.`Cuenta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelHangares`.`Cuenta` (
  `idcuenta` INT NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcuenta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelHangares`.`TipoUsuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelHangares`.`TipoUsuario` (
  `idTipoUsuario` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipoUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelHangares`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelHangares`.`Usuario` (
  `cedula` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `celular` INT(10) NOT NULL,
  `cuenta_idcuenta` INT NOT NULL,
  `TipoUsuario_idTipoUsuario` INT NOT NULL,
  PRIMARY KEY (`cedula`, `cuenta_idcuenta`, `TipoUsuario_idTipoUsuario`),
  INDEX `fk_Usuario_cuenta1_idx` (`cuenta_idcuenta` ASC) VISIBLE,
  INDEX `fk_Usuario_TipoUsuario1_idx` (`TipoUsuario_idTipoUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_cuenta1`
    FOREIGN KEY (`cuenta_idcuenta`)
    REFERENCES `hotelHangares`.`Cuenta` (`idcuenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_TipoUsuario1`
    FOREIGN KEY (`TipoUsuario_idTipoUsuario`)
    REFERENCES `hotelHangares`.`TipoUsuario` (`idTipoUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelHangares`.`Reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelHangares`.`Reserva` (
  `idReserva` INT NOT NULL,
  `fechaInicio` DATE NOT NULL,
  `fechaFin` DATE NOT NULL,
  `Usuario_idUsuarios` INT NOT NULL,
  `Factura_idFactura` INT NOT NULL,
  PRIMARY KEY (`idReserva`, `Usuario_idUsuarios`, `Factura_idFactura`),
  INDEX `fk_Reserva_Usuario1_idx` (`Usuario_idUsuarios` ASC) VISIBLE,
  CONSTRAINT `fk_Reserva_Usuario1`
    FOREIGN KEY (`Usuario_idUsuarios`)
    REFERENCES `hotelHangares`.`Usuario` (`cedula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelHangares`.`Habitacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelHangares`.`Habitacion` (
  `idHabitacion` INT NOT NULL,
  `numero` INT NOT NULL,
  `precio` DECIMAL(20) NOT NULL,
  `Reserva_idReserva` INT NOT NULL,
  `Reserva_Usuario_idUsuarios` INT NOT NULL,
  `Reserva_Factura_idFactura` INT NOT NULL,
  PRIMARY KEY (`idHabitacion`, `Reserva_idReserva`, `Reserva_Usuario_idUsuarios`, `Reserva_Factura_idFactura`),
  INDEX `fk_Habitacion_Reserva1_idx` (`Reserva_idReserva` ASC, `Reserva_Usuario_idUsuarios` ASC, `Reserva_Factura_idFactura` ASC) VISIBLE,
  CONSTRAINT `fk_Habitacion_Reserva1`
    FOREIGN KEY (`Reserva_idReserva` , `Reserva_Usuario_idUsuarios` , `Reserva_Factura_idFactura`)
    REFERENCES `hotelHangares`.`Reserva` (`idReserva` , `Usuario_idUsuarios` , `Factura_idFactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelHangares`.`Factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelHangares`.`Factura` (
  `idFactura` INT NOT NULL AUTO_INCREMENT,
  `fecha` VARCHAR(45) NOT NULL,
  `descuento` FLOAT NULL,
  `total` FLOAT NOT NULL,
  `Reserva_idReserva` INT NOT NULL,
  `Reserva_Usuario_idUsuarios` INT NOT NULL,
  `Reserva_Factura_idFactura` INT NOT NULL,
  PRIMARY KEY (`idFactura`, `Reserva_idReserva`, `Reserva_Usuario_idUsuarios`, `Reserva_Factura_idFactura`),
  INDEX `fk_Factura_Reserva1_idx` (`Reserva_idReserva` ASC, `Reserva_Usuario_idUsuarios` ASC, `Reserva_Factura_idFactura` ASC) VISIBLE,
  CONSTRAINT `fk_Factura_Reserva1`
    FOREIGN KEY (`Reserva_idReserva` , `Reserva_Usuario_idUsuarios` , `Reserva_Factura_idFactura`)
    REFERENCES `hotelHangares`.`Reserva` (`idReserva` , `Usuario_idUsuarios` , `Factura_idFactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelHangares`.`Comodidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelHangares`.`Comodidad` (
  `idComodidad` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idComodidad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelHangares`.`Habitacion_Comodidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelHangares`.`Habitacion_Comodidad` (
  `idHabitacion` INT NOT NULL,
  `idComodidad` INT NOT NULL,
  PRIMARY KEY (`idHabitacion`, `idComodidad`),
  INDEX `fk_Habitaciones_has_Comodidad_Comodidad1_idx` (`idComodidad` ASC) VISIBLE,
  INDEX `fk_Habitaciones_has_Comodidad_Habitaciones_idx` (`idHabitacion` ASC) VISIBLE,
  CONSTRAINT `fk_Habitaciones_has_Comodidad_Habitaciones`
    FOREIGN KEY (`idHabitacion`)
    REFERENCES `hotelHangares`.`Habitacion` (`idHabitacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Habitaciones_has_Comodidad_Comodidad1`
    FOREIGN KEY (`idComodidad`)
    REFERENCES `hotelHangares`.`Comodidad` (`idComodidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelHangares`.`TipoHabitacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotelHangares`.`TipoHabitacion` (
  `idTipoHabitacion` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `Habitacion_idHabitacion` INT NOT NULL,
  PRIMARY KEY (`idTipoHabitacion`, `Habitacion_idHabitacion`),
  INDEX `fk_TipoHabitacion_Habitacion1_idx` (`Habitacion_idHabitacion` ASC) VISIBLE,
  CONSTRAINT `fk_TipoHabitacion_Habitacion1`
    FOREIGN KEY (`Habitacion_idHabitacion`)
    REFERENCES `hotelHangares`.`Habitacion` (`idHabitacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
