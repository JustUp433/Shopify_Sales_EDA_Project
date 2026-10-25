# Exploratory Data Analysis of Shopify Sales Report
***
## Executive Summary

This project explores a Shopify sales dataset containing 60,000 records from January 2023 to June 2025. Using Microsoft SQL Server, the analysis examined sales performance, product categories, customer countries, traffic sources, payment methods, and customer ratings. Data cleaning was performed to standardize selected column data types before conducting exploratory data analysis (EDA).

The findings show that Electronics was the strongest-performing product category, generating approximately 8.72 million in total revenue and 8.60 million in total profit. Australia was the highest-revenue market, contributing approximately 8.70 million. Across traffic sources, Social Media generated the highest total revenue and profit, although the differences between channels were relatively small. The analysis also found that the five highest-ranked products by revenue were the same as those ranked highest by profit, while the lowest-ranked products differed, highlighting the importance of examining profitability alongside revenue.

Further analysis of order counts showed that Electronics recorded its highest order count through Social Media, with 1,784 orders, followed by Paid Ads with 1,734 orders. Across customer countries, the UAE recorded the highest number of Electronics orders at 1,273, followed by the USA at 1,257 and Germany at 1,256. These findings suggest opportunities to test targeted marketing campaigns for Electronics through Social Media and Paid Ads, while exploring market-specific promotions in the UAE, USA, and Germany.

Average customer ratings remained close to 3.00 across the periods analyzed, indicating little variation in average ratings. Some transactions recorded negative profit, creating an opportunity to investigate the underlying causes of losses.

An important limitation is that the dataset ends on June 18, 2025. Therefore, total figures for 2025 represent only part of the year and should not be directly compared with full-year totals from 2023 and 2024.

Based on these findings, the next step is to develop an interactive Power BI dashboard to monitor revenue, profit, sales trends, category performance, geographic markets, and traffic sources. Recommended actions include testing targeted Electronics promotions through Social Media and Paid Ads, evaluating market-specific campaigns in countries with high Electronics order counts, and reviewing profit margins before expanding discounts. Campaign performance should be measured using conversion rates, marketing costs, revenue, and profit to determine whether these strategies deliver sustainable growth. Further analysis should also prioritize comparable time periods, investigate unprofitable transactions, and evaluate marketing effectiveness using additional cost and conversion data where available.
***
## About Author
- **Author** : Phuree Sirimongkol
- Management Information Systems (MIS) Undergraduate at Chulalongkorn University

## Objective
- The objective of this report is to explore the Shopify Sales Dataset to understand its characteristics and uncover patterns that may provide business insights.

## Data Source
- **Source**    : "Shopify Sales Dataset for ML & EDA" from kaggle "https://www.kaggle.com/datasets/aliiihussain/shopify-sales-dataset-for-ml-and-eda?resource=download"
- **Format**    : CSV
- **Storage**   : Microsoft SQL Server

## Dataset Overview
- **Database**              : SampleSales
- **Table**                 : shopify_sales
- **Number Of Rows**     : 60000
- **Number of Columns**     : 17
- **Features** :

| COLUMN_NAME      | DATA_TYPE |
|------------------|-----------|
| order_id         | nvarchar  |
| order_date       | datetime2 |
| customer_id      | int       |
| product_id       | int       |
| product_category | nvarchar  |
| product_price    | float     |
| discount_percent | nvarchar  |
| quantity         | nvarchar  |
| customer_country | nvarchar  |
| traffic_source   | nvarchar  |
| payment_method   | nvarchar  |
| shipping_cost    | float     |
| rating           | float     |
| is_returned      | nvarchar  |
| discounted_price | float     |
| revenue          | float     |
| profit           | float     |

- **Data Samples**

| order_id | order_date                  | customer_id | product_id | product_category | product_price | discount_percent | quantity | customer_country | traffic_source | payment_method | shipping_cost | rating | is_returned | discounted_price | revenue | profit  |
|----------|-----------------------------|-------------|------------|------------------|---------------|------------------|----------|------------------|----------------|----------------|---------------|--------|-------------|------------------|---------|---------|
| 1        | 2023-04-13 00:00:00.0000000 | 14958       | 7824       | Accessories      | 143.39        | 40               | 1        | USA              | Paid Ads       | Credit Card    | 21.08         | 2      | 0           | 86.03            | 86.03   | 64.95   |
| 2        | 2024-03-11 00:00:00.0000000 | 26825       | 5557       | Sports           | 746.49        | 15               | 4        | UAE              | Email          | PayPal         | 5.48          | 3.7    | 0           | 634.52           | 2538.08 | 2532.6  |
| 3        | 2025-05-10 00:00:00.0000000 | 37450       | 2225       | Electronics      | 641.06        | 5                | 5        | Canada           | Paid Ads       | Apple Pay      | 11.27         | 3.2    | 0           | 609.01           | 3045.05 | 3033.78 |
| 4        | 2023-09-28 00:00:00.0000000 | 20691       | 7855       | Footwear         | 512.39        | 0                | 3        | UAE              | Direct         | Apple Pay      | 19.22         | 1.1    | 0           | 512.39           | 1537.17 | 1517.95 |
| 5        | 2023-04-17 00:00:00.0000000 | 24631       | 7789       | Sports           | 415.89        | 25               | 3        | UAE              | Social Media   | Debit Card     | 24.94         | 4.1    | 0           | 311.92           | 935.76  | 910.82  |

- **Number of Nulls** : 0
- **Observation**
> During inspection, several columns were found to have data types that were inconsistent with their intended values.
> - `order_id` was stored as **NVARCHAR**, while other identifier(ID) columns were stored as **INT**.
> - `discount_percent` was stored as **NVARCHAR**, although it represent numeric values. Similar numeric fields, such as `revenue`,`shipping_cost`, were stored as **FLOAT**.
> - `quantity` was stored as **NVARCHAR**, though it makes more sense to be **INT** as it represents numeric values.

## Data Cleaning
### Checking
To cast **NVARCHAR** values to **INT** or **FLOAT**, I first need to ensure that they contain only numeric values.  
For **INT**, the values must not contain any decimal points.
***
- Check for Non-Numeric Values in `order_id` ,`discount_percent` and `quantity`
```sql
select order_id from shopify_sales where ISNUMERIC(order_id) = 0
```  
```sql
select discount_percent from shopify_sales where ISNUMERIC(discount_percent) = 0
```  
```sql
select quantity from shopify_sales where ISNUMERIC(quantity) = 0
```
- There is **0** Non-Numeric Values in `order_id`
- There is **0** Non-Numeric Values in `discount_percent`
- There is **0** Non-Numeric Values in `quantity`
***
- Check for Decimal Values in `order_id` and `quantity`
```sql
SELECT order_id FROM shopify_sales 
WHERE order_id LIKE '%[0-9].[0-9]%'
```  
```sql
SELECT quantity FROM shopify_sales 
WHERE quantity LIKE '%[0-9].[0-9]%'
```  
- There is **0** Decimal Values in `order_id` and `quantity`
***
### Cleaning
To ensure consistency across the dataset :
- `order_id` was converted from `NVARCHAR` to `INT`.
- `discount_percent` was converted from `NVARCHAR` to `FLOAT`.
- `quantity` was converted from `NVARCHAR` to `INT`.
```sql
ALTER TABLE shopify_sales
ALTER COLUMN order_id INT NOT NULL;

ALTER TABLE shopify_sales
ALTER COLUMN discount_percent FLOAT NOT NULL;

ALTER TABLE shopify_sales
ALTER COLUMN quantity INT NOT NULL;
```  
### Result
| COLUMN_NAME      | DATA_TYPE |
|------------------|-----------|
| order_id         | int       |
| order_date       | datetime2 |
| customer_id      | int       |
| product_id       | int       |
| product_category | nvarchar  |
| product_price    | float     |
| discount_percent | float     |
| quantity         | int       |
| customer_country | nvarchar  |
| traffic_source   | nvarchar  |
| payment_method   | nvarchar  |
| shipping_cost    | float     |
| rating           | float     |
| is_returned      | nvarchar  |
| discounted_price | float     |
| revenue          | float     |
| profit           | float     |

***

## Univariate Analysis

### Explore ``order_date``
- group by **Years**
```SQL
select distinct Year(order_date) as Years,Count(order_date) as 'Number of Records' from shopify_sales
group by Year(order_date)
order by Year(order_date)
```
- First and last order_date records
```SQL
select min(order_date) as 'First order date',
max(order_date) as 'Last order date',
DATEDIFF(MONTH,min(order_date),max(order_date)) as order_range_month,
DATEDIFF(Day,min(order_date),max(order_date)) as order_range_Days
from shopify_sales
```
**Findings**
- ``order_date`` contains records from 3 Years: 2023, 2024, and 2025.

| Years | Number of Records |
|-------|-------------------|
| 2023  | 24245   |
| 2024  | 24452   |
| 2025  | 11303   |

- **2024** has the **highest** number of orders.
- **First** order date : 2023-01-01
- **Last** order date : 2025-06-18
- Overall, This dataset covers a period of **29 months**(899 Days).
***
### Explore ``product_category``
- Group by **product_category** and Order by **number of Records**
```SQL
select distinct product_category ,Count(product_category) as 'Number of Records' from shopify_sales
group by product_category
order by Count(product_category)
```  
**Findings**

| product_category | Number of Records |
|------------------|-------------------|
| Electronics      | 8624              |
| Accessories      | 8617              |
| Home Decor       | 8600              |
| Fashion          | 8594              |
| Beauty           | 8586              |
| Sports           | 8522              |
| Footwear         | 8457              |  

Top-selling products category by Number of orders
- **Electronics** has the **highest** number of orders (8624).
- Followed by , **Accessories** ranked **second** (8617).
- And **Home Decor** ranked **third** (8600)
***
### Explore ``customer_country``
- Group by **customer_country** and Order by **number of Records**
```SQL
select distinct customer_country,Count(customer_country) as 'Number of Records' from shopify_sales
group by customer_country
order by Count(customer_country) DESC
```  

**Findings**

| customer_country | Number of Records |
|------------------|-------------------|
| Australia        | 8714              |
| Germany          | 8606              |
| UAE              | 8599              |
| Canada           | 8586              |
| India            | 8554              |
| UK               | 8472              |
| USA              | 8469              |

Top-selling country by Number of orders
- **Australia** has the **highest** number of orders (8714).
- **Second**, **Germany** (8606).
- **UAE** ranked **third** (8599).
***
### Explore ``traffic_source``
- Group by **traffic_source** and Order by **number of Records**
```SQL
select distinct traffic_source,Count(traffic_source) as 'Number of Records' from shopify_sales
group by traffic_source
order by Count(traffic_source) DESC
```  

