use SampleSales;

--Dataset Overview

--Number of Records
SELECT count(*) as Records FROM shopify_sales

--Number of Column
select count(COLUMN_NAME) as Column_Number from INFORMATION_SCHEMA.COLUMNS

--Column Name and Data Type
select COLUMN_NAME, DATA_TYPE from INFORMATION_SCHEMA.COLUMNS

--Sample Data
select top(5) * from shopify_sales

--Check NULL
select  'order_id' as Column_Name,count(*) as 'Number of Nulls' from shopify_sales
where order_id is null
union
select  'order_date' as Column_Name,count(*) as 'Number of Nulls' from shopify_sales
where order_date is null
union
select  'customer_id' as Column_Name,count(*) as 'Number of Nulls' from shopify_sales
where customer_id is null
union
select  'product_id' as Column_Name,count(*) as 'Number of Nulls' from shopify_sales
where product_id is null
union
select  'product_category' as Column_Name,count(*) as 'Number of Nulls' from shopify_sales
where product_category is null
union
select  'product_price' as Column_Name,count(*) as 'Number of Nulls' from shopify_sales
where product_price is null
union
select  'discount_percent' as Column_Name,count(*) as 'Number of Nulls' from shopify_sales
where discount_percent is null
union
select  'quantity' as Column_Name,count(*) as 'Number of Nulls' from shopify_sales
where quantity is null
union
select  'customer_country' as Column_Name,count(*) as 'Number of Nulls' from shopify_sales
where customer_country is null
union
select  'traffic_source' as Column_Name,count(*) as 'Number of Nulls' from shopify_sales
where traffic_source is null
union
select  'payment_method' as Column_Name,count(*) as 'Number of Nulls' from shopify_sales
where payment_method is null
union
select  'shipping_cost' as Column_Name,count(*) as 'Number of Nulls' from shopify_sales
where shipping_cost is null
union
select  'rating' as Column_Name,count(*) as 'Number of Nulls' from shopify_sales
where rating is null
union
select  'is_returned' as Column_Name,count(*) as 'Number of Nulls' from shopify_sales
where is_returned is null
union
select  'discounted_price' as Column_Name,count(*) as 'Number of Nulls' from shopify_sales
where discounted_price is null
union
select  'revenue' as Column_Name,count(*) as 'Number of Nulls' from shopify_sales
where revenue is null
union
select  'profit' as Column_Name,count(*) as 'Number of Nulls' from shopify_sales
where profit is null

--Cleaning

--Check for Non-Numeric Values in order_id
select order_id from shopify_sales
where ISNUMERIC(order_id) = 0;

--Check for Non-Numeric Values in discount_percent
select discount_percent from shopify_sales
where ISNUMERIC(discount_percent) = 0;

--Check for Non-Numeric Values in quantity
select quantity from shopify_sales
where ISNUMERIC(quantity) = 0;

--Check for Decimal Values in order_id
SELECT order_id 
FROM shopify_sales 
WHERE order_id LIKE '%[0-9].[0-9]%';

--Check for Decimal Values in quantity
SELECT quantity 
FROM shopify_sales 
WHERE quantity LIKE '%[0-9].[0-9]%';
	
--Cleaning
ALTER TABLE shopify_sales
ALTER COLUMN order_id INT NOT NULL;

ALTER TABLE shopify_sales
ALTER COLUMN discount_percent FLOAT NOT NULL;

ALTER TABLE shopify_sales
ALTER COLUMN quantity INT NOT NULL;

--Check Data_Type
select COLUMN_NAME, DATA_TYPE from INFORMATION_SCHEMA.COLUMNS

--Explore order_date
--Distinct Years
select distinct Year(order_date) as Years,Count(order_date) as 'Number of Records' from shopify_sales
group by Year(order_date)
order by Year(order_date)

--First and last order_date records
select min(order_date) as 'First order date',
max(order_date) as 'Last order date',
DATEDIFF(MONTH,min(order_date),max(order_date)) as order_range_months,
DATEDIFF(Day,min(order_date),max(order_date)) as order_range_Days
from shopify_sales

