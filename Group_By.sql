USE practice_sql;

CREATE TABLE sale (
	sequence_number INT PRIMARY KEY AUTO_INCREMENT,
    date DATE,
    amount INT,
    employee_number INT 
);

INSERT INTO sale (date, amount, employee_number) VALUES('2024-07-01', 100000, 1);
INSERT INTO sale (date, amount, employee_number) VALUES('2024-07-01', 120000, 2);
INSERT INTO sale (date, amount, employee_number) VALUES('2024-07-01', 60000, 1);
INSERT INTO sale (date, amount, employee_number) VALUES('2024-07-03', 200000, 1);
INSERT INTO sale (date, amount, employee_number) VALUES('2024-07-03', 170000, 3);
INSERT INTO sale (date, amount, employee_number) VALUES('2024-07-06', 100000, 2);
INSERT INTO sale (date, amount, employee_number) VALUES('2024-07-06', 160000, 3);
INSERT INTO sale (date, amount, employee_number) VALUES('2024-07-07', 80000, 1);
INSERT INTO sale (date, amount, employee_number) VALUES('2024-07-08', 90000, 2);
INSERT INTO sale (date, amount, employee_number) VALUES('2024-07-08',110000, 3);

SELECT * FROM sale;

-- 집계 함수 : 여러 행의 레코드를 종합하여 하나의 결과값을 반환

-- COUNT() : 특정 조건에 해당하는 레코드의 개수를 반환
SELECT COUNT(*) FROM sale; # 전체 레코드 개수
SELECT COUNT(*) FROM sale WHERE amount <= 100000;
SELECT COUNT(amount) FROM sale; # amount의 전체 레코드 개수

-- SUM() : 특정 조건에 해당하는 컬럼의 값을 모두 더한 결과를 반환
SELECT SUM(amount) FROM sale;
SELECT SUM(amount) FROM sale WHERE employee_number = 1;






















