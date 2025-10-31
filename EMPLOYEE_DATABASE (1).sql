create database employee_database;
use employee_database;

create table dept(deptno int primary key,dname varchar(30),dloc varchar(30));
create table employee(empno int,ename varchar(20), mgrno int, hiredate date,salary decimal(10,2), deptno int, primary key(empno),
foreign key (deptno) references dept (deptno));
alter table employee add foreign key(mgrno) references employee(empno);
create table project(pno int primary key,ploc varchar(20),pname varchar(30));
create table incentives(empno int,incentivedate date,incentiveamt decimal(10,2),primary key(empno,incentivedate),
foreign key(empno) references employee(empno));
create table assignedto(empno int,pno int,jobrole varchar(30), primary key(empno,pno),foreign key (empno) references employee(empno),
foreign key (pno) references project(pno));

insert into dept values(1,"computer engineering","bangalore"),(2,"electronics engineering","kolkata"),
(3,"artificial intelligence","bangalore"),(4,"machine learning","mumbai"),(5,"mechanical engineering","delhi"),(6,"information science","delhi");
select * from dept;
insert into employee values(1001,"raghav",null,"2024-05-25",80000,1),(1002,"raghu",null,"2024-05-13",70000,2),(101,"ram",1001,"2023-05-25",40000,1),
(1003,"radha",null,"2023-04-25",70000,3),(102,"rishi",1003,"2025-05-25",40000,3),(1004,"tanvi",null,"2023-06-25",70000,4),(1005,"tanu",null,"2024-05-25",80000,5),
(1006,"armaan",null,"2025-11-02",60000,6),(103,"renu",1003,"2025-05-25",30000,3),(104,"radhika",1006,"2021-05-03",40000,6),(105,"anuj",1003,"2023-05-25",40000,1),
(106,"shivani",1004,"2024-06-25",40000,3),(107,"vani",1005,"2025-05-25",40000,6);
update employee set salary=95000 where empno=1003;
update employee set salary=55000 where empno=102;
update employee set salary=65000 where empno=1004;
update employee set salary=85000 where empno=1005;
update employee set salary=25000 where empno=104;
update employee set salary=45000 where empno=105;
update employee set salary=35000 where empno=106;
update employee set salary=15000 where empno=107;
select * from employee; 
insert into project values(10,"bangalore","web application"),(20,"kolkata","transformer"),(30,"mumbai","engine manufacture"),(40,"delhi","robotics"),
(50,"bangalore","ai chatbot"),(60,"mumbai","embedded systems");
select * from project;
insert into incentives values(1001,"2024-09-15",15000),(103,"2025-12-25",20000),(104,"2022-06-03",10000),(1006,"2026-01-01",35000),(107,"2025-12-03",10000);
select * from incentives;
insert into assignedto values(1001,10,"manager"),(1002,20,"manager"),(1003,30,"manager"),(1004,40,"manager"),(1005,50,"manager"),(1006,60,"manager"),
(101,10,"assitant"),(102,10,"developer"),(103,20,"assistant"),(104,40,"designer"),(105,50,"assistant"),(106,50,"designer");
select * from assignedto;

select a.empno from assignedto a where a.pno in (select p.pno from project p where ploc="kolkata" or ploc="mumbai");

select e.empno from employee e where e.empno not in (select i.empno from incentives i);

select distinct a.empno,e.ename,e.deptno,a.jobrole,d.dloc,p.ploc from employee e,assignedto a , project p, dept d where 
a.empno=e.empno and a.pno=p.pno and p.ploc=d.dloc; 

select e.mgrno,count(e.ename) as numberofemp from employee e , assignedto a where e.mgrno=a.empno 
group by (e.mgrno);
 
update incentives set incentiveamt=25000 where empno=107; 
select i.empno,e.ename from incentives i,employee e where e.empno=i.empno and 1=(select count(inc.incentiveamt) from incentives inc where
 inc.incentiveamt>i.incentiveamt and (i.incentivedate  like "2025%") );

select m.empno,m.ename,m.deptno,m.mgrno from employee e ,employee m,dept d where e.empno =m.mgrno and m.deptno=d.deptno and m.deptno=e.deptno;

select a.empno,e.ename,e.salary from assignedto a,employee e where a.empno=e.empno and a.jobrole="manager" and 
e.salary>(select avg(emp.salary) from employee emp ,employee em where a.empno=em.mgrno );

select e.ename,e.salary from employee e, assignedto a where a.empno=e.empno and 1=(select count(*) from employee em where em.mgrno is null and em.salary>e.salary);