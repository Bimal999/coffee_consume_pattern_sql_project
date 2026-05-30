-- coffee sales data analysis using sql---
------------------------------------------------------
-------------------------------------------------------
create database coffee_project;

---------------------------------------------------------
-- creates tables names city, customer, sales and products
----------------------------------------------------------

create table city(
	city_id	int primary key,
	city_name	varchar(10),
	population	int,
	estimated_rent float,	
	city_rank float
);


create table customers(
customer_id int primary key,
customer_name	varchar(20),
city_id int
);


create table products(
product_id int primary key,	
product_name	varchar(50),
price int
);


create table sales(
sale_id	int primary key,
sale_date varchar(20),
product_id	int,
customer_id	int,
total	float,
rating float
);


select * from city;
truncate table city;

-- how many people in each city are estimated to consume coffee,given that 25% of the population does?

select 
	city_name,
	round(((population::numeric )*0.25)/1000000,2)||' In millions' as estimated_consumer
from city
	order by 2 desc;
--- business problems
-- the company doesn't know market size in each city without understanding how many people could consume coffee,
-- expansion become a guess work

-- business impact 
-- helpe the potential demand in each city 
-- identity cities with larger target audience
-- avoide the opening the outlet where low coffee consumption potential

-- what is the total revenue generated from coffee sales across all cities in the last quarter of 2023?

select * from sales;
alter table sales
drop constraint fk_customer;


alter table sales
add constraint fk_product
foreign key (product_id) 
references products(product_id);

alter table sales
add constraint fk_customer
foreign key(customer_id)
references customers(customer_id);

alter table customers
add constraint fk_city
foreign key(city_id)
references city(city_id);


-- what is the total revenue generated from coffee sales across all cities in the last quarter of 2023?

		select 
			ci.city_name,
			extract( year from to_date(sale_date, 'dd/mm/yy')) as years,
			extract( quarter from to_date(sale_date, 'dd/mm/yy')) as quarters,
			sum(s.total) as total_revenue
		from sales s
		join customers c
		on 
		s.customer_id=c.customer_id
		
		join city ci
		on
		ci.city_id=c.city_id

		
where extract( year from to_date(sale_date, 'dd/mm/yy'))=2023
and extract( quarter from to_date(sale_date, 'dd/mm/yy'))=4
group by 1,2,3
order by 4 desc

-------- or
-- for more optimization
alter table sales 
alter column sale_date type date
using to_date(sale_date, 'dd/mm/yyy');
-------------------------------------------------
select 
	ci.city_name,
	extract(year from sale_date) as years,
	extract( quarter from sale_date) as quarter,
	sum(s.total) as total_revenue
from sales s

join customers c
on 
s.customer_id = c.customer_id

join city ci
on 
c.city_id=ci.city_id
where extract(year from sale_date)=2023
and extract( quarter from sale_date)=4
group by 1,2,3
order by 4 desc;

--------------------------------------------------------

-- q3. how many unit of each coffee product have been sold?

select * from sales;
select * from products;

select 
	p.product_name,
	count(*) as number_of_unit
from sales s

join products p
on
s.product_id=p.product_id

group by 1
order by 2 desc;


--------------------------------------------------------------------
-- a4 what is average sales amount per customer in each city?
select * from city;
with cte as(
		select 
			ci.city_name,
			ci.population,
			sum(total) as total_amount
		from sales s
		
		join customers c
		on
		s.customer_id=c.customer_id
		
		join city ci
		on
		c.city_id=ci.city_id
		group by 1,2
		order by 3 desc
	)

select city_name,
		(total_amount/population) as avg_sales_per_customer 
		from cte
--------------- or -------------------


SELECT
    ci.city_name,
    'Rs.'||round(SUM(s.total)::numeric / count(distinct s.customer_id),2) as sales_per_customer 
FROM sales s
JOIN customers c
    ON s.customer_id = c.customer_id