**Findings**

| traffic_source | Number of Records |
|----------------|-------------------|
| Organic        | 12075             |
| Social Media   | 12024             |
| Paid Ads       | 12018             |
| Direct         | 11961             |
| Email          | 11922             |

- **Organic** is the most **frequently** used traffic source (12075).
- Next, **Social Media** is **second** (12024).
- Followed by **Paid Ads** (12018).
***
### Explore ``payment_method``
- Group by **payment_method** and Order by **number of Records**
```SQL
select distinct payment_method,Count(payment_method) as 'Number of Records' from shopify_sales
group by payment_method
order by Count(payment_method) DESC
```  

**Findings**

| payment_method   | Number of Records |
|------------------|-------------------|
| Apple Pay        | 12116             |
| Cash on Delivery | 12032             |
| Credit Card      | 11998             |
| Debit Card       | 11936             |
| PayPal           | 11918             |

- **Apple Pay** is **the most popular** overall payment method (12116).
- **Second** is **Cash on Delivery** (12032).
- **Third** is **Credit Card** (11998).
***
Check ``is_returned``
```SQL
select distinct is_returned from shopify_sales
```

- ``is_returned`` contains only 0 and 1.
***
### Explore ``product_id`` and ``product_price``
- Find top 3 **highest**, **lowest**, and **Average** ``product_price``
```SQl
select top 3 product_id, product_price from shopify_sales
order by product_price DESC
```
```SQL
select top 3 product_id, product_price from shopify_sales
order by product_price ASC
```  
```SQL
select AVG(product_price) as 'Average Product Price' from shopify_sales
```  
**Findings**
- The dataset does not include product names.
- Top 3 **Highest** product price

| product_id | product_price |
|------------|---------------|
| 5747       | 799.99        |
| 6474       | 799.97        |
| 3086       | 799.97        |

- Top 3 **Lowest** product price

| product_id | product_price |
|------------|---------------|
| 5045       | 5.01          |
| 2933       | 5.01          |
| 4341       | 5.02          |  

- The **Average** Product Price is **403.4271**.
***
### How many product are sold
```SQL
select sum(quantity) as 'Product Sold' from shopify_sales
```  
**Findings**
- **180574** amount of product are **sold**.
***
### Explore ``product_id`` and ``shipping_cost``
- Find the **highest**, **lowest**, and **Average** ``shipping_cost``
```SQL
select top 15 product_id, shipping_cost from shopify_sales
order by shipping_cost DESC
```
```SQL
select top 15 product_id, shipping_cost from shopify_sales
order by shipping_cost ASC
```
```SQL
select AVG(shipping_cost) as 'Average Shipping Cost' from shopify_sales
```
**Findings**
- There are **11** product that have the **highest** shipping cost(**25**).
> Which are 3768, 6777, 1381, 1906, 4244, 2126, 5701, 7123, 7969, 2563, and 7047
- There are **14** product that have the **lowest** shipping cost(**2**).
> Which are 4396, 3551, 4710, 2454, 7787, 4188, 5721, 5432, 4170, 1447, 6133, 3199, 4604, and 1818
- The **Average** shipping cost is **13.5218**
***
### Products ``rating``
- How Many Products Are There for Each Rating?
```SQL
select TOP 5 rating, count(rating) as 'Number of Products' from shopify_sales
group by rating
order by count(rating) DESC
```
```SQL
select TOP 5 rating, count(rating) as 'Number of Products' from shopify_sales
group by rating
order by count(rating) ASC
```
**Findings**
- Top 5 **Most common** ``rating``

| rating | Number of Products |
|--------|--------------------|
| 3.1    | 1556               |
| 4.1    | 1555               |
| 2.9    | 1553               |
| 2.7    | 1536               |
| 1.7    | 1533               |  

- Top 5 **Least common** ``rating``

| rating | Number of Products |
|--------|--------------------|
| 1      | 738                |
| 5      | 743                |
| 1.3    | 1431               |
| 2.2    | 1455               |
| 1.1    | 1457               |  
***
### Product that generate the **highest**/**Lowest** ``revenue`` and ``profit``
```SQL
select TOP 5 product_id,sum(revenue) as revenue,sum(quantity) as sold from shopify_sales
group by product_id
order by sum(revenue) DESC
```
```SQL
select TOP 5 product_id,sum(revenue) as revenue,sum(quantity) as sold from shopify_sales
group by product_id
order by sum(revenue) ASC
``` 
```SQL
select TOP 5 product_id,sum(profit) as profit,sum(quantity) as sold from shopify_sales
group by product_id
order by sum(profit) DESC
```
```SQL
select TOP 5 product_id,sum(profit) as profit,sum(quantity) as sold from shopify_sales
group by product_id
order by sum(profit) ASC
```  
**Finding**
- **Highest** ``revenue``

| product_id | revenue  | sold |
|------------|----------|------|
| 3345       | 26020.15 | 66   |
| 3075       | 24599.69 | 70   |
| 3021       | 24038.95 | 67   |
| 6534       | 23876.33 | 63   |
| 6577       | 23671.35 | 50   |  

- **Lowest** ``revenue``

| product_id | revenue | sold |
|------------|---------|------|
| 6023       | 129.72  | 1    |
| 6994       | 304.68  | 8    |
| 3457       | 319.05  | 2    |
| 5019       | 381.07  | 1    |
| 2120       | 392     | 2    |  

- **Highest** ``profit``

| product_id | profit   | sold |
|------------|----------|------|
| 3345       | 25730.44 | 66   |
| 3075       | 24339.03 | 70   |
| 3021       | 23740.36 | 67   |
| 6534       | 23608.84 | 63   |
| 6577       | 23493.7  | 50   |  

- **Lowest** ``profit``

| product_id | profit | sold |
|------------|--------|------|
| 6023       | 105.74 | 1    |
| 6994       | 251.38 | 8    |
| 3457       | 287.13 | 2    |
| 2120       | 358.92 | 2    |
| 5019       | 376.82 | 1    |  

- The **Top 5** products ranked by ``revenue`` and ``profit`` are the same, whereas the **Bottom 5** rankings differ.
- There are **two metrics** that differ from each result, which are ``product_id``: **2120** and ``product_id``: **5019**
- 2120 generate **more revenue** but have **lower profit** than 5019. **why?**

#### Let's take a look
```SQL
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
```

**Finding**

| product_id | product_price | discount_percent | shipping_cost | discounted_price | revenue | profit | running_total_revenue | running_total_shipping_cost | running_total_profit |
|------------|---------------|------------------|---------------|------------------|---------|--------|-----------------------|-----------------------------|----------------------|
| 2120       | 105.57        | 15               | 21.97         | 89.73            | 89.73   | 67.76  | 89.73                 | 21.97                       | 67.76                |
| 2120       | 335.85        | 10               | 11.11         | 302.27           | 302.27  | 291.16 | 392                   | 33.08                       | 358.92               |
| 5019       | 635.11        | 40               | 4.25          | 381.07           | 381.07  | 376.82 | 381.07                | 4.25                        | 376.82               |  

- 2120 that sold 2 times generates **more** ``profit`` but also having **higher** ``shipping_cost``
- While 5019 have **higher** price and **less** ``shipping_cost`` which is why 5019 have **more profit**
***
## Bivariate Analysis  
### Distribution ``product_category`` and ``traffic_source``

```SQL
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
```  

**Findings**
- TOP **3** The **highest** of total_orders :

| product_category | traffic_source | total_orders |
|------------------|----------------|--------------|
| Electronics      | Social Media   | 1784         |
| Home Decor       | Social Media   | 1779         |
| Accessories      | Organic        | 1769         | 

- TOP **3** The **lowest** of total_orders :

| product_category | traffic_source | total_orders |
|------------------|----------------|--------------|
| Footwear         | Social Media   | 1596         |
| Fashion          | Organic        | 1654         |
| Home Decor       | Email          | 1679         |

- **Organic** is the most common **traffic source** for **Accessories** (1769).

| product_category | traffic_source | total_orders |
|------------------|----------------|--------------|
| Accessories      | Organic        | 1769         |
| Accessories      | Direct         | 1727         |
| Accessories      | Paid Ads       | 1725         |
| Accessories      | Social Media   | 1702         |
| Accessories      | Email          | 1694         |

- **Organic** is the most common **traffic source** for **Beauty** (1767).

| product_category | traffic_source | total_orders |
|------------------|----------------|--------------|
| Beauty           | Organic        | 1767         |
| Beauty           | Direct         | 1728         |
| Beauty           | Paid Ads       | 1712         |
| Beauty           | Email          | 1698         |
| Beauty           | Social Media   | 1681         |

- **Social Media** is the most common **traffic source** for **Electronics** (1784).

| product_category | traffic_source | total_orders |
|------------------|----------------|--------------|
| Electronics      | Social Media   | 1784         |
| Electronics      | Paid Ads       | 1734         |
| Electronics      | Organic        | 1721         |
| Electronics      | Direct         | 1693         |
| Electronics      | Email          | 1692         |

- **Social Media** is the most common **traffic source** for **Fashion** (1767).

| product_category | traffic_source | total_orders |
|------------------|----------------|--------------|
| Fashion          | Social Media   | 1767         |
| Fashion          | Email          | 1727         |
| Fashion          | Direct         | 1726         |
| Fashion          | Paid Ads       | 1720         |
| Fashion          | Organic        | 1654         |

- **Email** is the most common **traffic source** for **Footwear** (1738).

| product_category | traffic_source | total_orders |
|------------------|----------------|--------------|
| Footwear         | Email          | 1738         |
| Footwear         | Organic        | 1709         |
| Footwear         | Direct         | 1708         |
| Footwear         | Paid Ads       | 1706         |
| Footwear         | Social Media   | 1596         |

- **Social Media** is the most common **traffic source** for **Home Decor** (1779).

| product_category | traffic_source | total_orders |
|------------------|----------------|--------------|
| Home Decor       | Social Media   | 1779         |
| Home Decor       | Organic        | 1748         |
| Home Decor       | Direct         | 1699         |
| Home Decor       | Paid Ads       | 1695         |
| Home Decor       | Email          | 1679         |

- **Paid Ads** is the most common **traffic source** for **Sports** (1726).

| product_category | traffic_source | total_orders |
|------------------|----------------|--------------|
| Sports           | Paid Ads       | 1726         |
| Sports           | Social Media   | 1715         |
| Sports           | Organic        | 1707         |
| Sports           | Email          | 1694         |
| Sports           | Direct         | 1680         |

