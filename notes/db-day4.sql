-- ddl建表语句
-- 客房状态表
create table room_state(
       state_id number(4) not null,
       state_name nvarchar2(50)
);
-- 注释
comment on table room_state is '客房状态表';
comment on column room_state.state_id is '客房状态编号';
comment on column room_state.state_name is '客房状态名称';

-- 客房表
create table room(
       room_id number(4) not null,
       room_area number(4,2),
       guest_num number(4),
       window_num number(4)
);
-- 注释
comment on table room is '客房表'; 
comment on column room.room_id is '房间编号';
comment on column room.room_area is '房间面积';
comment on column room.guest_num is '入住人数';
comment on column room.window_num is '窗户数量';


-- 客人基本信息表
create table guest(
       guest_id number(4) not null,
       id_number char(18),
       guest_name nvarchar2(20),
       sex char(1),
       phone char(11)
);
-- 注释
comment on table guest is '客人信息表';
comment on column guest.guest_id is '客人编号';
comment on column guest.id_number is '客人身份证号';
comment on column guest.sex is '性别';
comment on column guest.guest_id is '客人编号';


-- 入住登记表
create table guest_record(
       record_id number(4) not null,
       check_in_time date,
       leave_time date,
       deposite number(4),
       total_cost number(4,2)
);
-- 注释
comment on table guest_record is '入住登记表';
comment on column guest_record.deposite is '押金';
comment on column guest_record.total_cost is '总费用';
comment on column guest_record.leave_time is '离开时间';
comment on column guest_record.check_in_time is '入住时间';
comment on column guest_record.record_id is '入住编号';


-- 添加主键
alter table guest
add constraint pk_guest_id primary key(guest_id);

alter table guest_record
add constraint pk_record_id primary key(record_id);

alter table room_state
add constraint pk_state_id primary key(state_id);

alter table room_type
add constraint pk_type_id primary key(type_id);

-- 删除约束
alter table room_type
drop constraint pk_type_id;-- constraint后加约束名删除


-- 给客房表的入住人数加上非负约束
alter table room
add constraint ck_room_guest_num check(guest_num>=0);
-- 设置押金非负
alter table guest_record
add constraint ck_guest_record_deposite 
check(deposite>=0);

-- 唯一约束，设置身份证号
alter table guest
add constraint uk_guest_id_number unique(id_number);

-- 给押金设置100元默认值
alter table guest_record
modify deposite default 100;


-- 给入住登记表添加客人编号
alter table guest_record 
add guest_id number(4) not null;

-- 设置子表入住登记表的引用完整性约束
-- 子表：入住登记表  
-- 主表：客人信息表
-- 错误操作，客人信息表中，guest_id没设置为主键
alter table guest 
drop constraint pk_guest_id;

-- 创建外键约束（参考完整性约束/引用完整性约束）
alter table guest_record
add constraint fk_guest_record_guest_id
foreign key(guest_id) -- 子表的外键guest_id
references guest(guest_id); -- 参考主表的主键guest_id



-- 给客房信息表（子表）添加两个外键约束  客房类型、客房状态
-- 客房类型（父表）
alter table room
add constraint fk_room_type_id
foreign key(type_id)
references room_type(type_id);
-- 客房状态（父表）
alter table room
add constraint fk_room_state_id
foreign key(state_id)
references room_state(state_id);


insert into room_type values(1,'单人间');
insert into room_type values(2,'双人间');
insert into room_type values(3,'商务间');
insert into room_type values(4,'总统套房');

select * from room_type;

-- 添加性别约束，只能输入男或女
alter table guest
add constraint ck_guest_sex
check(sex='男' or sex='女');

-- 修改数据列  只能小改大eg：char（20）→char（50）
alter table guest modify guest_name nvarchar2(100);



-- 添加列、删除列
alter table guest add test number(4);
alter table guest drop column test;

-- 添加多列、删除多列
alter table guest add (test1 number(4),test2 number(4));
alter table guest drop(test1,test2); -- 不用写column

-- 修改列名
alter table guest rename column test to test666;
alter table guest drop column test666;

-- merge into 有则更新、无则插入
-- 先备份emp表数据到emp_bak中
create table emp_bak as(
       select * from emp
);

select * from emp_bak;
-- 误删除某条数据
delete from emp where empno=7900;
commit;-- 提交
select * from emp where empno=7900;

-- 将备份表数据，恢复到原始表中
merge into emp a
using emp_bak b -- 备份表作为数据源
on(a.empno=b.empno)
when not matched then
  insert
  values(
     b.empno,b.ename,b.job,b.mgr,
     b.hiredate,b.sal,b.comm,b.deptno
  );
  
  






















