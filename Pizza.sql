select * from pizza_sales

select COUNT (*) as Total_Sales_Count from pizza_sales

--Total Revenue
select ROUND(SUM(total_price),2) as Total_Revenue from pizza_sales

--Average order value
select ROUND(SUM(total_price)/COUNT(distinct order_id),2) as Avg_order_value from pizza_sales

--Total pizzas sold
select SUM(quantity) as Total_pizzas_sold from pizza_sales

--Total orders
select COUNT(distinct order_id) as Total_Orders from pizza_sales

--Averge pizzas per order
select cast(cast(SUM(quantity) as decimal(10,2))/COUNT(distinct order_id) as decimal(10,2)) as Avg_pizzas_per_order from pizza_sales

--daily trend
select datename(dw,order_date) as Order_day,count(distinct order_id) as Total_orders
from pizza_sales
group by datename(dw,order_date)
order by count(distinct order_id) desc

--monthly trend
select MONTH(order_date) Month,datename(MONTH,order_date) as Order_month,count(distinct order_id) as Total_orders
from pizza_sales
group by datename(MONTH,order_date),MONTH(order_date)
order by count(distinct order_id) desc

--Total sales and percentage of sales by pizza category
select pizza_category,ROUND(SUM(total_price),2) as Total_Sales,
ROUND(SUM(total_price)*100/(select SUM(total_price) from pizza_sales),2) as PCT
from pizza_sales
group by pizza_category 


--Total sales and percentage of sales by pizza size
select pizza_size,
cast(SUM(total_price) as decimal(10,2)) as Total_Sales,
cast(SUM(total_price)*100/(select SUM(total_price) from pizza_sales) as decimal(10,2)) as PCT
from pizza_sales
--where DATEPART(QUARTER,order_date)=1
group by pizza_size 
order by pizza_size

--Top 5 pizzas by revenue
select top 5 pizza_name,SUM(total_price) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue desc
--Bottom 5 pizzas by revenue
select top 5 pizza_name,SUM(total_price) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue asc

--Top 5 pizzas by quantity
select top 5 pizza_name,SUM(quantity) as Total_Quantity
from pizza_sales
group by pizza_name
order by Total_Quantity desc
--Bottom 5 pizzas by quantity
select top 5 pizza_name,SUM(quantity) as Total_Quantity
from pizza_sales
group by pizza_name
order by Total_Quantity asc

--Top 5 pizzas by total orders
select top 5 pizza_name,COUNT(distinct order_id) as Total_orders
from pizza_sales
group by pizza_name
order by Total_orders desc
--Bottom 5 pizzas by total orders
select top 5 pizza_name,COUNT(distinct order_id) as Total_orders
from pizza_sales
group by pizza_name
order by Total_orders asc
