select * from emp where deptno=10;

-- �α����
-- ��ѯ����Ա����Ա�������͹���
-- ���������� ���� �ĸ�ʽ���ÿ����¼
-- whileʵ��
declare
  v_ename nvarchar2(50);
  v_sal number(7,2);
  -- 1. �����α�
  cursor c_emp_1 is select ename,sal from emp; 
begin
  -- 2. ���α�
  open c_emp_1;
  -- 3. ��ȡ�α�����
  fetch c_emp_1 into v_ename,v_sal;
  
  while c_emp_1%found loop 
    -- �α�����ԣ��жϱ����α��Ƿ�������  �� �������� �˳�
    -- ��ӡ���
    dbms_output.put_line(v_ename||': '||v_sal);
    -- ������ȡ�α�����
      fetch c_emp_1 into v_ename,v_sal;
  end loop;  
  -- 4. �ر��α�
  close c_emp_1;
end;

-- loopʵ��
declare
  v_ename nvarchar2(50);
  v_sal number(7,2);
  -- 1. �����α�
  cursor c_emp_2 is select ename,sal from emp; 
begin
  open c_emp_2;
  loop
    fetch c_emp_2 into v_ename,v_sal;
    exit when c_emp_2% notfound;-- û�л�ȡ������ �˳������� ����
    dbms_output.put_line(v_ename||': '||v_sal);
  end loop;
  close c_emp_2;
end;

-- ��ѯĳ���ŵ�Ա���������͹���
declare
  v_ename nvarchar2(50);
  v_sal number(7,2);
  v_deptno number(4);
  -- 1. �����α�
  cursor c_emp_3(v_deptno number) is select ename,sal 
  from emp
  where deptno = v_deptno; 
begin
  -- 2. ���α�ʱ����Ҫ�������
  -- open c_emp_3(10);
  open c_emp_3(v_deptno=>10);-- ���ִ��η�ʽ
  loop
    fetch c_emp_3 into v_ename,v_sal;
    exit when c_emp_3% notfound;-- û�л�ȡ������ �˳������� ����
    dbms_output.put_line(v_ename||': '||v_sal);
  end loop;
  close c_emp_3;
end;

-- �����ʵ���2000��Ա�����ʣ�����Ϊ2000, ��ӡ����������  rowcount
declare
  v_sal number(7,2);
  v_ename nvarchar2(50);
  cursor c_emp_4
  is select ename,sal from emp where sal<2000;  
begin
  open c_emp_4;
  loop  
    fetch c_emp_4 into v_ename,v_sal;
    exit when c_emp_4% notfound;
    -- ��������
    update emp set sal = 2000
    where ename=v_ename;
    dbms_output.put_line('Ա��'||v_ename||'���ʸ��³ɹ�');
  end loop;
  -- �ύ
  commit;
  -- ��ӡ���µ�����
  dbms_output.put_line('�ϼƸ���'||c_emp_4 %rowcount||'��Ա������');
  -- �ر��α�
  close c_emp_4;
end;

-- ��ѯ����Ա����Ա�������͹���
-- forѭ��
declare
  cursor c_emp_5 is select * from emp ;
begin
  for v_emp in c_emp_5 loop
    dbms_output.put_line(v_emp.ename||':'||v_emp.sal);
  end loop;
end;


-- ʹ��Ĭ�ϲ���
declare
  cursor c_emp_6(v_deptno number default 10) is 
  select * from emp where deptno = v_deptno;
begin
  for v_emp in c_emp_6 loop
    dbms_output.put_line(v_emp.ename||':'||v_emp.sal);
  end loop;
end;

-- �������
declare
  cursor c_emp_7(v_deptno number default 10) is 
  select * from emp where deptno = v_deptno;
begin
  for v_emp in c_emp_7(20) loop -- �����Ĭ�ϲ���10
    dbms_output.put_line(v_emp.ename||':'||v_emp.sal);
  end loop;
end;

-- �޸�
update emp set sal=sal+100 where ename='tony';
commit;