***
### Distribution ``product_category`` and ``customer_country``

```SQL
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
```  
**Findings**
- TOP **3** The **highest** of total_orders :

| product_category | customer_country | total_orders |
|------------------|------------------|--------------|
| Sports           | Australia        | 1293         |
| Fashion          | Canada           | 1280         |
| Accessories      | UK               | 1277         |

- TOP **3** The **lowest** of total_orders :

| product_category | customer_country | total_orders |
|------------------|------------------|--------------|
| Beauty           | UK               | 1149         |
| Footwear         | Germany          | 1151         |
| Sports           | Canada           | 1157         |

- **UK and Germany** have the most total_orders in **Accessories** category (1277).

| product_category | customer_country | total_orders |
|------------------|------------------|--------------|
| Accessories      | UK               | 1277         |
| Accessories      | Germany          | 1277         |
| Accessories      | UAE              | 1230         |
| Accessories      | USA              | 1221         |
| Accessories      | Australia        | 1209         |
| Accessories      | India            | 1208         |
| Accessories      | Canada           | 1195         |

- **Canada and Australia** have the most total_orders in **Beauty** category (1274).

| product_category | customer_country | total_orders |
|------------------|------------------|--------------|
| Beauty           | Canada           | 1274         |
| Beauty           | Australia        | 1274         |
| Beauty           | UAE              | 1265         |
| Beauty           | Germany          | 1230         |
| Beauty           | India            | 1206         |
| Beauty           | USA              | 1188         |
| Beauty           | UK               | 1149         |

- **UAE** have the most total_orders in **Electronics** category (1273).

| product_category | customer_country | total_orders |
|------------------|------------------|--------------|
| Electronics      | UAE              | 1273         |
| Electronics      | USA              | 1257         |
| Electronics      | Germany          | 1256         |
| Electronics      | UK               | 1224         |
| Electronics      | Canada           | 1208         |
| Electronics      | India            | 1206         |
| Electronics      | Australia        | 1200         |

- **Canada** have the most total_orders in **Fashion** category (1280).

| product_category | customer_country | total_orders |
|------------------|------------------|--------------|
| Fashion          | Canada           | 1280         |
| Fashion          | Australia        | 1251         |
| Fashion          | USA              | 1239         |
| Fashion          | Germany          | 1214         |
| Fashion          | UAE              | 1213         |
| Fashion          | India            | 1206         |
| Fashion          | UK               | 1191         |

- **Australia** have the most total_orders in **Footwear** category (1255).

| product_category | customer_country | total_orders |
|------------------|------------------|--------------|
| Footwear         | Australia        | 1255         |
| Footwear         | Canada           | 1243         |
| Footwear         | India            | 1235         |
| Footwear         | UAE              | 1214         |
| Footwear         | UK               | 1196         |
| Footwear         | USA              | 1163         |
| Footwear         | Germany          | 1151         |

- **UK** have the most total_orders in **Home Decor** category (1238).

| product_category | customer_country | total_orders |
|------------------|------------------|--------------|
| Home Decor       | UK               | 1238         |
| Home Decor       | India            | 1235         |
| Home Decor       | Australia        | 1232         |
| Home Decor       | Germany          | 1232         |
| Home Decor       | Canada           | 1229         |
| Home Decor       | UAE              | 1219         |
| Home Decor       | USA              | 1215         |

- **Australia** have the most total_orders in **Sports** category (1293).

| product_category | customer_country | total_orders |
|------------------|------------------|--------------|
| Sports           | Australia        | 1293         |
| Sports           | India            | 1258         |
| Sports           | Germany          | 1246         |
| Sports           | UK               | 1197         |
| Sports           | USA              | 1186         |
| Sports           | UAE              | 1185         |
| Sports           | Canada           | 1157         |

***
### Distribution ``product_category`` and ``payment_method``

```SQL
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
```  

**Findings**
- TOP **3** The **highest** of total_orders :

| product_category | payment_method   | total_orders |
|------------------|------------------|--------------|
| Fashion          | Cash on Delivery | 1792         |
| Home Decor       | Credit Card      | 1780         |
| Accessories      | Apple Pay        | 1763         |

- TOP **3** The **lowest** of total_orders :

| product_category | payment_method | total_orders |
|------------------|----------------|--------------|
| Sports           | PayPal         | 1630         |
| Footwear         | Debit Card     | 1632         |
| Fashion          | PayPal         | 1644         |

- **Apple Pay** is the most popular payment_method for **Accessories** category (1763).

| product_category | payment_method   | total_orders |
|------------------|------------------|--------------|
| Accessories      | Apple Pay        | 1763         |
| Accessories      | PayPal           | 1736         |
| Accessories      | Credit Card      | 1717         |
| Accessories      | Debit Card       | 1713         |
| Accessories      | Cash on Delivery | 1688         |

- **Credit Card** is the most popular payment_method for **Beauty** category (1758).

| product_category | payment_method   | total_orders |
|------------------|------------------|--------------|
| Beauty           | Credit Card      | 1758         |
| Beauty           | Cash on Delivery | 1754         |
| Beauty           | Debit Card       | 1725         |
| Beauty           | PayPal           | 1685         |
| Beauty           | Apple Pay        | 1664         |

- **PayPal** is the most popular payment_method for **Electronics** category (1759).

| product_category | payment_method   | total_orders |
|------------------|------------------|--------------|
| Electronics      | PayPal           | 1759         |
| Electronics      | Apple Pay        | 1758         |
| Electronics      | Credit Card      | 1712         |
| Electronics      | Debit Card       | 1711         |
| Electronics      | Cash on Delivery | 1684         |

- **Cash on Delivery** is the most popular payment_method for **Fashion** category (1792).

| product_category | payment_method   | total_orders |
|------------------|------------------|--------------|
| Fashion          | Cash on Delivery | 1792         |
| Fashion          | Apple Pay        | 1750         |
| Fashion          | Debit Card       | 1722         |
| Fashion          | Credit Card      | 1686         |
| Fashion          | PayPal           | 1644         |

- **PayPal** is the most popular payment_method for **Footwear** category (1728).

| product_category | payment_method   | total_orders |
|------------------|------------------|--------------|
| Footwear         | PayPal           | 1728         |
| Footwear         | Cash on Delivery | 1713         |
| Footwear         | Apple Pay        | 1711         |
| Footwear         | Credit Card      | 1673         |
| Footwear         | Debit Card       | 1632         |

- **Credit Card** is the most popular payment_method for **Home Decor** category (1780).

| product_category | payment_method   | total_orders |
|------------------|------------------|--------------|
| Home Decor       | Credit Card      | 1780         |
| Home Decor       | PayPal           | 1736         |
| Home Decor       | Apple Pay        | 1727         |
| Home Decor       | Cash on Delivery | 1685         |
| Home Decor       | Debit Card       | 1672         |

- **Debit Card** is the most popular payment_method for **Sports** category (1761).

| product_category | payment_method   | total_orders |
|------------------|------------------|--------------|
| Sports           | Debit Card       | 1761         |
| Sports           | Apple Pay        | 1743         |
| Sports           | Cash on Delivery | 1716         |
| Sports           | Credit Card      | 1672         |
| Sports           | PayPal           | 1630         |

***
### Distribution ``customer_country`` and ``traffic_source``

```SQL
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
```  

**Findings**
- TOP **3** The **highest** of total_orders :

| customer_country | traffic_source | total_orders |
|------------------|----------------|--------------|
| Australia        | Paid Ads       | 1836         |
| Germany          | Social Media   | 1764         |
| UAE              | Organic        | 1754         |

- TOP **3** The **lowest** of total_orders :

| customer_country | traffic_source | total_orders |
|------------------|----------------|--------------|
| USA              | Social Media   | 1654         |
| UAE              | Paid Ads       | 1667         |
| USA              | Paid Ads       | 1674         |

- **Paid Ads** is the most popular traffic_source for **Australia** (1836).

| customer_country | traffic_source | total_orders |
|------------------|----------------|--------------|
| Australia        | Paid Ads       | 1836         |
| Australia        | Organic        | 1751         |
| Australia        | Direct         | 1741         |
| Australia        | Email          | 1695         |
| Australia        | Social Media   | 1691         |

- **Paid Ads** is the most popular traffic_source for **Canada** (1749).

| customer_country | traffic_source | total_orders |
|------------------|----------------|--------------|
| Canada           | Paid Ads       | 1749         |
| Canada           | Social Media   | 1723         |
| Canada           | Organic        | 1718         |
| Canada           | Email          | 1703         |
| Canada           | Direct         | 1693         |

- **Social Media** is the most popular traffic_source for **Germany** (1764).

| customer_country | traffic_source | total_orders |
|------------------|----------------|--------------|
| Germany          | Social Media   | 1764         |
| Germany          | Paid Ads       | 1721         |
| Germany          | Direct         | 1716         |
| Germany          | Email          | 1711         |
| Germany          | Organic        | 1694         |

- **Organic** is the most popular traffic_source for **India** (1722).

| customer_country | traffic_source | total_orders |
|------------------|----------------|--------------|
| India            | Organic        | 1722         |
| India            | Social Media   | 1720         |
| India            | Email          | 1720         |
| India            | Direct         | 1697         |
| India            | Paid Ads       | 1695         |

- **Organic** is the most popular traffic_source for **UAE** (1754).

| customer_country | traffic_source | total_orders |
|------------------|----------------|--------------|
| UAE              | Organic        | 1754         |
| UAE              | Direct         | 1732         |
| UAE              | Email          | 1723         |
| UAE              | Social Media   | 1723         |
| UAE              | Paid Ads       | 1667         |

- **Social Media** is the most popular traffic_source for **UK** (1749).

| customer_country | traffic_source | total_orders |
|------------------|----------------|--------------|
| UK               | Social Media   | 1749         |
| UK               | Organic        | 1688         |
| UK               | Email          | 1681         |
| UK               | Direct         | 1678         |
| UK               | Paid Ads       | 1676         |

- **Organic** is the most popular traffic_source for **USA** (1748).

| customer_country | traffic_source | total_orders |
|------------------|----------------|--------------|
| USA              | Organic        | 1748         |
| USA              | Direct         | 1704         |
| USA              | Email          | 1689         |
| USA              | Paid Ads       | 1674         |
| USA              | Social Media   | 1654         |

***
### Distribution ``customer_country`` and ``payment_method``

```SQL
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
```  

**Findings**
- TOP **3** The **highest** of total_orders :

