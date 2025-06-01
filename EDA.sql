-- Creating Database

create database monday_coffee;

-- Creating Table Schemas

CREATE TABLE city
(
	city_id	INT PRIMARY KEY,
	city_name VARCHAR(15),	
	population	BIGINT,
	estimated_rent	FLOAT,
	city_rank INT
);

CREATE TABLE customers
(
	customer_id INT PRIMARY KEY,	
	customer_name VARCHAR(25),	
	city_id INT,
	CONSTRAINT fk_city FOREIGN KEY (city_id) REFERENCES city(city_id)
);

CREATE TABLE products
(
	product_id	INT PRIMARY KEY,
	product_name VARCHAR(35),	
	Price float
);

CREATE TABLE sales
(
	sale_id	INT PRIMARY KEY,
	sale_date	date,
	product_id	INT,
	customer_id	INT,
	total FLOAT,
	rating INT,
	CONSTRAINT fk_products FOREIGN KEY (product_id) REFERENCES products(product_id),
	CONSTRAINT fk_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
);

-- Imported Data Successfully 

-- How many people in each city are estimated to consume coffee? (given that 25% of the population does)

select city_name, round(population * 0.25/1000000, 2) as consumers_in_millions 
from city
order by population desc;

-- What is the total revenue generated across all cities in the last quarter of 2023?

select ci.city_name, sum(s.total) as revenue
from sales as s join customers as c on s.customer_id = c.customer_id 
				join city as ci on ci.city_id = c.city_id
where year(sale_date) = 2023 and quarter(sale_date) = 4
group by ci.city_name
order by revenue desc;

-- Count the total number of orders for each product.

select p.product_name, count(s.sale_id) as total_orders
from products as p
left join
sales as s
on s.product_id = p.product_id
group by p.product_name
order by total_orders desc;

-- Average Sales Amount per City and Per Customer in each City.

select ci.city_name, sum(s.total) as revenue, count(distinct(s.customer_id)) as total_customer,
					round(sum(s.total) / count(distinct(s.customer_id)), 2) as avg_bill
from sales as s join customers as c on s.customer_id = c.customer_id 
				join city as ci on ci.city_id = c.city_id
group by ci.city_name order by revenue desc;



-- Provide a list of cities along with their populations and estimated coffee consumers.

with city_table as (
    select city_name, round((population * 0.25) / 1000000, 2) as coffee_consumers
    from city
),
customers_table as (
    select ci.city_name, count(distinct c.customer_id) as unique_cx
    from sales as s
    join customers as c on c.customer_id = s.customer_id
    join city as ci on ci.city_id = c.city_id
    group by ci.city_name
)
select 
    customers_table.city_name,
    city_table.coffee_consumers as coffee_consumer_in_millions,
    customers_table.unique_cx
from city_table
join customers_table on city_table.city_name = customers_table.city_name;

-- What are the top 3 selling products in each city based on sales volume?

select * 
from (
    select ci.city_name, p.product_name, count(s.sale_id) as total_orders,
        dense_rank() over ( partition by ci.city_name order by count(s.sale_id) desc
        ) as product_rank
    from sales as s
    join products as p on s.product_id = p.product_id
    join customers as c on c.customer_id = s.customer_id
    join city as ci on ci.city_id = c.city_id
    group by ci.city_name, p.product_name
) as ranked_products
where product_rank <= 3;


-- Calculate the percentage growth (or decline) in sales over different time periods (monthly)

with monthly_sales as (
    select ci.city_name, extract(month from sale_date) as month, extract(year from sale_date) as year,
           sum(s.total) as total_sale
    from sales as s
    join customers as c on c.customer_id = s.customer_id
    join city as ci on ci.city_id = c.city_id
    group by ci.city_name, month, year
    order by ci.city_name, year, month
),
growth_ratio as (
    select city_name, month, year, total_sale as cr_month_sale,
        lag(total_sale, 1) over ( partition by city_name order by year, month) as last_month_sale
    from monthly_sales
)
select city_name, month, year, cr_month_sale, last_month_sale,
    round((cr_month_sale - last_month_sale) / last_month_sale * 100, 2) as growth_ratio
from growth_ratio
where last_month_sale is not null;

-- How many unique customers are there in each city who have purchased coffee products?

select ci.city_name, count(distinct c.customer_id) as unique_cx
from city as
 ci left join customers as c on c.city_id = ci.city_id
join sales as s on s.customer_id = c.customer_id
where s.product_id in (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14)
group by ci.city_name;





