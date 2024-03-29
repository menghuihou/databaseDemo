-- 1.�ڲ��ű��dname�ϴ���Ψһ������Ȼ��ɾ��������
create unique index idx_dept_1 on dept(dname);
drop index idx_dept_1
-- 2.ΪSCOTT����һ��ֻ����ͼ�����Բ�ѯ�����ж������¡�
create or replace view v$emp_1
as 
       select empno,ename,mgr from emp where mgr=(
              select empno from emp where ename='SCOTT'
       )
with read only; 
select count(*) from v$emp_1; -- �鿴scott����������

-- 3.��дpl/sql��,��ѯ��SCOTT���ϼ�����Ϣ
  -- Ҫ����ʾ���Ϊ:"SCOTT���ϼ����Ϊ:xxx, ����Ϊ:xxx"
declare 
  v_empno emp.mgr%type;
  v_ename1 emp.ename%type := 'SCOTT';
  v_ename2 emp.ename%type; -- �洢�ϼ�����

begin
  select e2.empno,e2.ename into v_empno,v_ename2 from emp e1,emp e2
  where e1.ename=v_ename1 and e2.empno=e1.mgr;
  dbms_output.put_line('SCOTT���ϼ����Ϊ��'||v_empno||',����Ϊ��'||v_ename2);
end;

-- 4.��дpl/sql�飬�ж�ĳ��������10���Ƿ�Ϊ������
declare
   v_num number(4) := 10;
   v_tmp number(4) := 2;
   v_tag number(1) := 0; -- �洢�����0��������1������
begin
  if v_num=0 or v_num=1 then
    -- �ж����������Ƿ�Ϊ0����1����  ��������������  �����ж�
    dbms_output.put_line(v_num||'��������');
  else
    while v_tmp<v_num loop
      if mod(v_num,v_tmp)=0 then -- v_tmp���Ա�������v_numΪ����
        v_tag:=1; 
      end if;
      v_tmp:=v_tmp+1;
    end loop;
    if v_tag=0 then
      dbms_output.put_line(v_num||'������');
    else 
      dbms_output.put_line(v_num||'��������');
    end if;
  end if;
end;



