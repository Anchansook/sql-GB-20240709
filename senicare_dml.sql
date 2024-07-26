USE senicare;

-- 로그인 
-- 최종 사용자 (아이디, 비밀번호)
-- 요양사 테이블에 입력한 아이디와 비밀번호에 해당하는 레코드가 존재하면 로그인 성공
-- 필요한 추가 데이터 X
-- 추가 조치 : 아이디로만 조회를 하고 암호화된 비밀번호 체크를 서버측에서 실행해야 함

-- SELECT * FROM nurse WHERE id = :id AND password = :password;
SELECT * FROM nurse WHERE id = 'qwer1234';

-- 회원가입 
-- 최종 사용자 (이름, 아이디, 비밀번호, 비밀번호확인, 전화번호, 인증번호)
-- 요양사 테이블에 레코드(이름, 아이디, 암호화된 비밀번호, 전화번호, 가입경로)를 생성
-- 필요한 추가 데이터 : 가입경로(화면에서 가져옴), 암호화된 비밀번호(서버가 생성)

-- 실 회원가입 시 절차대로 로직도 따라가줌
-- 레코드 삽입 시 아이디 중복 검증
SELECT * FROM nurse WHERE id = 'qwer1234';
-- 레코드 삽입 시 전화번호 중복 검증
SELECT * FROM nurse WHERE tel_number = '01012345678';
-- 절차 상 인증된 전화번호만 삽입 가능
SELECT * FROM tel_auth WHERE tel_number = '01012345678' AND auth_number = '0123'; 

INSERT INTO nurse VALUES ('qwer1234', 'qwertyuiop', '홍길동', '01012345678', 'HOME');

-- 아이디 중복 확인 
-- 최종 사용자 (아이디)
-- 요양사 테이블에서 입력한 아이디에 해당하는 레코드가 존재하는지 확인
-- 필요한 추가 데이터 X
SELECT * FROM nurse WHERE id = 'qwer1234';

-- 전화번호 인증 
-- 최종 사용자 (전화번호)
-- 서버측에서 인증번호를 생성하여 사용자가 입력한 전화번호에 전송 후 '전화번호 인증 테이블'에 '레코드(전화번호, 인증번호)'를 추가
-- 필요한 추가 데이터 : 인증번호 (서버가 생성)

-- 레코드 삽입 시 이미 사용중인 전화번호인지 유효 여부를 확인 후 전화번호와 인증번호 삽입
SELECT * FROM nurse WHERE tel_number = '01012345678';
-- 레코드 삽입 시 이미 인증 절차를 거치고 있는 전화번호인지 확인 (전화번호인증테이블에 존재하는 전화번호인지 확인)
SELECT * FROM tel_auth WHERE tel_number = '01012345678';
-- 1. 이미 인증 절차가 진행중인 전화번호가 있다면 해당 전화번호 인증 레코드를 삭제 후 진행
-- DELETE FROM tel_auth WHERE tel_number = '01012345678';
-- 2. 이미 인증 절차가 진행중인 전화번호가 있다면 해당 전화번호에 대한 인증 번호를 수정한다.
UPDATE tel_auth SET auth_number = '0123' WHERE tel_number = '01012345678';

INSERT INTO tel_auth VALUES ('01012345678', '0123'); 

-- 인증번호 확인 
-- 최종 사용자 (인증번호)
-- '전화번호 인증 테이블'에서 '전화번호에 해당하는 인증번호'가 '사용자가 입력한 인증번호'와 같은지 비교
-- 필요한 추가 데이터 : 전화번호 (화면에서 가져옴)
SELECT * FROM tel_auth WHERE tel_number = '01012345678' AND auth_number = '0123'; 

-- 전체 고객 수 및 전체 페이지 수 불러오기
-- 최종 사용자 () => (전체 고객 수, 전체 페이지 수)
-- 고객 테이블에서 전체 레코드의 개수와 전체 레코드의 개수에 10을 나눈 값에 소수점 첫번째 자리에서 올림한 값을 조회
SELECT COUNT(*) '전체 고객 수', CEIL(COUNT(*) / 10) '전체 페이지 수' FROM customer;

-- 전체 고객 리스트 불러오기
-- 최종 사용자 (페이지 번호) => (고객번호, 고객명, 나이, 지역, 담당자 이름)
-- 고객 테이블에서 페이지 번호에 해당하는 위치부터 10개의 고객 수를 내림차순 반환
-- 필요한 추가 데이터 : 페이지 번호에 해당하는 시작위치(서버가 생성)
SELECT C.customer_number, C.name, C.birth, C.area, N.name
FROM customer C INNER JOIN nurse N
ON C.charger = N.id
ORDER BY customer_number DESC
LIMIT 0, 10;

