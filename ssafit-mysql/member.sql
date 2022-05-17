
INSERT INTO sf_member
VALUES 
(0, 'admin', 'admin', '관리자'),
(0, 'asdf', 'asdf', 'asdf'),
(0, 'ㅁㄴㅇㄹ', 'ㅁㄴㄹㅇ', 'ㅁㄴㅇㄹ'),
(0, '1234', '1234', '1234');

SELECT * FROM sf_member;
SELECT * FROM follow_member;

INSERT INTO follow_member
VALUES
(1, 4),
(2, 4),
(3, 4),
(4, 1),
(4, 2),
(4, 3);

SELECT user_id, username 
  FROM follow_member f
  LEFT JOIN sf_member s
    ON f.to_seq = s.member_seq
 WHERE f.from_seq = (SELECT member_seq
					   FROM sf_member
                      WHERE user_id = 'admin'	)
 ;
 
 SELECT user_id, username 
  FROM follow_member f
  LEFT JOIN sf_member s
    ON f.from_seq = s.member_seq
 WHERE f.to_seq = (SELECT member_seq
					   FROM sf_member
                      WHERE user_id = 'asdf'	)
 ;
 
 
 UPDATE sf_member
    SET password = 'asdf',
        username = 'asdf'
 WHERE member_seq = 2;
 
 SELECT * FROM sf_member;
 
 ALTER TABLE `ssafit`.`follow_member` 
DROP FOREIGN KEY `FROM_SEQ`,
DROP FOREIGN KEY `TO_SEQ`;
ALTER TABLE `ssafit`.`follow_member` 
ADD CONSTRAINT `FROM_SEQ`
  FOREIGN KEY (`from_seq`)
  REFERENCES `ssafit`.`sf_member` (`member_seq`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
ADD CONSTRAINT `TO_SEQ`
  FOREIGN KEY (`to_seq`)
  REFERENCES `ssafit`.`sf_member` (`member_seq`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