--Explore product_category
--Distinct product_category
select distinct product_category ,Count(product_category) as 'Number of Records' from shopify_sales
group by product_category
order by Count(product_category) DESC

--Explore customer_country
--Distinct customer_country
select distinct customer_country,Count(customer_country) as 'Number of Records' from shopify_sales
group by customer_country
order by Count(customer_country) DESC

--Explore traffic_source
--Distinct traffic_source
select distinct traffic_source,Count(traffic_source) as 'Number of Records' from shopify_sales
group by traffic_source
order by Count(traffic_source) DESC

--Explore payment_method
--Distinct payment_method
select distinct payment_method,Count(payment_method) as 'Number of Records' from shopify_sales
group by payment_method
order by Count(payment_method) DESC

--check is_returned
select distinct is_returned from shopify_sales

-- Explore product_id & product_price
select top 3 product_id, product_price from shopify_sales
order by product_price DESC

select top 3 product_id, product_price from shopify_sales
order by product_price ASC

select AVG(product_price) as 'Average Product Price' from shopify_sales

--How many product are sold
select sum(quantity) as 'Product Sold' from shopify_sales

-- Explore product_id & shipping_cost
select top 15 product_id, shipping_cost from shopify_sales
order by shipping_cost DESC

select top 15 product_id, shipping_cost from shopify_sales
order by shipping_cost ASC

select AVG(shipping_cost) as 'Average Shipping Cost' from shopify_sales

--Product Rating
--5 Highest
select TOP 5 rating, count(rating) as 'Number of Products' from shopify_sales
group by rating
order by count(rating) DESC

--5 Lowest
select TOP 5 rating, count(rating) as 'Number of Products' from shopify_sales
group by rating
order by count(rating) ASC

--Highest Revenue
select TOP 5 product_id,sum(revenue) as revenue,sum(quantity) as sold from shopify_sales
group by product_id
order by sum(revenue) DESC

--Lowest Revenue
select TOP 5 product_id,sum(revenue) as revenue,sum(quantity) as sold from shopify_sales
group by product_id
order by sum(revenue) ASC

--Highest Profit
select TOP 5 product_id,sum(profit) as profit,sum(quantity) as sold from shopify_sales
group by product_id
order by sum(profit) DESC

--Lowest Profit
select TOP 5 product_id,sum(profit) as profit,sum(quantity) as sold from shopify_sales
group by product_id
order by sum(profit) ASC

--``product_id``: **2120** and ``product_id``: **5019**
select product_id,product_price, discount_percent,shipping_cost,
discounted_price,revenue,profit,
SUM(revenue) OVER (ORDER BY revenue asc) AS running_total_revenue,
SUM(shipping_cost) OVER (ORDER BY shipping_cost DESC) AS running_total_shipping_cost,
SUM(profit) OVER (ORDER BY profit asc) AS running_total_profit
from shopify_sales
where product_id = 2120
union
select product_id,product_price, discount_percent,shipping_cost,
discounted_price,revenue,profit,
SUM(revenue) OVER (ORDER BY revenue asc) AS running_total_revenue,
SUM(shipping_cost) OVER (ORDER BY shipping_cost DESC) AS running_total_shipping_cost,
SUM(profit) OVER (ORDER BY profit asc) AS running_total_profit
from shopify_sales
where product_id = 5019

-- Distribution ``product_category`` and ``traffic_source``
SELECT
    product_category,
    traffic_source,
    COUNT(order_id) AS total_orders
FROM shopify_sales
GROUP BY
    product_category,
    traffic_source
ORDER BY
    product_category,
    total_orders DESC;

-- Distribution ``product_category`` and ``customer_country``
SELECT
    product_category,
    customer_country,
    COUNT(order_id) AS total_orders
FROM shopify_sales
GROUP BY
    product_category,
    customer_country
ORDER BY
    product_category,
    total_orders DESC;

-- Distribution ``product_category`` and ``payment_method``
SELECT
    product_category,
    payment_method,
    COUNT(order_id) AS total_orders
