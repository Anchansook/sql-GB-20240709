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
SELECT 
E.employee_number '사번', E.name '사원이름', E.age '나이', 
D.department_code '부서코드', D.name '부서명', D.tel_number '부서 전화번호'
FROM employee E INNER JOIN department D ON E.department_code = D.department_code;

-- LEFT OUTER JOIN (LEFT JOIN) : 기준 테이블의 모든 레코드와 조합할 테이블 중 조건에 일치하는 레코드만 반환
-- 만약에 조합할 테이블에 조건에 일치하는 레코드가 존재하지 않으면 null로 표현
SELECT 
E.employee_number '사번', E.name '사원이름', E.age '나이', E.department_code '부서코드', 
D.name '부서명', D.tel_number '부서 전화번호'
FROM employee E LEFT JOIN department D ON E.department_code = D.department_code;

-- RIGHT OUTER JOIN (RIGHT JOIN) : 조합할 테이블의 모든 레코드와 기준 테이블 중 조건에 일치하는 레코드만 반환
-- 만약 기준 테이블에 조건에 일치하는 레코드가 존재하지 않으면 null로 반환
SELECT 
E.employee_number '사번', E.name '사원이름', E.age '나이', 
D.department_code '부서코드', D.name '부서명', D.tel_number '부서 전화번호'
FROM employee E RIGHT JOIN department D ON E.department_code = D.department_code;

-- FULL OUTER JOIN (FULL JOIN) : 기준 테이블의 모든 레코드와 조합할 테이블의 모든 레코드를 반환 (일치하는 레코드(중복 제거), 각 서로의 레코드)
-- 만약 기준 테이블 혹은 조합할 테이블에 조건에 일치하는 레코드가 존재하지 않으면 null로 반환
-- MySQL에서는 FULL OUTER JOIN을 문법상 제공하지 않음
-- FULL JOIN = LEFT JOIN + RIGHT JOIN : UNION
SELECT 
E.employee_number '사번', E.name '사원이름', E.age '나이', E.department_code '부서코드', 
D.name '부서명', D.tel_number '부서 전화번호'
FROM employee E LEFT JOIN department D ON E.department_code = D.department_code
UNION
SELECT 
E.employee_number '사번', E.name '사원이름', E.age '나이', 
D.department_code '부서코드', D.name '부서명', D.tel_number '부서 전화번호'
FROM employee E RIGHT JOIN department D ON E.department_code = D.department_code;

-- CROSS JOIN : 기준 테이블의 각 레코드를 조합할 테이블의 모든 레코드에 조합하여 반환
-- CROSS JOIN 결과 레코드 수 = 기준 테이블 레코드 수 * 조합할 테이블의 레코드 수
SELECT * FROM employee E CROSS JOIN department D;
-- MySQL에서 기본 조인이 CROSS JOIN 형태임
SELECT * FROM employee E JOIN department D;
SELECT * FROM employee E, department D;

-- 부서코드가 A인 사원에 대해
-- 사번, 이름, '부서명'을 조회하시오. (조회해서 반환할 컬럼의 레코드가 다른 테이블에 있기 때문에 JOIN)
SELECT E.employee_number '사번', E.name '이름', D.name '부서명'
FROM employee E INNER JOIN department D
ON E.department_code = D.department_code
WHERE E.department_code = 'A';

-- 부서명이 '영업부'인 사원에 대해
-- 사번, 이름, 나이를 조회하시오. 
-- (여기선 기준 테이블에서만 컬럼의 레코드를 조회해오기 때문에 JOIN을 쓰지 않아도 된다. 속도가 느려지는 비효율)
SELECT E.employee_number '사번', E.name '이름', E.age '나이'
FROM employee E INNER JOIN department D
ON E.department_code = D.department_code
WHERE D.name = '영업부';


















