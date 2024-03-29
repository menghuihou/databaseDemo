-- 学生表
create table student(
  studentNO number(4) not null,
  studentName nvarchar2(50) not null,
  sex nvarchar2(50) not null,
  gradeId number(4) not null, -- 年级
  phone number(11),
  address nvarchar2(255),
  bornDate date not null,
  email nvarchar2(50),
  identityCard char(18) not null
);

-- 年级表
create table grade(
  gradeId number(4) not null,
  gradeName nvarchar2(50) not null
);

-- 成绩表
create table stu_result(
  studentNo number(4) not null, -- 学号
  subjectNo number(4) not null, -- 课程编号
  studentResult number(4) not null, -- 成绩
  examDate date not null -- 考试时间
);

-- 考试科目表
create table subject(
  subjectNo number(4) not null,
  subjectName nvarchar2(50) not null, 
  classHour number(4) not null, -- 学时
  gradeId number(4) not null
);

drop table student;
drop table grade;
drop table stu_result;
drop table subject;

-- 添加约束条件
-- 添加主键列
alter table student -- 学号
add constraint pk_student_stuNo primary key(studentNo);

alter table grade -- 年级编号
add constraint pk_grade_gradeId primary key(gradeId);

alter table subject -- 科目编号
add constraint pk_subject_subjectNo primary key(subjectNo);

alter table stu_result -- 学号、科目编号、日期
add constraint pk_result 
primary key(studentNo,subjectNo,examDate);

-- 唯一约束(身份证号唯一)
alter table student
add constraint uq_student_stuID unique(identityCard);

-- 默认约束（默认地址不详）
alter table student
modify address default('地址不详');
-- 检查约束
alter table subject -- （学时必须大于等于0）
add constraint ck_subject_classhour check(classHour>=0);

alter table stu_result -- （分数>0且<100）
add constraint ck_student_result 
check(studentResult between 0 and 100);

-- 外键约束
alter table stu_result -- （主表student和从表stu_result建立关系）
add constraint fk_studentNo
foreign key(studentNo) references student(studentNo);

alter table stu_result -- （主表subject和从表stu_result建立关系）
add constraint fk_subject_subjectNo
foreign key(subjectNo) references subject(subjectNo);

alter table student -- （主表grade和从表student建立关系）
add constraint fk_student_gradeid
foreign key(gradeid) references grade(gradeid);

alter table subject -- （主表grade和从表subject建立关系）
add constraint fk_subject_gradeid
foreign key(gradeid) references grade(gradeid);


-- 向grade表中插入数据
insert into grade(gradeid,gradename) values(1,'一年级');
insert into grade(gradeid,gradename) values(2,'二年级');
insert into grade(gradeid,gradename) values(3,'三年级');

-- 向subject表中插入数据
insert into subject values(1,'计算机基础',20,1);
insert into subject values(2,'java程序设计基础',16,1);
insert into subject values(3,'数据库设计基础',18,1);
insert into subject values(4,'HTML',32,1);
insert into subject values(5,'JavaScript',38,1);
insert into subject values(6,'css',36,1);
insert into subject values(7,'java面向对象程序设计',24,2);
insert into subject values(8,'MySql从入门到删库跑路',28,2);
insert into subject values(9,'数据结构与算法设计',12,2);
insert into subject values(10,'设计模式之美',26,2);
insert into subject values(11,'深入理解Spring框架',42,3);
insert into subject values(12,'MyBatis从入门到放弃',38,3);
insert into subject values(13,'SpringBoot实战',12,3);