FROM shopify_sales
GROUP BY
    product_category,
    payment_method
ORDER BY
    product_category,
    total_orders DESC;

--Distribution ``customer_country`` and ``traffic_source``
SELECT
    customer_country,
    traffic_source,
    COUNT(order_id) AS total_orders
FROM shopify_sales
GROUP BY
    customer_country,
    traffic_source
ORDER BY
    customer_country,
    total_orders DESC;

--Distribution ``customer_country`` and ``payment_method``
SELECT
    customer_country,
    payment_method,
    COUNT(order_id) AS total_orders
FROM shopify_sales
GROUP BY
    customer_country,
    payment_method
ORDER BY
    customer_country,
    total_orders DESC;

--Distribution ``traffic_source`` and ``payment_method``

SELECT
    traffic_source,
    payment_method,
    COUNT(order_id) AS total_orders
FROM shopify_sales
GROUP BY
    traffic_source,
    payment_method
ORDER BY
    traffic_source,
    total_orders DESC;

--Distribution YEARS and ``product_category``

SELECT
    YEAR(order_date) as Order_Year,
    payment_method,
    COUNT(order_id) AS total_orders
FROM shopify_sales
GROUP BY
    YEAR(order_date),
    payment_method
ORDER BY
    YEAR(order_date),
    total_orders DESC;

--Distribution YEARS and ``customer_country``

SELECT
    YEAR(order_date) as Order_Year,
    customer_country,
    COUNT(order_id) AS total_orders
FROM shopify_sales
GROUP BY
    YEAR(order_date),
    customer_country
ORDER BY
    YEAR(order_date),
    total_orders DESC;

--Distribution YEARS and ``traffic_source``

SELECT
    YEAR(order_date) as Order_Year,
    traffic_source,
    COUNT(order_id) AS total_orders
FROM shopify_sales
GROUP BY
    YEAR(order_date),
    traffic_source
ORDER BY
    YEAR(order_date),
    total_orders DESC;

--Distribution YEARS and ``payment_method``

SELECT
    YEAR(order_date) as Order_Year,
    payment_method,
    COUNT(order_id) AS total_orders
FROM shopify_sales
GROUP BY
    YEAR(order_date),
    payment_method
ORDER BY
    YEAR(order_date),
    total_orders DESC;

--product_price by product_category
select product_category, CAST(AVG(product_price) AS decimal(10,2)) as 'Average Price',
CAST(MAX(product_price) AS decimal(10,2)) as 'MAX Price',
CAST(MIN(product_price) AS decimal(10,2)) as 'MIN Price'
from shopify_sales
group by product_category
order by product_category ASC;

--quantity by product_category
select product_category, CAST(AVG(quantity) AS decimal(10,2)) as 'Average quantity',
CAST(MAX(quantity) AS decimal(10,2)) as 'MAX quantity',
CAST(MIN(quantity) AS decimal(10,2)) as 'MIN quantity',
SUM(quantity) as 'Total quantity'
from shopify_sales
group by product_category
order by SUM(quantity)DESC, product_category ASC;

--shipping_cost by product_category
select product_category, CAST(AVG(shipping_cost) AS decimal(10,2)) as 'Average shipping_cost',
CAST(MAX(shipping_cost) AS decimal(10,2)) as 'MAX shipping_cost',
CAST(MIN(shipping_cost) AS decimal(10,2)) as 'MIN shipping_cost'
from shopify_sales
group by product_category
order by product_category ASC;

--rating by product_category
select product_category, CAST(AVG(rating) AS decimal(10,2)) as 'Average rating',
CAST(MAX(rating) AS decimal(10,2)) as 'MAX rating',
CAST(MIN(rating) AS decimal(10,2)) as 'MIN rating'
from shopify_sales
group by product_category
order by AVG(rating) DESC, product_category ASC;

