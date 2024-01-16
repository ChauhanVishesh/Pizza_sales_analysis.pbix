CREATE DATABASE pizza_sales_db;
USE pizza_sales_db;

SELECT * FROM sales_data;

ALTER TABLE sales_data
ADD COLUMN order_dates date;

UPDATE sales_data
SET order_dates = str_to_date(order_date,"%d-%m-%Y");

ALTER TABLE sales_data
DROP COLUMN order_date;

ALTER TABLE sales_data
MODIFY order_dates date after quantity;

                                                    /*KPI RQUIREMENTS*/

#TOTAL REVENUE
SELECT ROUND(SUM(total_price),2) AS Total_Revenue
FROM sales_data;

#AVERAGE ORDER VALUE
SELECT ROUND(SUM(total_price) / COUNT(DISTINCT order_id),2) AS AVG_ORDER_VALUE
FROM sales_data;

#TOTAL PIZZAS SOLD
SELECT SUM(quantity) AS total_pizzas_sold
FROM sales_data;

#TOTAL ORDERS PLACED
SELECT COUNT(DISTINCT(order_id)) AS total_orders_placed
FROM sales_data;

#AVERAGE PIZZAS PER ORDER
SElECT SUM(quantity) / COUNT(DISTINCT order_id)
AS avg_pizzas_per_order
FROM sales_data;

                                                  /*CHART REQUIREMENTS*/    
#DAILY TREND FOR TOTAL ORDERS
SELECT DAYNAME(order_dates) as day_of_the_week,
COUNT(DISTINCT order_id) AS order_per_day
FROM sales_data
GROUP BY 1
ORDER BY 2 DESC;

#MONTHLY TREND FOR ORDERS
SELECT MONTHNAME(order_dates),
COUNT(DISTINCT order_id) AS monthly_order
FROM sales_data
GROUP BY 1
ORDER BY 2 DESC;

#PERCENTAGE OF SALES BY PIZZA CATEGORY
SELECT pizza_category,ROUND(SUM(total_price),2),
ROUND(SUM(total_price)*100/
(SELECT SUM(total_price) FROM sales_data),2)
AS sales_percentage
FROM sales_data
GROUP BY 1
ORDER BY 2 DESC;

#PERCENTAGE OF SALES BY PIZZA SIZE
SELECT pizza_size,ROUND(SUM(total_price),2),
ROUND(SUM(total_price)*100/
(SELECT SUM(total_price) FROM sales_data),2)
AS sales_percentage
FROM sales_data
GROUP BY 1
ORDER BY 2 DESC;

/*TOP 5 SELLERS*/
#BY REVENUE
SELECT pizza_name,SUM(total_price) AS revenue
FROM sales_data
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

#BY TOTAL QUANTITY
SELECT pizza_name,SUM(quantity) AS quantity_sold
FROM sales_data
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

#BY TOTAL ORDERS
SELECT pizza_name,COUNT(DISTINCT order_id) AS total_orders
FROM sales_data
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

/*BOTTOM 5 SELLERS*/
#BY REVENUE
SELECT pizza_name,ROUND(SUM(total_price),2) AS revenue
FROM sales_data
GROUP BY 1
ORDER BY 2 ASC
LIMIT 5;

#BY TOTAL QUANTITY
SELECT pizza_name,SUM(quantity) AS quantity
FROM sales_data
GROUP BY 1
ORDER BY 2 ASC
LIMIT 5;

#BY TOTAL ORDERS
SELECT pizza_name,COUNT(DISTINCT order_id) AS total_order
FROM sales_data
GROUP BY 1
ORDER BY 2 ASC
LIMIT 5;


















