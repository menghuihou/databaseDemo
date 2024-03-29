-- dml 数据操作语言
-- insert操作

-- 值1,值2,...,值n要跟表的列的顺序保持一致
-- 插入所有列
-- insert [into](into可省略) 表名 values(值1,值2,...,值n); 

-- 插入部分列的值，部分列的列表中，必须包含非空列
-- insert [into] 表名(列1,列2,...,列n) values(值1,值2,...,值n);

-- 插入全部列的值
insert into emp 
values(111,'tom','tester',7788,sysdate,1000,null,20);

commit;


select * from emp;
-- 插入部分列
insert into emp(empno,ename,deptno,sal)
values(112,'jerry',20,1100);

select count(*) from emp;

-- 将emp的数据继续备份到emp_bak中
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

-- 修改操作
/*
update 表名
set 列名1=新值,列名2=新值,...,列名n=新值;
where 条件表达式1 [or|and 条件表达式n]
*/
-- 将20号部门的员工工资全部加100元
update emp
set sal=sal+100
where deptno=20;
commit;


-- 删除操作
/*
delete from 表名 [where 条件];
*/
select * from emp where job='tester';
delete from emp where job='tester';
commit;



-- 查询用户是否有操作视图的权限
select * from session_privs;

-- 管理员赋予创建视图的权限给当前用户
grant create view to scott;


-- 创建一个只可以看到员工编号、姓名、基础工资、奖金的视图
create view v$emp_sal
as 
       select empno,ename,sal,comm from emp;


select * from v$emp_sal;

-- 开放视图的查询权限给某用户
grant select on v$emp_sal to tom;

-- 开放给jerry查询自己全部信息的视图
create view v$emp_jerry
as 
       select * from emp where empno=112; -- ename='jerry'

select * from v$emp_jerry;

grant select on v$emp_jerry to jerry;
-- 更新权限
grant update on v$emp_sal to tom;

-- 基于视图修改信息
update v$emp_sal set sal=sal+100 where sal<1000;

-- 删除
delete from v$emp_sal where  empno=112;

-- 新增
insert into v$emp_sal values(113,'tony',1000,null);

-- 删除视图
drop view v$emp_sal;
-- 或者在创建视图时带上replace
create or replace view v$emp_sal
as 
       select empno,ename,sal,comm from emp
with read only; -- 只读视图




-- 创建索引
-- 为员工姓名创建普通单列索引
create index idx_emp_1 on emp(ename);
-- 为员工姓名和部门编号创建索引
create index idx_emp_2 on emp(ename,deptno);
-- 为已存在索引的列上，如主键列，再创建索引
create index idx_emp_3 on emp(empno);

-- 创建唯一索引
-- 先删除已有的普通索引
drop index idx_emp_1;
create unique index idx_emp_3 on emp(ename);
-- 测试索引的唯一性
insert into emp(empno,ename,sal,deptno) 
values(114,'jerry',1000,20);

-- 删除唯一索引
drop index idx_emp_3;
-- 删除主键上的唯一索引,无法直接删除,要通过删除约束的方式
drop index pk_emp;


-- 重建索引
alter index pk_emp rebuild;
-- 修改索引名称
alter index idx_emp_2 rename to idx_emp_1;

-- 修改表名
alter table emp10 rename to emp_10;

-- 禁用索引
alter index idx_emp_3 unusable;

-- 解禁索引
alter index idx_emp_3 rebuild;

-- 索引表空间
select * from user_users;


select emp.*,rowid from emp where empno>5000;

-- 直接使用rowid查询，会走rowid
select * from emp where rowid='AAAMfPAAEAAAAAdAAB';


-- plsql程序
-- 第一个helloworld  无名块
declare
   v_content nvarchar2(50):= 'hello world';
begin
  -- 打印变量的值到控制台
  dbms_output.put_line(v_content);
end;

-- 打印输出tony的工资信息
-- 员工姓名：tony
-- 基本工资：$1000
declare 
  v_ename nvarchar2(50);
  v_sal emp.sal%type;
begin
  select ename,sal into v_ename,v_sal from emp where ename='tom';
  dbms_output.put_line(v_ename||'的基本工资是：$'||v_sal); -- 字符串拼凑 ||
end;


-- 删除员工姓名为tony的员工信息
declare
   v_ename emp.ename%type := 'tony';
begin
  delete from emp where ename=v_ename;
  -- 手动提交
  commit;
end;

select * from emp where ename='tony';


-- 分支判断语句  if-else
declare
   v_ename emp.ename%type := 'SCOTT';
   v_sal emp.sal%type ; -- 保存获取到的工资
begin
  -- 查询工资
  select sal into v_sal from emp where ename=v_ename;
  -- 判断等级
  if v_sal>=5000 then
    dbms_output.put_line('大佬');
  elsif v_sal>=3000 then
    dbms_output.put_line('老鸟');
  else
    dbms_output.put_line('菜鸟');   
   end if;
end;


-- 分支判断语句  case
declare
   v_ename emp.ename%type := 'SCOTT';
   v_sal emp.sal%type ; -- 保存获取到的工资
   v_result nvarchar2(50); -- 保存判断后的结果
begin
  -- 查询工资
  select sal into v_sal from emp where ename=v_ename;
  -- 判断等级
  v_result :=case
              when v_sal>=5000 then '大佬'
              when v_sal>=3000 then '老鸟'
              else '菜鸟'
             end;
  dbms_output.put_line('工资等级：'||v_result);
end;

-- 输出10遍好好学习，天天向上
declare
  v_words nvarchar2(50) := 'good good study,day day up!';
  v_start number(4):=0;
  v_end number(4):=10;
begin
  loop
    v_start := v_start+1; -- 计数
    dbms_output.put_line(v_start||'.'||v_words);
    -- 输出完后，看看是否已经输出10遍了
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


-- 统计10以内的偶数之和
declare
  v_start number(4) := 0;
  v_end number(4) := 10;
  v_sum number(4) := 0;
begin
  while v_start<v_end loop
    v_start := v_start+2;
    v_sum := v_start+v_sum;   
  end loop;
  dbms_output.put_line('10以内的偶数和为：'||v_sum);
end;

-- 求1-10以内的奇数之和
declare
   v_start number(4) := 1;
   v_end number(4) := 10;
   v_sum number(4) := 0;
begin
  while v_start<v_end loop    
    v_sum := v_sum + v_start;
    v_start := v_start+2;
  end loop;
  dbms_output.put_line('10以内的奇数和为：'||v_sum);
end;


declare 
   v_start number(4) := 1;
   v_end number(4) := 10;
   v_sum number(4) := 0;
begin
  -- 每次取当前数，判断是否为奇数
  while v_start<v_end loop
    if mod(v_start,2)!=0 then -- mod(v_start,2)  求余
       v_sum := v_sum + v_start;       
    end if;
    v_start := v_start+1;
  end loop;
  dbms_output.put_line('累加结果：'||v_sum);
end;





















































