-- ddl�������
-- �ͷ�״̬��
create table room_state(
       state_id number(4) not null,
       state_name nvarchar2(50)
);
-- ע��
comment on table room_state is '�ͷ�״̬��';
comment on column room_state.state_id is '�ͷ�״̬���';
comment on column room_state.state_name is '�ͷ�״̬����';

-- �ͷ���
create table room(
       room_id number(4) not null,
       room_area number(4,2),
       guest_num number(4),
       window_num number(4)
);
-- ע��
comment on table room is '�ͷ���'; 
comment on column room.room_id is '������';
comment on column room.room_area is '�������';
comment on column room.guest_num is '��ס����';
comment on column room.window_num is '��������';


-- ���˻�����Ϣ��
create table guest(
       guest_id number(4) not null,
       id_number char(18),
       guest_name nvarchar2(20),
       sex char(1),
       phone char(11)
);
-- ע��
comment on table guest is '������Ϣ��';
comment on column guest.guest_id is '���˱��';
comment on column guest.id_number is '�������֤��';
comment on column guest.sex is '�Ա�';
comment on column guest.guest_id is '���˱��';


-- ��ס�ǼǱ�
create table guest_record(
       record_id number(4) not null,
       check_in_time date,
       leave_time date,
       deposite number(4),
       total_cost number(4,2)
);
-- ע��
comment on table guest_record is '��ס�ǼǱ�';
comment on column guest_record.deposite is 'Ѻ��';
comment on column guest_record.total_cost is '�ܷ���';
comment on column guest_record.leave_time is '�뿪ʱ��';
comment on column guest_record.check_in_time is '��סʱ��';
comment on column guest_record.record_id is '��ס���';


-- �������
alter table guest
add constraint pk_guest_id primary key(guest_id);

alter table guest_record
add constraint pk_record_id primary key(record_id);

alter table room_state
add constraint pk_state_id primary key(state_id);

alter table room_type
add constraint pk_type_id primary key(type_id);

-- ɾ��Լ��
alter table room_type
drop constraint pk_type_id;-- constraint���Լ����ɾ��


-- ���ͷ������ס�������ϷǸ�Լ��
alter table room
add constraint ck_room_guest_num check(guest_num>=0);
-- ����Ѻ��Ǹ�
alter table guest_record
add constraint ck_guest_record_deposite 
check(deposite>=0);

-- ΨһԼ�����������֤��
alter table guest
add constraint uk_guest_id_number unique(id_number);

-- ��Ѻ������100ԪĬ��ֵ
alter table guest_record
modify deposite default 100;


-- ����ס�ǼǱ���ӿ��˱��
alter table guest_record 
add guest_id number(4) not null;

-- �����ӱ���ס�ǼǱ������������Լ��
-- �ӱ���ס�ǼǱ�  
-- ����������Ϣ��
-- ���������������Ϣ���У�guest_idû����Ϊ����
alter table guest 
drop constraint pk_guest_id;

-- �������Լ�����ο�������Լ��/����������Լ����
alter table guest_record
add constraint fk_guest_record_guest_id
foreign key(guest_id) -- �ӱ�����guest_id
references guest(guest_id); -- �ο����������guest_id



-- ���ͷ���Ϣ���ӱ�����������Լ��  �ͷ����͡��ͷ�״̬
-- �ͷ����ͣ�����
alter table room
add constraint fk_room_type_id
foreign key(type_id)
references room_type(type_id);
-- �ͷ�״̬������
alter table room
add constraint fk_room_state_id
foreign key(state_id)
references room_state(state_id);


insert into room_type values(1,'���˼�');
insert into room_type values(2,'˫�˼�');
insert into room_type values(3,'�����');
insert into room_type values(4,'��ͳ�׷�');

select * from room_type;

-- ����Ա�Լ����ֻ�������л�Ů
alter table guest
add constraint ck_guest_sex
check(sex='��' or sex='Ů');

-- �޸�������  ֻ��С�Ĵ�eg��char��20����char��50��
alter table guest modify guest_name nvarchar2(100);



-- ����С�ɾ����
alter table guest add test number(4);
alter table guest drop column test;

-- ��Ӷ��С�ɾ������
alter table guest add (test1 number(4),test2 number(4));
alter table guest drop(test1,test2); -- ����дcolumn

-- �޸�����
alter table guest rename column test to test666;
alter table guest drop column test666;

-- merge into ������¡��������
-- �ȱ���emp�����ݵ�emp_bak��
create table emp_bak as(
       select * from emp
);

select * from emp_bak;
-- ��ɾ��ĳ������
delete from emp where empno=7900;
commit;-- �ύ
select * from emp where empno=7900;

-- �����ݱ����ݣ��ָ���ԭʼ����
merge into emp a
using emp_bak b -- ���ݱ���Ϊ����Դ
on(a.empno=b.empno)
when not matched then
  insert
  values(
     b.empno,b.ename,b.job,b.mgr,
     b.hiredate,b.sal,b.comm,b.deptno
  );
  
  






















