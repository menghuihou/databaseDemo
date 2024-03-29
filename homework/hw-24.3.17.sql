-- user表
create table user0(
       user_id number(4) not null,
       user_naem nvarchar2(50),
       user_password nvarchar2(50),
       user_type number(2),
       phone char(11)

);
-- 注释
comment on table user0 is '用户表';
comment on column user0.user_name is '用户名';
comment on column user0.user_password is '密码';
comment on column user0.user_type is '用户类型';
comment on column user0.phone is '手机号';


-- user_type表
create table user_type(
       type_id number(4) not null,
       type_name nvarchar2(50)
);
-- 注释
comment on table user_type is '用户类型表';
comment on column user_type.type_name is '用户类型名称';

-- 添加主键
-- user0
alter table user0
add constraint pk_user_id primary key(user_id);

-- user_type
alter table user_type
add constraint pk_user_type_id primary key(type_id);

-- 改名
alter table user0 rename column user_naem to user_name;

-- 改长度
alter table user0 modify user_name nvarchar2(60);
