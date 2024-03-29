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
alter user tom quota 2m on users;
-- ������
create table temp(
       id number(4),
       username varchar2(50)
);

-- ������ɫ
create role tester;
-- ���û��������Ȩ��
grant create session to tester;
grant create table to tester;
grant create view to tester;
-- �½��û�
create user jerry identified by "123456";
-- ���û������ɫ
grant tester to jerry;

-- �鿴��ɫ��Ȩ��
select * from role_sys_privs where role='TESTER';


-- Ȩ�޴���
-- scott���Լ��ı�emp�Ĳ鿴Ȩ�޸�����tom
-- û��Ȩ��ǰ���鿴����
select * from scott.emp;
-- ����Ȩ��
grant select on emp to tom;
-- tom�û���scott��emp��Ĳ鿴Ȩ�������jerry
-- ���У���Ϊscott����Ȩ��ʱ��û��ͬ��Ȩ�޴���
grant select on scott.emp to jerry;
-- ����Ȩʱͬ�⣬�Ϳ��Դ���
-- ���ջ�Ȩ�ޣ������¸�Ȩ
revoke select on emp from tom;
grant select on scott.emp to tom with grant option;

-- ɾ���û�
drop user jerry;
-- �û��������Դʱ��Ҫʹ��cascade�ؼ���ɾ����Ӧ����Դ
drop user tom cascade;



-- �鿴�û���ӵ�еĶ���Ĳ���Ȩ��
select * from user_tab_privs;

select * from scott.emp;
select * from user_tab_privs;-- ��ѯĳ�û���ӵ�еĶ���Ĳ���Ȩ��;
select * from session_privs;-- �鿴��ǰ�û�������Ȩ��

-- ���û�����
alter user tom account lock;
-- ����
alter user tom account unlock;










