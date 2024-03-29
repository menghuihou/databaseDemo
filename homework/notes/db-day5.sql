-- dml ���ݲ�������
-- insert����

-- ֵ1,ֵ2,...,ֵnҪ������е�˳�򱣳�һ��
-- ����������
-- insert [into](into��ʡ��) ���� values(ֵ1,ֵ2,...,ֵn); 

-- ���벿���е�ֵ�������е��б��У���������ǿ���
-- insert [into] ����(��1,��2,...,��n) values(ֵ1,ֵ2,...,ֵn);

-- ����ȫ���е�ֵ
insert into emp 
values(111,'tom','tester',7788,sysdate,1000,null,20);

commit;


select * from emp;
-- ���벿����
insert into emp(empno,ename,deptno,sal)
values(112,'jerry',20,1100);

select count(*) from emp;

-- ��emp�����ݼ������ݵ�emp_bak��
merge into emp_bak a
using emp b
on(a.empno=b.empno)
when not matched then
  insert
  values(
     b.empno,b.ename,b.job,b.mgr,
     b.hiredate,b.sal,b.comm,b.deptno
  );


select count(*) from emp_bak;

-- �޸Ĳ���
/*
update ����
set ����1=��ֵ,����2=��ֵ,...,����n=��ֵ;
where �������ʽ1 [or|and �������ʽn]
*/
-- ��20�Ų��ŵ�Ա������ȫ����100Ԫ
update emp
set sal=sal+100
where deptno=20;
commit;


-- ɾ������
/*
delete from ���� [where ����];
*/
select * from emp where job='tester';
delete from emp where job='tester';
commit;



-- ��ѯ�û��Ƿ��в�����ͼ��Ȩ��
select * from session_privs;

-- ����Ա���贴����ͼ��Ȩ�޸���ǰ�û�
grant create view to scott;


-- ����һ��ֻ���Կ���Ա����š��������������ʡ��������ͼ
create view v$emp_sal
as 
       select empno,ename,sal,comm from emp;


select * from v$emp_sal;

-- ������ͼ�Ĳ�ѯȨ�޸�ĳ�û�
grant select on v$emp_sal to tom;

-- ���Ÿ�jerry��ѯ�Լ�ȫ����Ϣ����ͼ
create view v$emp_jerry
as 
       select * from emp where empno=112; -- ename='jerry'

select * from v$emp_jerry;

grant select on v$emp_jerry to jerry;
-- ����Ȩ��
grant update on v$emp_sal to tom;

-- ������ͼ�޸���Ϣ
update v$emp_sal set sal=sal+100 where sal<1000;

-- ɾ��
delete from v$emp_sal where  empno=112;

-- ����
insert into v$emp_sal values(113,'tony',1000,null);

-- ɾ����ͼ
drop view v$emp_sal;
-- �����ڴ�����ͼʱ����replace
create or replace view v$emp_sal
as 
       select empno,ename,sal,comm from emp
with read only; -- ֻ����ͼ




-- ��������
-- ΪԱ������������ͨ��������
create index idx_emp_1 on emp(ename);
-- ΪԱ�������Ͳ��ű�Ŵ�������
create index idx_emp_2 on emp(ename,deptno);
-- Ϊ�Ѵ������������ϣ��������У��ٴ�������
create index idx_emp_3 on emp(empno);

-- ����Ψһ����
-- ��ɾ�����е���ͨ����
drop index idx_emp_1;
create unique index idx_emp_3 on emp(ename);
-- ����������Ψһ��
insert into emp(empno,ename,sal,deptno) 
values(114,'jerry',1000,20);

-- ɾ��Ψһ����
drop index idx_emp_3;
-- ɾ�������ϵ�Ψһ����,�޷�ֱ��ɾ��,Ҫͨ��ɾ��Լ���ķ�ʽ
drop index pk_emp;


-- �ؽ�����
alter index pk_emp rebuild;
-- �޸���������
alter index idx_emp_2 rename to idx_emp_1;

-- �޸ı���
alter table emp10 rename to emp_10;

-- ��������
alter index idx_emp_3 unusable;

-- �������
alter index idx_emp_3 rebuild;

