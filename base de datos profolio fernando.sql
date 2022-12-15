-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mi_perfil
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mi_perfil
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mi_perfil` DEFAULT CHARACTER SET utf8 ;
USE `mi_perfil` ;

-- -----------------------------------------------------
-- Table `mi_perfil`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_perfil`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nombre_usuario` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `foto_perfil` BLOB NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi_perfil`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_perfil`.`persona` (
  `iddni` DOUBLE NOT NULL,
  `Apellido` VARCHAR(45) NULL,
  `Nombre` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `url_foto` LONGTEXT NULL,
  `url_banner` LONGTEXT NULL,
  `url_faceboock` VARCHAR(250) NULL,
  `url_twiter` VARCHAR(250) NULL,
  `url_instagram` VARCHAR(250) NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`iddni`, `usuario_idusuario`),
  INDEX `fk_persona_usuario_idx` (`usuario_idusuario` ASC) ,
  CONSTRAINT `fk_persona_usuario`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `mi_perfil`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi_perfil`.`proyectos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_perfil`.`proyectos` (
  `idproyectos` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `descripcion` LONGTEXT NULL,
  `entidad_empresa` VARCHAR(200) NULL,
  `link` VARCHAR(450) NULL,
  `imagen` BLOB NULL,
  `inicio` DATE NULL,
  `final` DATE NULL,
  `persona_iddni` DOUBLE NOT NULL,
  `persona_usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idproyectos`, `persona_iddni`, `persona_usuario_idusuario`),
  INDEX `fk_proyectos_persona1_idx` (`persona_iddni` ASC, `persona_usuario_idusuario` ASC) ,
  CONSTRAINT `fk_proyectos_persona1`
    FOREIGN KEY (`persona_iddni` , `persona_usuario_idusuario`)
    REFERENCES `mi_perfil`.`persona` (`iddni` , `usuario_idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi_perfil`.`experiencia_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_perfil`.`experiencia_laboral` (
  `idexperiencia_laboral` INT NOT NULL AUTO_INCREMENT,
  `tipo_experiencia` VARCHAR(45) NULL,
  `entidad` VARCHAR(45) NULL,
  `puesto` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `actualmente` VARCHAR(45) NULL,
  `inicio` DATE NULL,
  `final` DATE NULL,
  `persona_iddni` DOUBLE NOT NULL,
  `persona_usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idexperiencia_laboral`, `persona_iddni`, `persona_usuario_idusuario`),
  INDEX `fk_experiencia_laboral_persona1_idx` (`persona_iddni` ASC, `persona_usuario_idusuario` ASC) ,
  CONSTRAINT `fk_experiencia_laboral_persona1`
    FOREIGN KEY (`persona_iddni` , `persona_usuario_idusuario`)
    REFERENCES `mi_perfil`.`persona` (`iddni` , `usuario_idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi_perfil`.`tipo_experiencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_perfil`.`tipo_experiencia` (
  `idtipo_experiencia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtipo_experiencia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi_perfil`.`estudios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_perfil`.`estudios` (
  `idestudios` INT NOT NULL AUTO_INCREMENT,
  `institucion` VARCHAR(45) NULL,
  `logo` VARCHAR(45) NULL,
  `descripcion` LONGTEXT NULL,
  `inicio` DATE NULL,
  `final` DATE NULL,
  `persona_iddni` DOUBLE NOT NULL,
  `persona_usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idestudios`, `persona_iddni`, `persona_usuario_idusuario`),
  INDEX `fk_estudios_persona1_idx` (`persona_iddni` ASC, `persona_usuario_idusuario` ASC) ,
  CONSTRAINT `fk_estudios_persona1`
    FOREIGN KEY (`persona_iddni` , `persona_usuario_idusuario`)
    REFERENCES `mi_perfil`.`persona` (`iddni` , `usuario_idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi_perfil`.`exp_tiene_tipo_exp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_perfil`.`exp_tiene_tipo_exp` (
  `experiencia_laboral_idexperiencia_laboral` INT NOT NULL,
  `tipo_experiencia_idtipo_experiencia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`experiencia_laboral_idexperiencia_laboral`, `tipo_experiencia_idtipo_experiencia`),
  INDEX `fk_experiencia_laboral_has_tipo_experiencia_tipo_experienci_idx` (`tipo_experiencia_idtipo_experiencia` ASC) ,
  INDEX `fk_experiencia_laboral_has_tipo_experiencia_experiencia_lab_idx` (`experiencia_laboral_idexperiencia_laboral` ASC) ,
  CONSTRAINT `fk_experiencia_laboral_has_tipo_experiencia_experiencia_labor1`
    FOREIGN KEY (`experiencia_laboral_idexperiencia_laboral`)
    REFERENCES `mi_perfil`.`experiencia_laboral` (`idexperiencia_laboral`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_experiencia_laboral_has_tipo_experiencia_tipo_experiencia1`
    FOREIGN KEY (`tipo_experiencia_idtipo_experiencia`)
    REFERENCES `mi_perfil`.`tipo_experiencia` (`idtipo_experiencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