JOIN city ci
    ON c.city_id = ci.city_id
GROUP BY ci.city_name
order by SUM(s.total) / count(distinct s.customer_id) 

--------------------------------------------------------------------------
-- q5. what are the top 3 selling products in each city based on the sales volume?

with cte as(
	select 
		ci.city_name,
		p.product_name,
		count(sale_id) as total_sales,
		rank() over(partition by ci.city_name order by count(sale_id) desc) as rank
	from sales s
	
	join customers c
	on 
	s.customer_id=c.customer_id
	
	join products p
	on
	s.product_id=p.product_id
	
	join city ci
	on 
	c.city_id= ci.city_id
	
	group by 1,2
)

select city_name, product_name, total_sales
from cte 
where rank<4

----------------------------------------------------------------------------------
-- question 7 how many uniques customers are there in in ecah city who have purchase coffee products?
select 
	ci.city_name,
	count(distinct c.customer_name) as unique_customer
from sales s
join customers c
on 
s.customer_id=c.customer_id

join city ci
on 
c.city_id=c.city_id
group by 1
order by 2

----------------------------------------------------------------------------------------
--8 find each city and thier average sale per customer and avg rent per customer


SELECT
    ci.city_name,
    ROUND(
        SUM(s.total)::numeric /
        COUNT(DISTINCT c.customer_id),
        2
    ) AS avg_sales_per_customer,
    ROUND(
        ci.estimated_rent::numeric /
        COUNT(DISTINCT c.customer_id),
        2
    ) AS avg_rent_per_customer
FROM sales s
JOIN customers c
    ON s.customer_id = c.customer_id
JOIN city ci
    ON c.city_id = ci.city_id
GROUP BY
    ci.city_name,
    ci.estimated_rent
ORDER BY avg_sales_per_customer DESC;
 

-------------------------------------------------------------------------------------------------------------------------
-- Q9. Sales growth rate : calculate the percentage growth ( or decline ) in sales over different time periods (monthly)

with cte_sales_difference as(
		with cte_sales_growth as(
					select 
						ci.city_name,
						extract(year from sale_date) as years,
						extract(month from sale_date) as monthly_details,
						sum(total) as total_sale
					from sales s
					join customers c
					on
					s.customer_id=c.customer_id
		
					join city ci
					on
					c.city_id=ci.city_id
					group by 1,2,3
					order by 1,2,3
				)
		 select 
		 	city_name,
			 years,
			 monthly_details,
			 total_sale,
			 lag(total_sale) over(partition by city_name order by years, monthly_details) as previous_month_sale
		 from cte_sales_growth
	)
select 
	city_name,
	years,
	monthly_details,
	total_sale,
	round((((total_sale-previous_month_sale)/previous_month_sale)*100)::numeric,2) as monthly_growth
from cte_sales_difference;


---- or ------------------------------------

WITH monthly_sales AS (
    SELECT
        ci.city_name,
        DATE_TRUNC('month', s.sale_date) AS sales_month,
        SUM(s.total) AS total_sales
    FROM sales s
    JOIN customers c
        ON s.customer_id = c.customer_id
    JOIN city ci
        ON c.city_id = ci.city_id
    GROUP BY
        ci.city_name,
        DATE_TRUNC('month', s.sale_date)
),

sales_growth AS (
    SELECT
        city_name,
        sales_month,
        total_sales,
        LAG(total_sales) OVER (
            PARTITION BY city_name
            ORDER BY sales_month
        ) AS previous_month_sales
    FROM monthly_sales
)

SELECT
    city_name,
    sales_month,
    total_sales,
    previous_month_sales,
    ROUND(
        (
           ( (total_sales - previous_month_sales)
            / NULLIF(previous_month_sales, 0)
        ) * 100)::numeric,
        2
    ) AS monthly_growth_pct
FROM sales_growth
ORDER BY
    city_name,
    sales_month;
 