-- ������ռ�
select * from user_users;


select emp.*,rowid from emp where empno>5000;

-- ֱ��ʹ��rowid��ѯ������rowid
select * from emp where rowid='AAAMfPAAEAAAAAdAAB';


-- plsql����
-- ��һ��helloworld  ������
declare
   v_content nvarchar2(50):= 'hello world';
begin
  -- ��ӡ������ֵ������̨
  dbms_output.put_line(v_content);
end;

-- ��ӡ���tony�Ĺ�����Ϣ
-- Ա��������tony
-- �������ʣ�$1000
declare 
  v_ename nvarchar2(50);
  v_sal emp.sal%type;
begin
  select ename,sal into v_ename,v_sal from emp where ename='tom';
  dbms_output.put_line(v_ename||'�Ļ��������ǣ�$'||v_sal); -- �ַ���ƴ�� ||
end;


-- ɾ��Ա������Ϊtony��Ա����Ϣ
declare
   v_ename emp.ename%type := 'tony';
begin
  delete from emp where ename=v_ename;
  -- �ֶ��ύ
  commit;
end;

select * from emp where ename='tony';


-- ��֧�ж����  if-else
declare
   v_ename emp.ename%type := 'SCOTT';
   v_sal emp.sal%type ; -- �����ȡ���Ĺ���
begin
  -- ��ѯ����
  select sal into v_sal from emp where ename=v_ename;
  -- �жϵȼ�
  if v_sal>=5000 then
    dbms_output.put_line('����');
  elsif v_sal>=3000 then
    dbms_output.put_line('����');
  else
    dbms_output.put_line('����');   
   end if;
end;


-- ��֧�ж����  case
declare
   v_ename emp.ename%type := 'SCOTT';
   v_sal emp.sal%type ; -- �����ȡ���Ĺ���
   v_result nvarchar2(50); -- �����жϺ�Ľ��
begin
  -- ��ѯ����
  select sal into v_sal from emp where ename=v_ename;
  -- �жϵȼ�
  v_result :=case
              when v_sal>=5000 then '����'
              when v_sal>=3000 then '����'
              else '����'
             end;
  dbms_output.put_line('���ʵȼ���'||v_result);
end;

-- ���10��ú�ѧϰ����������
declare
  v_words nvarchar2(50) := 'good good study,day day up!';
  v_start number(4):=0;
  v_end number(4):=10;
begin
  loop
    v_start := v_start+1; -- ����
    dbms_output.put_line(v_start||'.'||v_words);
    -- �����󣬿����Ƿ��Ѿ����10����
    exit when v_start=v_end;
  end loop;
end;

-- while
declare
  v_words nvarchar2(50) := 'good good study,day day up!';
  v_start number(4):=0;
  v_end number(4):=10;
begin
  while v_start<v_end loop
    v_start := v_start+1;
    dbms_output.put_line(v_start||'.'||v_words);
  end loop;
end;


-- ͳ��10���ڵ�ż��֮��
declare
  v_start number(4) := 0;
  v_end number(4) := 10;
  v_sum number(4) := 0;
begin
  while v_start<v_end loop
    v_start := v_start+2;
    v_sum := v_start+v_sum;   
  end loop;
  dbms_output.put_line('10���ڵ�ż����Ϊ��'||v_sum);
end;

-- ��1-10���ڵ�����֮��
declare
   v_start number(4) := 1;
   v_end number(4) := 10;
   v_sum number(4) := 0;
begin
  while v_start<v_end loop    
    v_sum := v_sum + v_start;
    v_start := v_start+2;
  end loop;
  dbms_output.put_line('10���ڵ�������Ϊ��'||v_sum);
end;


declare 
   v_start number(4) := 1;
   v_end number(4) := 10;
   v_sum number(4) := 0;
begin
  -- ÿ��ȡ��ǰ�����ж��Ƿ�Ϊ����
  while v_start<v_end loop
    if mod(v_start,2)!=0 then -- mod(v_start,2)  ����
       v_sum := v_sum + v_start;       
    end if;
    v_start := v_start+1;
  end loop;
  dbms_output.put_line('�ۼӽ����'||v_sum);
end;





















