--rating by product_category
select product_category, CAST(AVG(revenue) AS decimal(10,2)) as 'Average revenue',
CAST(MAX(revenue) AS decimal(10,2)) as 'MAX revenue',
CAST(MIN(revenue) AS decimal(10,2)) as 'MIN revenue',
CAST(SUM(revenue) AS decimal(10,2)) as 'Total revenue'
from shopify_sales
group by product_category
order by SUM(revenue) DESC, product_category ASC;

--profit by product_category
select product_category, CAST(AVG(profit) AS decimal(10,2)) as 'Average profit',
CAST(MAX(profit) AS decimal(10,2)) as 'MAX profit',
CAST(MIN(profit) AS decimal(10,2)) as 'MIN profit',
CAST(SUM(profit) AS decimal(10,2)) as 'Total profit'
from shopify_sales
group by product_category
order by SUM(profit) DESC, product_category ASC;

--``product_price`` by ``Years``
select YEAR(order_date) as Years, CAST(AVG(product_price) AS decimal(10,2)) as 'Average price',
CAST(MAX(product_price) AS decimal(10,2)) as 'MAX price',
CAST(MIN(product_price) AS decimal(10,2)) as 'MIN price'
from shopify_sales
group by YEAR(order_date)
order by YEAR(order_date) ASC;

--``quantity`` by ``Years``
select YEAR(order_date) as Years, CAST(AVG(quantity) AS decimal(10,2)) as 'Average quantity',
CAST(MAX(quantity) AS decimal(10,2)) as 'MAX quantity',
CAST(MIN(quantity) AS decimal(10,2)) as 'MIN quantity',
CAST(SUM(quantity) AS decimal(10,2)) as 'Total quantity'
from shopify_sales
group by YEAR(order_date)
order by SUM(quantity) DESC,YEAR(order_date) ASC;

--``shipping_cost`` by ``Years``
select YEAR(order_date) as Years, CAST(AVG(shipping_cost) AS decimal(10,2)) as 'Average shipping_cost',
CAST(MAX(shipping_cost) AS decimal(10,2)) as 'MAX shipping_cost',
CAST(MIN(shipping_cost) AS decimal(10,2)) as 'MIN shipping_cost',
CAST(SUM(shipping_cost) AS decimal(10,2)) as 'Total shipping_cost'
from shopify_sales
group by YEAR(order_date)
order by SUM(shipping_cost) DESC,YEAR(order_date) ASC;

--``rating`` by ``Years``
select YEAR(order_date) as Years, CAST(AVG(rating) AS decimal(10,2)) as 'Average rating',
CAST(MAX(rating) AS decimal(10,2)) as 'MAX rating',
CAST(MIN(rating) AS decimal(10,2)) as 'MIN rating'
from shopify_sales
group by YEAR(order_date)
order by AVG(rating) DESC,YEAR(order_date) ASC;

--``revenue`` by ``Years``
select YEAR(order_date) as Years, CAST(AVG(revenue) AS decimal(10,2)) as 'Average revenue',
CAST(MAX(revenue) AS decimal(10,2)) as 'MAX revenue',
CAST(MIN(revenue) AS decimal(10,2)) as 'MIN revenue',
CAST(SUM(revenue) AS decimal(10,2)) as 'Total revenue'
from shopify_sales
group by YEAR(order_date)
order by SUM(revenue) DESC,YEAR(order_date) ASC;

--``profit`` by ``Years``
select YEAR(order_date) as Years, CAST(AVG(profit) AS decimal(10,2)) as 'Average profit',
CAST(MAX(profit) AS decimal(10,2)) as 'MAX profit',
CAST(MIN(profit) AS decimal(10,2)) as 'MIN profit',
CAST(SUM(profit) AS decimal(10,2)) as 'Total profit'
from shopify_sales
group by YEAR(order_date)
order by SUM(profit) DESC,YEAR(order_date) ASC;

--``product_price`` by ``traffic_source``
select traffic_source, CAST(AVG(product_price) AS decimal(10,2)) as 'Average price',
CAST(MAX(product_price) AS decimal(10,2)) as 'MAX price',
CAST(MIN(product_price) AS decimal(10,2)) as 'MIN price'
from shopify_sales
group by traffic_source
order by AVG(product_price) DESC,traffic_source ASC;

