-- user��
create table user0(
       user_id number(4) not null,
       user_naem nvarchar2(50),
       user_password nvarchar2(50),
       user_type number(2),
       phone char(11)

);
-- ע��
comment on table user0 is '�û���';
comment on column user0.user_name is '�û���';
comment on column user0.user_password is '����';
comment on column user0.user_type is '�û�����';
comment on column user0.phone is '�ֻ���';


-- user_type��
create table user_type(
       type_id number(4) not null,
       type_name nvarchar2(50)
);
-- ע��
comment on table user_type is '�û����ͱ�';
comment on column user_type.type_name is '�û���������';

-- �������
-- user0
alter table user0
add constraint pk_user_id primary key(user_id);

-- user_type
alter table user_type
add constraint pk_user_type_id primary key(type_id);

-- ����
alter table user0 rename column user_naem to user_name;

-- �ĳ���
alter table user0 modify user_name nvarchar2(60);
