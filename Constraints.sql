USE practice_sql;

-- 제약조건 : 데이터베이스 테이블 컬럼에 삽입, 수정, 삭제 시 적용되는 규칙

-- NOT NULL 제약조건 : 해당 컬럼에 null을 포함하지 못하도록 제약
-- 영향을 미치는 작업 : (자기 자신 테이블 INSERT, UPDATE)
CREATE TABLE not_null_table (
	null_column INT NULL,
    not_null_column INT NOT NULL
);

-- NOT NULL의 값을 넣지 않았을 때 Field 'column_name' doesn't have a default value 에러를 띄운다.
-- NOT NULL 제약조건이 걸린 컬럼에 값을 지정하지 않음.
INSERT INTO not_null_table (null_column) VALUES (1); # error

-- NOT NULL 제약조건이 걸린 컬럼에 null을 지정함. - error : null값을 넣을 수 없다.
INSERT INTO not_null_table VALUES (null, null); # error

INSERT INTO not_null_table VALUES (1, 1);
INSERT INTO not_null_table VALUES (null, 2);
INSERT INTO not_null_table (not_null_column) VALUES (2);

SELECT * FROM not_null_table;

-- NOT NULL 제약조건이 걸린 컬럼은 null로 수정할 수 없다.
UPDATE not_null_table SET not_null_column = null; # error

-- UNIQUE 제약조건 : 해당 컬럼에 중복된 데이터를 포함할 수 없도록 하는 제약
-- 영향을 미치는 작업 : (자기 자신 테이블 INSERT, UPDATE)
CREATE TABLE unique_table (
	unique_column INT UNIQUE,
    not_unique_column INT
);

INSERT INTO unique_table VALUES (1, 1);
-- UNIQUE로 지정된 컬럼은 중복된 데이터를 삽입할 수 없음
INSERT INTO unique_table VALUES (1, 1); # error
INSERT INTO unique_table VALUES (2, 1);

SELECT * FROM unique_table;

-- UNIQUE로 지정된 컬럼은 중복된 데이터로 수정할 수 없음.
-- 컬럼이 2개인데 밑에 로직처럼 하면 두 개의 값이 동일하게 3이 들어가므로 ERROR
UPDATE unique_table SET unique_column = 3; # error
-- 현재 2라는 값을 가지고 있는 컬럼이 있기 때문에 동일한 2값으로 넣으려고 해서 ERROR
UPDATE unique_table SET unique_column = 1 WHERE unique_column = 2; # error

-- NOT NULL + UNIQUE = 후보키
-- 후보키 : 테이블에서 각 레코드를 고유하게 식별할 수 있는 속성(들)
-- 기본키 : 테이블에서 각 레코드를 고유하게 식별하기 위해 후보키에서 선택한 속성
-- 대체키 : 후보키에서 기본키를 제외한 나머지 속성들

-- PRIMARY KEY 제약조건 : 특정 컬럼을 기본키로 지정
-- 영향을 미치는 작업 : (INSERT, UPDATE)
CREATE TABLE key_table (
	primary_column INT PRIMARY KEY,
    surrogate_column INT NOT NULL UNIQUE 
); 

-- PRIMARY KEY 제약조건은 NOT NULL + UNIQUE 제약조건을 모두 가지고 있음
INSERT INTO key_table VALUES (null, 1); # error
INSERT INTO key_table (surrogate_column) VALUES (1); # error

INSERT INTO key_table VALUES (1, 1);
INSERT INTO key_table VALUES (1, 2); # error

-- PRIMARY KEY 제약조건을 2개 이상 지정 불가능
CREATE TABLE composite_table (
	primary1 INT PRIMARY KEY,
    primary2 INT PRIMARY KEY
);

CREATE TABLE composite_table (
	primary1 INT,
    primary2 INT,
    CONSTRAINT primary_key PRIMARY KEY (primary1, primary2)
);

