select * from Retail_Sales

--/ Data Cleaning/-- 

delete from retail_sales
where transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null



-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * 
from Retail_Sales
where sale_date = '2022-11-05'


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

select *
from Retail_Sales
where category = 'clothing'
and quantiy >= 4
and MONTH(sale_date) = 11 and YEAR(sale_date) = 2022

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category,
SUM(total_sale)
from Retail_Sales
group by category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select AVG(age)
from Retail_Sales
where category  = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select *
from Retail_Sales
where total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select 
gender,
category,
COUNT(*)
from Retail_Sales
group by gender, category
order by gender

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select top 1 YEAR(sale_date),
MONTH(sale_date),
AVG(total_sale)
from Retail_Sales
group by MONTH(sale_date), YEAR(sale_date)
order by AVG(total_sale) DESC

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select top 5 customer_id,
SUM(total_sale),
rank() over(order by sum(total_sale) DESC)
from Retail_Sales
group by customer_id
order by SUM(total_sale) DESC

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select category,
count(distinct customer_id)
from Retail_Sales
group by category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with Shifts AS(
select *,
	case
		when datepart(hour, sale_time) <= 12 then 'Morning'
		when datepart(hour, sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening' end as shift
from Retail_Sales
)
select shift,
count(*)
from shifts
group by shift