declare
  v_ename nvarchar2(50) := 'SCOTT';
begin
  -- ��������
  update emp set sal=sal+100 where ename=v_ename;
  if sql%notfound then
    dbms_output.put_line('�޸�ʧ�ܣ����޴���');
  else
    dbms_output.put_line('�޸ĳɹ�');
  end if;
  commit;
end;

-- ����Ԥ�����쳣
declare 
  v_ename nvarchar2(50);
  v_sal emp.sal%type;
begin
  select ename,sal into v_ename,v_sal 
  from emp where ename='tom';
  dbms_output.put_line(v_ename||'�Ļ��������ǣ�$'||v_sal); -- �ַ���ƴ�� ||
  dbms_output.put_line(888888); 
exception
  when no_data_found then
    dbms_output.put_line('���޴���');  
end;


-- ��Ԥ���쳣����
-- ǰ�ᣬ��emp.sal������һ�����ʷǸ���Լ��
alter table emp
add constraint ck_emp_sal check(sal>=0);

update emp set sal=-100
where deptno=10;

declare
  -- 1. �����쳣
  sal_less_than_zero exception;
  -- 2. ��ϵ�������
  pragma exception_init(sal_less_than_zero,-02290);
begin
  update emp set sal=sal+100 
  where deptno=10; 
  commit;-- �ɹ����ύ
  dbms_output.put_line('����'); 
exception
  when sal_less_than_zero then
    dbms_output.put_line('���ʲ���Ϊ����');
    rollback;-- ʧ�ܣ��ع�����ԭ��(�����쳣ǰ)
  when others then
    dbms_output.put_line(sqlcode||'-'||sqlerrm);
    rollback;
end;


-- �û��Զ����쳣����
declare
  -- 1. �����쳣
  no_result exception;
begin
  -- ��������ҵ�����
  update emp set sal=sal+100 where empno=7788;
  if sql%notfound then 
    -- 2. �����쳣
    raise no_result;
  end if;
  commit;
  dbms_output.put_line('���³ɹ�');
  
exception
  when no_result then
    dbms_output.put_line('����ʧ�ܣ����޴���');
    rollback;
  when others then
    dbms_output.put_line(sqlcode||'-'||sqlerrm);
    rollback;
end;


-- �����޲κ���
-- ����ִ�У�ֻ�Ǵ洢����
create or replace function show_date_fun
  return date
  is 
  -- ������������
  v_date date;
  v_name nvarchar2(50) := 'kitty';
begin
  -- ��������ֵ
  select sysdate into v_date from dual;
  -- ����ָ���ı���ֵ
  return v_date;
end;

-- �����ѱ���ĺ���
declare 
  v_mydate date;
begin
  -- ����ֱ�ӵ��ã�Ҫ������
  -- show_date_fun();
   v_mydate := show_date_fun();
   dbms_output.put_line(v_mydate);
end;


-- �������ĺ���
-- ��ĳԱ����Ա�����
create or replace function show_emp_no(v_ename nvarchar2)
  return number
  is
  v_empno number(4); -- ��������Ϊnumberʱ������Ҳ���Բ�ָ�� 
begin
  select empno into v_empno from emp where ename=v_ename;
  return v_empno;
-- �����쳣������߳���׳��
exception
  when no_data_found then
    -- dbms_output.put_line('û�в�ѯ��ָ���ļ�¼!');
    return -1;
  when others then
    -- dbms_output.put_line(sqlcode||'-'||sqlerrm);  
    return -1;  
end;

-- ִ��
declare
  v_no number;
  v_ename nvarchar2(50) := 'KING';
begin
  v_no := show_emp_no(v_ename);
  if v_no=-1 then
    dbms_output.put_line('���޴���');    
  else
    dbms_output.put_line(v_ename||'�Ĺ����ǣ�'||v_no);
  end if;
end;

-- ����ϵͳ�α� sys_refcursor
-- ��ѯ����Ա����Ա����š�����������������Ϣ
create or replace function query_emp_fun
  return sys_refcursor
  is 
  out_cursor sys_refcursor;