-- 向student表中插入数据
insert into student values(1000,'郭靖','男',1,
02088762106,'天津市河西区',to_date('1987-09-08 00:00:00','yyyy-mm-dd hh24:mi:ss'),
'guojing@sohu.com',111111);
insert into student values(1001,'杨过','男',1,
01084587826,'地址不详',to_date('1993-09-08 00:00:00','yyyy-mm-dd hh24:mi:ss'),
'yangguo@sohu.com',111112);
insert into student values(1002,'李斯文','男',1,
02174836538,'河南洛阳',to_date('1992-08-08 00:00:00','yyyy-mm-dd hh24:mi:ss'),
'lisiwen@sohu.com',111113);
insert into student values(1011,'武松','男',1,
01023897437,'地址不详',to_date('1983-05-08 00:00:00','yyyy-mm-dd hh24:mi:ss'),
'wusong@sohu.com',111114);
insert into student values(1012,'王宝','女',1,
02934783579,'地址不详',to_date('1989-04-08 00:00:00','yyyy-mm-dd hh24:mi:ss'),
'wangbao@sohu.com',111115);
insert into student values(2011,'张三','女',1,
01274976583,'北京市海淀区',to_date('1999-05-12 00:00:00','yyyy-mm-dd hh24:mi:ss'),
'zhangsan@sohu.com',111116);
insert into student values(2012,'张秋丽','女',2,
01243627767,'北京市东城区',to_date('1979-05-12 00:00:00','yyyy-mm-dd hh24:mi:ss'),
'zhangqiuli@sohu.com',111117);
insert into student values(2015,'肖梅','女',2,
02947666666,'河北省石家庄市',to_date('1979-05-12 00:00:00','yyyy-mm-dd hh24:mi:ss'),
'xiaomei@sohu.com',111118);
insert into student values(3021,'欧阳俊雄','男',3,
01287389777,'上海市卢湾区',to_date('1999-02-14 00:00:00','yyyy-mm-dd hh24:mi:ss'),
'ouyangjunxiong@sohu.com',111119);
insert into student values(3023,'梅超风','女',3,
02377777777,'广州市天河区',to_date('1998-11-23 00:00:00','yyyy-mm-dd hh24:mi:ss'),
'meichaofeng@sohu.com',111120);

update student 
set  gradeid=2 where studentname='张秋丽';

-- 向stu_result表中插入数据
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

-- 练习
-- 1. 查询年龄比“杨过”大的学生，显示这些学生的信息
select * from student where borndate<(
  select borndate from student where studentname='杨过'
);

-- 2. 查询“Java程序设计基础”课程至少
    --一次考试刚好等于60分的多个学生信息
select * from student where studentno in(
  select studentno from stu_result where studentresult=60 and subjectno=(
    select subjectno from subject where subjectname='java程序设计基础'
  )
);

-- 3. 查询参加最近一次“Java面向对象程序设计”
    --考试成绩最高分和最低分
select max(studentresult) as 最高分,min(studentresult) as 最低分 from stu_result
where subjectno=(
  select subjectno from subject where subjectname='java面向对象程序设计'
) and examdate =(
  select max(examdate) from stu_result
  group by subjectno
  having subjectno=(
    select subjectno from subject where subjectname='java面向对象程序设计'
  )
)
group by subjectno; 
    
    
-- 4. 查询获得所有参加2020年2月17日“Java程序设计基础”
    --课程考试的所有学生的考试成绩，要求输出学生姓名、课程名称和考试成绩。 
select stu.studentname as 学生姓名,sub.subjectname as 课程名称,
       r.studentresult as 考试成绩
from student stu,subject sub,stu_result r
where sub.subjectname='java程序设计基础' and sub.subjectno=r.subjectno 
      and stu.studentno=r.studentno and 
      r.examdate=to_date('2020-02-17 00:00:00','yyyy-mm-dd hh24:mi:ss')

  
-- 5. 查询参加“Java程序设计基础”课程最近一次考试的学生名单
select s1.studentname from student s1,subject s2,stu_result r
where s1.studentno=r.studentno and s2.subjectno=r.subjectno and 
      s2.subjectname='java程序设计基础'
      and r.examdate=(
        select max(examdate) from stu_result  
        where subjectno=(select subjectno from subject 
                         where subjectname='java程序设计基础')
        group by subjectno 
      )

-- 6. 查询“Java程序设计基础”课程最近一次考试成绩为60分的学生信息
select s1.*
from student s1,subject s2,stu_result r
where s1.studentno=r.studentno and s2.subjectno=r.subjectno 
      and s2.subjectname='java程序设计基础'
      and r.studentresult=60
      and r.examdate=(
        select max(examdate) from stu_result  
        where subjectno=(select subjectno from subject 
                         where subjectname='java程序设计基础')
        group by subjectno 
      )


-- 7. 查询一年级开设的课程信息,（查询所有年级开设的课程信息）
select * from subject where gradeid=(
  select gradeid from grade where gradename='一年级'
)


    
-- 8. 查询未参加“Java程序设计基础”课程最近一次考试的学生名单
select s1.studentname
from student s1
left join (
  select s2.subjectno,r.studentno,r.studentresult,r.examdate
  from subject s2
  left join stu_result r
  on s2.subjectno=r.subjectno 
  where s2.subjectname='java程序设计基础' and
  r.examdate=(
    select max(examdate) from stu_result  
    where subjectno=(select subjectno from subject where subjectname='java程序设计基础')
    group by subjectno 
  )
) sr
on sr.studentno = s1.studentno 
where sr.studentresult is null ;




