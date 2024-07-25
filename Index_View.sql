USE practice_sql;

-- 인덱스 (INDEX) : 테이블에서 원하는 컬럼을 빠르게 조회하기 위해 사용하는 구조

-- 인덱스 생성
-- CREATE INDEX 인덱스이름 ON 테이블명(컬럼, ...)
CREATE INDEX employee_name_idx ON employee (name);
CREATE INDEX employee_name_age_idx ON employee (name, age);
CREATE INDEX employee_name_desc_idx ON employee (name DESC);

-- 테이블에 인덱스 추가
-- ALTER TABLE 테이블명 ADD INDEX 인덱스이름(컬럼명);
ALTER TABLE sale ADD INDEX amount_idx (amount);

-- 인덱스 삭제
-- DROP INDEX 인덱스명 ON 테이블명;
DROP INDEX employee_name_desc_idx ON employee;

-- 테이블에서 인덱스 삭제
-- ALTER TABLE 테이블명 DROP INDEX 인덱스명;
ALTER TABLE employee DROP INDEX employee_name_age_idx;

-- 뷰 (View) : 물리적으로 존재하지 않는 읽기전용의 가상 테이블
-- 조회문을 미리 작성해서 재사용하는 용도, 컬럼에 대한 제한된 보기를 제공하는 용도

-- 뷰 생성
-- CREATE VIEW 뷰이름 AS SELECT ...
CREATE VIEW employee_view AS 
SELECT 
	E.employee_number '사번', 
    E.name '사원이름', 
    E.department_code '부서코드', 
    D.name '부서명', 
    D.tel_number '부서 전화번호'
FROM employee E LEFT JOIN department D
ON E.department_code = D.department_code
ORDER BY 부서명;

SELECT * FROM employee_view;
-- VIEW는 물리적으로 데이터가 저장되는 것이 아니기 때문에
-- INSERT, UPDATE, DELETE 및 INDEX 생성이 불가능

-- VIEW 수정
-- ALTER VIEW 뷰이름 AS SELECT ...
ALTER VIEW employee_view AS 
SELECT 
	E.employee_number '사번', 
    E.name '사원이름', 
    D.name '부서명', 
    D.tel_number '부서 전화번호'
FROM employee E LEFT JOIN department D
ON E.department_code = D.department_code
ORDER BY 부서명;

-- VIEW 삭제
-- DROP VIEW 뷰이름
DROP VIEW employee_view;

















