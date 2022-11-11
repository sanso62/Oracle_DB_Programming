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
    DBMS_OUTPUT.put_line(subs_name || '�� ���������� ��û�Ͽ����ϴ�.');

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
RESULT := subs_name || '�� ' || discount_ratio|| '%���εǾ� ' || discounted_price ||'���� ������ �� �ֽ��ϴ�.';
EXCEPTION
WHEN there_is_no_id THEN
RESULT :='���������� �����ϴ�.';

WHEN there_is_no_discount THEN
RESULT :='�����ϰ� ���� �ʽ��ϴ�.';
end;