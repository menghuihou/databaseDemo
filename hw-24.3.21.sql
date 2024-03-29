-- ѧ����
create table student(
  studentNO number(4) not null,
  studentName nvarchar2(50) not null,
  sex nvarchar2(50) not null,
  gradeId number(4) not null, -- �꼶
  phone number(11),
  address nvarchar2(255),
  bornDate date not null,
  email nvarchar2(50),
  identityCard char(18) not null
);

-- �꼶��
create table grade(
  gradeId number(4) not null,
  gradeName nvarchar2(50) not null
);

-- �ɼ���
create table stu_result(
  studentNo number(4) not null, -- ѧ��
  subjectNo number(4) not null, -- �γ̱��
  studentResult number(4) not null, -- �ɼ�
  examDate date not null -- ����ʱ��
);

-- ���Կ�Ŀ��
create table subject(
  subjectNo number(4) not null,
  subjectName nvarchar2(50) not null, 
  classHour number(4) not null, -- ѧʱ
  gradeId number(4) not null
);

drop table student;
drop table grade;
drop table stu_result;
drop table subject;

-- ���Լ������
-- ���������
alter table student -- ѧ��
add constraint pk_student_stuNo primary key(studentNo);

alter table grade -- �꼶���
add constraint pk_grade_gradeId primary key(gradeId);

alter table subject -- ��Ŀ���
add constraint pk_subject_subjectNo primary key(subjectNo);

alter table stu_result -- ѧ�š���Ŀ��š�����
add constraint pk_result 
primary key(studentNo,subjectNo,examDate);

-- ΨһԼ��(���֤��Ψһ)
alter table student
add constraint uq_student_stuID unique(identityCard);

-- Ĭ��Լ����Ĭ�ϵ�ַ���꣩
alter table student
modify address default('��ַ����');
-- ���Լ��
alter table subject -- ��ѧʱ������ڵ���0��
add constraint ck_subject_classhour check(classHour>=0);

alter table stu_result -- ������>0��<100��
add constraint ck_student_result 
check(studentResult between 0 and 100);

-- ���Լ��
alter table stu_result -- ������student�ʹӱ�stu_result������ϵ��
add constraint fk_studentNo
foreign key(studentNo) references student(studentNo);

alter table stu_result -- ������subject�ʹӱ�stu_result������ϵ��
add constraint fk_subject_subjectNo
foreign key(subjectNo) references subject(subjectNo);

alter table student -- ������grade�ʹӱ�student������ϵ��
add constraint fk_student_gradeid
foreign key(gradeid) references grade(gradeid);

alter table subject -- ������grade�ʹӱ�subject������ϵ��
add constraint fk_subject_gradeid
foreign key(gradeid) references grade(gradeid);


-- ��grade���в�������
insert into grade(gradeid,gradename) values(1,'һ�꼶');
insert into grade(gradeid,gradename) values(2,'���꼶');
insert into grade(gradeid,gradename) values(3,'���꼶');

-- ��subject���в�������
insert into subject values(1,'���������',20,1);
insert into subject values(2,'java������ƻ���',16,1);
insert into subject values(3,'���ݿ���ƻ���',18,1);
insert into subject values(4,'HTML',32,1);
insert into subject values(5,'JavaScript',38,1);
insert into subject values(6,'css',36,1);
insert into subject values(7,'java�������������',24,2);
insert into subject values(8,'MySql�����ŵ�ɾ����·',28,2);
insert into subject values(9,'���ݽṹ���㷨���',12,2);
insert into subject values(10,'���ģʽ֮��',26,2);
insert into subject values(11,'�������Spring���',42,3);
insert into subject values(12,'MyBatis�����ŵ�����',38,3);
insert into subject values(13,'SpringBootʵս',12,3);