--``quantity`` by ``traffic_source``
select traffic_source, CAST(AVG(quantity) AS decimal(10,2)) as 'Average quantity',
CAST(MAX(quantity) AS decimal(10,2)) as 'MAX quantity',
CAST(MIN(quantity) AS decimal(10,2)) as 'MIN quantity',
CAST(SUM(quantity) AS decimal(10,2)) as 'Total quantity'
from shopify_sales
group by traffic_source
order by SUM(quantity) DESC,traffic_source ASC;

--``shipping_cost`` by ``traffic_source``
select traffic_source,CAST(AVG(shipping_cost) AS decimal(10,2)) as 'Average shipping_cost',
CAST(MAX(shipping_cost) AS decimal(10,2)) as 'MAX shipping_cost',
CAST(MIN(shipping_cost) AS decimal(10,2)) as 'MIN shipping_cost',
CAST(SUM(shipping_cost) AS decimal(10,2)) as 'Total shipping_cost'
from shopify_sales
group by traffic_source
order by SUM(shipping_cost) DESC,traffic_source ASC;

--``rating`` by ``traffic_source``
select traffic_source, CAST(AVG(rating) AS decimal(10,2)) as 'Average rating',
CAST(MAX(rating) AS decimal(10,2)) as 'MAX rating',
CAST(MIN(rating) AS decimal(10,2)) as 'MIN rating'
from shopify_sales
group by traffic_source
order by AVG(rating) DESC,traffic_source ASC;

--``revenue`` by ``traffic_source``
select traffic_source, CAST(AVG(revenue) AS decimal(10,2)) as 'Average revenue',
CAST(MAX(revenue) AS decimal(10,2)) as 'MAX revenue',
CAST(MIN(revenue) AS decimal(10,2)) as 'MIN revenue',
CAST(SUM(revenue) AS decimal(10,2)) as 'Total revenue'
from shopify_sales
group by traffic_source
order by SUM(revenue) DESC,traffic_source ASC;

--``profit`` by ``traffic_source``
select traffic_source, CAST(AVG(profit) AS decimal(10,2)) as 'Average profit',
CAST(MAX(profit) AS decimal(10,2)) as 'MAX profit',
CAST(MIN(profit) AS decimal(10,2)) as 'MIN profit',
CAST(SUM(profit) AS decimal(10,2)) as 'Total profit'
from shopify_sales
group by traffic_source
order by SUM(profit) DESC,traffic_source ASC;

--``product_price`` by ``customer_country``
select customer_country, CAST(AVG(product_price) AS decimal(10,2)) as 'Average price',
CAST(MAX(product_price) AS decimal(10,2)) as 'MAX price',
CAST(MIN(product_price) AS decimal(10,2)) as 'MIN price'
from shopify_sales
group by customer_country
order by AVG(product_price) DESC,customer_country ASC;
 
--``quantity`` by ``customer_country``
select customer_country, CAST(AVG(quantity) AS decimal(10,2)) as 'Average quantity',
CAST(MAX(quantity) AS decimal(10,2)) as 'MAX quantity',
CAST(MIN(quantity) AS decimal(10,2)) as 'MIN quantity',
CAST(SUM(quantity) AS decimal(10,2)) as 'Total quantity'
from shopify_sales
group by customer_country
order by SUM(quantity) DESC,customer_country ASC;
 
--``shipping_cost`` by ``customer_country``
select customer_country, CAST(AVG(shipping_cost) AS decimal(10,2)) as 'Average shipping_cost',
CAST(MAX(shipping_cost) AS decimal(10,2)) as 'MAX shipping_cost',
CAST(MIN(shipping_cost) AS decimal(10,2)) as 'MIN shipping_cost',
CAST(SUM(shipping_cost) AS decimal(10,2)) as 'Total shipping_cost'
from shopify_sales
group by customer_country
order by SUM(shipping_cost) DESC,customer_country ASC;
 
