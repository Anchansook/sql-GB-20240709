-- 데이터베이스 생성
-- officetel
CREATE DATABASE officetel;
USE officetel;

-- 이메일 인증 테이블
CREATE TABLE email_auth (
	email VARCHAR(100) PRIMARY KEY CHECK(email REGEXP '^[a-zA-Z0-9]*@([-.]?[a-zA-Z0-9])*\.[a-zA-Z]{2,4}$'),
    auth_number VARCHAR(4) NOT NULL CHECK(auth_number REGEXP '^[0-9]{4}$')
);

-- 회원 테이블
CREATE TABLE user (
	id VARCHAR(20) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    join_path VARCHAR(5) NOT NULL DEFAULT 'HOME',
    role VARCHAR(6) NOT NULL DEFAULT 'NORMAL',
    CONSTRAINT user_email_fk FOREIGN KEY (email) REFERENCES email_auth (email)
);

-- 게시물 테이블
CREATE TABLE board (
	receipt_number INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    status BOOLEAN NOT NULL DEFAULT false,
    writer_id VARCHAR(20) NOT NULL,
    write_date DATETIME NOT NULL DEFAULT now(),
    view_count INT NOT NULL DEFAULT 0,
    contents VARCHAR(1000) NOT NULL,
    reply TEXT,
    CONSTRAINT writer_fk FOREIGN KEY (write_id) REFERENCES user (id)
);

-- 로그인
SELECT * FROM user
WHERE id = 'qwer1234' AND password = 'qwer1234';

SELECT * FROM user WHERE id = :id;

-- 아이디 중복확인
SELECT * FROM user WHERE id = 'qwer1234';

-- 이메일 인증
INSERT INTO email_auth VALUES ('qwer1234@qwer.com', '0123');

-- 이메일 인증확인
SELECT * FROM email_auth
WHERE email = 'qwer1234@qwer.com' AND auth_number = '0123';

-- 회원가입
INSERT INTO user (id, password, email) VALUES ('qwer1234', 'qwer1234', 'qwer1234@qwer.com');

-- 게시물 리스트
SELECT receipt_number, status, title, writer_id, write_date, view_count
FROM board
WHERE 
title LIKE '%두%'
ORDER BY receipt_number DESC
LIMIT 0, 10;

-- 게시물 작성
INSERT INTO board (title, contents, writer_id)
VALUES ('열두번째 게시물', '안녕하세욥', 'qwer1234');

-- 게시물 상세보기
UPDATE board SET view_count = view_count + 1
WHERE receipt_number = 1;

SELECT receipt_number, title, writer_id, write_date, view_count, contents, reply
FROM board
WHERE receipt_number = 1;

-- 답글 작성, 답글 작성 시에 완료 상태로 같이 바뀌도록
UPDATE board SET reply = '반갑구만유', status = true
WHERE receipt_number = 1;

-- 게시물 수정
UPDATE board SET title = '게시물 수정', contents = '안녕하세욥'
WHERE receipt_number = 1;

-- 게시물 삭제
DELETE FROM board WHERE receipt_number = 1;
































