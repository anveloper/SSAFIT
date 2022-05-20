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
(0, '7TLk7pscICk', '(Sub)누워서하는 5분 복부운동!! 효과보장! (매일 2주만 해보세요!)', 0 , 400 ),(0, 'HCnDDAMDKps', '어깨후면.. 저는 이렇게 합니다..', 0, 200),
(0, 'XjEfUcZLbG4', "건장한 상체가 여리+슬림+탄탄해지는 '상체올킬루틴' (7일효과: 팔뚝살,등살,뱃살 완전빠짐&탄력up!!!)", 0, 200),
(0, 'Cb0yy0yHRUg', '헬스장이 처음이라면 이대로만 따라하세요! 헬스 초보자용 가슴+어깨 상체운동 루틴', 0, 200),
(0, 'xoWKLNwNva0', '등, 가슴, 팔, 어깨 탄탄하게 만들기 - 덤벨 상체 운동 홈트 루틴', 0, 200),
(0, 'e1DHt9wfQOA', 'NO 층간소음 - 20분 상체운동 루틴 + 스트레칭', 0, 200),
(0, 'GZtB7W9Uafk', '집에서 할 수 있는 상체운동 루틴 | 다이어트+근육증가 버전!! 이대로만 하세요', 0, 200),
(0,'voxhcy_oDGA', '상체 덤벨 홈트레이닝 운동루틴 사이드밴드/덤벨로우/백익스텐션/체스트스퀴즈 [웨이홈트]',  0 , 200),
(0,'js8z5wIZ0wg', '(층간소음X, 설명O) 진짜 힘듦주의.. 초강력 힙으뜸 하체운동 2주 챌린지', 0 , 300),
(0,'ARc1KXjagTY', '“선생님 하체 너무 맛있어요” PT회원님이 인정한 하체운동루틴 [런지/스쿼트/스티프데드리프트/레그프레스]', 0 ,300),
(0,'m0Y7kvirvCY', '이것만 알면 당신의 하체는 달라집니다.', 0 ,300),
(0,'myNjmnvI6x0', 'NO 층간소음 올인원 운동 - 40분 유산소운동 홈트 - 관절에 무리없이 체지방 태우기', 0 ,100),
(0,'lPtENEtGDYU', '(층간소음X) 설명 다 퍼주는 심으뜸 올인원 전신운동 50분루틴', 0 ,100),
(0,'4kZHHPH6heY', 'NO 층간소음 - 고민없이 하나로 끝내는 전신운동 근력 유산소 - 운동 못한 날 죄책감 씻어줄 30분 홈트', 0 ,100),
(0,'_I7MrmBreOc', '[층간소음X] 다음날 전신근육통 보장! WHOLE BODY TABATA WORKOUT', 0 ,100),
(0,'rSBOuArsz1k', '힙으뜸 기초체력 홈트 15분루틴 (ft.땀폭발 전신순환운동, 코어운동)', 0 ,100),
(0,'nz5qsvRgK24', '[전신 운동] 근육은 늘리고 살은 빼는 홈트 (초급자 추천)', 0 ,100),
(0,'6jTDXo9E59Y', '헬스장 전신운동 올인원 루틴, 홈트로 활용 가능!! feat. 땀터짐 주의, 근력운동 여자', 0 ,100),
(0,'s14NQ6Cz4QE', '살 빠지는 전신운동 루틴 with 피지컬갤러리', 0 ,100),
(0,'4dH528sDhGA', '맙소사. 이번 4분 전신 타바타 꼭 하세요 | MUST DO TOTAL BODY 4MIN TABATA', 0 ,100),
(0,'sVQqBDBZhmI', '복부운동 짧고 굵게! 운동효율 갑! [6 MINS ABS WORKOUT]', 0 ,400),
(0,'rS5aH95job8', '2주만에 효과보장 복부운동 10분 #매일 #하복부 #초보', 0 ,400),
(0,'EojxzBZbo4o', '[누워서하는] 복부 파괴 핵마라맛 11분 복부운동 (ABS WORKOUT 10 MIN)', 0 ,400),
(0,'DmbC-TyGIIM', '뱃살 없애는 최고의 홈트 루틴 허리라인은 덤! NO 층간 소음 [웨이홈트]', 0 ,400),
(0,'zcQ16cfJN9Q', '9분! 초간단 누워서하는 11자 복근운동', 0 ,400),
(0,'Iazno8QPDOg', '다이어트용 헬스장 기구운동 순서와 횟수! 루틴표 공개 [초보자용]', 0 ,100),
(0,'zjfGs_iIIE8', '반드시보세요!! 헬스장이 처음 이신 분들을 위한 완벽 루틴 정리(헬린이와 운동초보자분들을 위해)', 0 ,100),
(0,'7NPwSCjqka0', '운동 다시 시작하시게요? 헬스 초,중급 상체 루틴 가이드', 0 ,200),
(0,'8thMw9JyxBE', "어깨 운동만 '한' 남자", 0 ,200);

INSERT INTO sf_member
VALUES
(0, 'ssafy', 'ssafy', '김우원');

INSERT INTO sf_review
VALUES
(0, 'gMaB-fG4u4g', 'ssafy', '최고에요', '땀이 뻘뻘 나요');



select * FROM sf_review;
