create or replace TRIGGER BeforeEnrollsrv
BEFORE insert ON srv
FOR EACH ROW

DECLARE
  not_consist_of_www     EXCEPTION;
  srv_url srv.url%type;

BEGIN
    srv_url:= :new.url;


  IF ( not (srv_url like 'www.%') ) THEN
     RAISE not_consist_of_www;
  END IF;

  EXCEPTION
    WHEN not_consist_of_www THEN
       RAISE_APPLICATION_ERROR(-20009, 'url 형식에 맞지 않습니다.');
END;