--``rating`` by ``customer_country``
select customer_country, CAST(AVG(rating) AS decimal(10,2)) as 'Average rating',
CAST(MAX(rating) AS decimal(10,2)) as 'MAX rating',
CAST(MIN(rating) AS decimal(10,2)) as 'MIN rating'
from shopify_sales
group by customer_country
order by AVG(rating) DESC,customer_country ASC;
 
--``revenue`` by ``customer_country``
select customer_country, CAST(AVG(revenue) AS decimal(10,2)) as 'Average revenue',
CAST(MAX(revenue) AS decimal(10,2)) as 'MAX revenue',
CAST(MIN(revenue) AS decimal(10,2)) as 'MIN revenue',
CAST(SUM(revenue) AS decimal(10,2)) as 'Total revenue'
from shopify_sales
group by customer_country
order by SUM(revenue) DESC,customer_country ASC;
 
--``profit`` by ``customer_country``
select customer_country, CAST(AVG(profit) AS decimal(10,2)) as 'Average profit',
CAST(MAX(profit) AS decimal(10,2)) as 'MAX profit',
CAST(MIN(profit) AS decimal(10,2)) as 'MIN profit',
CAST(SUM(profit) AS decimal(10,2)) as 'Total profit'
from shopify_sales
group by customer_country
order by SUM(profit) DESC,customer_country ASC;

--``product_price`` by ``payment_method``
select payment_method, CAST(AVG(product_price) AS decimal(10,2)) as 'Average price',
CAST(MAX(product_price) AS decimal(10,2)) as 'MAX price',
CAST(MIN(product_price) AS decimal(10,2)) as 'MIN price'
from shopify_sales
group by payment_method
order by AVG(product_price) DESC,payment_method ASC;
 
--``quantity`` by ``payment_method``
select payment_method, CAST(AVG(quantity) AS decimal(10,2)) as 'Average quantity',
CAST(MAX(quantity) AS decimal(10,2)) as 'MAX quantity',
CAST(MIN(quantity) AS decimal(10,2)) as 'MIN quantity',
CAST(SUM(quantity) AS decimal(10,2)) as 'Total quantity'
from shopify_sales
group by payment_method
order by SUM(quantity) DESC,payment_method ASC;
 
--``shipping_cost`` by ``payment_method``
select payment_method, CAST(AVG(shipping_cost) AS decimal(10,2)) as 'Average shipping_cost',
CAST(MAX(shipping_cost) AS decimal(10,2)) as 'MAX shipping_cost',
CAST(MIN(shipping_cost) AS decimal(10,2)) as 'MIN shipping_cost',
CAST(SUM(shipping_cost) AS decimal(10,2)) as 'Total shipping_cost'
from shopify_sales
group by payment_method
order by SUM(shipping_cost) DESC,payment_method ASC;
 
--``rating`` by ``payment_method``
select payment_method, CAST(AVG(rating) AS decimal(10,2)) as 'Average rating',
CAST(MAX(rating) AS decimal(10,2)) as 'MAX rating',
CAST(MIN(rating) AS decimal(10,2)) as 'MIN rating'
from shopify_sales
group by payment_method
order by AVG(rating) DESC,payment_method ASC;
 
--``revenue`` by ``payment_method``
select payment_method, CAST(AVG(revenue) AS decimal(10,2)) as 'Average revenue',
CAST(MAX(revenue) AS decimal(10,2)) as 'MAX revenue',
CAST(MIN(revenue) AS decimal(10,2)) as 'MIN revenue',
CAST(SUM(revenue) AS decimal(10,2)) as 'Total revenue'
from shopify_sales
group by payment_method
order by SUM(revenue) DESC,payment_method ASC;
 
--``profit`` by ``payment_method``
select payment_method, CAST(AVG(profit) AS decimal(10,2)) as 'Average profit',
CAST(MAX(profit) AS decimal(10,2)) as 'MAX profit',
CAST(MIN(profit) AS decimal(10,2)) as 'MIN profit',
CAST(SUM(profit) AS decimal(10,2)) as 'Total profit'
from shopify_sales
group by payment_method
order by SUM(profit) DESC,payment_method ASC;