-- FOREIGN KEY 제약조건 : 특정 컬럼을 다른 테이블 혹은 같은 테이블의 기본키 컬럼과 연결하는 제약
-- FOREIGN KEY 제약조건을 특정 컬럼에 적용할 때는 반드시 데이터 타입이 '참조하고자 하는 컬럼의 타입과 일치'해야 함
CREATE TABLE foreign_table (
	primary1 INT PRIMARY KEY,
    foreign1 INT,
    CONSTRAINT foreign_key FOREIGN KEY (foreign1)
    REFERENCES key_table(primary_column)
);

SELECT * FROM key_table;

-- FOREIGN KEY 제약조건이 적용된 컬럼에는 참조하고 있는 테이블의 컬럼에 값이 존재하지 않으면 삽입, 수정이 불가능
-- 자식 테이블의 foreign key와 참조하고 있는 부모의 컬럼의 내용이 일치해야 함.
INSERT INTO foreign_table VALUES (1, 0); # error
INSERT INTO foreign_table VALUES (1, 1);

-- 부모 테이블과 다른 값을 넣으려고 해서 에러남
UPDATE foreign_table SET foreign1 = 2 WHERE primary1 = 1; # error

-- FOREIGN KEY 제약조건으로 참조되어지고 있는 테이블의 레코드는 수정, 삭제가 불가능
-- 자식 테이블이 참조하고 있는 값이기 때문에 수정을 할 수가 없다.
UPDATE key_table SET primary_column = 2 WHERE primary_column = 1; # error
DELETE FROM key_table WHERE primary_column = 1;

-- FOREIGN KEY 제약조건으로 참조되어지고 있는 테이블의 컬럼 변경 작업이 불가능
-- 참조되어지고 있는 부모 테이블이라서 지우려고 하니 에러남
DROP TABLE key_table; # error

ALTER TABLE key_table
MODIFY COLUMN primary_column VARCHAR(10); # error

-- ON UPDATE / ON DELETE 옵션
-- ON UPDATE : 참조하고 있는 테이블의 기본키가 변경될 때 동작
-- ON DELETE : 참조하고 있는 테이블의 기본키가 삭제될 때 동작

-- CASCADE : 참조되고 있는 테이블의 데이터가 삭제 또는 수정된다면
--           , 참조하고 있는 테이블에서도 삭제 또는 수정이 같이 일어남
-- SET NULL : 참조되고 있는 테이블의 데이터가 삭제 또는 수정된다면
--            , 참조하고 있는 테이블의 데이터는 NULL로 지정됨
-- RESTRICT : 참조되고 있는 테이블의 데이터의 삭제 또는 수정을 불가능하게 함

CREATE TABLE optional_foreign_table (
	primary_column INT PRIMARY KEY,
    foreign_column INT,
    FOREIGN KEY (foreign_column) REFERENCES key_table (primary_column)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

INSERT INTO optional_foreign_table VALUES (1, 1);

SELECT * FROM optional_foreign_table;

-- 다른 참조하고 있던 자식 테이블이 있어서 안 먹혔었음.
UPDATE key_table SET primary_column = 2;

DROP TABLE foreign_table;

-- 확인! 따라서 값이 바뀜
SELECT * FROM key_table;
SELECT * FROM optional_foreign_table;

DELETE FROM key_table;

-- CHECK 제약조건 : 해당 컬럼의 값을 제한하는 제약
CREATE TABLE check_table (
	primary_column INT PRIMARY KEY,
    check_column VARCHAR(5) CHECK(check_column IN('남', '여'))
);

-- CHECK 제약조건이 걸린 컬럼의 조건에 해당하지 않는 값을 삽입, 수정 할 수 없음
INSERT INTO check_table VALUES (1, '남');
INSERT INTO check_table VALUES (2, '남자'); # error
UPDATE check_table SET check_column = '여자'; # error

-- DEFAULT 제약조건 : 해당 컬럼에 삽입 시 값이 지정되지 않으면 기본값으로 지정하는 제약
CREATE TABLE default_table (
	-- AUTO_INCREMENT : 기본키가 정수형일 때 기본키의 값을 1씩 증가하는 값으로 자동 지정 (MySQL에만 존재!)
	primary_column INT PRIMARY KEY AUTO_INCREMENT,
    column1 INT,
    default_column INT DEFAULT 10
);













