-- ��student���в�������
insert into student values(1000,'����','��',1,
02088762106,'����к�����',to_date('1987-09-08 00:00:00','yyyy-mm-dd hh24:mi:ss'),
'guojing@sohu.com',111111);
insert into student values(1001,'���','��',1,
01084587826,'��ַ����',to_date('1993-09-08 00:00:00','yyyy-mm-dd hh24:mi:ss'),
'yangguo@sohu.com',111112);
insert into student values(1002,'��˹��','��',1,
02174836538,'��������',to_date('1992-08-08 00:00:00','yyyy-mm-dd hh24:mi:ss'),
'lisiwen@sohu.com',111113);
insert into student values(1011,'����','��',1,
01023897437,'��ַ����',to_date('1983-05-08 00:00:00','yyyy-mm-dd hh24:mi:ss'),
'wusong@sohu.com',111114);
insert into student values(1012,'����','Ů',1,
02934783579,'��ַ����',to_date('1989-04-08 00:00:00','yyyy-mm-dd hh24:mi:ss'),
'wangbao@sohu.com',111115);
insert into student values(2011,'����','Ů',1,
01274976583,'�����к�����',to_date('1999-05-12 00:00:00','yyyy-mm-dd hh24:mi:ss'),
'zhangsan@sohu.com',111116);
insert into student values(2012,'������','Ů',2,
01243627767,'�����ж�����',to_date('1979-05-12 00:00:00','yyyy-mm-dd hh24:mi:ss'),
'zhangqiuli@sohu.com',111117);
insert into student values(2015,'Ф÷','Ů',2,
02947666666,'�ӱ�ʡʯ��ׯ��',to_date('1979-05-12 00:00:00','yyyy-mm-dd hh24:mi:ss'),
'xiaomei@sohu.com',111118);
insert into student values(3021,'ŷ������','��',3,
01287389777,'�Ϻ���¬����',to_date('1999-02-14 00:00:00','yyyy-mm-dd hh24:mi:ss'),
'ouyangjunxiong@sohu.com',111119);
insert into student values(3023,'÷����','Ů',3,
02377777777,'�����������',to_date('1998-11-23 00:00:00','yyyy-mm-dd hh24:mi:ss'),
'meichaofeng@sohu.com',111120);

update student 
set  gradeid=2 where studentname='������';

