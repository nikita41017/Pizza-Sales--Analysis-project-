create database pizzadb

select * from pizza_sales

#Q1. TOTAL REVENUE
SELECT SUM(total_price) 
from pizza_sales

#2. Average Order Value
SELECT SUM(total_price) /  COUNT(DISTINCT order_id) as Avg_Order_Value
from pizza_sales

#3. total pizza sold
SELECT SUM(quantity) AS Total_pizza_sold 
FROM pizza_sales

#4. total order placed
SELECT COUNT(DISTINCT order_id) as Total_orders 
FROM pizza_sales

#5. Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS AVG_PIZZA_per_OREDER
FROM pizza_sales

#CHARTS REQUIREMENT #ERROR 
#1.Daily trend for total orders:
SELECT DAYNAME(ORDER_DATE) AS ORDER_DAY, COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
FROM PIZZA_SALES
GROUP BY DAYNAME(ORDER_DATE)

SELECT DAYNAME(ORDER_DATE) AS ORDER_DAY,
       COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
FROM PIZZA_SALES
GROUP BY DAYNAME(ORDER_DATE), DAYOFWEEK(ORDER_DATE)
ORDER BY DAYOFWEEK(ORDER_DATE);


#2 hourly trend 
select HOUR(ORDER_TIME)AS ORDER_HOURS, COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
FROM PIZZA_SALES
GROUP BY HOUR(ORDER_TIME)
ORDER BY (TOTAL_ORDERS)

#3. PERCENTAGE of sales by pizza category:
SELECT pizza_category, SUM(total_price) AS TOTAL_SALES, SUM(TOTAL_PRICE)* 100 /
 (SELECT SUM(total_price) from pizza_sales ) as PCT
from pizza_sales 
GROUP BY pizza_category;

#4. percentage of sales by pizza size: 
SELECT pizza_size, SUM(total_price) as Total_Sales, SUM(total_price) * 100 /
(SELECT sum(total_price) from pizza_sales) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC

#5. total pizzas sold by pizza category:
SELECT pizza_category, SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_category

#6. top 5 best sellers by total pizzas sold:
SELECT  pizza_name, sum(quantity) AS Total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY sum(quantity) desc
limit 5

#7 bottom 5 worst sellers by total sold:
SELECT pizza_name, SUM(QUANTITY) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY sum(quantity) asc
limit 5 