| customer_country | payment_method | total_orders |
|------------------|----------------|--------------|
| Australia        | Credit Card    | 1799         |
| Germany          | Apple Pay      | 1780         |
| USA              | Apple Pay      | 1777         |

- TOP **3** The **lowest** of total_orders :

| customer_country | payment_method | total_orders |
|------------------|----------------|--------------|
| USA              | Credit Card    | 1635         |
| USA              | Debit Card     | 1652         |
| USA              | PayPal         | 1656         |

- **Credit Card** is the most popular payment_method for **Australia** (1799).

| customer_country | payment_method   | total_orders |
|------------------|------------------|--------------|
| Australia        | Credit Card      | 1799         |
| Australia        | Cash on Delivery | 1775         |
| Australia        | PayPal           | 1746         |
| Australia        | Debit Card       | 1715         |
| Australia        | Apple Pay        | 1679         |

- **Debit Card** is the most popular payment_method for **Canada** (1760).

| customer_country | payment_method   | total_orders |
|------------------|------------------|--------------|
| Canada           | Debit Card       | 1760         |
| Canada           | Cash on Delivery | 1732         |
| Canada           | PayPal           | 1703         |
| Canada           | Credit Card      | 1696         |
| Canada           | Apple Pay        | 1695         |

- **Apple Pay** is the most popular payment_method for **Germany** (1780).

| customer_country | payment_method   | total_orders |
|------------------|------------------|--------------|
| Germany          | Apple Pay        | 1780         |
| Germany          | Cash on Delivery | 1726         |
| Germany          | Debit Card       | 1716         |
| Germany          | PayPal           | 1699         |
| Germany          | Credit Card      | 1685         |

- **Credit Card** is the most popular payment_method for **India** (1763).

| customer_country | payment_method   | total_orders |
|------------------|------------------|--------------|
| India            | Credit Card      | 1763         |
| India            | Cash on Delivery | 1715         |
| India            | Debit Card       | 1692         |
| India            | PayPal           | 1692         |
| India            | Apple Pay        | 1692         |

- **Apple Pay** is the most popular payment_method for **UAE** (1758).

| customer_country | payment_method   | total_orders |
|------------------|------------------|--------------|
| UAE              | Apple Pay        | 1758         |
| UAE              | Credit Card      | 1735         |
| UAE              | PayPal           | 1722         |
| UAE              | Debit Card       | 1713         |
| UAE              | Cash on Delivery | 1671         |

- **Apple Pay** is the most popular payment_method for **UK** (1735).

| customer_country | payment_method   | total_orders |
|------------------|------------------|--------------|
| UK               | Apple Pay        | 1735         |
| UK               | PayPal           | 1700         |
| UK               | Debit Card       | 1688         |
| UK               | Credit Card      | 1685         |
| UK               | Cash on Delivery | 1664         |

- **Apple Pay** is the most popular payment_method for **USA** (1777).

| customer_country | payment_method   | total_orders |
|------------------|------------------|--------------|
| USA              | Apple Pay        | 1777         |
| USA              | Cash on Delivery | 1749         |
| USA              | PayPal           | 1656         |
| USA              | Debit Card       | 1652         |
| USA              | Credit Card      | 1635         |

***
### Distribution ``traffic_source`` and ``payment_method``

```SQL
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
```  

**Findings**
- TOP **3** The **highest** of total_orders :

| traffic_source | payment_method   | total_orders |
|----------------|------------------|--------------|
| Paid Ads       | Apple Pay        | 2473         |
| Social Media   | Apple Pay        | 2458         |
| Social Media   | Cash on Delivery | 2458         |

- TOP **3** The **lowest** of total_orders :

| traffic_source | payment_method   | total_orders |
|----------------|------------------|--------------|
| Direct         | PayPal           | 2301         |
| Email          | Cash on Delivery | 2336         |
| Paid Ads       | Credit Card      | 2336         |

- **Credit Card** was the most common payment method among **Direct orders**, with 2453 orders.

| traffic_source | payment_method   | total_orders |
|----------------|------------------|--------------|
| Direct         | Credit Card      | 2453         |
| Direct         | Cash on Delivery | 2421         |
| Direct         | Debit Card       | 2405         |
| Direct         | Apple Pay        | 2381         |
| Direct         | PayPal           | 2301         |

- **Credit Card** was the most common payment method among **Email**, with 2428 orders.

| traffic_source | payment_method   | total_orders |
|----------------|------------------|--------------|
| Email          | Credit Card      | 2428         |
| Email          | Apple Pay        | 2405         |
| Email          | PayPal           | 2395         |
| Email          | Debit Card       | 2358         |
| Email          | Cash on Delivery | 2336         |

- **PayPal** was the most common payment method among **Organic**, with 2446 orders.

| traffic_source | payment_method   | total_orders |
|----------------|------------------|--------------|
| Organic        | PayPal           | 2446         |
| Organic        | Credit Card      | 2436         |
| Organic        | Debit Card       | 2408         |
| Organic        | Apple Pay        | 2399         |
| Organic        | Cash on Delivery | 2386         |

- **Apple Pay** was the most common payment method among **Paid Ads**, with 2473 orders.

| traffic_source | payment_method   | total_orders |
|----------------|------------------|--------------|
| Paid Ads       | Apple Pay        | 2473         |
| Paid Ads       | Cash on Delivery | 2431         |
| Paid Ads       | PayPal           | 2391         |
| Paid Ads       | Debit Card       | 2387         |
| Paid Ads       | Credit Card      | 2336         |

- **Cash on Delivery and Apple Pay** was the most common payment method among **Social Media**, with 2458 orders.

| traffic_source | payment_method   | total_orders |
|----------------|------------------|--------------|
| Social Media   | Cash on Delivery | 2458         |
| Social Media   | Apple Pay        | 2458         |
| Social Media   | PayPal           | 2385         |
| Social Media   | Debit Card       | 2378         |
| Social Media   | Credit Card      | 2345         |

***
### Distribution YEARS and ``product_category``

```SQL
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
```  

**Findings**
- TOP **3** The **highest** of total_orders :

| Order_Year | payment_method   | total_orders |
|------------|------------------|--------------|
| 2024       | Apple Pay        | 5021         |
| 2024       | Debit Card       | 4943         |
| 2023       | Cash on Delivery | 4908         |

- TOP **3** The **lowest** of total_orders :

| Order_Year | payment_method | total_orders |
|------------|----------------|--------------|
| 2025       | Debit Card     | 2116         |
| 2025       | PayPal         | 2280         |
| 2025       | Credit Card    | 2292         |

- **Cash on Delivery** was the most  popular payment_method in **2023**, with 4908 orders.

| Order_Year | payment_method   | total_orders |
|------------|------------------|--------------|
| 2023       | Cash on Delivery | 4908         |
| 2023       | Debit Card       | 4877         |
| 2023       | Credit Card      | 4859         |
| 2023       | PayPal           | 4811         |
| 2023       | Apple Pay        | 4790         |

- **Apple Pay** was the most  popular payment_method in **2024**, with 5021 orders.

| Order_Year | payment_method   | total_orders |
|------------|------------------|--------------|
| 2024       | Apple Pay        | 5021         |
| 2024       | Debit Card       | 4943         |
| 2024       | Credit Card      | 4847         |
| 2024       | PayPal           | 4827         |
| 2024       | Cash on Delivery | 4814         |

- **Cash on Deliver** was the most popular payment_method in **2025**, with 2310 orders.

| Order_Year | payment_method   | total_orders |
|------------|------------------|--------------|
| 2025       | Cash on Delivery | 2310         |
| 2025       | Apple Pay        | 2305         |
| 2025       | Credit Card      | 2292         |
| 2025       | PayPal           | 2280         |
| 2025       | Debit Card       | 2116         |


***
### Distribution YEARS and ``customer_country``

```SQL
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
```  

**Findings**
- TOP **3** The **highest** of total_orders :

| Order_Year | customer_country | total_orders |
|------------|------------------|--------------|
| 2024       | Australia        | 3578         |
| 2024       | Canada           | 3534         |
| 2023       | Germany          | 3498         |

- TOP **3** The **lowest** of total_orders :

| Order_Year | customer_country | total_orders |
|------------|------------------|--------------|
| 2025       | UK               | 1564         |
| 2025       | Canada           | 1578         |
| 2025       | USA              | 1617         |

- **Germany** was the most popular customer_country in **2023**, with 3498 orders.

| Order_Year | customer_country | total_orders |
|------------|------------------|--------------|
| 2023       | Germany          | 3498         |
| 2023       | Australia        | 3479         |
| 2023       | UAE              | 3477         |
| 2023       | Canada           | 3474         |
| 2023       | India            | 3448         |
| 2023       | UK               | 3446         |
| 2023       | USA              | 3423         |

- **Australia** was the most popular customer_country in **2024**, with 3578 orders.

| Order_Year | customer_country | total_orders |
|------------|------------------|--------------|
| 2024       | Australia        | 3578         |
| 2024       | Canada           | 3534         |
| 2024       | Germany          | 3488         |
| 2024       | India            | 3484         |
| 2024       | UAE              | 3477         |
| 2024       | UK               | 3462         |
| 2024       | USA              | 3429         |

- **Australia** was the most popular customer_country in **2025**, with 1657 orders.

| Order_Year | customer_country | total_orders |
|------------|------------------|--------------|
| 2025       | Australia        | 1657         |
| 2025       | UAE              | 1645         |
| 2025       | India            | 1622         |
| 2025       | Germany          | 1620         |
| 2025       | USA              | 1617         |
| 2025       | Canada           | 1578         |
| 2025       | UK               | 1564         |

***
### Distribution YEARS and ``traffic_source``

```SQL
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
```  

**Findings**
- TOP **3** The **highest** of total_orders :

| Order_Year | traffic_source | total_orders |
|------------|----------------|--------------|
| 2024       | Social Media   | 4932         |
| 2024       | Organic        | 4901         |
| 2024       | Direct         | 4888         |

- TOP **3** The **lowest** of total_orders :

| Order_Year | traffic_source | total_orders |
|------------|----------------|--------------|
| 2025       | Social Media   | 2212         |
| 2025       | Direct         | 2233         |
| 2025       | Email          | 2233         |

- **Social Media** was the most popular traffic_source in **2023**, with 4880 orders.

| Order_Year | traffic_source | total_orders |
|------------|----------------|--------------|
| 2023       | Social Media   | 4880         |
| 2023       | Paid Ads       | 4879         |
| 2023       | Direct         | 4840         |
| 2023       | Email          | 4838         |
| 2023       | Organic        | 4808         |