-- ��stu_result���в�������
INSERT INTO stu_result VALUES(1001,2,70,
to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO stu_result VALUES(1000,2,60,
to_date('2020-02-17 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO stu_result VALUES(1001,2,46,
to_date('2020-02-17 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO stu_result VALUES(1002,2,83,
to_date('2020-02-17 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO stu_result VALUES(1011,2,71,
to_date('2020-02-16 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO stu_result VALUES(1011,2,95,
to_date('2020-02-17 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO stu_result VALUES(1012,2,76,
to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO stu_result VALUES(2011,2,60,
to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO stu_result VALUES(2012,2,91,
to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO stu_result VALUES(2012,7,61,
to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO stu_result VALUES(2015,2,60,
to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO stu_result VALUES(2015,7,65,
to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO stu_result VALUES(3021,2,23,
to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO stu_result VALUES(3021,8,74,
to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO stu_result VALUES(3023,2,23,
to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));
INSERT INTO stu_result VALUES(3023,9,39,
to_date('2020-02-15 00:00:00','yyyy-mm-dd hh24:mi:ss'));




select * from student;
select * from grade;
select * from subject;
select * from stu_result;

-- ��ϰ
-- 1. ��ѯ����ȡ���������ѧ������ʾ��Щѧ������Ϣ
select * from student where borndate<(
  select borndate from student where studentname='���'
);

-- 2. ��ѯ��Java������ƻ������γ�����
    --һ�ο��Ըպõ���60�ֵĶ��ѧ����Ϣ
select * from student where studentno in(
  select studentno from stu_result where studentresult=60 and subjectno=(
    select subjectno from subject where subjectname='java������ƻ���'
  )
);

-- 3. ��ѯ�μ����һ�Ρ�Java������������ơ�
    --���Գɼ���߷ֺ���ͷ�
select max(studentresult) as ��߷�,min(studentresult) as ��ͷ� from stu_result
where subjectno=(
  select subjectno from subject where subjectname='java�������������'
) and examdate =(
  select max(examdate) from stu_result
  group by subjectno
  having subjectno=(
    select subjectno from subject where subjectname='java�������������'
  )
)
group by subjectno; 
    
    
-- 4. ��ѯ������вμ�2020��2��17�ա�Java������ƻ�����
    --�γ̿��Ե�����ѧ���Ŀ��Գɼ���Ҫ�����ѧ���������γ����ƺͿ��Գɼ��� 
select stu.studentname as ѧ������,sub.subjectname as �γ�����,
       r.studentresult as ���Գɼ�
from student stu,subject sub,stu_result r
where sub.subjectname='java������ƻ���' and sub.subjectno=r.subjectno 
      and stu.studentno=r.studentno and 
      r.examdate=to_date('2020-02-17 00:00:00','yyyy-mm-dd hh24:mi:ss')

  
-- 5. ��ѯ�μӡ�Java������ƻ������γ����һ�ο��Ե�ѧ������
select s1.studentname from student s1,subject s2,stu_result r
where s1.studentno=r.studentno and s2.subjectno=r.subjectno and 
      s2.subjectname='java������ƻ���'
      and r.examdate=(
        select max(examdate) from stu_result  
        where subjectno=(select subjectno from subject 
                         where subjectname='java������ƻ���')
        group by subjectno 
      )

-- 6. ��ѯ��Java������ƻ������γ����һ�ο��Գɼ�Ϊ60�ֵ�ѧ����Ϣ
select s1.*
from student s1,subject s2,stu_result r
where s1.studentno=r.studentno and s2.subjectno=r.subjectno 
      and s2.subjectname='java������ƻ���'
      and r.studentresult=60
      and r.examdate=(
        select max(examdate) from stu_result  
        where subjectno=(select subjectno from subject 
                         where subjectname='java������ƻ���')
        group by subjectno 
      )


-- 7. ��ѯһ�꼶����Ŀγ���Ϣ,����ѯ�����꼶����Ŀγ���Ϣ��
select * from subject where gradeid=(
  select gradeid from grade where gradename='һ�꼶'
)


    
-- 8. ��ѯδ�μӡ�Java������ƻ������γ����һ�ο��Ե�ѧ������
select s1.studentname
from student s1
left join (
  select s2.subjectno,r.studentno,r.studentresult,r.examdate
  from subject s2
  left join stu_result r
  on s2.subjectno=r.subjectno 
  where s2.subjectname='java������ƻ���' and
  r.examdate=(
    select max(examdate) from stu_result  
    where subjectno=(select subjectno from subject where subjectname='java������ƻ���')
    group by subjectno 
  )
) sr
on sr.studentno = s1.studentno 
where sr.studentresult is null ;




-- 9. ��ѯͬ�꼶δ�μӡ�Java������ƻ������γ����һ�ο��Ե�ѧ������  
select s1.gradeid,s1.studentname
from student s1
left join (
  select s2.subjectno,r.studentno,r.studentresult,r.examdate
  from subject s2
  left join stu_result r
  on s2.subjectno=r.subjectno 
  where s2.subjectname='java������ƻ���' and
  r.examdate=(
    select max(examdate) from stu_result  
    where subjectno=(select subjectno from subject where subjectname='java������ƻ���')
    group by subjectno 
  )
) sr
on sr.studentno = s1.studentno 
where sr.studentresult is null and s1.gradeid=1;
   
    
-- 10. ��ѯ��5-10��ѧ������Ϣ��
select r.* 
from (
  select rownum rn,s.* from student s
) r 
where rn>=5 and rn<=10
-- 11. ����ѧ����У�ڼ����пγ̵ĳɼ�����
select s.studentno,s.studentname,s.subjectname,
       nvl2(to_char(re.studentresult),to_char(re.studentresult),'ȱ��') ���Գɼ�
from(select s1.studentno,s1.studentname,s2.subjectname,s2.subjectno 
     from student s1,subject s2)s
left join stu_result re
on s.studentno=re.studentno and s.subjectno=re.subjectno
order by s.subjectno;
-- 12. ��ѯÿ�ſγ����һ�ο��Գɼ���90�����ϵ�ѧ������������Ӳ�ѯ��
select s2.subjectname,s1.studentname,r.examdate,r.studentresult
from student s1,subject s2,stu_result r
where r.studentno=s1.studentno and r.subjectno=s2.subjectno and r.studentresult>90
      and r.examdate in(
        select max(examdate) from stu_result group by r.subjectno 
      )  

--��ѯÿ�ſγ����һ�ο��Գɼ���90�����ϵ�ѧ������
-- ���������ҿγ̵�����Ŀ���ʱ��
SELECT D.SubjectName, C.StudentName, A.ExamDate, B.StudentResult
  FROM (SELECT MAX(ExamDate) ExamDate, SubjectNo
          FROM stu_Result
         GROUP BY SubjectNo) A,
       stu_Result B,
       Student C,
       Subject D
 WHERE C.StudentNo = B.StudentNo
   AND D.SubjectNo = B.SubjectNo
   AND A.ExamDate = B.ExamDate
   AND A.SubjectNo = B.SubjectNo
   AND B.StudentResult >= 60
 ORDER BY B.SubjectNo, B.StudentNo



-- 13. ͳ����Ů������������ʾ������£�
select sex �Ա�,count(*) ����
from student 
group by sex

-- 14. ����ͳ��ÿ��ѧ���Ŀγ̱�ŷֱ�Ϊ1-4�ĳɼ�����ʾ�������
select r.studentno,
(select sum(studentresult) from stu_result where subjectno=2 and r.studentno=studentno) ���Ϊ2�Ŀγ�,
(select sum(studentresult) from stu_result where subjectno=7 and r.studentno=studentno) ���Ϊ7�Ŀγ�,
(select sum(studentresult) from stu_result where subjectno=8 and r.studentno=studentno) ���Ϊ8�Ŀγ�,
(select sum(studentresult) from stu_result where subjectno=9 and r.studentno=studentno) ���Ϊ9�Ŀγ�
from stu_result r
group by r.studentno;
  
  -- ������
select studentno,
        sum(
          case subjectno
            when 2 then studentresult
          end
        )as �γ̱��Ϊ2���ܳɼ�,
        sum(
          case subjectno
            when 7 then studentresult
          end
        )as �γ̱��Ϊ7���ܳɼ�,
        sum(
          case subjectno
            when 8 then studentresult
          end
        )as �γ̱��Ϊ8���ܳɼ�,
        sum(
          case subjectno
            when 9 then studentresult
          end
        )as �γ̱��Ϊ9���ܳɼ�
        
from stu_result
group by studentno;

-- �����
-- 1. ���ʵ�ֲ�ѯ����ȡ���˹�ġ����ѧ����ʹ�ñ�����ʾ��Щѧ����������������ڡ�
    --Ҫ��ʹ�ñ����������ѯ��ѧ��������
declare
  v_studentname nvarchar2(50);
  v_borndate student.borndate%type;
  cursor c_student_1 is select studentname,borndate from student
  where borndate<(
    select borndate from student where studentname='��˹��'
  ); 
begin
  open c_student_1;
  loop
    fetch c_student_1 into v_studentname,v_borndate;
    exit when c_student_1 %notfound;
    dbms_output.put_line('ѧ������:'||v_studentname||'��������:'||v_borndate);
  end loop;
  close c_student_1;
end;


-- 2. ���ʵ�ֽ��μӡ�Java������ƻ������γ̿��Գɼ�����60�ֵ�ѧ���ɼ��������60�֡�

begin
  update stu_result set studentresult = 60
  where studentresult<60 and subjectno=(select subjectno from subject 
                                        where subjectname='java������ƻ���');
end;

select * from stu_result;
-- 3. ���ʵ�ֲ�ѯһ�꼶����Ŀγ���Ϣ��Ҫ��ʹ����ʽ�α꣬��ʾ�γ̱�źͿγ����ơ�
declare
  v_subjectno number(4);
  v_subjectname nvarchar2(50);
  v_gradename nvarchar2(50) := 'һ�꼶';
  cursor c_subject_1
  is select subjectno,subjectname
  from subject where gradeid=(select gradeid from grade 
                              where gradename=v_gradename);
begin
  open c_subject_1;
  loop
    fetch c_subject_1 into v_subjectno,v_subjectname;
    exit when c_subject_1 %notfound;
    dbms_output.put_line('�γ̱�ţ�'||v_subjectno||'�γ�����'||v_subjectname);
  end loop;
  close c_subject_1;
end;

-- 4. ʹ�ô洢���̲�ѯJava������ƻ������һ�ο���ƽ���֡�
create or replace procedure avg_subject_result
  is
  v_avg_result number(7,2);
  v_subjectname nvarchar2(50) := 'java������ƻ���';
begin
  select avg(studentresult) into v_avg_result
  from stu_result where subjectno=(
    select subjectno from subject where subjectname=v_subjectname
  ) and examdate=(
    select max(examdate) from stu_result where subjectno=(
      select subjectno from subject where subjectname=v_subjectname
    )
  );
  dbms_output.put_line('�γ����ƣ�'||v_subjectname||'  ƽ���֣�'||v_avg_result);
end;

begin 
  avg_subject_result;
end;

-- 5. ʹ�ú�����ѯJava������ƻ������һ�ο��Եĳɼ�<90��ѧ��������
    --Ҫ����ʾѧ�����������Գɼ���
create or replace function c_fail_result
  return number
  is 
  result number(4);
  cursor v_student_cursor is
    select table1.studentname, table1.studentresult
    from (select stu.*, re.* from student stu
          left join stu_result re
          on stu.studentno=re.studentno) table1
    where table1.studentresult<90 and 
    table1.examdate=(select max(re1.examdate) from stu_result re1 
                     where re1.subjectno=(select sub1.subjectno from subject sub1 
                                          where sub1.subjectname='java������ƻ���'));
  v_studentname nvarchar2(50);
  v_studentresult number(4);
begin
  open v_student_cursor;
  loop
    fetch v_student_cursor into v_studentname, v_studentresult;
    exit when v_student_cursor %notfound;
    dbms_output.put_line('ѧ��������'||v_studentname||'�����Գɼ���'||v_studentresult);
  end loop;
  
  close v_student_cursor;  
  return 1;
end;


declare
  tmp_num number(4);
begin
  tmp_num := c_fail_result();
  dbms_output.put_line(tmp_num);
end;


-- 6. ʹ�ú�����ѯδ�μӡ�Java������ƻ������γ����һ�ο��Ե�ѧ������ ��
create or replace function show_uncommitted_stu
  return number
  is
  v_studentname nvarchar2(50);
  cursor c_uncommitted_stu_1 is select s1.studentname 
  from student s1
  left join (
    select s2.subjectno,r.studentno,r.studentresult,r.examdate from stu_result r 
    left join subject s2
    on r.subjectno=s2.subjectno
    where s2.subjectname='java������ƻ���' and
          r.examdate=(select max(examdate) from stu_result 
                      where subjectno=(select subjectno from subject where
                                       subjectname='java������ƻ���'))
  )sr
  on sr.studentno=s1.studentno
  where sr.studentresult is null;
        
  
begin
  dbms_output.put_line('java������ƻ������һ�ο���δ�μӵ�ѧ��������');
  open c_uncommitted_stu_1;
  loop
    fetch c_uncommitted_stu_1 into v_studentname;
    exit when c_uncommitted_stu_1 %notfound;
    dbms_output.put_line('ѧ��������'||v_studentname);
  end loop;
  close c_uncommitted_stu_1;
  return 1;
end;

declare
  v_tmp_num number(4);
begin
  v_tmp_num := show_uncommitted_stu;
  dbms_output.put_line(v_tmp_num);  
end;


-- 7. ʹ�ô洢���̲�ѯָ���꼶����Ŀγ����ơ�
create or replace procedure term_subjectname
  is
  v_subjectname nvarchar2(50);
  v_gradename nvarchar2(50) := '���꼶';
  cursor c_term_subjectname is select s2.subjectname
  from subject s2
  left join grade g
  on s2.gradeid=g.gradeid
  where g.gradename=v_gradename;
  
begin
  dbms_output.put_line(v_gradename||'����Ŀγ̣�');
  open c_term_subjectname;
  loop
    fetch c_term_subjectname into v_subjectname;
    exit when c_term_subjectname %notfound;
    dbms_output.put_line(v_subjectname);
  end loop;
  close c_term_subjectname;
end;

begin
  term_subjectname;
end;


-- 8. ʹ�ô洢���̣�����ָ��pageIndex��pageSize, ��ʾ��Ӧ��ҳ���ѧ���Ļ�����Ϣ��
create or replace procedure student_message
  is
  v_pageindex number(4) := 2 ;
  v_pagesize number(4) := 3 ;
  v_studentno student.studentno%type;
  v_studentname nvarchar2(50);
  v_sex student.sex%type;
  v_rownum number(4);
  
  cursor c_stu_message_1 is select s.*
  from (select rownum rn,stu.studentno,stu.studentname,stu.sex from student stu)s
  where rn>(v_pageindex-1)*v_pagesize and rn<=v_pagesize*v_pageindex;
  
begin
  dbms_output.put_line('��'||v_pageindex||'ҳѧ���Ļ�����Ϣ��');
  open c_stu_message_1;
  loop
    fetch c_stu_message_1 into v_rownum,v_studentno,v_studentname,v_sex;
    exit when c_stu_message_1 %notfound;
    dbms_output.put_line('rownum:'||v_rownum||'  '||'ѧ����ţ�'||v_studentno||'  '
                          ||'ѧ��������'||v_studentname||'  '||'ѧ���Ա�'||v_sex);
    
  end loop;
  close c_stu_message_1;
end;

begin
  student_message;
end;
-- 9. ��д�洢���̣�����ѧ�Ų�ѯĳѧ�������еĳɼ���Ϣ��
create or replace procedure  stu_result_stuno
  is
  v_studentno number(4) := 1011;
  v_result number(4);
  v_subjectno number(4);
  v_subjectname nvarchar2(50);
  
  cursor c_stuno_result is select r.subjectno,s2.subjectname,r.studentresult
  from stu_result r
  left join subject s2
  on s2.subjectno=r.subjectno
  where studentno=v_studentno;
  
begin
  dbms_output.put_line('ѧ��Ϊ��'||v_studentno||'��ѧ���ĳɼ���Ϣ��');
  open c_stuno_result;
  loop
    fetch c_stuno_result into v_subjectno,v_subjectname,v_result;
    exit when c_stuno_result %notfound;
    dbms_output.put_line('�γ̱�ţ�'||v_subjectno||'  �γ����ƣ�'||v_subjectname
                          ||'  �ɼ���'||v_result);
    
  end loop;
  close c_stuno_result;
end;

begin
  stu_result_stuno;
end;

-- 10. ��д������洢���̣���ѯĳ�ſγ̵Ŀ��Ե���߷֡�    
create or replace procedure sub_max_result
  is
  v_max_result number(4);
  v_subjectname nvarchar2(50);
  v_subjectno number(4) := 7;
  
begin
  select subjectname into v_subjectname from subject 
  where subjectno=v_subjectno;

  select max(studentresult) into v_max_result from stu_result
  where subjectno= v_subjectno;
  dbms_output.put_line('�γ̱�ţ�'||v_subjectno||'  �γ����ƣ�'||v_subjectname||
                        '  ��߷֣�'||v_max_result);

end;

begin
  sub_max_result;
end;




    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
