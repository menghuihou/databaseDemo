-- �������û�
create user tom identified by "123456";
-- ��ѯ�û���Ϣ
select * from all_users;

-- �������Ȩ�޸��û�
grant create session to tom;
grant create table to tom;
grant create view to tom;

-- ��ѯ�û�����ϸ��Ϣ
select * from user_users;

-- ���û������ռ�����
alter user tom 2m on users;
-- ������
create table temp(
       id number(4)��
       username varchar2(50)
);
