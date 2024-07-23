USE practice_sql;

-- 거래내역 테이블
-- 거래번호 정수
-- 거래일자 날짜
-- 거래구분 가변문자열 10
-- 내역 장문의 문자열
-- 금액 정수
-- 세금 정수
-- 비고 장문의 문자열

CREATE TABLE transaction(
	transaction_number INT,
    transaction_date DATE,
    transaction_type VARCHAR(10),
    breakdown TEXT,
    amount INT,
    tax INT,
    note TEXT
);

INSERT INTO transaction 
VALUES (1, '2024-07-10', '구매', '기타자재', 100000, 0, null);

INSERT INTO transaction 
VALUES (2, '2024-07-10', '판매', '영양제', 700000, 70000, '종합 비타민');

INSERT INTO transaction 
VALUES (3, '2024-07-12', '판매', '영양제', 1200000, 120000, '종합 비타민');

INSERT INTO transaction 
VALUES (4, '2024-07-13', '구매', '책상', 4000000, 0, '4개 구매');

INSERT INTO transaction 
VALUES (5, '2024-07-13', '구매', '노트북', 10000000, 0, '4대 구매');

INSERT INTO transaction 
VALUES (6, '2024-07-17', '판매', '의약외품', 2000000, 200000, '소염진통제');

INSERT INTO transaction 
VALUES (7, '2024-07-18', '구매', '기타자재', 100000, 0, '볼펜 및 노트');

INSERT INTO transaction 
VALUES (8, '2024-07-19', '판매', '의약외품', 1500000, 150000, '소염진통제');

INSERT INTO transaction 
VALUES (9, '2024-07-20', '판매', '의료기구', 8000000, 800000, '휠체어');

INSERT INTO transaction 
VALUES (10, '2024-07-21', '판매', '영양제', 400000, 40000, '오메가3');

-- 연산자

-- 산술 연산자
-- +, -, *, /, %
SELECT amount + tax, breakdown 
FROM transaction;

-- 비교 연산자 (WHERE 절에서 자주 사용)
-- 원하는 레코드를 정확히 조회하는데 중요한 역할을 함

-- = : 좌항이 우항과 같으면 true
SELECT * FROM transaction 
WHERE transaction_type = '구매';

-- <>, != : 좌항이 우항과 다르면 true
SELECT * FROM transaction
WHERE transaction_type <> '구매';

SELECT * FROM transaction
WHERE transaction_type != '구매';

-- < : 좌항이 우항보다 작으면 true
-- <= : 좌항이 우항보다 작거나 같으면 true
SELECT * FROM transaction
WHERE amount < 1200000;

SELECT * FROM transaction
WHERE amount <= 1200000;

-- > : 좌항이 우항보다 크면 true
-- >= : 좌항이 우항보다 크거나 같으면 true
SELECT * FROM transaction
WHERE amount > 1200000;

SELECT * FROM transaction
WHERE amount >= 1200000;

ALTER TABLE transaction
ADD complete BOOLEAN;

UPDATE transaction SET complete = true
WHERE (transaction_number % 3) = 1;

UPDATE transaction SET complete = false
WHERE (transaction_number % 3) = 2;

SELECT * FROM transaction;













