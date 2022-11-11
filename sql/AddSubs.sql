create or replace PROCEDURE AddSubs
    (subsId in subs.subs_id%type, --������ ���̵�
    srvId in subs.srv_id%type, -- �������� ��ü
    subsName in subs.name%type, -- ���� �̸�
    subsPrice in subs.price%type, -- ���� ����
    result OUT VARCHAR2) -- ���¸޽���
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
    DBMS_OUTPUT.put_line(srvName || '���񽺰� �����ϴ� ' || subsName || '�������񽺸� ��� ��û�Ͽ����ϴ�.');


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

RESULT := subsName||' ����߽��ϴ�.';
EXCEPTION
WHEN there_is_no_service THEN
RESULT :='�������񽺸� �����ϴ� ��ü�� �����ϴ�.';

WHEN there_is_overlapped_subsId THEN
RESULT :='�������̵� �ߺ��ƽ��ϴ�. �ٸ� ���̵�� �Է����ּ���';

WHEN there_is_already_subs THEN
RESULT :=subsName || '�� �̹� ��ϵǾ� �ֽ��ϴ�.';
end;