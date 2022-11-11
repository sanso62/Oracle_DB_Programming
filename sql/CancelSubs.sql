create or replace PROCEDURE CancelSubs
    (subsid_to_cancel IN number, -- ����� �������̵�
    userid_to_cancel IN varCHAR2, -- ��Ҹ� ��û�ϴ� �������̵�
    result OUT VARCHAR2) -- ���¸޽���
IS
    there_is_no_id EXCEPTION;

    nId NUMBER;

BEGIN
result := '';
    DBMS_OUTPUT.put_line('#');
    DBMS_OUTPUT.put_line(userid_to_cancel || '���� �������̵� ' || subsid_to_cancel || '�� �������� ��� ��û�Ͽ����ϴ�.');

SELECT count(*)
INTO nId
FROM review r
WHERE r.subs_id = subsid_to_cancel and r.user_id= userid_to_cancel;

IF nId =0 THEN
    RAISE  there_is_no_id;
END IF;

delete from review r
where r.subs_id = subsid_to_cancel and r.user_id= userid_to_cancel;
commit;
RESULT :='��������߽��ϴ�.';
EXCEPTION
WHEN there_is_no_id THEN
RESULT :='���������� �����ϴ�.';
end;