-- 검색 고객 리스트 불러오기
-- 최종 사용자 (이름) => (고객번호, 고객명, 나이, 지역, 담당자 이름)
-- 고객 테이블에서 이름이 포함되어 있는 레코드들을 페이지 번호에 해당하는 위치부터 10개의 고객들을 내림차순 반환
-- 필요한 추가 데이터 : 페이지 번호(화면에서 가져옴), 페이지 번호에 해당하는 시작위치(서버가 생성)
SELECT C.customer_number, C.name, C.birth, C.area, N.name
FROM customer C INNER JOIN nurse N
ON C.charger = N.id
WHERE C.name LIKE '%이름%'
ORDER BY customer_number DESC
LIMIT 0, 10;
-- LIMIT : 데이터가 굉장히 많을 때 오히려 효율적일 수 있다. 십만건까지는 없어도 속도에 문제없다.

-- 고객 삭제
-- 최종 사용자 (고객 정보)
-- 고객 테이블에서 지정한 고객(고객 번호에 해당하는)의 레코드를 삭제하는 작업
-- 필요한 추가 데이터 : 고객 번호(화면에서), 로그인 사용자 아이디(화면에서)
SELECT * FROM customer WHERE customer_number = 1 AND charger = 'qwer1234'; 
DELETE FROM customer WHERE cutomer_number = 1;

-- 고객 등록
-- 최종 사용자 (고객 사진, 고객 이름, 생년월일, 담당자, 주소)
-- 고객 테이블에 레코드(고객 사진, 고객 이름, 지역, 생년월일, 담당자, 주소)를 삽입
-- 필요한 추가 데이터 : 지역(화면에서)

-- 레코드 삽입 시 담당자에 대한 참조 제약 확인
SELECT * FROM nurse WHERE id = 'qwer1234';

INSERT INTO customer (name, area, charger, profile_image, birth, address)
VALUES ('이영희', '부산광역시', 'qwer1234', null, '590826', '부산광역시 부산진구...');

-- 담당자(요양사) 검색
-- 최종 사용자 (이름) => (아이디, 이름, 전화번호)
-- 요양사 테이블에서 이름을 기준으로 입력한 이름과 같은 레코드를 조회
-- 필요 추가 데이터 : x
SELECT id, name, tel_number FROM nurse WHERE name = '홍길동';

-- 고객 상세보기
-- 최종 사용자 (고객 정보) => (고객 번호, 고객 사진, 고객 이름, 생년월일, 담당자 이름, 주소)
-- 사용하든 안 하든 요양사의 id도 가져옴 (수정 작업 시 담당자 관계 확인을 위해서)
-- 고객 테이블에서 특정 고객을 조회하여 반환, 담당자 이름을 반환하기 위해 요양사 테이블을 조인
-- 필요 추가 데이터 : 고객 번호(화면에서)
SELECT C.customer_number, .profile_image, C.name, C.birth, N.id, N.name, C.address
FROM customer C INNER JOIN nurse N
ON C.charger = N.id
WHERE C.customer_number = 1;

-- 관리 기록 리스트
-- 최종 사용자 (고객 정보) => (날짜, 내용, 사용용품, 개수)
-- 관리 기록 테이블에서 특정 고객에 대한 관리 기록 리스트를 날짜 순으로 내림차순 정렬하여 조회
-- 추가 필요 데이터 : 고객 번호(화면에서)
SELECT CM.manage_date, CM.comment, G.name, CM.used_goods_count
FROM customer_management CM LEFT JOIN goods G
ON CM.used_goods = G.goods_number
WHERE CM.customer_number = 1
ORDER BY CM.manage_date DESC;

-- 관리 기록
-- 최종 사용자 (내용, 사용용품, 용품개수)
-- 관리 기록 테이블에 레코드(고객번호, 날짜, 내용, 사용용품, 용품개수)를 삽입
-- 필요 추가 데이터 : 고객번호(화면에서), 날짜(서버에서 생성)

-- 레코드 삽입 시 고객 관계 검증
SELECT * FROM customer WHERE customer_number = 1;
-- 레코드 삽입 시 용품 관계 검증 (사용하는 용품이 있을 경우)
SELECT * FROM goods WHERE goods_number = 1;

INSERT INTO customer_management VALUES (1, '2024-07-26', '최초 방문', null, null);
-- 절차상 사용한 용품의 개수 감소 (사용하는 용품이 있을 경우)
UPDATE goods SET count = count - 2 WHERE goods_number = 1;

-- 고객 수정
-- 최종 사용자 (고객 사진, 고객 이름, 생년월일, 담당자, 주소)
-- 고객 테이블에서 특정 고객에 대한 레코드(고객 사진, 고객 이름, 생년월일, 담당자, 주소)를 수정
-- 필요 추가 데이터 : 고객 번호(화면에서)

-- 수정을 하려고 하는 레코드가 존재하는지 확인
SELECT * FROM customer WHERE customer_number = 1;
-- 레코드 수정 시 담당자 관계를 확인
SELECT * FROM nurse WHERE id = 1;

UPDATE customer SET 
	profile_image = 'http://~~~',
    name = '고길동',
    birth = '590830',
    charger = 1,
    address = '부산광역시 부산진구...'
WHERE customer_number = 1;






