-- 9. 查询同年级未参加“Java程序设计基础”课程最近一次考试的学生名单  
select s1.gradeid,s1.studentname
from student s1
left join (
  select s2.subjectno,r.studentno,r.studentresult,r.examdate
  from subject s2
  left join stu_result r
  on s2.subjectno=r.subjectno 
  where s2.subjectname='java程序设计基础' and
  r.examdate=(
    select max(examdate) from stu_result  
    where subjectno=(select subjectno from subject where subjectname='java程序设计基础')
    group by subjectno 
  )
) sr
on sr.studentno = s1.studentno 
where sr.studentresult is null and s1.gradeid=1;
   
    
-- 10. 查询第5-10名学生的信息。
select r.* 
from (
  select rownum rn,s.* from student s
) r 
where rn>=5 and rn<=10
-- 11. 制作学生在校期间所有课程的成绩单。
select s.studentno,s.studentname,s.subjectname,
       nvl2(to_char(re.studentresult),to_char(re.studentresult),'缺考') 考试成绩
from(select s1.studentno,s1.studentname,s2.subjectname,s2.subjectno 
     from student s1,subject s2)s
left join stu_result re
on s.studentno=re.studentno and s.subjectno=re.subjectno
order by s.subjectno;
-- 12. 查询每门课程最近一次考试成绩在90分以上的学生名单（相关子查询）
select s2.subjectname,s1.studentname,r.examdate,r.studentresult
from student s1,subject s2,stu_result r
where r.studentno=s1.studentno and r.subjectno=s2.subjectno and r.studentresult>90
      and r.examdate in(
        select max(examdate) from stu_result group by r.subjectno 
      )  

--查询每门课程最近一次考试成绩在90分以上的学生名单
-- 核心是先找课程的最近的考试时间
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



-- 13. 统计男女生的人数，显示结果如下：
select sex 性别,count(*) 人数
from student 
group by sex

-- 14. 汇总统计每个学生的课程编号分别为1-4的成绩，显示结果如下
select r.studentno,
(select sum(studentresult) from stu_result where subjectno=2 and r.studentno=studentno) 编号为2的课程,
(select sum(studentresult) from stu_result where subjectno=7 and r.studentno=studentno) 编号为7的课程,
(select sum(studentresult) from stu_result where subjectno=8 and r.studentno=studentno) 编号为8的课程,
(select sum(studentresult) from stu_result where subjectno=9 and r.studentno=studentno) 编号为9的课程
from stu_result r
group by r.studentno;
  
  -- 方法二
select studentno,
        sum(
          case subjectno
            when 2 then studentresult
          end
        )as 课程编号为2的总成绩,
        sum(
          case subjectno
            when 7 then studentresult
          end
        )as 课程编号为7的总成绩,
        sum(
          case subjectno
            when 8 then studentresult
          end
        )as 课程编号为8的总成绩,
        sum(
          case subjectno
            when 9 then studentresult
          end
        )as 课程编号为9的总成绩
        
from stu_result
group by studentno;

-- 编程题
-- 1. 编程实现查询年龄比“李斯文”大的学生，使用变量显示这些学生的姓名与出生日期。
    --要求使用变量保存待查询的学生姓名。
declare
  v_studentname nvarchar2(50);
  v_borndate student.borndate%type;
  cursor c_student_1 is select studentname,borndate from student
  where borndate<(
    select borndate from student where studentname='李斯文'
  ); 
begin
  open c_student_1;
  loop
    fetch c_student_1 into v_studentname,v_borndate;
    exit when c_student_1 %notfound;
    dbms_output.put_line('学生姓名:'||v_studentname||'出生日期:'||v_borndate);
  end loop;
  close c_student_1;
end;


-- 2. 编程实现将参加“Java程序设计基础”课程考试成绩低于60分的学生成绩，提高至60分。

begin
  update stu_result set studentresult = 60
  where studentresult<60 and subjectno=(select subjectno from subject 
                                        where subjectname='java程序设计基础');
end;

select * from stu_result;
-- 3. 编程实现查询一年级开设的课程信息，要求使用显式游标，显示课程编号和课程名称。
declare
  v_subjectno number(4);
  v_subjectname nvarchar2(50);
  v_gradename nvarchar2(50) := '一年级';
  cursor c_subject_1
  is select subjectno,subjectname
  from subject where gradeid=(select gradeid from grade 
                              where gradename=v_gradename);
