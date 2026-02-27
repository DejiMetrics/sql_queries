........DATA CLEANING 

CREATE TABLE `chocolate_2` (
  `Sales Person` text,
  `Country` text,
  `Product` text,
  `Date` text,
  `Amount` text,
  `Boxes Shipped` int DEFAULT NULL,
  row_num INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO chocolate_2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY 'sales person', country, product, 'date', amount, 'boxes shipped') AS row_num
FROM chocolate_w;


SELECT *
FROM chocolate_2
ORDER BY 2;

SELECT `date`,
str_to_date(`date`, '%d/%m/%Y')
FROM chocolate_2;

UPDATE chocolate
SET `date` = str_to_date(`date`, '%d/%m/%Y');

ALTER TABLE chocolate
MODIFY Column `date` DATE;

SELECT *
FROM chocolate_2
ORDER BY 1;

UPDATE chocolate_2 c
JOIN chocolate o
	ON c.product = o.product AND c.date = o.date
SET c.amount = o.amount;

SELECT Amount,
CONCAT('$', REPLACE(Amount, '$', ' ')) AS 'Amount ($)'
FROM chocolate_2;


UPDATE chocolate_2
SET amount = REPLACE(Amount, '$', ' ');

ALTER TABLE chocolate_2
RENAME Column `Amount` TO `Amount ($)`;

UPDATE Chocolate_2
SET `amount ($)` = trim(`Amount ($)`);

UPDATE chocolate_2
SET `Amount ($)` = REPLACE(`Amount ($)`, ' ', '');

SELECT *
FROM chocolate_2
WHERE `boxes shipped` IS NOT NULL;

SELECT *
FROM chocolate_2
ORDER BY 1;

........HIGHEST REVENUE GENERATED

SELECT MAX(`Amount ($)`)
FROM chocolate_2;


.......SALES PERFORMANCE BY COUNTRY/YEAR

SELECT Country, product, YEAR(date), ROUND(SUM(`Amount ($)`), 2) AS TOTAL_REVENUE, SUM(`Boxes Shipped`),
dense_rank() OVER (PARTITION BY YEAR(date) ORDER BY ROUND(SUM(`Amount ($)`), 2) DESC) AS ranking
FROM chocolate_2
GROUP BY country, YEAR(date), product
ORDER BY YEAR(date) DESC;


.......TOTAL_REVENUE_PER_PRODUCT_PER_YEAR;

SELECT Country, product, YEAR(date), ROUND(SUM(`Amount ($)`), 2) AS TOTAL_REVENUE_PER_PRODUCT_PER_YEAR
FROM chocolate_2
GROUP BY country, YEAR(date), product
ORDER BY ROUND(SUM(`Amount ($)`), 2) DESC;

SELECT MIN(date), MAX(date)
c

......TREND OF REVENUE GROWTH PER YEAR;

SELECT YEAR(date), ROUND(SUM(`Amount ($)`), 2) AS TOTAL_REVENUE_PER_YEAR
FROM chocolate_2
GROUP BY YEAR(date)
ORDER BY YEAR(date) DESC;

........SALES PERFORMANCE BY SALES PERSON;

SELECT `sales person`, count(product) AS total_orders,
	ROUND(sum(`Amount ($)`), 2) AS total_revenue,
    sum(`Boxes Shipped`) AS Total_boxes_shipped,
    ROUND(avg(`Amount ($)`), 2) AS avg_revenue,
    ROUND(avg(`Amount ($)` / `Boxes Shipped`), 2) AS avg_price_per_box
FROM chocolate_2
GROUP BY `sales person`
ORDER BY total_revenue desc;
    

SELECT `sales person`, product, YEAR(date),
	ROUND((`Amount ($)` / `Boxes Shipped`), 2) AS revenue_per_box
FROM chocolate_2
ORDER BY revenue_per_box desc;

SELECT *
FROM chocolate_2;

ALTER TABLE Chocolate_2
DROP Column row_num;

SELECT `sales person`, country, product, `Amount ($)`,
substring(Date, 6,2) AS Month
FROM chocolate_2
ORDER BY 1;