use employee_database;
insert into incentives values(103,"2024-06-08",10000),(107,"2024-09-08",25000);
update incentives set incentiveamt=12000 where empno=107;
insert into employee values (108,"Veer",1001,"2025-07-11",60000,2);
update employee set salary=68000 where empno=108;
insert into dept values(7,"aerospace engineering","Bangalore");
insert into assignedto values(101,20,"designer");

select e.ename,d.dname,d.dloc from employee e,dept d where e.deptno=d.deptno;

select e.empno ,e.ename from employee e where e.empno not in (select a.empno from assignedto a);
select a.pno ,count(*) as project_wise_head_count from assignedto a group by a.pno; 

select e.deptno ,max(e.salary) as maximum_salary,avg(e.salary) as average_salary from employee e group by(e.deptno);

select i.empno,sum(i.incentiveamt) as total_incentive from incentives i group by(i.empno);

select e.empno,e.ename from employee e, project p, assignedto a where e.empno=a.empno and a.pno=p.pno and p.pname="web application";

select d.deptno from dept d where d.deptno not in (select distinct e.deptno from employee e);

select m.mgrno , count(m.mgrno)as report_count from employee e,employee m where e.empno =m.mgrno group by(m.mgrno);

select a.empno,e.ename, count(*) as no_of_projects from employee e, assignedto a where e.empno=a.empno group by (a.empno) having count(*)>1;

