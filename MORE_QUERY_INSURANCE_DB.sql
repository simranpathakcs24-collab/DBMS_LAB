use insurance;
select * from car order by year asc;

select pa.reg_num, c.model, count(*) as number_of_accidents from participated pa,car c
where c.reg_num=pa.reg_num and c.model="lancer"
group by pa.reg_num;

select count(*) as number_of_accidents_in2017 from accident where accident_date  like "2017%" ;

select * from participated order by damage_amount desc;

select avg(damage_amount) as average_damage_amount from participated;

delete from participated pa where pa.damage_amount<(select avg(p.damage_amount) from participated p);

select p.name from person p, participated pa 
where pa.driver_id=p.driver_id and pa.damage_amount>(select avg(damage_amount) from participated);

select max(damage_amount) as maximum_damage from participated ;