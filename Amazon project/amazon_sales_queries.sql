select *
FROM amazon_sales_dataset;

ALTER TABLE amazon_sales_dataset
MODIFY Column `order_date` Date;

SELECT product_category, Year(order_date), min(total_revenue), max(total_revenue), Round(avg(total_revenue), 2) AS avg_revenue
FROM amazon_sales_dataset
GROUP BY product_category, Year(order_date)
ORDER BY 4 desc;

SELECT product_category, Year(order_date), ROUND(SUM(total_revenue), 2) AS Sum_revenue
FROM amazon_sales_dataset
GROUP BY product_category, Year(order_date)
ORDER BY sum_revenue desc;

WITH product_year (product, year, sum_revenue) AS 
(
SELECT product_category, Year(order_date), ROUND(SUM(total_revenue), 2)
FROM amazon_sales_dataset
GROUP BY product_category, Year(order_date)
), product_year_rank AS
(
SELECT *, DENSE_RANK() OVER (PARTITION BY year ORDER BY sum_revenue desc) AS Ranking
FROM product_year
)
SELECT *
FROM product_year_rank
WHERE Ranking <= 3;


SELECT product_category, Sum(quantity_sold) AS total_quantity_sold, 
ROUND(avg(Discounted_price), 2) AS avg_discount,
ROUND(avg(total_revenue), 2) AS avg_revenue
FROM amazon_sales_dataset
GROUP BY product_category
ORDER BY avg(total_revenue) desc;

SELECT customer_region, Sum(quantity_sold) AS total_quantity_sold, 
ROUND(sum(total_revenue), 2) AS sum_revenue
FROM amazon_sales_dataset
GROUP BY customer_region
ORDER BY sum_revenue desc;

SELECT Payment_method, Sum(quantity_sold) AS total_quantity_sold, 
ROUND(sum(total_revenue), 2) AS sum_revenue
FROM amazon_sales_dataset
GROUP BY payment_method
ORDER BY sum_revenue desc;

WITH order_2022 AS
(
SELECT order_date, product_category, customer_region, payment_method, total_revenue
FROM amazon_sales_dataset
WHERE order_date LIKE '2022%'
)
SELECT *, DENSE_RANK() OVER (ORDER BY total_revenue desc) AS 2022_Ranking
FROM order_2022
ORDER BY 2022_ranking;

SELECT order_date, product_category, customer_region, payment_method, total_revenue
FROM amazon_sales_dataset
WHERE order_date LIKE '2023%'
ORDER BY 5 desc;

SELECT payment_method, ROUND(avg(rating), 2) AS avg_rating, ROUND(avg(total_revenue),2) AS avgtotal_revenue
FROM amazon_sales_dataset
GROUP BY payment_method
ORDER BY avg_rating desc;

SELECT Customer_region, ROUND(avg(rating), 2) AS avg_rating, ROUND(sum(total_revenue),2) AS sumtotal_revenue
FROM amazon_sales_dataset
GROUP BY customer_region
ORDER BY avg_rating desc;

SELECT SUBSTRING(`Order_date`, 1, 7) AS `month`, product_category, customer_region,
payment_method, total_revenue 
FROM amazon_sales_dataset
WHERE product_category = 'books' AND customer_region = 'North america';

SELECT product_category, ROUND(avg(rating), 2) AS avg_rating, ROUND(sum(total_revenue),2) AS sumtotal_revenue
FROM amazon_sales_dataset
WHERE YEAR(order_date) = 2023
GROUP BY product_category
ORDER BY avg_rating desc;
