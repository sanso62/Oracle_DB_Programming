drop user c##subscribe cascade;

-- test ����� �����ϱ�
CREATE USER c##subscribe IDENTIFIED BY database;


-- Grant ��ɾ�� ����, ��� ���� �ֱ�
grant connect, resource, create view  to c##subscribe;


alter user c##subscribe default tablespace USERS quota unlimited on USERS