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
-- LIMIT : 데이터가 굉장히 많을 때 오히려 효율적일 수 있다. 십만건까지는 없어도 불러오는데 속도에 문제없다.

-- 고객 삭제
-- 최종 사용자 (고객 정보)

-- 고객 등록
-- 최종 사용자 (고객 사진, 고객 이름, 생년월일, 담당자, 주소)

-- 담당자(요양사) 검색
-- 최종 사용자 (이름)

-- 고객 상세보기
-- 최종 사용자 (고객 정보)

-- 관리 기록 리스트
-- 최종 사용자 (고객 정보)

-- 관리 기록
-- 최종 사용자 (내용, 사용용품, 용품개수)

-- 고객 수정
-- 최종 사용자 (고객 사진, 고객 이름, 생년월일, 담당자, 주소)






























