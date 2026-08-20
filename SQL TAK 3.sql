create database saldanha_db;
use saldanha_db;
create table students_2(
      Student_id int,
      Name varchar(50),
      Course varchar(50),
      Age int,
      Marks int,
      City varchar(50)
);
select * from students_2;
insert into students_2 values(21,"jenevia","bcom",18, 91,"kochi"),(22,"sweedal","bcom",28, 81,"chennai"),(23,"deepika","bba",24, 78,"Banglore");
select * from students_2;
SET SQL_SAFE_UPDATES=0;
update students_2
set Age=34
where Student_id=19;
update students_2
set Course="bba"
where Student_id=17;
update students_2
set Age=55
where Student_id=20;
update students_2
set City=34
where Student_id=13;
update students_2
set Age=70
where Student_id=21;
select * from students_2;
delete from students_2 where Course="bcom";
delete from students_2 where City="bangalore";
delete from students_2 where Course="bcom";
delete from students_2 where Marks=73;
delete from students_2 where course="bba";
select * from students_2;

