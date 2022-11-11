create or replace PROCEDURE SearchDiscountSubs
    (subsId in number,
    result OUT VARCHAR2)
IS
    there_is_no_id exception;
    there_is_no_discount EXCEPTION;
    nId number;
    nDiscount number;
    subs_name subs.name%type;
    discount_amount discount.price%type;
    subs_price subs.price%type;
    discount_ratio number;
    discounted_price number;

BEGIN
result := '';

SELECT count(*)
INTO nId
FROM subs
where subs.subs_id = subsId;

IF nId = 0 THEN
    RAISE  there_is_no_id;
END IF;

select subs.name, subs.price
into subs_name, subs_price
from subs 
where subs.subs_id = subsId;


    DBMS_OUTPUT.put_line('#');
    DBMS_OUTPUT.put_line(subs_name || '의 할인정보를 요청하였습니다.');

SELECT count(*)
INTO nDiscount
FROM discount
where discount.subs_id=subsId; 

IF nDiscount = 0 THEN
    RAISE  there_is_no_discount;
END IF;

select discount.price
into discount_amount
from discount
where discount.subs_id=subsId;

discount_ratio := (discount_amount/subs_price)*100;
discounted_price := subs_price-discount_amount;
RESULT := subs_name || '는 ' || discount_ratio|| '%할인되어 ' || discounted_price ||'원에 구독할 수 있습니다.';
EXCEPTION
WHEN there_is_no_id THEN
RESULT :='구독정보가 없습니다.';

WHEN there_is_no_discount THEN
RESULT :='할인하고 있지 않습니다.';
end;