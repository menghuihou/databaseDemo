select * from emp where deptno=10;

-- 游标操作
-- 查询所有员工的员工姓名和工资
-- 按照姓名： 工资 的格式输出每条记录
-- while实现
declare
  v_ename nvarchar2(50);
  v_sal number(7,2);
  -- 1. 定义游标
  cursor c_emp_1 is select ename,sal from emp; 
begin
  -- 2. 打开游标
  open c_emp_1;
  -- 3. 获取游标数据
  fetch c_emp_1 into v_ename,v_sal;
  
  while c_emp_1%found loop 
    -- 游标的属性：判断本次游标是否有数据  有 继续，无 退出
    -- 打印输出
    dbms_output.put_line(v_ename||': '||v_sal);
    -- 继续获取游标数据
      fetch c_emp_1 into v_ename,v_sal;
  end loop;  
  -- 4. 关闭游标
  close c_emp_1;
end;

-- loop实现
declare
  v_ename nvarchar2(50);
  v_sal number(7,2);
  -- 1. 定义游标
  cursor c_emp_2 is select ename,sal from emp; 
begin
  open c_emp_2;
  loop
    fetch c_emp_2 into v_ename,v_sal;
    exit when c_emp_2% notfound;-- 没有获取到数据 退出，否则 继续
    dbms_output.put_line(v_ename||': '||v_sal);
  end loop;
  close c_emp_2;
end;

-- 查询某部门的员工的姓名和工资
declare
  v_ename nvarchar2(50);
  v_sal number(7,2);
  v_deptno number(4);
  -- 1. 定义游标
  cursor c_emp_3(v_deptno number) is select ename,sal 
  from emp
  where deptno = v_deptno; 
begin
  -- 2. 打开游标时，需要传入参数
  -- open c_emp_3(10);
  open c_emp_3(v_deptno=>10);-- 两种传参方式
  loop
    fetch c_emp_3 into v_ename,v_sal;
    exit when c_emp_3% notfound;-- 没有获取到数据 退出，否则 继续
    dbms_output.put_line(v_ename||': '||v_sal);
  end loop;
  close c_emp_3;
end;

-- 给工资低于2000的员工工资，调整为2000, 打印调整的人数  rowcount
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
    -- 更新数据
    update emp set sal = 2000
    where ename=v_ename;
    dbms_output.put_line('员工'||v_ename||'工资更新成功');
  end loop;
  -- 提交
  commit;
  -- 打印更新的人数
  dbms_output.put_line('合计更新'||c_emp_4 %rowcount||'名员工工资');
  -- 关闭游标
  close c_emp_4;
end;

-- 查询所有员工的员工姓名和工资
-- for循环
declare
  cursor c_emp_5 is select * from emp ;
begin
  for v_emp in c_emp_5 loop
    dbms_output.put_line(v_emp.ename||':'||v_emp.sal);
  end loop;
end;


-- 使用默认参数
declare
  cursor c_emp_6(v_deptno number default 10) is 
  select * from emp where deptno = v_deptno;
begin
  for v_emp in c_emp_6 loop
    dbms_output.put_line(v_emp.ename||':'||v_emp.sal);
  end loop;
end;

-- 传入参数
declare
  cursor c_emp_7(v_deptno number default 10) is 
  select * from emp where deptno = v_deptno;
begin
  for v_emp in c_emp_7(20) loop -- 会替代默认参数10
    dbms_output.put_line(v_emp.ename||':'||v_emp.sal);
  end loop;
end;

-- 修改
update emp set sal=sal+100 where ename='tony';
commit;

declare
  v_ename nvarchar2(50) := 'SCOTT';
begin
  -- 更新数据
  update emp set sal=sal+100 where ename=v_ename;
  if sql%notfound then
    dbms_output.put_line('修改失败，查无此人');
  else
    dbms_output.put_line('修改成功');
  end if;
  commit;
end;

-- 处理预定义异常
declare 
  v_ename nvarchar2(50);
  v_sal emp.sal%type;
begin
  select ename,sal into v_ename,v_sal 
  from emp where ename='tom';
  dbms_output.put_line(v_ename||'的基本工资是：$'||v_sal); -- 字符串拼凑 ||
  dbms_output.put_line(888888); 
exception
  when no_data_found then
    dbms_output.put_line('查无此人');  
end;


-- 非预定异常处理
-- 前提，给emp.sal列增加一个工资非负的约束
alter table emp
add constraint ck_emp_sal check(sal>=0);

update emp set sal=-100
where deptno=10;

