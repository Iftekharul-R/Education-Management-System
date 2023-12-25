use test
CREATE TABLE s
 ( Id int NOT NULL,
 name varchar(20) NOT NULL,
 sex char(12) NULL,
 age int NOT NULL
 )
Insert into s values(1,’Tom’,’male’,20),
(2,’Jack’,’male’,21),
(3,’Jane’,’female’,22)
Select * from student;
delete from s where id=3;
Update student set age = 25 where id = 1;
Select * from s;
Drop table s;
Drop database test;
CREATE TABLE S(
Sno CHAR(6) PRIMARY KEY,
Sname CHAR(20) UNIQUE,
age SMALLINT,
sex CHAR(2)
);
CREATE TABLE C(
Cno CHAR(4) PRIMARY KEY,
Cname CHAR(40),
teacher CHAR(10),
office char(10)
);
CREATE TABLE SC
(Sno CHAR(6),
Cno CHAR(4),
score SMALLINT,
PRIMARY KEY (Sno,Cno),
FOREIGN KEY (Sno) REFERENCES S(Sno),
FOREIGN KEY (Cno) REFERENCES C(Cno)
);
insert into s values('98601','LiQiang',20,'M');
insert into s values('98602','LiuLi',21,'F');
insert into s values('98603','ZhangBing',20,'M');
insert into s values('98604','ChenJian',22,'M');
insert into s values('98605',' LiBing',21,'F');
insert into C values('C601','AM','TAZhou','416');
insert into c values('C602','DS','TALiu','415');
insert into c values('C603','OS','TALiu','415');
insert into c values('C604','CP','TAWang','415');
4 / 8
insert into sc values('98601','C601',90);
insert into sc values('98601','C602',90);
insert into sc values('98601','C603',85);
insert into sc values('98601','C604',87);
insert into sc values('98602','C601',90);
insert into sc values('98603','C601',75);
insert into sc values('98603','C602',70);
insert into sc values('98603','C604',56);
insert into sc values('98604','C601',90);
insert into sc values('98604','C604',85);
insert into sc values('98605','C601',95);
insert into sc values('98605','C603',80);
select cno,cname from C where teacher='TAZhou';
select sno,sname from s where age>21 and sex='M';
SELECT sname FROM S
 WHERE NOT EXISTS
 (SELECT * FROM C
WHERE teacher='TALiu' AND NOT EXISTS 
 (SELECT * FROM SC
WHERE SC.sno=S.sno AND SC.cno=C.cno));
select cno
 from C
 where Cno not in(
 select cno
 from sc,s
 where s.sno=sc.sno and s.sname='LiuLi');
select sno,count(cno) from sc
 group by sno
 having count(cno)>=2;
select cno,cname
from c
where not exists (
 select *
 from s
 where not exists (
 select *
 from sc
 where cno=c.cno and sno=s.sno));
select sno from s
where not exists
(select * from c
where teacher='TAWang' and not exists
(select * from sc where sc.sno=s.sno and sc.cno=c.cno)
);
SELECT distinct sno 
FROM sc
WHERE sno in
(SELECT sno FROM sc
 where cno='C601'
 and sno in 
(SELECT sno FROM sc
 WHERE cno='C603'
 )
 );
SELECT Sname FROM S
WHERE NOT EXISTS(
 SELECT * FROM C
 WHERE NOT EXISTS
 (SELECT * FROM SC
 WHERE Sno=S.Sno AND Cno=C.Cno
 ));
SELECT sno FROM S
 WHERE sno IN
 (SELECT sno FROM SC
 WHERE cno IN
 (SELECT cno FROM SC
 WHERE sno='98603'))
 AND sno!='98603'
