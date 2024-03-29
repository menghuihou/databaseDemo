-- 1.在部门表的dname上创建唯一索引，然后删除该索引
create unique index idx_dept_1 on dept(dname);
drop index idx_dept_1
-- 2.为SCOTT创建一个只读视图，可以查询出他有多少手下。
create or replace view v$emp_1
as 
       select empno,ename,mgr from emp where mgr=(
              select empno from emp where ename='SCOTT'
       )
with read only; 
select count(*) from v$emp_1; -- 查看scott的手下数量

-- 3.编写pl/sql块,查询出SCOTT的上级的信息
  -- 要求显示结果为:"SCOTT的上级编号为:xxx, 姓名为:xxx"
declare 
  v_empno emp.mgr%type;
  v_ename1 emp.ename%type := 'SCOTT';
  v_ename2 emp.ename%type; -- 存储上级姓名

begin
  select e2.empno,e2.ename into v_empno,v_ename2 from emp e1,emp e2
  where e1.ename=v_ename1 and e2.empno=e1.mgr;
  dbms_output.put_line('SCOTT的上级编号为：'||v_empno||',姓名为：'||v_ename2);
end;

-- 4.编写pl/sql块，判断某个数，如10，是否为质数。
declare
   v_num number(4) := 10;
   v_tmp number(4) := 2;
   v_tag number(1) := 0; -- 存储结果，0：质数，1：合数
begin
  if v_num=0 or v_num=1 then
    -- 判断输入数字是否为0或者1，是  不是质数，不是  往下判断
    dbms_output.put_line(v_num||'不是质数');
  else
    while v_tmp<v_num loop
      if mod(v_num,v_tmp)=0 then -- v_tmp可以被整除，v_num为合数
        v_tag:=1; 
      end if;
      v_tmp:=v_tmp+1;
    end loop;
    if v_tag=0 then
      dbms_output.put_line(v_num||'是质数');
    else 
      dbms_output.put_line(v_num||'不是质数');
    end if;
  end if;
end;



