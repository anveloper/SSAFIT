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
CREATE TABLE IF NOT EXISTS `ssafit`.`sf_member` (
  `member_seq` INT NOT NULL AUTO_INCREMENT,
  `user_id` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`member_seq`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ssafit`.`follow_member`
-- -----------------------------------------------------
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
AUTO_INCREMENT = 61
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ssafit`.`sf_reply`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ssafit`.`sf_reply` (
  `reply_seq` INT NOT NULL AUTO_INCREMENT,
  `re_seq` INT NULL DEFAULT '0',
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
AUTO_INCREMENT = 169
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ssafit`.`zzim`
-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- Table `ssafit`.`ex_part_code`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ssafit`.`ex_part_code` (
  `part_no` INT NOT NULL,
  `part_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`part_no`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ssafit`.`sf_ex`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ssafit`.`sf_ex` (
  `ex_no` INT NOT NULL AUTO_INCREMENT,
  `ex_name` VARCHAR(45) NOT NULL,
  `part_no` INT NOT NULL,
  PRIMARY KEY (`ex_no`),
  INDEX `part_no_idx` (`part_no` ASC) VISIBLE,
  CONSTRAINT `part_no`
    FOREIGN KEY (`part_no`)
    REFERENCES `ssafit`.`ex_part_code` (`part_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ssafit`.`ex_daily`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ssafit`.`ex_daily` (
  `record_seq` INT NOT NULL AUTO_INCREMENT,
  `user_seq` INT NOT NULL,
  `date` DATE NOT NULL,
  `ex_no` INT NOT NULL,
  `weight` INT NULL DEFAULT 0,
  `reps` INT NULL DEFAULT 0,
  `sets` INT NULL DEFAULT 0,
  PRIMARY KEY (`record_seq`),
  INDEX `ex_no_idx` (`ex_no` ASC) VISIBLE,
  INDEX `user_idx` (`user_seq` ASC) VISIBLE,
  CONSTRAINT `ex_no`
    FOREIGN KEY (`ex_no`)
    REFERENCES `ssafit`.`sf_ex` (`ex_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_seq`
    FOREIGN KEY (`user_seq`)
    REFERENCES `ssafit`.`sf_member` (`member_seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ssafit`.`ex_best`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ssafit`.`ex_best` (
  `user_seq` INT NOT NULL,
  `ex_no` INT NOT NULL,
  `record` INT NULL DEFAULT 0,
  INDEX `user_idx` (`user_seq` ASC) VISIBLE,
  INDEX `ex_idx` (`ex_no` ASC) VISIBLE,
  PRIMARY KEY (`user_seq`, `ex_no`),
  CONSTRAINT `user`
    FOREIGN KEY (`user_seq`)
    REFERENCES `ssafit`.`sf_member` (`member_seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ex`
    FOREIGN KEY (`ex_no`)
    REFERENCES `ssafit`.`sf_ex` (`ex_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `ssafit`.`ex_part_code`
-- -----------------------------------------------------
START TRANSACTION;
USE `ssafit`;
INSERT INTO `ssafit`.`ex_part_code` (`part_no`, `part_name`) VALUES (1, '하체');
INSERT INTO `ssafit`.`ex_part_code` (`part_no`, `part_name`) VALUES (2, '가슴');
INSERT INTO `ssafit`.`ex_part_code` (`part_no`, `part_name`) VALUES (3, '등');
INSERT INTO `ssafit`.`ex_part_code` (`part_no`, `part_name`) VALUES (4, '어깨');
INSERT INTO `ssafit`.`ex_part_code` (`part_no`, `part_name`) VALUES (5, '팔');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ssafit`.`sf_ex`
-- -----------------------------------------------------
START TRANSACTION;
USE `ssafit`;
INSERT INTO `ssafit`.`sf_ex` (`ex_no`, `ex_name`, `part_no`) VALUES (0, '스쿼트', 1);
INSERT INTO `ssafit`.`sf_ex` (`ex_no`, `ex_name`, `part_no`) VALUES (0, '데드리프트', 1);
INSERT INTO `ssafit`.`sf_ex` (`ex_no`, `ex_name`, `part_no`) VALUES (0, '런지', 1);
INSERT INTO `ssafit`.`sf_ex` (`ex_no`, `ex_name`, `part_no`) VALUES (0, '벤치프레스', 2);
INSERT INTO `ssafit`.`sf_ex` (`ex_no`, `ex_name`, `part_no`) VALUES (0, '펙덱 플라이 머신', 2);
INSERT INTO `ssafit`.`sf_ex` (`ex_no`, `ex_name`, `part_no`) VALUES (0, '덤벨 벤치프레스', 2);
INSERT INTO `ssafit`.`sf_ex` (`ex_no`, `ex_name`, `part_no`) VALUES (0, '풀업', 3);
INSERT INTO `ssafit`.`sf_ex` (`ex_no`, `ex_name`, `part_no`) VALUES (0, '랫 풀 다운', 3);
INSERT INTO `ssafit`.`sf_ex` (`ex_no`, `ex_name`, `part_no`) VALUES (0, '바벨 로우', 3);
INSERT INTO `ssafit`.`sf_ex` (`ex_no`, `ex_name`, `part_no`) VALUES (0, '오버 헤드 프레스', 4);
INSERT INTO `ssafit`.`sf_ex` (`ex_no`, `ex_name`, `part_no`) VALUES (0, '덤벨 숄더 프레스', 4);
INSERT INTO `ssafit`.`sf_ex` (`ex_no`, `ex_name`, `part_no`) VALUES (0, '덤벨 사이드 레터럴 레이즈', 4);
INSERT INTO `ssafit`.`sf_ex` (`ex_no`, `ex_name`, `part_no`) VALUES (0, '바벨 컬', 5);
INSERT INTO `ssafit`.`sf_ex` (`ex_no`, `ex_name`, `part_no`) VALUES (0, '케이블 푸시 다운', 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ssafit`.`ex_daily`
-- -----------------------------------------------------
START TRANSACTION;
USE `ssafit`;
INSERT INTO `ssafit`.`ex_daily` (`record_seq`, `user_seq`, `date`, `ex_no`, `weight`, `reps`, `sets`) 
VALUES (0, 1, '2022-05-22', 3, 30, 12, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `ssafit`.`ex_record`
-- -----------------------------------------------------
START TRANSACTION;
USE `ssafit`;
INSERT INTO `ssafit`.`ex_best` (`user_seq`, `ex_no`, `record`) VALUES (1, 9, 1000);
INSERT INTO `ssafit`.`ex_best` (`user_seq`, `ex_no`, `record`) VALUES (1, 8, 2000);
COMMIT;