order by sno asc;
select s.sno,s.sname
from s,c,sc
where (c.cname='OS' and sc.cno=c.cno and sc.sno=s.sno);
CREATE DATABASE teaching;
use teaching;
CREATE TABLE S(
S CHAR(6) PRIMARY KEY,
Sname CHAR(20) UNIQUE,
age SMALLINT,
sex CHAR(2)
);
CREATE TABLE C(
C CHAR(4) PRIMARY KEY,
Cname CHAR(40),
teacher CHAR(10)
);
CREATE TABLE SC
(S CHAR(6),
C CHAR(4),
grade SMALLINT,
PRIMARY KEY (S,C),
FOREIGN KEY (S) REFERENCES S(S),
FOREIGN KEY (C) REFERENCES C(C)
);
insert into S values('S1','WANG',20,'M');
insert into S values('S2','LIU',19,'M');
insert into S values('S3','CHEN',22,'M');
insert into S values('S4','WU',19,'M');
4 / 8
insert into S values('S5','LOU',21,'F');
insert into S values('S6','DONG',18,'F');
insert into C values('C2','MATHS','MA');
insert into C values('C4','PHYSICS','SHI');
insert into C values('C3','CHEMISTRY','ZHOU');
insert into C values('C1','DB','LI');
insert into C values('C5','OS','WEN');
insert into SC values('s1','c1',80);
insert into SC values('s1','c2',70);
insert into SC values('s1','c3',85);
insert into SC values('s1','c4',90);
insert into SC values('s1','c5',70);
insert into SC values('s2','c1',85);
insert into SC values('s2','c2',null);
insert into SC values('s2','c4',null);
insert into SC values('s3','c1',90);
insert into SC values('s3','c2',85);
insert into SC values('s3','c3',95);
insert into SC values('s4','c1',75);
insert into SC values('s4','c3',null);
insert into SC values('s4','c4',70);
insert into SC values('s5','c1',70);
insert into SC values('s5','c2',60);
insert into SC values('s5','c3',80);
insert into SC values('s5','c5',65);
insert into SC values('s6','c1',90);
insert into SC values('s6','c2',null);
insert into SC values('s6','c3',90);
insert into SC values('s6','c5',null);
update sc set grade=grade*1.1 where C='c2';
delete from sc where C=
(select C from c where cname='PHYSICS');
select s,AVG (grade),COUNT(*) from sc where grade>0 group by s;
select s,AVG (grade),COUNT(*) from sc where not grade is null group by s;
Use teaching;
create view schoolboy
as
select S,SNAME,AGE
from S
where sex='M';
select S,SNAME from schoolboy where age>19;
update schoolboy set age=21 where s='s2';
alter table SC
drop CONSTRAINT sc_ibfk_1 ;
DELETE FROM schoolboy WHERE S= 'S3';
create view stu1
as
select s.S,s.Sname,c.Cname,sc.grade
from s,C,SC
where SC.C =C.C and SC.S =s.S and s.sex ='F';
select s,sname from stu1
group by s,sname
having AVG(grade)>80;
drop view stu1
create database library;
use library;
Create table class (
Category char(2) primary key,
name char(10) not null,
borrowedday tinyint not null,
borrowablesdays tinyint not null
);
Create table reader(
ReaderID char(10) primary key,
Name char(16) not null,
Gender char(8) not null default 'male',
Unit char(30) not null,
Cardstatus char(5) not null
);
Create table book (
Booknumber char(8) primary key,
Title char(40) not null,
Classname char(16) not null,
Author char(16) not null,
Publisher char(20) not null,
Dateofpublication date,
Unitprice double not null,
Quantityinstock tinyint not null
);
Create table borrowing (
ReaderID char(10),
Booknumber char(8),
Dateofborrowing date not null,
Returndate date
);
Alter table reader
auto_increment 1;
Alter table reader
Add constraint unique_dzxm unique(name);
create unique index idx_sm on book(Booknumber,classname desc);
create unique index idx_xmxb on reader(ReaderID,Gender desc);
Create database xskc;
 Use xskc;
Create table student
(Sno char(9) primary key,
Sname char(8) not null,
Ssex char(8) default 'male',
Sage int,
Sdept char(20)
);
Create table course(
Cno char(4) primary key,
Cname char(40) not null,
Cpno char(4),
Ccredit int,
Foreign key(Cpno) references course(Cno)
);
Create table SC(
Sno char(9),
Cno char(4),
Grade int,
Primary key(Sno,Cno),
Foreign key(Sno) references student(Sno),
Foreign key(Cno) references course(Cno)
);
Alter table Student ADD S_entrance DATETIME;
Alter table Student modify column Sage SMALLINT;
use xskc;
Alter table Course ADD UNIQUE(Cname);
Alter table Student modifycolumn Sdept char(20) not null;
Alter table Student drop column S_entrance;
Create index Stu_Sname on student(Sname);
Create unique index Stu_Sno on student(Sno);
Create unique index Sou_Cno on course(Cno);
Create unique index SCno on SC(Sno ASC, Cno desc);
DROP INDEX Stu_Sname on Student;