- **Social Media** was the most popular traffic_source in **2024**, with 4932 orders.

| Order_Year | traffic_source | total_orders |
|------------|----------------|--------------|
| 2024       | Social Media   | 4932         |
| 2024       | Organic        | 4901         |
| 2024       | Direct         | 4888         |
| 2024       | Paid Ads       | 4880         |
| 2024       | Email          | 4851         |

- **Organic** was the most popular traffic_source in **2025**, with 2366 orders.

| Order_Year | traffic_source | total_orders |
|------------|----------------|--------------|
| 2025       | Organic        | 2366         |
| 2025       | Paid Ads       | 2259         |
| 2025       | Direct         | 2233         |
| 2025       | Email          | 2233         |
| 2025       | Social Media   | 2212         |

***
### Distribution YEARS and ``payment_method``

```SQL
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
```  

**Findings**
- TOP **3** The **highest** of total_orders :

| Order_Year | payment_method   | total_orders |
|------------|------------------|--------------|
| 2024       | Apple Pay        | 5021         |
| 2024       | Debit Card       | 4943         |
| 2023       | Cash on Delivery | 4908         |

- TOP **3** The **lowest** of total_orders :

| Order_Year | payment_method | total_orders |
|------------|----------------|--------------|
| 2025       | Debit Card     | 2116         |
| 2025       | PayPal         | 2280         |
| 2025       | Credit Card    | 2292         |

- **Cash on Delivery** was the most popular payment_method in **2023**, with 4908 orders.

| Order_Year | payment_method   | total_orders |
|------------|------------------|--------------|
| 2023       | Cash on Delivery | 4908         |
| 2023       | Debit Card       | 4877         |
| 2023       | Credit Card      | 4859         |
| 2023       | PayPal           | 4811         |
| 2023       | Apple Pay        | 4790         |

- **Apple Pay** was the most popular payment_method in **2024**, with 5021 orders.

| Order_Year | payment_method   | total_orders |
|------------|------------------|--------------|
| 2024       | Apple Pay        | 5021         |
| 2024       | Debit Card       | 4943         |
| 2024       | Credit Card      | 4847         |
| 2024       | PayPal           | 4827         |
| 2024       | Cash on Delivery | 4814         |

- **Cash on Delivery** was the most popular payment_method in **2025**, with 2310 orders.

| Order_Year | payment_method   | total_orders |
|------------|------------------|--------------|
| 2025       | Cash on Delivery | 2310         |
| 2025       | Apple Pay        | 2305         |
| 2025       | Credit Card      | 2292         |
| 2025       | PayPal           | 2280         |
| 2025       | Debit Card       | 2116         |

***

### ``product_price`` by ``product_category``
```SQL
select product_category, CAST(AVG(product_price) AS decimal(10,2)) as 'Average Price',
CAST(MAX(product_price) AS decimal(10,2)) as 'MAX Price',
CAST(MIN(product_price) AS decimal(10,2)) as 'MIN Price'
from shopify_sales
group by product_category
order by product_category ASC;
```  

| product_category | Average Price | MAX Price | MIN Price |
|------------------|---------------|-----------|-----------|
| Accessories      | 404.12        | 799.88    | 5.03      |
| Beauty           | 403.93        | 799.97    | 5.21      |
| Electronics      | 405.81        | 799.94    | 5.47      |
| Fashion          | 397.65        | 799.99    | 5.13      |
| Footwear         | 403.20        | 799.97    | 5.01      |
| Home Decor       | 402.98        | 799.87    | 5.02      |
| Sports           | 406.30        | 799.97    | 5.01      |  

**Findings**  
- Average product prices are relatively consistent across categories, ranging from **397.65** for Fashion to **406.30** for Sports.
- Price range are also approximately the same across all categories, ranging around **5** to **800**

### ``quantity`` by ``product_category``
```SQL
select product_category, CAST(AVG(quantity) AS decimal(10,2)) as 'Average quantity',
CAST(MAX(quantity) AS decimal(10,2)) as 'MAX quantity',
CAST(MIN(quantity) AS decimal(10,2)) as 'MIN quantity',
SUM(quantity) as 'Total quantity'
from shopify_sales
group by product_category
order by SUM(quantity)DESC, product_category ASC;
```  

| product_category | Average quantity | MAX quantity | MIN quantity | Total quantity |
|------------------|------------------|--------------|--------------|----------------|
| Electronics      | 3.00             | 5.00         | 1.00         | 26075          |
| Accessories      | 3.00             | 5.00         | 1.00         | 26060          |
| Fashion          | 3.00             | 5.00         | 1.00         | 25925          |
| Home Decor       | 3.00             | 5.00         | 1.00         | 25907          |
| Beauty           | 2.00             | 5.00         | 1.00         | 25757          |
| Sports           | 2.00             | 5.00         | 1.00         | 25500          |
| Footwear         | 2.00             | 5.00         | 1.00         | 25350          |  

**Findings**  
- Average quantity are relatively consistent across categories, separate into 2 groups **average** of **2** and **3** .
- Quantity range are the same across all 7 categories, started from **1** to **5**.
- The **Highest** sold quantity is **Electronics**(26075).
- The **Lowest** sold quantity is **Footwear**(25350).

### ``shipping_cost`` by ``product_category``
```SQL
select product_category, CAST(AVG(shipping_cost) AS decimal(10,2)) as 'Average shipping_cost',
CAST(MAX(shipping_cost) AS decimal(10,2)) as 'MAX shipping_cost',
CAST(MIN(shipping_cost) AS decimal(10,2)) as 'MIN shipping_cost'
from shopify_sales
group by product_category
order by product_category ASC;
```  

| product_category | Average shipping_cost | MAX shipping_cost | MIN shipping_cost |
|------------------|-----------------------|-------------------|-------------------|
| Accessories      | 13.49                 | 25.00             | 2.01              |
| Beauty           | 13.49                 | 25.00             | 2.00              |
| Electronics      | 13.48                 | 24.99             | 2.00              |
| Fashion          | 13.64                 | 25.00             | 2.00              |
| Footwear         | 13.46                 | 25.00             | 2.00              |
| Home Decor       | 13.63                 | 25.00             | 2.00              |
| Sports           | 13.47                 | 24.99             | 2.01              |  

**Findings**  
- Average shipping_cost are relatively consistent across categories, with **Footwear** having **Lowest** Average to **Fashion** having **highest**.
- Quantity range are nearly the same across all categories, mostly started from **2** to **25**.

### ``rating`` by ``product_category``
```SQL
select product_category, CAST(AVG(rating) AS decimal(10,2)) as 'Average rating',
CAST(MAX(rating) AS decimal(10,2)) as 'MAX rating',
CAST(MIN(rating) AS decimal(10,2)) as 'MIN rating'
from shopify_sales
group by product_category
order by AVG(rating) DESC, product_category ASC;
```  

| product_category | Average rating | MAX rating | MIN rating |
|------------------|----------------|------------|------------|
| Electronics      | 3.02           | 5.00       | 1.00       |
| Footwear         | 3.01           | 5.00       | 1.00       |
| Sports           | 3.01           | 5.00       | 1.00       |
| Home Decor       | 3.01           | 5.00       | 1.00       |
| Beauty           | 3.00           | 5.00       | 1.00       |
| Accessories      | 2.99           | 5.00       | 1.00       |
| Fashion          | 2.98           | 5.00       | 1.00       |  

**Findings**  
- **Electronics** is the **Highest** average rating (**3.02**), while **Fashion** is the **Lowest** (**2.98**)
- Rating range are the same across all categories, started from **1** to **5**.

### ``revenue`` by ``product_category``
```SQL
select product_category, CAST(AVG(revenue) AS decimal(10,2)) as 'Average revenue',
CAST(MAX(revenue) AS decimal(10,2)) as 'MAX revenue',
CAST(MIN(revenue) AS decimal(10,2)) as 'MIN revenue',
CAST(SUM(revenue) AS decimal(10,2)) as 'Total revenue'
from shopify_sales
group by product_category
order by SUM(revenue) DESC, product_category ASC;
```  

| product_category | Average revenue | MAX revenue | MIN revenue | Total revenue |
|------------------|-----------------|-------------|-------------|---------------|
| Electronics      | 1010.82         | 3998.75     | 5.64        | 8717301.49    |
| Accessories      | 999.09          | 3983.15     | 4.50        | 8609171.52    |
| Home Decor       | 993.70          | 3990.20     | 3.82        | 8545840.45    |
| Beauty           | 995.21          | 3963.15     | 4.53        | 8544881.95    |
| Fashion          | 982.67          | 3984.75     | 3.26        | 8445072.67    |
| Sports           | 989.76          | 3993.10     | 4.26        | 8434698.81    |
| Footwear         | 987.23          | 3999.50     | 3.08        | 8348968.69    |

**Findings**  
- **Electronics** is the **Highest** average revenue (**1010.82**), while **Fashion** is the **Lowest** (**982.67**)
- Also, **Electronics** is the **Highest** total  revenue (**8.71M**) and **Footwear** is the **Lowest** (**8.34M**)
- Revenue ranging around **3** to **4000**.

### ``profit`` by ``product_category``
```SQL
select product_category, CAST(AVG(profit) AS decimal(10,2)) as 'Average profit',
CAST(MAX(profit) AS decimal(10,2)) as 'MAX profit',
CAST(MIN(profit) AS decimal(10,2)) as 'MIN profit',
CAST(SUM(profit) AS decimal(10,2)) as 'Total profit'
from shopify_sales
group by product_category
order by SUM(profit) DESC, product_category ASC;
```  

| product_category | Average profit | MAX profit | MIN profit | Total profit |
|------------------|----------------|------------|------------|--------------|
| Electronics      | 997.34         | 3983.31    | -18.69     | 8601068.01   |
| Accessories      | 985.60         | 3974.61    | -16.89     | 8492938.90   |
| Beauty           | 981.72         | 3954.92    | -18.02     | 8429076.60   |
| Home Decor       | 980.08         | 3968.58    | -18.83     | 8428664.14   |
| Fashion          | 969.03         | 3967.01    | -16.39     | 8327844.15   |
| Sports           | 976.29         | 3986.81    | -17.12     | 8319929.75   |
| Footwear         | 973.76         | 3989.95    | -20.49     | 8235108.55   |  

**Findings**  

- **Electronics** generated the highest total profit at approximately **8.60M**, while **Footwear** generated the lowest at approximately **8.24M**.
- Average profit was relatively similar across categories, ranging from **969.03** to **997.34**.
- **All categories recorded negative minimum profits**, with Footwear having the lowest at **-20.49**, indicating that some products were sold at a loss.