begin 
  -- ���α�
  open out_cursor for
    select empno,ename,sal from emp;
  return out_cursor;
end;
-- ʹ��
declare
  v_empno number;
  v_ename nvarchar2(50);
  v_sal number;
  v_cursor sys_refcursor;
begin
  v_cursor := query_emp_fun();
  -- ����Ҫ���α�
  loop 
    fetch v_cursor into v_empno,v_ename,v_sal;
    exit when v_cursor%notfound;
    -- ��ӡ
    dbms_output.put_line('���ţ�'||v_empno||',������'||
                          v_ename||',���ʣ�$'||v_sal);
  end loop;
  -- �ر��α�
  close v_cursor;
end;


-- ʹ�ô洢���̲�ѯ��ӡ'SCOTT'�ı�ź͹���
-- û�з���ֵ
create or replace procedure emp_sal_pro
  is
  v_empno number;
  v_sal number;
begin
  select empno,sal into v_empno,v_sal 
  from emp where ename='SCOTT';
  -- ��ӡ
  dbms_output.put_line('���ţ�'||v_empno||
                        '�����ʣ�$'||v_sal);
end;

-- ִ�д洢����
begin
  emp_sal_pro;
end;


-- �����������
create or replace procedure emp_sal_pro(
    v_ename in nvarchar2 -- in ָ���������
  )
  is
  v_empno number;
  v_sal number;
begin
  select empno,sal into v_empno,v_sal 
  from emp where ename=v_ename;
  -- ��ӡ
  dbms_output.put_line('���ţ�'||v_empno||
                        '�����ʣ�$'||v_sal);
end;

-- ִ�д洢����
begin
  emp_sal_pro('KING');
end;



-- �������롢�������
create or replace procedure emp_sal_pro(
    v_ename in nvarchar2, -- in ָ���������
    v_empno out number,
    v_sal out number
  )
  is
begin
  select empno,sal into v_empno,v_sal 
  from emp where ename=v_ename;
end;

-- ��������������Ĵ洢����
declare
  v_empno number;
  v_sal number;
  v_ename nvarchar2(50);
begin
  -- ��ָ��˳�������
  -- emp_sal_pro('SCOTT',v_empno,v_sal);
  emp_sal_pro(v_ename=>'SCOTT',v_sal=>v_sal,v_empno=>v_empno);
  -- �Լ���ӡ
  dbms_output.put_line('Ա�����ţ�'||v_empno||
                        '��Ա�����ʣ�$'||v_sal);
end;



-- ������emp���������־��
create table emp_log(
  tname varchar2(10), -- ԭ������
  srcrowid rowid, -- rowidֵ
  sqltype number(2), -- sql������ͣ���1-insert, 2-update, 3-delete
  trname varchar2(10) -- ����������
);

-- ����������
create or replace trigger tr_emp_1
  -- ��䴥����
  before insert or update or delete on emp 
begin
  if inserting then
    insert into emp_log values('emp',null,1,'tr_emp_1');
  end if;
  if updating then 
    insert into emp_log values('emp',null,2,'tr_emp_1');
  end if;
  if deleting then
    insert into emp_log values('emp',null,3,'tr_emp_1');
  end if;
end;

-- ���Դ�������ִ��
insert into scott.emp(empno,ename,sal,deptno) 
values(114,'tony',1000,20);
update emp set sal=sal+100 where empno=114;
delete from emp where empno in (113,114);
commit;

select * from emp_log;

delete from emp_log;

grant insert on emp to tom;

-- ɾ��������
drop trigger tr_emp_1;


-- ����������
create or replace trigger tr_emp_2
  -- �м�������
  before insert or update or delete 
  on emp for each row 
begin
  if inserting then
    insert into emp_log values('emp',:new.rowid,1,'tr_emp_2');
  end if;
  if updating then 
    insert into emp_log values('emp',:new.rowid,2,'tr_emp_2');
  end if;
  if deleting then
    insert into emp_log values('emp',:new.rowid,3,'tr_emp_2');
  end if;