declare
  -- 1. 定义异常
  sal_less_than_zero exception;
  -- 2. 联系错误代码
  pragma exception_init(sal_less_than_zero,-02290);
begin
  update emp set sal=sal+100 
  where deptno=10; 
  commit;-- 成功，提交
  dbms_output.put_line('阳光'); 
exception
  when sal_less_than_zero then
    dbms_output.put_line('工资不能为负数');
    rollback;-- 失败，回滚到还原点(发生异常前)
  when others then
    dbms_output.put_line(sqlcode||'-'||sqlerrm);
    rollback;
end;


-- 用户自定义异常处理
declare
  -- 1. 定义异常
  no_result exception;
begin
  -- 进行正常业务操作
  update emp set sal=sal+100 where empno=7788;
  if sql%notfound then 
    -- 2. 引发异常
    raise no_result;
  end if;
  commit;
  dbms_output.put_line('更新成功');
  
exception
  when no_result then
    dbms_output.put_line('更新失败，查无此人');
    rollback;
  when others then
    dbms_output.put_line(sqlcode||'-'||sqlerrm);
    rollback;
end;


-- 定义无参函数
-- 不是执行，只是存储起来
create or replace function show_date_fun
  return date
  is 
  -- 变量定义区域
  v_date date;
  v_name nvarchar2(50) := 'kitty';
begin
  -- 给变量赋值
  select sysdate into v_date from dual;
  -- 返回指定的变量值
  return v_date;
end;

-- 调用已保存的函数
declare 
  v_mydate date;
begin
  -- 不能直接调用，要保存结果
  -- show_date_fun();
   v_mydate := show_date_fun();
   dbms_output.put_line(v_mydate);
end;


-- 带参数的函数
-- 求某员工的员工编号
create or replace function show_emp_no(v_ename nvarchar2)
  return number
  is
  v_empno number(4); -- 数据类型为number时，长度也可以不指定 
begin
  select empno into v_empno from emp where ename=v_ename;
  return v_empno;
-- 加入异常处理，提高程序健壮性
exception
  when no_data_found then
    -- dbms_output.put_line('没有查询到指定的记录!');
    return -1;
  when others then
    -- dbms_output.put_line(sqlcode||'-'||sqlerrm);  
    return -1;  
end;

-- 执行
declare
  v_no number;
  v_ename nvarchar2(50) := 'KING';
begin
  v_no := show_emp_no(v_ename);
  if v_no=-1 then
    dbms_output.put_line('查无此人');    
  else
    dbms_output.put_line(v_ename||'的工号是：'||v_no);
  end if;
end;

-- 返回系统游标 sys_refcursor
-- 查询所有员工的员工编号、姓名、基本工资信息
create or replace function query_emp_fun
  return sys_refcursor
  is 
  out_cursor sys_refcursor;
begin 
  -- 打开游标
  open out_cursor for
    select empno,ename,sal from emp;
  return out_cursor;
end;
-- 使用
declare
  v_empno number;
  v_ename nvarchar2(50);
  v_sal number;
  v_cursor sys_refcursor;
begin
  v_cursor := query_emp_fun();
  -- 不需要打开游标
  loop 
    fetch v_cursor into v_empno,v_ename,v_sal;
    exit when v_cursor%notfound;
    -- 打印
    dbms_output.put_line('工号：'||v_empno||',姓名：'||
                          v_ename||',工资：$'||v_sal);
  end loop;
  -- 关闭游标
  close v_cursor;
end;


-- 使用存储过程查询打印'SCOTT'的编号和工资
-- 没有返回值
create or replace procedure emp_sal_pro
  is
  v_empno number;
  v_sal number;
begin
  select empno,sal into v_empno,v_sal 
  from emp where ename='SCOTT';
  -- 打印
  dbms_output.put_line('工号：'||v_empno||
                        '，工资：$'||v_sal);
end;

-- 执行存储过程
begin
  emp_sal_pro;
end;


-- 定义输入参数
create or replace procedure emp_sal_pro(
    v_ename in nvarchar2 -- in 指定输入参数
  )
  is
  v_empno number;
  v_sal number;
begin
  select empno,sal into v_empno,v_sal 
  from emp where ename=v_ename;
  -- 打印
  dbms_output.put_line('工号：'||v_empno||
                        '，工资：$'||v_sal);
end;

-- 执行存储过程
begin
  emp_sal_pro('KING');
end;



-- 定义输入、输出参数
create or replace procedure emp_sal_pro(
    v_ename in nvarchar2, -- in 指定输入参数
    v_empno out number,
    v_sal out number
  )
  is
