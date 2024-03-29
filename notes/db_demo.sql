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
alter user tom 2m on users;
-- 创建表
create table temp(
       id number(4)，
       username varchar2(50)
);
