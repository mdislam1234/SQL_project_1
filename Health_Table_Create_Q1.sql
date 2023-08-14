CREATE TABLE sql_intv_q_1 (
   FoodId varchar(100) not null,
   Food varchar(100) not null,
   Date timestamp not null,
   Revenue float not null
);

INSERT INTO sql_intv_q_1(FoodId,Food,Date,Revenue)
VALUES ('123','Sushi','01/01/2022',50),
       ('123','Sushi','02/01/2022',100),
       ('456','Pizza','03/01/2022',70),
       ('789','Pasta','04/01/2022',20),
       ('111','Tofu','01/01/2022',10),
       ('789','Pasta','05/01/2022',90),
       ('789','Pasta','06/01/2022',80),
       ('789','Pasta','07/01/2022',80);


/* Sql server*/
Drop table if exists sql_intv_q_1
	   CREATE TABLE sql_intv_q_1 
	   (FoodId varchar(100),
   Food varchar(100),
   Date datetime,
   Revenue float
);

INSERT INTO sql_intv_q_1
VALUES ('123','Sushi','01/01/2022',50),
       ('123','Sushi','02/01/2022',100),
       ('456','Pizza','03/01/2022',70),
       ('789','Pasta','04/01/2022',20),
       ('111','Tofu','01/01/2022',10),
       ('789','Pasta','05/01/2022',90),
       ('789','Pasta','06/01/2022',80),
       ('789','Pasta','07/01/2022',80);


	   
-----------------------------------------------------------
-- Want to see the answer?
-- Think through it first, then scroll down for the solution!
-----------------------------------------------------------
	   
select *
from sql_intv_q_1


	select *
	from sql_intv_q_1
	where Revenue in (50,80)

	select *
	from sql_intv_q_1
	where Revenue = (select MAX(Revenue) from sql_intv_q_1)


	select *
	from sql_intv_q_1
	where Revenue = (select MAX(Revenue) from sql_intv_q_1 where Food='Pasta')
	
	select *
	from sql_intv_q_1
	where Revenue = (select MAX(Revenue) from sql_intv_q_1 where Food = 'Tofu' )
	
	   

	   Select FoodID, Food, 
	   MAX(Revenue) as Revenue
	   from sql_intv_q_1
	   group by FoodID, Food


	select *
	from sql_intv_q_1 s1
	where Revenue = (select MAX(s2.Revenue )
	from sql_intv_q_1 s2
	where s1.Food=s2.Food)
	order by Revenue



	select *
	from sql_intv_q_1 s1

	select s1.Food, s1.FoodId, s1.Date, s1.Revenue
	from sql_intv_q_1 s1
	left join sql_intv_q_1 s2
	on /*s1.Food=s2.Food and*/ s1.Revenue<s2.Revenue
	where s2.Revenue is Null
	order by s1.Food Asc


	https://database.guide/5-ways-to-select-rows-with-the-maximum-value-for-their-group-in-sql/

	SELECT * 
	FROM sql_intv_q_1  
	WHERE revenue IN
	 (SELECT MAX(revenue) AS revenue 
	 FROM sql_intv_q_1 
	 GROUP BY foodid)

	select MAX(Revenue)
	from sql_intv_q_1
	
	SELECT --Food, FoodID, 
    MAX( Revenue ) AS MaxRevenue
    FROM sql_intv_q_1
    GROUP BY Food, FoodID
    ORDER BY Food;

	select 

/* practice table*/

create table Food
(id varchar(20), Name varchar(50), Date date, Sale int)

Insert into Food values
('1', 'roti', '2020/1/1',  10),
('1', 'roti', '2020/2/1', 20),
('2', 'Egg', '2020/3/1', 30),
('3', 'Meat', '2020/4/1', 25)

select *
from food

/* find the average sale of each food item*/
select id, Name, count(Name), AVG(Sale)
from food
Group by id, Name
Order by id asc
/* find the maximum sale of each food item*/

select id, Name, Name, max(Sale) -- without date
from food
Group by id, Name
Order by id asc


select f1.id, f1.Name, f1.Sale, f1.Date,f2.Date, f2.id, f2.Name, f2.Sale ---- with date
from food f1
left join food f2
on f1.id=f2.id and f1.Sale<f2.Sale
where f2.id is null
order by f1.id asc

with cte as (select id, Name, date, Sale, Rank()------- using rank
   over(partition by id order by Sale desc) as r
   from food)
  select id, name, date, sale
  from cte
  where r=1

select id, name, date, sale ---------using correlated subquery
from food f1
where sale = (select max(f2.sale) 
from food f2 where f1.id=f2.id)
order by id asc

select f1.id, f1.name, f1.date, f1.sale ------ using uncorrelated subquery
from food f1
join (select id, max(sale) as sale  from food group by id) as f2
on f1.id=f2.id and f1.sale=f2.sale
order by id asc
------------------------------------------------------------------------------------
select Name, max(Sale) as MaxSale
from food
group by Name

select f1.Name, f1.Date, f1.Sale
from food f1
where Sale = (select max(f2.Sale)
from food f2
join food f1
on f1.Sale>f2.Sale)


select f1.Name, f1.Date, f1.Sale
from food f1
where Sale = (select max(f2.Sale)
from food f2
where f1.Name=f2.Name)

/*by cte*/
with cte as (
select Name, Date, Sale, 
Rank() over (partition by Name order by sale asc  ) as r
from Food)
select Name, Date, Sale
from cte where r=1
order by sale asc

with cte as (
select Name, Date, Sale, 
Rank() over (partition by Name order by sale  ) 
from Food)
select Name, Date, Sale
from cte 


select Name, Date, Sale
from food f1
where Sale = (select max(f2.Sale)
from food f2
where f1.Name=f2.Name)


select f1.id, f1.Name, f1.Date, f1.Sale
from Food f1
join Food f2 
on f1.Name=f2.Name 

select f1.id, f1.Name, f1.Date, f1.Sale
from Food f1
join Food f2 
on f1.Sale > f2.Sale

select f1.id, f1.Name, f1.Date, f1.Sale
from Food f1
join Food f2 
on f1.Sale < f2.Sale

select f1.id, f1.Name, f1.Date, f1.Sale
from Food f1
left join Food f2 
on f1.Sale > f2.Sale

select f1.id, f1.Name, f1.Date, f1.Sale
from Food f1
left join Food f2 
on f1.Sale < f2.Sale

select f1.id, f1.Name, f1.Date, f1.Sale
from Food f1
left join Food f2 
on f1.Name=f2.Name









-----------------------------------
-- A little further
-----------------------------------












----------------
-- Solution 1 --
----------------

with main as
(
   select foodId,
	      food,
          date,
	      revenue
   from sql_intv_q_1
   where 1=1
),

reduction as
(
    select foodId, 
    max(revenue) as max_revenue
    from main
    group by foodId  
)

select t1.*
from main as t1
inner join reduction as t2
  on t1.foodid = t2.foodid
 and t1.revenue = t2.max_revenue
 
-------------------- 
-- Solution 2 --
--------------------

with main as
(
   select foodId,
	      food,
          date,
	      revenue
   from sql_intv_q_1
   where 1=1
)

select foodid,
       food,
	   date,
	   revenue
from
(
  select foodid,
	     food,
	     date,
	     revenue,
         max(revenue) over (partition by foodid) as max_rev
  from main
) t1	
where 1=1
  and max_rev = revenue
