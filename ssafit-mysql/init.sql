-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ssafit
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ssafit
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ssafit` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `ssafit` ;

-- -----------------------------------------------------
-- Table `ssafit`.`part_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ssafit`.`part_info` ;

CREATE TABLE IF NOT EXISTS `ssafit`.`part_info` (
  `part_no` INT NOT NULL,
  `part_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`part_no`),
  UNIQUE INDEX `part_name_UNIQUE` (`part_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ssafit`.`sf_video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ssafit`.`sf_video` ;

CREATE TABLE IF NOT EXISTS `ssafit`.`sf_video` (
  `video_seq` INT NOT NULL AUTO_INCREMENT,
  `youtube_id` VARCHAR(45) NOT NULL,
  `video_title` VARCHAR(200) NULL,
  `view_cnt` INT NULL DEFAULT 0,
  `part_code` INT NULL DEFAULT 0,
  PRIMARY KEY (`video_seq`),
  UNIQUE INDEX `youtube_id_UNIQUE` (`youtube_id` ASC) VISIBLE,
  INDEX `PART_CODE_idx` (`part_code` ASC) VISIBLE,
  CONSTRAINT `PART_CODE`
    FOREIGN KEY (`part_code`)
    REFERENCES `ssafit`.`part_info` (`part_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


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
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ssafit`.`follow_member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ssafit`.`follow_member` ;

CREATE TABLE IF NOT EXISTS `ssafit`.`follow_member` (
  `from_seq` INT NOT NULL,
  `to_seq` INT NOT NULL,
  INDEX `FROM_SEQ_idx` (`from_seq` ASC) VISIBLE,
  INDEX `TO_SEQ_idx` (`to_seq` ASC) VISIBLE,
  PRIMARY KEY (`from_seq`, `to_seq`),
  CONSTRAINT `FROM_SEQ`
    FOREIGN KEY (`from_seq`)
    REFERENCES `ssafit`.`sf_member` (`member_seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `TO_SEQ`
    FOREIGN KEY (`to_seq`)
    REFERENCES `ssafit`.`sf_member` (`member_seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ssafit`.`zzim`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ssafit`.`zzim` ;

CREATE TABLE IF NOT EXISTS `ssafit`.`zzim` (
  `member_seq` INT NOT NULL,
  `video_seq` INT NOT NULL,
  INDEX `ZZIM_MEMBER_idx` (`member_seq` ASC) VISIBLE,
  INDEX `ZZIM_VIDEO_idx` (`video_seq` ASC) VISIBLE,
  PRIMARY KEY (`member_seq`, `video_seq`),
  CONSTRAINT `ZZIM_MEMBER`
    FOREIGN KEY (`member_seq`)
    REFERENCES `ssafit`.`sf_member` (`member_seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ZZIM_VIDEO`
    FOREIGN KEY (`video_seq`)
    REFERENCES `ssafit`.`sf_video` (`video_seq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ssafit`.`sf_review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ssafit`.`sf_review` ;

CREATE TABLE IF NOT EXISTS `ssafit`.`sf_review` (
  `review_seq` INT auto_increment NOT NULL,
  `youtube_id` VARCHAR(45) NULL,
  `writer` VARCHAR(45) NULL,
  `title` VARCHAR(45) NOT NULL,
  `content` TEXT(2000) NULL,
  PRIMARY KEY (`review_seq`),
  INDEX `RV_YOUTUBE_ID_idx` (`youtube_id` ASC) VISIBLE,
  INDEX `RV_MEMBER_ID_idx` (`writer` ASC) INVISIBLE,
  CONSTRAINT `RV_YOUTUBE_ID`
    FOREIGN KEY (`youtube_id`)
    REFERENCES `ssafit`.`sf_video` (`youtube_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `RV_MEMBER_ID`
    FOREIGN KEY (`writer`)
    REFERENCES `ssafit`.`sf_member` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- part_info, sf_video 초기 
-- -----------------------------------------------------

INSERT INTO part_info
VALUES
('000', '미분류'),
('100', '전신'),
('200', '상체'),
('300', '하체'),
('400', '복부'),
('500', '스트레칭');

SELECT * FROM part_info;

INSERT INTO sf_video
VALUES
(0, 'gMaB-fG4u4g', '전신 다이어트 최고의 운동 [칼소폭 찐 핵핵매운맛]', 0 , 100 ),
(0, 'swRNeYw1JkY', '하루 15분! 전신 칼로리 불태우는 다이어트 운동', 0 , 100 ),
(0, '54tTYO-vU2E', '상체 다이어트 최고의 운동 BEST [팔뚝살/겨드랑이살/등살/가슴어깨라인]', 0 , 200 ),
(0, 'QqqZH3j_vH0', '상체비만 다이어트 최고의 운동 [상체 핵매운맛]', 0 , 200 ),
(0, 'tzN6ypk6Sps', '하체운동이 중요한 이유? 이것만 보고 따라하자 ! [하체운동 교과서]', 0 , 300 ),
(0, 'u5OgcZdNbMo', '저는 하체 식주의자 입니다', 0 , 300 ),
(0, 'PjGcOP-TQPE', '11자복근 복부 최고의 운동 [복근 핵매운맛]', 0 , 400 ),
(0, '7TLk7pscICk', '(Sub)누워서하는 5분 복부운동!! 효과보장! (매일 2주만 해보세요!)', 0 , 400 );

INSERT INTO sf_member
VALUES
(0, 'ssafy', 'ssafy', '김우원');

INSERT INTO sf_review
VALUES
(0, 'gMaB-fG4u4g', 'ssafy', '최고에요', '땀이 뻘뻘 나요');



select * FROM sf_review;
