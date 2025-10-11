create database insurance;
use insurance;
create table person (driver_id varchar(10),
name varchar(20), 
address varchar(30),
primary key(driver_id));
desc person;
create table car(reg_num varchar(10),model varchar(10),year int, primary key(reg_num));


desc car;
create table accident(report_num int, accident_date date, location varchar(20),primary key(report_num));
desc accident;
create table owns(driver_id varchar(10),reg_num varchar(10),
primary key(driver_id, reg_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num));
desc owns;
create table participated(driver_id varchar(10), reg_num varchar(10),
report_num int, damage_amount int, 
primary key(driver_id, reg_num, report_num), 
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),
foreign key(report_num) references accident(report_num));
desc participated;
insert into person values('A01','Richard','Srinivas Nagar');
insert into person values('A02','Pradeep','Rajaji Nagar');
insert into person values('A03','smith','Ashok Nagar');
insert into person values('A04','Richard','NR Colony');
insert into person values('A05','Richard','Hanumanth Nagar');
 select * from person;
 insert into car values('KA052250','Indica', 1990);
 insert into car values('KA031181','Lancer', 1957);
insert into car values('KA095477','Toyota', 1998);
insert into car values('KA053408','Honda', 2008);
insert into car values('KA041702','Audi', 2005);
select * from car;
insert into accident values(11,'2015-02-12','Mysore Road');
insert into accident values(12,'2016-11-08','South End Circle');
insert into accident values(13,'2017-10-03','bull Temple Road');
insert into accident values(14,'2017-09-03','Mysore Road');
insert into accident values(15,'2018-06-04','Kanakpura Road');
select * from accident;
insert into owns values('A01','KA052250');
insert into owns values('A02','KA053408');
insert into owns values('A03','KA031181');
insert into owns values('A04','KA095477');
insert into owns values('A05','KA041702');
select * from owns;
insert into participated values('A01','KA052250',11,10000);
insert into participated values('A02','KA053408',12,50000);
insert into participated values('A03','KA031181',13,25000);
insert into participated values('A04','KA095477',14,3000);
insert into participated values('A05','KA041702',15,5000);
 select * from participated;
 update participated set damage_amount=25000 where reg_num='KA053408' and report_num=12;
select * from participated;
insert into accident values(16,'15-MAR-08','Domlur');
select * from accident;
select accident_date, location from accident;

select driver_id from participated where damage_amount >=25000;

select p.driver_id, p.name, c.model from person p, car c , owns o 
where p.driver_id=o.driver_id and o.reg_num=c.reg_num;

select pa.driver_id,p.name,pa.report_num,pa.damage_amount from participated pa, person p, accident a
where pa.driver_id=p.driver_id and pa.report_num=a.report_num;

select pa.driver_id, sum(pa.damage_amount) as total_damage_amount from participated pa ,accident a
where pa.report_num=a.report_num
group by(pa.driver_id);

select driver_id, count(*) as number_of_accidents from participated
group by driver_id having number_of_accidents>=1;

select o.driver_id from owns o
where o.driver_id not in (select pa.driver_id from participated pa);

select max(accident_date) as latest_date_of_accident from accident;

select pa.driver_id, avg(pa.damage_amount) as average_damage_amount from participated pa 
group by(pa.driver_id);

select pa.driver_id,p.name from participated pa,person p 
where pa.driver_id=p.driver_id and pa.damage_amount =(select  max(damage_amount)  from participated) ;

select pa.reg_num,c.model, sum(pa.damage_amount) as total_damage from car c , participated pa
where pa.reg_num=c.reg_num
group by pa.reg_num having total_damage>20000 ; 

create view accidentview(DRIVER_ID,PARTICIPANTS_COUNT,TOTAL_DAMAGE) as select pa.driver_id,count(*),sum(pa.damage_amount) from participated pa
group by pa.driver_id;
select * from accidentview;











