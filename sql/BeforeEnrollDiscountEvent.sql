create or replace TRIGGER BeforeEnrollDiscountEvent
BEFORE insert ON discount
FOR EACH ROW

DECLARE
  discount_event_is_over      EXCEPTION;
  discount_amount_is_over      EXCEPTION;
  now      date;
  end_date date;
  subs_price  subs.price%type;
  discount_amount subs.price%type;
  
BEGIN
    now:=sysdate;
    end_date:=:new.enddate;
    select subs.price
    into subs_price
    from subs
    where subs.subs_id=:new.subs_id;
    discount_amount:=:new.price;
    
  IF (end_date <= now ) THEN
     RAISE discount_event_is_over;
  END IF;
  
  IF (subs_price < discount_amount ) THEN
     RAISE discount_amount_is_over;
  END IF;
  
  EXCEPTION
    WHEN discount_event_is_over THEN
       RAISE_APPLICATION_ERROR(-20008, '이미 지난 날짜입니다.');
    WHEN discount_amount_is_over THEN
       RAISE_APPLICATION_ERROR(-20009, '할인금액이 원래가격을 초과합니다.');
END;