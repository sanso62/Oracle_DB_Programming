drop user c##subscribe cascade;

-- test 사용자 생성하기
CREATE USER c##subscribe IDENTIFIED BY database;


-- Grant 명령어로 접속, 사용 권한 주기
grant connect, resource, create view  to c##subscribe;


alter user c##subscribe default tablespace USERS quota unlimited on USERS