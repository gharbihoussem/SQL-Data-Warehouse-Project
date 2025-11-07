
-- ******************************************************
-- Checking : 'gold.customer_key'
-- ******************************************************
-- Check Of Uniqueness of Customer Key in 'gold_dim_customers'.
--Expectation : No Results.

SELECT
customer_key ,
COUNT(*) AS duplicate_count
From gold_dim_customers
group by customer_key
HAVING COUNT (*) > 1 ;

-- ******************************************************
-- Checking : 'gold.product_key'
-- ******************************************************
-- Check Of Uniqueness of Product Key in 'gold_dim_products'.
--Expectation : No Results .

SELECT
product_key,
COUNT(*) AS duplicate_count
From gold_dim_products
group by product_key
HAVING COUNT (*) > 1 ;

-- ******************************************************
-- Checking : 'gold_fact_sales'
-- ******************************************************
-- Check The Data Model Connectivity Between Fact And Dimentions .

select 
*
from gold_fact_sales as f 
left join gold_dim_customers as c 
on f.customer_key = c.customer_key
left join gold_dim_products as p
on f.product_key = p.product_key
where f.product_key is null 
   or f.customer_key is null ;