***
### ``product_price`` by ``Years``
```SQL
select YEAR(order_date) as Years, CAST(AVG(product_price) AS decimal(10,2)) as 'Average price',
CAST(MAX(product_price) AS decimal(10,2)) as 'MAX price',
CAST(MIN(product_price) AS decimal(10,2)) as 'MIN price'
from shopify_sales
group by YEAR(order_date)
order by YEAR(order_date) ASC;
```  
| Years | Average price | MAX price | MIN price |
|-------|---------------|-----------|-----------|
| 2023  | 404.35        | 799.94    | 5.01      |
| 2024  | 401.90        | 799.99    | 5.29      |
| 2025  | 404.75        | 799.94    | 5.03      |

**Findings**
- Average product prices remained relatively stable from **2023** to **2025**, ranging from **401.90** to **404.75**. **Maximum** and **minimum** prices also remained consistent across the three years.

### ``quantity`` by ``Years``
```SQL
select YEAR(order_date) as Years, CAST(AVG(quantity) AS decimal(10,2)) as 'Average quantity',
CAST(MAX(quantity) AS decimal(10,2)) as 'MAX quantity',
CAST(MIN(quantity) AS decimal(10,2)) as 'MIN quantity',
CAST(SUM(quantity) AS decimal(10,2)) as 'Total quantity'
from shopify_sales
group by YEAR(order_date)
order by SUM(quantity) DESC,YEAR(order_date) ASC;
```  
| Years | Average quantity | MAX quantity | MIN quantity | Total quantity |
|-------|------------------|--------------|--------------|----------------|
| 2024  | 3.00             | 5.00         | 1.00         | 73544.00       |
| 2023  | 3.00             | 5.00         | 1.00         | 72803.00       |
| 2025  | 3.00             | 5.00         | 1.00         | 34227.00       |

**Findings**
- Average quantity remained stable at 3 units per order from 2023 to 2025, while total quantity decreased significantly in 2025.
### ``shipping_cost`` by ``Years``
```SQL
select YEAR(order_date) as Years, CAST(AVG(shipping_cost) AS decimal(10,2)) as 'Average shipping_cost',
CAST(MAX(shipping_cost) AS decimal(10,2)) as 'MAX shipping_cost',
CAST(MIN(shipping_cost) AS decimal(10,2)) as 'MIN shipping_cost',
CAST(SUM(shipping_cost) AS decimal(10,2)) as 'Total shipping_cost'
from shopify_sales
group by YEAR(order_date)
order by SUM(shipping_cost) DESC,YEAR(order_date) ASC;
```  
| Years | Average shipping_cost | MAX shipping_cost | MIN shipping_cost | Total shipping_cost |
|-------|-----------------------|-------------------|-------------------|---------------------|
| 2024  | 13.53                 | 25.00             | 2.00              | 330850.26           |
| 2023  | 13.52                 | 25.00             | 2.00              | 327688.26           |
| 2025  | 13.52                 | 25.00             | 2.00              | 152766.96           |  

**Findings**
- Average shipping cost remained stable at around 13.52–13.53 from 2023 to 2025, while total shipping cost decreased significantly in 2025.
### ``rating`` by ``Years``
```SQL
select YEAR(order_date) as Years, CAST(AVG(rating) AS decimal(10,2)) as 'Average rating',
CAST(MAX(rating) AS decimal(10,2)) as 'MAX rating',
CAST(MIN(rating) AS decimal(10,2)) as 'MIN rating'
from shopify_sales
group by YEAR(order_date)
order by AVG(rating) DESC,YEAR(order_date) ASC;
```  
| Years | Average rating | MAX rating | MIN rating |
|-------|----------------|------------|------------|
| 2023  | 3.01           | 5.00       | 1.00       |
| 2024  | 3.00           | 5.00       | 1.00       |
| 2025  | 2.99           | 5.00       | 1.00       |

**Findings**
- The average rating slightly decreased from 3.01 in 2023 to 2.99 in 2025, while the minimum and maximum ratings remained constant at 1.00 and 5.00.
### ``revenue`` by ``Years``
```SQL
select YEAR(order_date) as Years, CAST(AVG(revenue) AS decimal(10,2)) as 'Average revenue',
CAST(MAX(revenue) AS decimal(10,2)) as 'MAX revenue',
CAST(MIN(revenue) AS decimal(10,2)) as 'MIN revenue',
CAST(SUM(revenue) AS decimal(10,2)) as 'Total revenue'
from shopify_sales
group by YEAR(order_date)
order by SUM(revenue) DESC,YEAR(order_date) ASC;
```  
| Years | Average revenue | MAX revenue | MIN revenue | Total revenue |
|-------|-----------------|-------------|-------------|---------------|
| 2024  | 990.82          | 3998.75     | 3.26        | 24227620.05   |
| 2023  | 994.71          | 3999.50     | 3.82        | 24116735.92   |
| 2025  | 999.87          | 3993.55     | 3.08        | 11301579.61   |

**Findings**
- Average revenue remained relatively stable from 2023 to 2025, ranging from 990.82 to 999.87. However, total revenue decreased significantly in 2025, from 24.23 million in 2024 to 11.30 million.
### ``profit`` by ``Years``
```SQL
select YEAR(order_date) as Years, CAST(AVG(profit) AS decimal(10,2)) as 'Average profit',
CAST(MAX(profit) AS decimal(10,2)) as 'MAX profit',
CAST(MIN(profit) AS decimal(10,2)) as 'MIN profit',
CAST(SUM(profit) AS decimal(10,2)) as 'Total profit'
from shopify_sales
group by YEAR(order_date)
order by SUM(profit) DESC,YEAR(order_date) ASC;
```  
| Years | Average profit | MAX profit | MIN profit | Total profit |
|-------|----------------|------------|------------|--------------|
| 2024  | 977.29         | 3986.81    | -17.89     | 23896769.79  |
| 2023  | 981.19         | 3989.95    | -18.83     | 23789047.66  |
| 2025  | 986.36         | 3984.80    | -20.49     | 11148812.65  |
**Findings**
- Average profit remained relatively stable from 2023 to 2025, ranging from 977.29 to 986.36. However, total profit decreased significantly in 2025, from 23.90 million in 2024 to 11.15 million. Additionally, all three years recorded negative minimum profit values, indicating that some transactions resulted in losses.
***
### ``product_price`` by ``traffic_source``
```SQL
select traffic_source, CAST(AVG(product_price) AS decimal(10,2)) as 'Average price',
CAST(MAX(product_price) AS decimal(10,2)) as 'MAX price',
CAST(MIN(product_price) AS decimal(10,2)) as 'MIN price'
from shopify_sales
group by traffic_source
order by AVG(product_price) DESC,traffic_source ASC;
```  
| traffic_source | Average price | MAX price | MIN price |
|----------------|---------------|-----------|-----------|
| Paid Ads       | 405.52        | 799.91    | 5.30      |
| Organic        | 403.72        | 799.99    | 5.02      |
| Direct         | 402.99        | 799.97    | 5.01      |
| Social Media   | 402.60        | 799.97    | 5.01      |
| Email          | 402.30        | 799.96    | 5.28      |

**Findings**
- Average product prices were relatively similar across all traffic sources, ranging from 402.30 to 405.52. Paid Ads had the highest average price at 405.52, while Email had the lowest at 402.30. The maximum and minimum prices were also consistent across traffic sources, ranging from approximately 5 to 800.

### ``quantity`` by ``traffic_source``
```SQL
select traffic_source, CAST(AVG(quantity) AS decimal(10,2)) as 'Average quantity',
CAST(MAX(quantity) AS decimal(10,2)) as 'MAX quantity',
CAST(MIN(quantity) AS decimal(10,2)) as 'MIN quantity',
CAST(SUM(quantity) AS decimal(10,2)) as 'Total quantity'
from shopify_sales
group by traffic_source
order by SUM(quantity) DESC,traffic_source ASC;
```  
| traffic_source | Average quantity | MAX quantity | MIN quantity | Total quantity |
|----------------|------------------|--------------|--------------|----------------|
| Social Media   | 3.00             | 5.00         | 1.00         | 36402.00       |
| Direct         | 3.00             | 5.00         | 1.00         | 36151.00       |
| Paid Ads       | 3.00             | 5.00         | 1.00         | 36077.00       |
| Organic        | 2.00             | 5.00         | 1.00         | 36025.00       |
| Email          | 3.00             | 5.00         | 1.00         | 35919.00       |

**Findings**
- Total quantity was relatively similar across all traffic sources, ranging from 35,919 to 36,402 units. Most traffic sources had an average quantity of 3 units per order, while Organic had a slightly lower average of 2 units.
### ``shipping_cost`` by ``traffic_source``
```SQL
select traffic_source,CAST(AVG(shipping_cost) AS decimal(10,2)) as 'Average shipping_cost',
CAST(MAX(shipping_cost) AS decimal(10,2)) as 'MAX shipping_cost',
CAST(MIN(shipping_cost) AS decimal(10,2)) as 'MIN shipping_cost',
CAST(SUM(shipping_cost) AS decimal(10,2)) as 'Total shipping_cost'
from shopify_sales
group by traffic_source
order by SUM(shipping_cost) DESC,traffic_source ASC;
```  
| traffic_source | Average shipping_cost | MAX shipping_cost | MIN shipping_cost | Total shipping_cost |
|----------------|-----------------------|-------------------|-------------------|---------------------|
| Organic        | 13.55                 | 25.00             | 2.00              | 163674.26           |
| Paid Ads       | 13.58                 | 25.00             | 2.00              | 163149.58           |
| Email          | 13.56                 | 25.00             | 2.00              | 161625.58           |
| Direct         | 13.51                 | 25.00             | 2.00              | 161572.99           |
| Social Media   | 13.41                 | 25.00             | 2.00              | 161283.07           |

**Findings**
- Average shipping cost remained relatively stable across all traffic sources, ranging from 13.41 to 13.58. Organic had the highest total shipping cost at 163,674.26, while Social Media had the lowest at 161,283.07.
### ``rating`` by ``traffic_source``
```SQL
select traffic_source, CAST(AVG(rating) AS decimal(10,2)) as 'Average rating',
CAST(MAX(rating) AS decimal(10,2)) as 'MAX rating',
CAST(MIN(rating) AS decimal(10,2)) as 'MIN rating'
from shopify_sales
group by traffic_source
order by AVG(rating) DESC,traffic_source ASC;
```  
| traffic_source | Average rating | MAX rating | MIN rating |
|----------------|----------------|------------|------------|
| Social Media   | 3.01           | 5.00       | 1.00       |
| Organic        | 3.00           | 5.00       | 1.00       |
| Email          | 3.00           | 5.00       | 1.00       |
| Direct         | 3.00           | 5.00       | 1.00       |
| Paid Ads       | 3.00           | 5.00       | 1.00       |