begin
  select empno,sal into v_empno,v_sal 
  from emp where ename=v_ename;
end;

-- 调用有输出参数的存储过程
declare
  v_empno number;
  v_sal number;
  v_ename nvarchar2(50);
begin
  -- 不指定顺序传入参数
  -- emp_sal_pro('SCOTT',v_empno,v_sal);
  emp_sal_pro(v_ename=>'SCOTT',v_sal=>v_sal,v_empno=>v_empno);
  -- 自己打印
  dbms_output.put_line('员工工号：'||v_empno||
                        '，员工工资：$'||v_sal);
end;



-- 创建对emp表操作的日志表
create table emp_log(
  tname varchar2(10), -- 原表名称
  srcrowid rowid, -- rowid值
  sqltype number(2), -- sql语句类型，如1-insert, 2-update, 3-delete
  trname varchar2(10) -- 触发器名称
);

-- 创建触发器
create or replace trigger tr_emp_1
  -- 语句触发器
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

-- 测试触发器的执行
insert into scott.emp(empno,ename,sal,deptno) 
values(114,'tony',1000,20);
update emp set sal=sal+100 where empno=114;
delete from emp where empno in (113,114);
commit;

select * from emp_log;

delete from emp_log;

grant insert on emp to tom;

-- 删除触发器
drop trigger tr_emp_1;


-- 创建触发器
create or replace trigger tr_emp_2
  -- 行级触发器
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
-- 测试触发器的执行
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
创建行级触发器tr_emp_3,
若进行了修改员工表数据的擦欧洲哦，
打印输出修改前后的操作数据；
*/
create or replace trigger tr_emp_3
  after update on emp for each row
begin
  dbms_output.put_line('FBI WARNING:emp表中更新了一条员工记录：');
  dbms_output.put_line('更新前：');
  dbms_output.put_line('员工编号：'||:old.empno);
  dbms_output.put_line('员工姓名：'||:old.ename);
  dbms_output.put_line('员工工资：'||:old.sal);
  dbms_output.put_line('更新后：');
  dbms_output.put_line('员工编号：'||:new.empno);
  dbms_output.put_line('员工姓名：'||:new.ename);
  dbms_output.put_line('员工工资：'||:new.sal);
  dbms_output.put_line('记录时间：'||to_char(sysdate,'yyyy"年"-MM"月"-dd"日"'));
end;

update emp set sal=sal+100 where empno=7788;
commit;

select * from emp_log;



-- 创建触发器，实现创建数据库对象时发出警告，
    -- 删除数据库对象时阻止的功能
create or replace trigger tr_no_drop
  before ddl on schema
begin
  if ora_sysevent='CREATE' then
    -- 输出警告信息
    dbms_output.put_line('警告：你创建了'||ora_dict_obj_type
                          ||'-'||ora_dict_obj_name
                          ||'；操作人：'||ora_dict_obj_owner
                          );
  elsif ora_sysevent='DROP' then
    -- 报错
    RAISE_APPLICATION_ERROR(-20000,'用户'||ORA_DICT_OBJ_OWNER
                            ||'不允许进行删除'||ORA_DICT_OBJ_TYPE||'-'
                            ||ORA_DICT_OBJ_NAME ||'的操作');                       
  end if;
end;

create table test1(
  id number(4),
  name nvarchar2(50)
);

drop table test1;
drop trigger tr_no_drop;


-- 登录日志表
create table login_info(
  client_ip varchar2(100),
  login_user varchar2(100),
  database_name varchar2(100),
  database_event varchar2(100),
  login_date date
);

-- 创建登录触发器
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



-- 创建一个序列，用于生成员工表的主键值
create sequence seq_emp_id
start with 1
increment by 1;



select seq_emp_id.nextval from dual;

-- 创建触发器,实现新增员工信息前，自动生成主键列的值
create or replace trigger tr_insert_emp
  before insert on emp for each row
begin
    -- dbms_output.put_line(:new.empno);
  -- 若用户新增时，手动传入了主键列，就用用户传的
  -- 否则，就用序列自动生成的
  if :new.empno is null then
    select seq_emp_id.nextval into :new.empno from dual;
  end if;
end;

-- 测试
-- 不传入主键列，使用触发器自动生成
insert into emp(ename,sal,deptno) 
values('kitty7',1000,20);
commit;
-- 传入主键列，不用触发器自动生成
insert into emp(empno,ename,sal,deptno) 
values(88,'kitty88',1000,20);
commit;

select * from emp;














