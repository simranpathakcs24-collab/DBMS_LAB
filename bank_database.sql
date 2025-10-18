create database bankdatabase;
use bankdatabase;
create table branch(branchname varchar(20),branchcity varchar(15),assets decimal(4),primary key(branchname));
create table bankaccount(accno int,branchname varchar(20),balance decimal(4),primary key(accno), foreign key(branchname) references branch (branchname));
create table bankcustomer(customername varchar(10),customerstreet varchar(15),primary key(customername));
alter table bankcustomer add customercity varchar(20);
create table depositer(customername varchar(10),accno int,primary key(customername,accno) ,foreign key (customername) references bankcustomer (customername), 
foreign key (accno) references bankaccount(accno));
create table loan(loannumber int,branchname varchar(20),amount decimal(4),primary key(loannumber), foreign key (branchname) references branch(branchname)); 
alter table branch modify column assets decimal(10,2);

insert into branch values("sbi-chamarajpet","bangalore",50000),("sbi-residency road","bangalore",100000),("sbi-shivaji road","mumbai",20000),
("sbi-parliament road","delhi",40000),("sbi-jantarmantar","delhi",20000);
alter table loan modify column amount decimal(10,2);
alter table bankaccount modify column balance decimal(10,2);
update branch set assets=60000 where branchname="sbi-parliament road";
update branch set assets=200000 where branchname="sbi-shivaji road";
update branch set assets=300000 where branchname="sbi-jantarmantar";
select * from branch;

insert into bankaccount values(12345,"sbi-chamarajpet",30000),(67890,"sbi-residency road",45000),(54321,"sbi-shivaji road",10000),
(18975,"sbi-shivaji road",56000),(11345,"sbi-chamarajpet",45000),(89700,"sbi-chamarajpet",8000),(67845,"sbi-jantarmantar",10000),
(09321,"sbi-chamarajpet",56000),(56785,"sbi-residency road",30000),(45645,"sbi-parliament road",35000),(16545,"sbi-jantarmantar",80000),
(18976,"sbi-chamarajpet",28000);
select * from bankaccount;

insert into bankcustomer values ("anuj","temple road","bangalore"),("anurag","south circle","bangalore"),("rishi","gandhi road","mumbai"),
("veer","shahjahan road","delhi");
insert into bankcustomer values("anshuman","nehru road","delhi");
select * from bankcustomer;

insert into depositer values("anuj",12345),("anurag",67890),("rishi",54321),("veer",18975),("anurag",11345),("anurag",56785);
select * from depositer;

insert into loan values(1,"sbi-chamarajpet",20000),(2,"sbi-chamarajpet",100000),(3,"sbi-residency road",45000),(4,"sbi-jantarmantar",10000),
(5,"sbi-parliament road",400000),(6,"sbi-shivaji road",56000);
select * from loan;

select branchname , assets as assets_in_lakhs from branch;       

select d.customername,count(*) as number_of_customers from depositer d , bankaccount ba 
where d.accno=ba.accno group by (d.customername) having number_of_customers>=2; 

create view loanview (BRANCH , TOTAL_LOAN_AMOUNT) as select branchname,sum(amount) from loan group by branchname;
select * from loanview; 

select distinct d.customername from depositer d,bankaccount ba where d.accno=ba.accno and ba.branchname in (select br.branchname from branch br where br.branchcity="mumbai") ;
                                                                                                                                                                                                                             
select bc.customername from bankcustomer bc where bc.customername not in ( select distinct d.customername from depositer d);

select de.customername,de.accno from bankaccount ba , depositer de where de.accno=ba.accno 
and ba.branchname  in ( select  b.branchname from  branch b where b.branchcity="bangalore");

select branchname from branch where assets > all(select br.assets from branch br where br.branchcity="bangalore");

update bankaccount set balance=balance+(0.05*balance) ;
select * from bankaccount; 

delete from bankaccount ba where ba.branchname in (select br.branchname from branch br where br.branchcity="mumbai");

 