**Findings**
- Average ratings were highly consistent across all traffic sources, ranging from 3.00 to 3.01. The minimum and maximum ratings were also identical across all sources at 1.00 and 5.00, respectively.
### ``revenue`` by ``traffic_source``
```SQL
select traffic_source, CAST(AVG(revenue) AS decimal(10,2)) as 'Average revenue',
CAST(MAX(revenue) AS decimal(10,2)) as 'MAX revenue',
CAST(MIN(revenue) AS decimal(10,2)) as 'MIN revenue',
CAST(SUM(revenue) AS decimal(10,2)) as 'Total revenue'
from shopify_sales
group by traffic_source
order by SUM(revenue) DESC,traffic_source ASC;
```  
| traffic_source | Average revenue | MAX revenue | MIN revenue | Total revenue |
|----------------|-----------------|-------------|-------------|---------------|
| Social Media   | 999.82          | 3990.30     | 3.26        | 12021807.48   |
| Direct         | 999.34          | 3999.50     | 3.53        | 11953141.33   |
| Paid Ads       | 993.46          | 3992.20     | 4.26        | 11939378.20   |
| Organic        | 986.14          | 3998.75     | 3.08        | 11907664.90   |
| Email          | 991.78          | 3993.55     | 4.60        | 11823943.67   |

**Findings**
- Total revenue was relatively similar across traffic sources, ranging from 11.82 million to 12.02 million. Social Media generated the highest total revenue at 12.02 million, while Email generated the lowest at 11.82 million. Average revenue also remained relatively stable, ranging from 986.14 to 999.82.
### ``profit`` by ``traffic_source``
```SQL
select traffic_source, CAST(AVG(profit) AS decimal(10,2)) as 'Average profit',
CAST(MAX(profit) AS decimal(10,2)) as 'MAX profit',
CAST(MIN(profit) AS decimal(10,2)) as 'MIN profit',
CAST(SUM(profit) AS decimal(10,2)) as 'Total profit'
from shopify_sales
group by traffic_source
order by SUM(profit) DESC,traffic_source ASC;
```  
| traffic_source | Average profit | MAX profit | MIN profit | Total profit |
|----------------|----------------|------------|------------|--------------|
| Social Media   | 986.40         | 3981.17    | -18.69     | 11860524.41  |
| Direct         | 985.83         | 3989.95    | -18.02     | 11791568.34  |
| Paid Ads       | 979.88         | 3977.12    | -17.12     | 11776228.62  |
| Organic        | 972.59         | 3983.31    | -20.49     | 11743990.64  |
| Email          | 978.22         | 3984.80    | -18.83     | 11662318.09  |
**Findings**
- Profit was relatively consistent across traffic sources, with total profit ranging from 11.66 million to 11.86 million. Social Media generated the highest total profit, while Email generated the lowest. However, all traffic sources recorded negative minimum profit values, indicating that some transactions resulted in losses.
***
### ``product_price`` by ``customer_country``
```SQL
select customer_country, CAST(AVG(product_price) AS decimal(10,2)) as 'Average price',
CAST(MAX(product_price) AS decimal(10,2)) as 'MAX price',
CAST(MIN(product_price) AS decimal(10,2)) as 'MIN price'
from shopify_sales
group by customer_country
order by AVG(product_price) DESC,customer_country ASC;
```  
| customer_country | Average price | MAX price | MIN price |
|------------------|---------------|-----------|-----------|
| Canada           | 405.20        | 799.81    | 5.07      |
| Germany          | 404.70        | 799.96    | 5.23      |
| Australia        | 404.67        | 799.97    | 5.01      |
| UAE              | 403.41        | 799.97    | 5.02      |
| USA              | 402.84        | 799.99    | 5.19      |
| UK               | 401.81        | 799.97    | 5.01      |
| India            | 401.31        | 799.75    | 5.13      |

**Findings**
- Average product prices were very similar across countries, from 401.31 to 405.20. Canada had the highest average and India the lowest. Min and max prices were about the same everywhere (around 5 to 800).

### ``quantity`` by ``customer_country``
```SQL
select customer_country, CAST(AVG(quantity) AS decimal(10,2)) as 'Average quantity',
CAST(MAX(quantity) AS decimal(10,2)) as 'MAX quantity',
CAST(MIN(quantity) AS decimal(10,2)) as 'MIN quantity',
CAST(SUM(quantity) AS decimal(10,2)) as 'Total quantity'
from shopify_sales
group by customer_country
order by SUM(quantity) DESC,customer_country ASC;
```  
| customer_country | Average quantity | MAX quantity | MIN quantity | Total quantity |
|------------------|------------------|--------------|--------------|----------------|
| Australia        | 3.00             | 5.00         | 1.00         | 26258.00       |
| Germany          | 3.00             | 5.00         | 1.00         | 25986.00       |
| UAE              | 3.00             | 5.00         | 1.00         | 25889.00       |
| India            | 3.00             | 5.00         | 1.00         | 25774.00       |
| Canada           | 2.00             | 5.00         | 1.00         | 25652.00       |
| USA              | 3.00             | 5.00         | 1.00         | 25621.00       |
| UK               | 2.00             | 5.00         | 1.00         | 25394.00       |

**Findings**
- Total quantity was close across countries, from 25,394 to 26,258 units. Australia sold the most and the UK the least. Most countries averaged 3 units per order, while Canada and the UK were slightly lower at 2.

### ``shipping_cost`` by ``customer_country``
```SQL
select customer_country, CAST(AVG(shipping_cost) AS decimal(10,2)) as 'Average shipping_cost',
CAST(MAX(shipping_cost) AS decimal(10,2)) as 'MAX shipping_cost',
CAST(MIN(shipping_cost) AS decimal(10,2)) as 'MIN shipping_cost',
CAST(SUM(shipping_cost) AS decimal(10,2)) as 'Total shipping_cost'
from shopify_sales
group by customer_country
order by SUM(shipping_cost) DESC,customer_country ASC;
```  
| customer_country | Average shipping_cost | MAX shipping_cost | MIN shipping_cost | Total shipping_cost |
|------------------|-----------------------|-------------------|-------------------|---------------------|
| Australia        | 13.55                 | 25.00             | 2.00              | 118071.85           |
| Germany          | 13.55                 | 25.00             | 2.00              | 116624.91           |
| UAE              | 13.55                 | 24.99             | 2.00              | 116521.05           |
| India            | 13.53                 | 25.00             | 2.00              | 115773.09           |
| Canada           | 13.48                 | 25.00             | 2.01              | 115716.94           |
| UK               | 13.51                 | 25.00             | 2.00              | 114434.03           |
| USA              | 13.48                 | 24.99             | 2.00              | 114163.61           |

**Findings**
- Average shipping cost was stable across countries, from 13.48 to 13.55. Australia had the highest total shipping cost (118,071.85) and the USA the lowest (114,163.61).

### ``rating`` by ``customer_country``
```SQL
select customer_country, CAST(AVG(rating) AS decimal(10,2)) as 'Average rating',
CAST(MAX(rating) AS decimal(10,2)) as 'MAX rating',
CAST(MIN(rating) AS decimal(10,2)) as 'MIN rating'
from shopify_sales
group by customer_country
order by AVG(rating) DESC,customer_country ASC;
```  
| customer_country | Average rating | MAX rating | MIN rating |
|------------------|----------------|------------|------------|
| India            | 3.04           | 5.00       | 1.00       |
| Germany          | 3.01           | 5.00       | 1.00       |
| USA              | 3.00           | 5.00       | 1.00       |
| Canada           | 3.00           | 5.00       | 1.00       |
| UAE              | 3.00           | 5.00       | 1.00       |
| UK               | 2.99           | 5.00       | 1.00       |
| Australia        | 2.99           | 5.00       | 1.00       |

**Findings**
- Ratings were almost the same everywhere, from 2.99 to 3.04. India had the highest average, while the UK and Australia had the lowest. Every country had the full range of ratings, from 1 to 5.

### ``revenue`` by ``customer_country``
```SQL
select customer_country, CAST(AVG(revenue) AS decimal(10,2)) as 'Average revenue',
CAST(MAX(revenue) AS decimal(10,2)) as 'MAX revenue',
CAST(MIN(revenue) AS decimal(10,2)) as 'MIN revenue',
CAST(SUM(revenue) AS decimal(10,2)) as 'Total revenue'
from shopify_sales
group by customer_country
order by SUM(revenue) DESC,customer_country ASC;
```  
| customer_country | Average revenue | MAX revenue | MIN revenue | Total revenue |
|------------------|-----------------|-------------|-------------|---------------|
| Australia        | 998.27          | 3993.55     | 3.08        | 8698940.71    |
| Germany          | 995.47          | 3959.90     | 3.53        | 8566995.25    |
| UAE              | 993.28          | 3999.50     | 3.26        | 8541233.92    |
| India            | 994.76          | 3990.30     | 4.73        | 8509138.00    |
| Canada           | 990.76          | 3985.40     | 4.27        | 8506629.46    |
| USA              | 997.87          | 3998.75     | 4.62        | 8450978.82    |
| UK               | 988.20          | 3990.20     | 4.73        | 8372019.42    |

**Findings**
- Australia generated the highest total revenue (8.70 million) and the UK the lowest (8.37 million). Average revenue per order was similar everywhere, from 988.20 to 998.27. The USA had a high average but a lower total, which suggests it had slightly fewer orders.

### ``profit`` by ``customer_country``
```SQL
select customer_country, CAST(AVG(profit) AS decimal(10,2)) as 'Average profit',
CAST(MAX(profit) AS decimal(10,2)) as 'MAX profit',
CAST(MIN(profit) AS decimal(10,2)) as 'MIN profit',
CAST(SUM(profit) AS decimal(10,2)) as 'Total profit'
from shopify_sales
group by customer_country
order by SUM(profit) DESC,customer_country ASC;
```  
| customer_country | Average profit | MAX profit | MIN profit | Total profit |
|------------------|----------------|------------|------------|--------------|
| Australia        | 984.72         | 3986.81    | -20.49     | 8580868.86   |
| Germany          | 981.92         | 3947.32    | -17.89     | 8450370.34   |
| UAE              | 979.73         | 3989.95    | -18.02     | 8424712.87   |
| India            | 981.22         | 3981.17    | -17.12     | 8393364.91   |
| Canada           | 977.28         | 3974.61    | -17.14     | 8390912.52   |
| USA              | 984.39         | 3983.31    | -18.69     | 8336815.21   |
| UK               | 974.69         | 3968.58    | -18.83     | 8257585.39   |

