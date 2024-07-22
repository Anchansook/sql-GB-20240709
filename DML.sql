USE practice_sql;

-- 데이터 조작어 (DML)
-- 테이블에 레코드를 삽입, 조회, 수정, 삭제 할 때 사용

-- INSERT : 테이블에 레코드를 삽입하는 명령

-- 1. 모든 컬럼에 대하여 삽입
-- INSERT INTO 테이블명 VALUES(데이터1, 데이터2, ...);
-- 테이블 구조의 컬럼 순서에 맞게 모든 데이터를 입력해야 함
INSERT INTO example_table VALUES ('데이터1', '데이터2');

-- 2. 특정 컬럼을 선택하여 삽입
-- INSERT INTO 테이블명 (컬럼명1, 컬럼명2, ...)
-- VALUES (데이터1, 데이터2, ...);
-- 지정한 컬럼의 순서와 데이터의 순서가 일치해야 함
INSERT INTO example_table (example_column2) VALUES ('선택 데이터1');























