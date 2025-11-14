create database supplier_database;
use supplier_database;
create table supplier(sid int,sname varchar(20),city varchar(20), primary key(sid));
create table parts (pid int,pname varchar(20),color varchar(10),primary key(pid));
create table catalog(sid int,pid int,cost decimal(10,2),primary key(sid,pid),foreign key (sid) references supplier(sid),foreign key (pid) references parts(pid));

insert into supplier values(1,"Rishi","Bangalore"),(2,"Anurag","Kolkata"),(3,"Raghav","Ayodhya"),(4,"Tanu","Mumbai"),(5,"Anuj","Ahmedabad");
select * from supplier;
insert into parts values(10,"Nuts","Black"),(20,"Screw","Yellow"),(30,"Screw","Red"),(40,"Hammer","brown"),(50,"Nuts","Red");
insert into parts values(60,"Bolts","Black");
select * from parts;
insert into catalog values(1,10,1000),(1,20,5000),(1,30,2000),(1,40,4000),(1,50,10000),(2,10,3000),(3,50,4400),(4,20,1100),(5,10,8000);
insert into catalog values(1,60,4500);
insert into catalog values(2,20,6000);
select * from catalog;

select p.pname from parts p where p.pid in (select c.pid from catalog c);

select c.sid ,count(*) from catalog c group by (c.sid) having count(*)=(select count(*) from parts);

select s.sname  from supplier s ,parts p,catalog c where s.sid=c.sid and p.pid=c.pid and p.color="Red" group  by (s.sname) 
having count(*)=(select count(*) from parts pa where pa.color="Red");

select p.pname,p.pid from parts p ,catalog c , supplier s where p.pid=c.pid and s.sid=c.sid and s.sname="Rishi" and 
p.pid not in (select ca.pid from catalog ca ,supplier su where ca.sid=su.sid and su.sname <> "Rishi");

select distinct c.sid from catalog c where c.cost > (select avg(ca.cost) from catalog ca group by(c.pid));

select distinct s.sid,s.sname,p.pid from supplier s,parts p ,catalog c where c.pid=p.pid and s.sid=c.sid and 
c.cost =some (select max(ca.cost) from catalog ca group by (ca.pid));