end;
-- ���Դ�������ִ��
insert into emp(empno,ename,sal,deptno) 
values(114,'tony1',1000,20);
insert into emp(empno,ename,sal,deptno) 
values(113,'tony2',1000,20);
commit;
update emp set sal=sal+100 where empno=114;
delete from emp where empno in (113,114);
commit;


select * from emp_log;

delete from emp_log;

/*
�����м�������tr_emp_3,
���������޸�Ա�������ݵĲ�ŷ��Ŷ��
��ӡ����޸�ǰ��Ĳ������ݣ�
*/
create or replace trigger tr_emp_3
  after update on emp for each row
begin
  dbms_output.put_line('FBI WARNING:emp���и�����һ��Ա����¼��');
  dbms_output.put_line('����ǰ��');
  dbms_output.put_line('Ա����ţ�'||:old.empno);
  dbms_output.put_line('Ա��������'||:old.ename);
  dbms_output.put_line('Ա�����ʣ�'||:old.sal);
  dbms_output.put_line('���º�');
  dbms_output.put_line('Ա����ţ�'||:new.empno);
  dbms_output.put_line('Ա��������'||:new.ename);
  dbms_output.put_line('Ա�����ʣ�'||:new.sal);
  dbms_output.put_line('��¼ʱ�䣺'||to_char(sysdate,'yyyy"��"-MM"��"-dd"��"'));
end;

update emp set sal=sal+100 where empno=7788;
commit;

select * from emp_log;



-- ������������ʵ�ִ������ݿ����ʱ�������棬
    -- ɾ�����ݿ����ʱ��ֹ�Ĺ���
create or replace trigger tr_no_drop
  before ddl on schema
begin
  if ora_sysevent='CREATE' then
    -- ���������Ϣ
    dbms_output.put_line('���棺�㴴����'||ora_dict_obj_type
                          ||'-'||ora_dict_obj_name
                          ||'�������ˣ�'||ora_dict_obj_owner
                          );
  elsif ora_sysevent='DROP' then
    -- ����
    RAISE_APPLICATION_ERROR(-20000,'�û�'||ORA_DICT_OBJ_OWNER
                            ||'���������ɾ��'||ORA_DICT_OBJ_TYPE||'-'
                            ||ORA_DICT_OBJ_NAME ||'�Ĳ���');                       
  end if;
end;

create table test1(
  id number(4),
  name nvarchar2(50)
);

drop table test1;
drop trigger tr_no_drop;


-- ��¼��־��
create table login_info(
  client_ip varchar2(100),
  login_user varchar2(100),
  database_name varchar2(100),
  database_event varchar2(100),
  login_date date
);

-- ������¼������
create or replace trigger scott.tr_login_info
  after logon on database
begin
  insert into login_info
  values(dbms_standard.client_ip_address,
        dbms_standard.login_user,
        dbms_standard.database_name,
        dbms_standard.sysevent,
        sysdate);
  commit;
end;

select * from login_info;

delete from login_info;



-- ����һ�����У���������Ա���������ֵ
create sequence seq_emp_id
start with 1
increment by 1;



select seq_emp_id.nextval from dual;

-- ����������,ʵ������Ա����Ϣǰ���Զ����������е�ֵ
create or replace trigger tr_insert_emp
  before insert on emp for each row
begin
    -- dbms_output.put_line(:new.empno);
  -- ���û�����ʱ���ֶ������������У������û�����
  -- ���򣬾��������Զ����ɵ�
  if :new.empno is null then
    select seq_emp_id.nextval into :new.empno from dual;
  end if;
end;

-- ����
-- �����������У�ʹ�ô������Զ�����
insert into emp(ename,sal,deptno) 
values('kitty7',1000,20);
commit;
-- ���������У����ô������Զ�����
insert into emp(empno,ename,sal,deptno) 
values(88,'kitty88',1000,20);
commit;

select * from emp;














