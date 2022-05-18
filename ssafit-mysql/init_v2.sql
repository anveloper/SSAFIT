-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ssafit
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ssafit
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ssafit` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `ssafit` ;

-- -----------------------------------------------------
-- Table `ssafit`.`sf_member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ssafit`.`sf_member` ;

CREATE TABLE IF NOT EXISTS `ssafit`.`sf_member` (
  `member_seq` INT NOT NULL AUTO_INCREMENT,
  `user_id` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`member_seq`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ssafit`.`follow_member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ssafit`.`follow_member` ;

CREATE TABLE IF NOT EXISTS `ssafit`.`follow_member` (
  `from_seq` INT NOT NULL,
  `to_seq` INT NOT NULL,
  PRIMARY KEY (`from_seq`, `to_seq`),
  INDEX `FROM_SEQ_idx` (`from_seq` ASC) VISIBLE,
  INDEX `TO_SEQ_idx` (`to_seq` ASC) VISIBLE,
  CONSTRAINT `FROM_SEQ`
    FOREIGN KEY (`from_seq`)
    REFERENCES `ssafit`.`sf_member` (`member_seq`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `TO_SEQ`
    FOREIGN KEY (`to_seq`)
    REFERENCES `ssafit`.`sf_member` (`member_seq`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ssafit`.`part_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ssafit`.`part_info` ;

CREATE TABLE IF NOT EXISTS `ssafit`.`part_info` (
  `part_no` INT NOT NULL,
  `part_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`part_no`),
  UNIQUE INDEX `part_name_UNIQUE` (`part_name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ssafit`.`sf_video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ssafit`.`sf_video` ;

CREATE TABLE IF NOT EXISTS `ssafit`.`sf_video` (
  `video_seq` INT NOT NULL AUTO_INCREMENT,
  `youtube_id` VARCHAR(45) NOT NULL,
  `video_title` VARCHAR(200) NULL DEFAULT NULL,
  `view_cnt` INT NULL DEFAULT '0',
  `part_code` INT NULL DEFAULT '0',
  PRIMARY KEY (`video_seq`),
  UNIQUE INDEX `youtube_id_UNIQUE` (`youtube_id` ASC) VISIBLE,
  INDEX `PART_CODE_idx` (`part_code` ASC) VISIBLE,
  CONSTRAINT `PART_CODE`
    FOREIGN KEY (`part_code`)
    REFERENCES `ssafit`.`part_info` (`part_no`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ssafit`.`sf_reply`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ssafit`.`sf_reply` ;

CREATE TABLE IF NOT EXISTS `ssafit`.`sf_reply` (
  `reply_seq` INT NOT NULL AUTO_INCREMENT,
  `re_seq` INT NULL DEFAULT 0,
  `youtube_id` VARCHAR(45) NOT NULL,
  `writer` VARCHAR(45) NOT NULL,
  `content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`reply_seq`),
  INDEX `RV_YOUTUBE_ID_idx` (`youtube_id` ASC) VISIBLE,
  INDEX `RV_MEMBER_ID_idx` (`writer` ASC) INVISIBLE,
  CONSTRAINT `RP_MEMBER_ID`
    FOREIGN KEY (`writer`)
    REFERENCES `ssafit`.`sf_member` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `RP_YOUTUBE_ID`
    FOREIGN KEY (`youtube_id`)
    REFERENCES `ssafit`.`sf_video` (`youtube_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ssafit`.`zzim`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ssafit`.`zzim` ;

CREATE TABLE IF NOT EXISTS `ssafit`.`zzim` (
  `member_seq` INT NOT NULL,
  `video_seq` INT NOT NULL,
  PRIMARY KEY (`member_seq`, `video_seq`),
  INDEX `ZZIM_MEMBER_idx` (`member_seq` ASC) VISIBLE,
  INDEX `ZZIM_VIDEO_idx` (`video_seq` ASC) VISIBLE,
  CONSTRAINT `ZZIM_MEMBER`
    FOREIGN KEY (`member_seq`)
    REFERENCES `ssafit`.`sf_member` (`member_seq`),
  CONSTRAINT `ZZIM_VIDEO`
    FOREIGN KEY (`video_seq`)
    REFERENCES `ssafit`.`sf_video` (`video_seq`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
