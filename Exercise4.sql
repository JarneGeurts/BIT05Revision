-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medical` (
  `idMedical` INT NOT NULL,
  `Overtime rate` VARCHAR(45) NULL,
  PRIMARY KEY (`idMedical`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Specialist` (
  `idspecialist` INT NOT NULL,
  `Field_area` VARCHAR(45) NULL,
  PRIMARY KEY (`idspecialist`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Doctor` (
  `idDoctor` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Date_of_birth` DATE NULL,
  `Adress` VARCHAR(45) NULL,
  `Phone_number` INT NULL,
  `Salary` VARCHAR(45) NULL,
  `Medical_idMedical` INT NOT NULL,
  `Specialist_idspecialist` INT NOT NULL,
  PRIMARY KEY (`idDoctor`),
  INDEX `fk_Doctor_Medical1_idx` (`Medical_idMedical` ASC),
  INDEX `fk_Doctor_Specialist1_idx` (`Specialist_idspecialist` ASC),
  CONSTRAINT `fk_Doctor_Medical1`
    FOREIGN KEY (`Medical_idMedical`)
    REFERENCES `mydb`.`Medical` (`idMedical`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Doctor_Specialist1`
    FOREIGN KEY (`Specialist_idspecialist`)
    REFERENCES `mydb`.`Specialist` (`idspecialist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `idPatient` INT NOT NULL,
  `Name_patient` VARCHAR(45) NULL,
  `adress` VARCHAR(45) NULL,
  `Phone_number` INT NULL,
  `Date_of_birth` DATE NULL,
  PRIMARY KEY (`idPatient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Appointment` (
  `idAppointment` INT NOT NULL,
  `Date` DATE NULL,
  `Time` VARCHAR(45) NULL,
  `Doctor_idDoctor` INT NOT NULL,
  `Patient_idPatient` INT NOT NULL,
  PRIMARY KEY (`idAppointment`),
  INDEX `fk_Appointment_Doctor1_idx` (`Doctor_idDoctor` ASC),
  INDEX `fk_Appointment_Patient1_idx` (`Patient_idPatient` ASC),
  CONSTRAINT `fk_Appointment_Doctor1`
    FOREIGN KEY (`Doctor_idDoctor`)
    REFERENCES `mydb`.`Doctor` (`idDoctor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_Patient1`
    FOREIGN KEY (`Patient_idPatient`)
    REFERENCES `mydb`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `idPayment` INT NOT NULL,
  `Details` FLOAT NULL,
  `Method` VARCHAR(45) NULL,
  PRIMARY KEY (`idPayment`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill` (
  `idBill` INT NOT NULL,
  `Total` VARCHAR(45) NULL,
  `Patient_idPatient` INT NOT NULL,
  PRIMARY KEY (`idBill`),
  INDEX `fk_Bill_Patient1_idx` (`Patient_idPatient` ASC),
  CONSTRAINT `fk_Bill_Patient1`
    FOREIGN KEY (`Patient_idPatient`)
    REFERENCES `mydb`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment_has_Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment_has_Bill` (
  `Payment_idPayment` INT NOT NULL,
  `Bill_idBill` INT NOT NULL,
  PRIMARY KEY (`Payment_idPayment`, `Bill_idBill`),
  INDEX `fk_Payment_has_Bill_Bill1_idx` (`Bill_idBill` ASC),
  INDEX `fk_Payment_has_Bill_Payment1_idx` (`Payment_idPayment` ASC),
  CONSTRAINT `fk_Payment_has_Bill_Payment1`
    FOREIGN KEY (`Payment_idPayment`)
    REFERENCES `mydb`.`Payment` (`idPayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_has_Bill_Bill1`
    FOREIGN KEY (`Bill_idBill`)
    REFERENCES `mydb`.`Bill` (`idBill`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
