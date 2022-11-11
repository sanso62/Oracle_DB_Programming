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
    DBMS_OUTPUT.put_line(' ������ ���� ���� �������� ��ȸ ��û�Ͽ����ϴ�.');

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

RESULT := '���� ���� ������ �������񽺴� ' || subs_name || '�Դϴ�. ' || srvUrl || '���� �����ϼ���.';
EXCEPTION
WHEN there_is_no_score THEN
RESULT :='���������� �����ϴ�.';
end;