**Findings**
- Australia had the highest total profit (8.58 million) and the UK the lowest (8.26 million). Average profit per order was similar across countries, from 974.69 to 984.72. Every country had a negative minimum profit, so some orders lost money.
***
### ``product_price`` by ``payment_method``
```SQL
select payment_method, CAST(AVG(product_price) AS decimal(10,2)) as 'Average price',
CAST(MAX(product_price) AS decimal(10,2)) as 'MAX price',
CAST(MIN(product_price) AS decimal(10,2)) as 'MIN price'
from shopify_sales
group by payment_method
order by AVG(product_price) DESC,payment_method ASC;
```  
| payment_method   | Average price | MAX price | MIN price |
|------------------|---------------|-----------|-----------|
| PayPal           | 404.66        | 799.96    | 5.01      |
| Apple Pay        | 403.74        | 799.97    | 5.02      |
| Debit Card       | 403.41        | 799.99    | 5.03      |
| Cash on Delivery | 402.88        | 799.97    | 5.01      |
| Credit Card      | 402.44        | 799.94    | 5.32      |

**Findings**
- Average product prices were very similar across payment methods, from 402.44 to 404.66. PayPal had the highest average and Credit Card the lowest. Min and max prices were about the same for all (around 5 to 800).

### ``quantity`` by ``payment_method``
```SQL
select payment_method, CAST(AVG(quantity) AS decimal(10,2)) as 'Average quantity',
CAST(MAX(quantity) AS decimal(10,2)) as 'MAX quantity',
CAST(MIN(quantity) AS decimal(10,2)) as 'MIN quantity',
CAST(SUM(quantity) AS decimal(10,2)) as 'Total quantity'
from shopify_sales
group by payment_method
order by SUM(quantity) DESC,payment_method ASC;
```  
| payment_method   | Average quantity | MAX quantity | MIN quantity | Total quantity |
|------------------|------------------|--------------|--------------|----------------|
| Apple Pay        | 3.00             | 5.00         | 1.00         | 36640.00       |
| Credit Card      | 3.00             | 5.00         | 1.00         | 36182.00       |
| Cash on Delivery | 2.00             | 5.00         | 1.00         | 36073.00       |
| Debit Card       | 3.00             | 5.00         | 1.00         | 36007.00       |
| PayPal           | 2.00             | 5.00         | 1.00         | 35672.00       |

**Findings**
- Total quantity was close across payment methods, from 35,672 to 36,640 units. Apple Pay sold the most and PayPal the least. Most methods averaged 3 units per order, while Cash on Delivery and PayPal were slightly lower at 2.

### ``shipping_cost`` by ``payment_method``
```SQL
select payment_method, CAST(AVG(shipping_cost) AS decimal(10,2)) as 'Average shipping_cost',
CAST(MAX(shipping_cost) AS decimal(10,2)) as 'MAX shipping_cost',
CAST(MIN(shipping_cost) AS decimal(10,2)) as 'MIN shipping_cost',
CAST(SUM(shipping_cost) AS decimal(10,2)) as 'Total shipping_cost'
from shopify_sales
group by payment_method
order by SUM(shipping_cost) DESC,payment_method ASC;
```  
| payment_method   | Average shipping_cost | MAX shipping_cost | MIN shipping_cost | Total shipping_cost |
|------------------|-----------------------|-------------------|-------------------|---------------------|
| Apple Pay        | 13.52                 | 25.00             | 2.00              | 163864.61           |
| Credit Card      | 13.55                 | 25.00             | 2.00              | 162578.30           |
| Cash on Delivery | 13.47                 | 24.99             | 2.00              | 162031.13           |
| PayPal           | 13.54                 | 25.00             | 2.00              | 161422.29           |
| Debit Card       | 13.52                 | 25.00             | 2.00              | 161409.15           |

**Findings**
- Average shipping cost was stable across payment methods, from 13.47 to 13.55. Apple Pay had the highest total shipping cost (163,864.61) and Debit Card the lowest (161,409.15).

### ``rating`` by ``payment_method``
```SQL
select payment_method, CAST(AVG(rating) AS decimal(10,2)) as 'Average rating',
CAST(MAX(rating) AS decimal(10,2)) as 'MAX rating',
CAST(MIN(rating) AS decimal(10,2)) as 'MIN rating'
from shopify_sales
group by payment_method
order by AVG(rating) DESC,payment_method ASC;
```  
| payment_method   | Average rating | MAX rating | MIN rating |
|------------------|----------------|------------|------------|
| PayPal           | 3.01           | 5.00       | 1.00       |
| Apple Pay        | 3.01           | 5.00       | 1.00       |
| Credit Card      | 3.00           | 5.00       | 1.00       |
| Debit Card       | 3.00           | 5.00       | 1.00       |
| Cash on Delivery | 2.99           | 5.00       | 1.00       |

**Findings**
- Ratings were almost identical across payment methods, from 2.99 to 3.01. PayPal and Apple Pay were slightly higher, and Cash on Delivery was slightly lower. All methods had the full range of ratings, from 1 to 5.

### ``revenue`` by ``payment_method``
```SQL
select payment_method, CAST(AVG(revenue) AS decimal(10,2)) as 'Average revenue',
CAST(MAX(revenue) AS decimal(10,2)) as 'MAX revenue',
CAST(MIN(revenue) AS decimal(10,2)) as 'MIN revenue',
CAST(SUM(revenue) AS decimal(10,2)) as 'Total revenue'
from shopify_sales
group by payment_method
order by SUM(revenue) DESC,payment_method ASC;
```  
| payment_method   | Average revenue | MAX revenue | MIN revenue | Total revenue |
|------------------|-----------------|-------------|-------------|---------------|
| Apple Pay        | 999.50          | 3990.30     | 3.53        | 12109957.21   |
| Debit Card       | 997.25          | 3999.50     | 3.08        | 11903139.90   |
| Credit Card      | 991.69          | 3993.10     | 3.26        | 11898249.20   |
| Cash on Delivery | 986.59          | 3992.20     | 4.49        | 11870651.24   |
| PayPal           | 995.46          | 3998.75     | 3.82        | 11863938.03   |

**Findings**
- Apple Pay generated the highest total revenue (12.11 million) and PayPal the lowest (11.86 million). Average revenue per order was similar, from 986.59 to 999.50. PayPal had a high average but the lowest total, which suggests it had fewer orders.

### ``profit`` by ``payment_method``
```SQL
select payment_method, CAST(AVG(profit) AS decimal(10,2)) as 'Average profit',
CAST(MAX(profit) AS decimal(10,2)) as 'MAX profit',
CAST(MIN(profit) AS decimal(10,2)) as 'MIN profit',
CAST(SUM(profit) AS decimal(10,2)) as 'Total profit'
from shopify_sales
group by payment_method
order by SUM(profit) DESC,payment_method ASC;
```  
| payment_method   | Average profit | MAX profit | MIN profit | Total profit |
|------------------|----------------|------------|------------|--------------|
| Apple Pay        | 985.98         | 3981.17    | -17.89     | 11946092.60  |
| Debit Card       | 983.72         | 3989.95    | -20.49     | 11741730.75  |
| Credit Card      | 978.14         | 3986.81    | -18.02     | 11735670.90  |
| Cash on Delivery | 973.12         | 3977.12    | -18.83     | 11708620.11  |
| PayPal           | 981.92         | 3984.80    | -17.17     | 11702515.74  |

**Findings**
- Apple Pay had the highest total profit (11.95 million) and PayPal the lowest (11.70 million). Average profit per order was similar, from 973.12 to 985.98. Every payment method had a negative minimum profit, so some orders lost money.
***
## Overall Findings

The exploratory data analysis examined 60,000 records from the Shopify sales dataset, covering product categories, customer countries, traffic sources, payment methods, and sales performance over time. The initial data inspection found no null values, and the data types of order_id, discount_percent, and quantity were standardized to support further analysis.

Several key findings emerged:

Sales performance by product category: Electronics generated the highest total revenue (8.72 million) and total profit (8.60 million), while Footwear recorded the lowest totals for both metrics. Revenue and profit were relatively evenly distributed across the seven product categories.

Geographic performance: Australia generated the highest total revenue among the seven countries, at approximately 8.70 million, while the UK generated the lowest, at approximately 8.37 million. Average revenue per record was relatively similar across countries.

Traffic source performance: Total revenue and profit were relatively consistent across traffic sources. Social Media generated the highest total revenue, while Email generated the lowest. Further analysis of marketing costs and conversion performance is needed before deciding which channels deserve greater investment.

Product performance: The five highest-ranked products by total revenue were also the five highest-ranked by total profit. However, the bottom-five rankings differed, showing that revenue alone does not fully explain product profitability. Shipping costs and discount levels are useful factors to investigate.

Customer ratings: Average ratings remained close to 3.00 across years and customer countries, with little variation. This indicates that average ratings were broadly stable, although individual low ratings warrant further investigation.

Yearly performance: The dataset contains records from 2023 through June 18, 2025. Total revenue, profit, quantity sold, and shipping costs are lower in 2025, but this period is incomplete and should not be directly compared with the full years of 2023 and 2024.

Electronics order patterns: Electronics recorded its highest order count through Social Media (1,784 orders), followed by Paid Ads (1,734 orders). By customer country, the UAE recorded the highest number of Electronics orders (1,273), followed by the USA (1,257) and Germany (1,256). These patterns suggest potential opportunities to test targeted promotions, although order counts alone do not establish marketing effectiveness.

Overall, the analysis identifies Electronics as a strong-performing category, Australia as the leading market by total revenue, and product profitability and customer ratings as areas for further investigation.

Based on these findings, the next step is to develop an interactive Power BI dashboard to monitor revenue, profit, sales trends, category performance, geographic markets, and traffic sources. Recommended actions include testing targeted Electronics promotions through Social Media and Paid Ads, evaluating market-specific campaigns in countries with high Electronics order counts, and reviewing profit margins before expanding discounts. Campaign performance should be measured using conversion rates, marketing costs, revenue, and profit to determine whether these strategies deliver sustainable growth. Further analysis should prioritize comparable time periods, investigate unprofitable transactions, and evaluate marketing effectiveness using additional cost and conversion data where available.