begin
  open c_subject_1;
  loop
    fetch c_subject_1 into v_subjectno,v_subjectname;
    exit when c_subject_1 %notfound;
    dbms_output.put_line('课程编号：'||v_subjectno||'课程名称'||v_subjectname);
  end loop;
  close c_subject_1;
end;

-- 4. 使用存储过程查询Java程序设计基础最近一次考试平均分。
create or replace procedure avg_subject_result
  is
  v_avg_result number(7,2);
  v_subjectname nvarchar2(50) := 'java程序设计基础';
begin
  select avg(studentresult) into v_avg_result
  from stu_result where subjectno=(
    select subjectno from subject where subjectname=v_subjectname
  ) and examdate=(
    select max(examdate) from stu_result where subjectno=(
      select subjectno from subject where subjectname=v_subjectname
    )
  );
  dbms_output.put_line('课程名称：'||v_subjectname||'  平均分：'||v_avg_result);
end;

begin 
  avg_subject_result;
end;

-- 5. 使用函数查询Java程序设计基础最近一次考试的成绩<90的学生名单，
    --要求显示学生姓名，考试成绩。
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
                                          where sub1.subjectname='java程序设计基础'));
  v_studentname nvarchar2(50);
  v_studentresult number(4);
begin
  open v_student_cursor;
  loop
    fetch v_student_cursor into v_studentname, v_studentresult;
    exit when v_student_cursor %notfound;
    dbms_output.put_line('学生姓名：'||v_studentname||'；考试成绩：'||v_studentresult);
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


-- 6. 使用函数查询未参加“Java程序设计基础”课程最近一次考试的学生名单 。
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
    where s2.subjectname='java程序设计基础' and
          r.examdate=(select max(examdate) from stu_result 
                      where subjectno=(select subjectno from subject where
                                       subjectname='java程序设计基础'))
  )sr
  on sr.studentno=s1.studentno
  where sr.studentresult is null;
        
  
begin
  dbms_output.put_line('java程序设计基础最近一次考试未参加的学生名单：');
  open c_uncommitted_stu_1;
  loop
    fetch c_uncommitted_stu_1 into v_studentname;
    exit when c_uncommitted_stu_1 %notfound;
    dbms_output.put_line('学生姓名：'||v_studentname);
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


-- 7. 使用存储过程查询指定年级开设的课程名称。
create or replace procedure term_subjectname
  is
  v_subjectname nvarchar2(50);
  v_gradename nvarchar2(50) := '三年级';
  cursor c_term_subjectname is select s2.subjectname
  from subject s2
  left join grade g
  on s2.gradeid=g.gradeid
  where g.gradename=v_gradename;
  
begin
  dbms_output.put_line(v_gradename||'开设的课程：');
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


-- 8. 使用存储过程，传入指定pageIndex和pageSize, 显示对应分页后的学生的基本信息。
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
  dbms_output.put_line('第'||v_pageindex||'页学生的基本信息：');
  open c_stu_message_1;
  loop
    fetch c_stu_message_1 into v_rownum,v_studentno,v_studentname,v_sex;
    exit when c_stu_message_1 %notfound;
    dbms_output.put_line('rownum:'||v_rownum||'  '||'学生编号：'||v_studentno||'  '
                          ||'学生姓名：'||v_studentname||'  '||'学生性别：'||v_sex);
    
  end loop;
  close c_stu_message_1;
end;

begin
  student_message;
end;
-- 9. 编写存储过程，根据学号查询某学生的所有的成绩信息。
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
  dbms_output.put_line('学号为：'||v_studentno||'的学生的成绩信息：');
  open c_stuno_result;
  loop
    fetch c_stuno_result into v_subjectno,v_subjectname,v_result;
    exit when c_stuno_result %notfound;
    dbms_output.put_line('课程编号：'||v_subjectno||'  课程名称：'||v_subjectname
                          ||'  成绩：'||v_result);
    
  end loop;
  close c_stuno_result;
end;

begin
  stu_result_stuno;
end;

-- 10. 编写函数或存储过程，查询某门课程的考试的最高分。    
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
  dbms_output.put_line('课程编号：'||v_subjectno||'  课程名称：'||v_subjectname||
                        '  最高分：'||v_max_result);

end;

begin
  sub_max_result;
end;




    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
