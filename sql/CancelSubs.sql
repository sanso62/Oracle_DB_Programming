create or replace PROCEDURE CancelSubs
    (subsid_to_cancel IN number, -- 취소할 구독아이디
    userid_to_cancel IN varCHAR2, -- 취소를 요청하는 유저아이디
    result OUT VARCHAR2) -- 상태메시지
IS
    there_is_no_id EXCEPTION;

    nId NUMBER;

BEGIN
result := '';
    DBMS_OUTPUT.put_line('#');
    DBMS_OUTPUT.put_line(userid_to_cancel || '님이 구독아이디가 ' || subsid_to_cancel || '인 구독서비스 취소 요청하였습니다.');

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
RESULT :='구독취소했습니다.';
EXCEPTION
WHEN there_is_no_id THEN
RESULT :='구독정보가 없습니다.';
end;

