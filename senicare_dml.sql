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
SELECT * FROM nurse WHERE id = :id;
-- 레코드 삽입 시 전화번호 중복 검증
SELECT * FROM nurse WHERE tel_number = :tel_number;
-- 절차 상 인증된 전화번호만 삽입 가능
SELECT * FROM tel_auth WHERE tel_number = :tel_number AND auth_number = :auth_number; 

INSERT INTO nurse VALUES (:id, encode_password, :name, :tel_number, :join_path);

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

INSERT INTO tel_auth VALUES ('01012345678', '0123'); 

-- 인증번호 확인 
-- 최종 사용자 (인증번호)
-- '전화번호 인증 테이블'에서 '전화번호에 해당하는 인증번호'가 '사용자가 입력한 인증번호'와 같은지 비교
-- 필요한 추가 데이터 : 전화번호 (화면에서 가져옴)
SELECT * FROM tel_auth WHERE tel_number = '01012345678' AND auth_number = '0123'; 






























