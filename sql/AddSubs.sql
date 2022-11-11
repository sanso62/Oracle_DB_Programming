create or replace PROCEDURE AddSubs
    (subsId in subs.subs_id%type, --구독할 아이디
    srvId in subs.srv_id%type, -- 구독서비스 업체
    subsName in subs.name%type, -- 구독 이름
    subsPrice in subs.price%type, -- 구독 가격
    result OUT VARCHAR2) -- 상태메시지
IS
    there_is_no_service exception;
    there_is_overlapped_subsId exception;
    there_is_already_subs EXCEPTION;
    nSrv number;
    srvName srv.name%type;
    nSubs number;
    nSubsName number;

BEGIN
result := '';
SELECT count(*)
INTO nSrv
FROM srv
where srv.srv_id = srvId;

IF nSrv = 0 THEN
    RAISE  there_is_no_service;
END IF;

SELECT srv.name
INTO srvName
FROM srv
where srv.srv_id = srvId;

    DBMS_OUTPUT.put_line('#');
    DBMS_OUTPUT.put_line(srvName || '서비스가 제공하는 ' || subsName || '구독서비스를 등록 요청하였습니다.');


SELECT count(*)
INTO nSubs
FROM subs
where subs.subs_id=subsId; 

IF nSubs > 0 THEN
    RAISE  there_is_overlapped_subsId;
END IF;

SELECT count(*)
INTO nSubsName
FROM subs
where subs.name=subsName; 

IF nSubsName > 0 THEN
    RAISE  there_is_already_subs;
END IF;

insert into subs
values(subsId, srvId, subsName, subsPrice);

RESULT := subsName||' 등록했습니다.';
EXCEPTION
WHEN there_is_no_service THEN
RESULT :='구독서비스를 제공하는 업체가 없습니다.';

WHEN there_is_overlapped_subsId THEN
RESULT :='구독아이디가 중복됐습니다. 다른 아이디로 입력해주세요';

WHEN there_is_already_subs THEN
RESULT :=subsName || '는 이미 등록되어 있습니다.';
end;