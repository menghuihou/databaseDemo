-- 创建新用户
create user tom identified by "123456";
-- 查询用户信息
select * from all_users;

-- 分配相关权限给用户
grant create session to tom;
grant create table to tom;
grant create view to tom;

-- 查询用户的详细信息
select * from user_users;

-- 给用户分配表空间容量
alter user tom quota 2m on users;
-- 创建表
create table temp(
       id number(4),
       username varchar2(50)
);

-- 创建角色
create role tester;
-- 给用户赋予相关权限
grant create session to tester;
grant create table to tester;
grant create view to tester;
-- 新建用户
create user jerry identified by "123456";
-- 给用户分配角色
grant tester to jerry;

-- 查看角色的权限
select * from role_sys_privs where role='TESTER';


-- 权限传递
-- scott把自己的表emp的查看权限给予了tom
-- 没有权限前，查看不了
select * from scott.emp;
-- 赋予权限
grant select on emp to tom;
-- tom用户将scott的emp表的查看权限授予给jerry
-- 不行，因为scott在授权的时候，没有同意权限传递
grant select on scott.emp to jerry;
-- 若授权时同意，就可以传递
-- 先收回权限，再重新赋权
revoke select on emp from tom;
grant select on scott.emp to tom with grant option;

-- 删除用户
drop user jerry;
-- 用户有相关资源时，要使用cascade关键字删除对应的资源
drop user tom cascade;



-- 查看用户所拥有的对象的操作权限
select * from user_tab_privs;

select * from scott.emp;
select * from user_tab_privs;-- 查询某用户所拥有的对象的操作权限;
select * from session_privs;-- 查看当前用户的所有权限

-- 给用户上锁
alter user tom account lock;
-- 解锁
alter user tom account unlock;










