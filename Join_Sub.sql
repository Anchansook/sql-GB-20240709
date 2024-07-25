USE practice_sql;

CREATE TABLE employee (
	employee_number INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20),
    age INT,
    department_code VARCHAR(2)
);

CREATE TABLE department (
	department_code VARCHAR(2) PRIMARY KEY,
    name VARCHAR(30),
    tel_number VARCHAR(15)
);

ALTER TABLE employee
ADD CONSTRAINT department_code_fk 
FOREIGN KEY (department_code) REFERENCES department (department_code);

ALTER TABLE employee
DROP CONSTRAINT department_code_fk;

INSERT INTO department VALUES ('A', '영업부', '123456');
INSERT INTO department VALUES ('B', '재무부', '123457');
INSERT INTO department VALUES ('C', '행정부', '123458');

INSERT INTO employee (name, age, department_code) VALUES ('홍길동', 23, 'A');
INSERT INTO employee (name, age, department_code) VALUES ('이영희', 15, 'A');
INSERT INTO employee (name, age, department_code) VALUES ('고길동', 34, 'C');
INSERT INTO employee (name, age, department_code) VALUES ('김둘리', 20, 'D');
INSERT INTO employee (name, age, department_code) VALUES ('이도', 17, 'D');

SELECT * FROM employee;
SELECT * FROM department;

-- Alias : 쿼리문에서 사용되는 별칭
-- 컬럼 및 테이블에서 사용가능
-- 사용하는 이름을 변경하고 싶을 때 적용
SELECT department_code AS '부서코드', name AS '부서명', tel_number AS '부서 전화번호'
FROM department AS DPT;

-- AS 키워드 생략 가능
SELECT DPT.department_code '부서코드', DPT.name '부서명', DPT.tel_number '부서 전화번호'
FROM department DPT;

-- JOIN : 두 개 이상의 테이블을 특정 조건에 따라 조합하여 결과를 조회하고자 할 때 사용하는 명령어

-- INNER JOIN : 두 테이블에서 조건이 일치하는 레코드만 반환
-- SELECT column, ... FROM 기준테이블 INNER JOIN 조합할 테이블 ON 조인 조건
SELECT * FROM employee E INNER JOIN department D ON E.department_code = D.department_code;





















