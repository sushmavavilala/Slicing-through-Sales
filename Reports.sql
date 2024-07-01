-- Reports

-- 1. Daily Trend for Total Orders
SELECT DATENAME(DW, order_date) AS Order_day, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

-- 2. Monthly Trend for Total Orders
SELECT DATENAME(MONTH, order_date) AS Month_name, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_orders DESC

-- 3. Percentage of sales by Pizza Category
SELECT pizza_category, SUM(total_price)*100 / (SELECT SUM(total_price) FROM pizza_sales) AS PCT
FROM pizza_sales
GROUP BY pizza_category

-- 4. Percentage of sales by Pizza Category for January
SELECT pizza_category, SUM(total_price) AS Total_sales, SUM(total_price)*100 / 
(SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) AS PCT
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category

-- 5. Percentage of sales by Pizza Category for 1st Quarter
SELECT pizza_category, SUM(total_price) AS Total_sales, SUM(total_price)*100 / 
(SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(QUARTER, order_date) = 1) AS PCT
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY pizza_category

-- 6. Percentage of Sales by Pizza Size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_sales, CAST(SUM(total_price)*100 / 
(SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC

-- 7. Percentage of sales by Pizza Size for 1st Quarter
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_sales, CAST(SUM(total_price)*100 / 
(SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(QUARTER, order_date) = 1) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY pizza_size
ORDER BY PCT DESC

-- 8. Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) AS total_pizzas FROM pizza_sales
GROUP BY pizza_category

-- 9. Top 5 Best sellers by Revenue, Total Quantity and Total Orders
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC


-- . Bottom 5 Worst sellers by Revenue, Total Quantity and Total Orders
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC