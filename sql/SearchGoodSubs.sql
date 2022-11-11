create or replace PROCEDURE SearchGoodSubs
    (result OUT VARCHAR2)
IS
    there_is_no_score EXCEPTION;
    nScore number;
    best_subs NUMBER;
    subs_name varchar2(30);
    srvId number;
    srvUrl varchar2(30);

BEGIN
result := '';
    DBMS_OUTPUT.put_line('#');
    DBMS_OUTPUT.put_line(' 평점이 가장 높은 구독서비스 조회 요청하였습니다.');

SELECT count(*)
INTO nScore
FROM subs_avg;

IF nScore =0 THEN
    RAISE  there_is_no_score;
END IF;

SELECT s.subs
INTO best_subs
FROM (select * from subs_avg order by score) s
WHERE rownum =1;

select subs.name, subs.srv_id
into subs_name, srvId
from subs
where subs.subs_id = best_subs;

select srv.url
into srvUrl
from srv
where srv.srv_id=srvId;

RESULT := '가장 높은 평점의 구독서비스는 ' || subs_name || '입니다. ' || srvUrl || '에서 구독하세요.';
EXCEPTION
WHEN there_is_no_score THEN
RESULT :='구독평점이 없습니다.';
end;

