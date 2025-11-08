/*
===========================================================================
DDL Script: Create Gold Views
===========================================================================
Scrip Purpose :
  -This script creates views for the Gold layer in the data warehouse.
  -The Gold layer represents the final dimension and fact tables (Star Schema).

  -Each view performs transformations and combines data from the Silver layer 
   to produce a clean, enriched, and business-ready dataset.

Usage:|
  - These views can be queried directly for analytics and reporting.

===========================================================================

*/

-- *******************************************************************************
-- Create Dimention : gold.dim_customers.
-- *******************************************************************************

IF object_id('gold.dim_customers','V') is not null 
	drop view gold.dim_customers ;
GO 
  
create view gold.dim_customers as 
select
  row_number() over (order by  ci.cst_id ) as customer_key,
  ci.cst_id as customer_id, 
  ci.cst_key as customer_number,
  ci.cst_firstname as first_name,
  ci.cst_lastname as last_name, 
  la.cntry as country ,
  ci.cst_marital_status as marital_status ,
  case 
  	when ci.cst_gndr != 'N/A' then ci.cst_gndr
  	else coalesce(ca.gen , 'N/A')
  end gender ,
  ca.bdate as birth_date ,
  ci.cst_create_date as create_date
from silver.crm_cust_info as ci
left join silver.erp_CUST_AZ12 as ca
on ca.cid=ci.cst_key
left join silver.erp_LOC_A101 as la
on la.cid=ci.cst_key ;

-- *******************************************************************************
-- Create Dimention : gold.dim_products.
-- *******************************************************************************

IF object_id('gold.dim_products','V') is not null 
	drop view gold.dim_products ;
GO 
  
create view gold.dim_products as 
select
  row_number() over (order by prd_start_dt , prd_key) as product_key,
  pi.prd_id as product_id , 
  pi.prd_key as product_number ,
  pi.prd_nm as product_name, 
  pi.cat_id as category_id , 
  cg.cat as category, 
  cg.subcat as subcat,
  cg.maintenance ,
  pi.prd_cost as cost, 
  pi.prd_line as product_line , 
  cast(pi.prd_start_dt as date ) as start_date  
from silver.crm_prd_info as pi
left join silver.erp_PX_CAT_G1V2 as cg
on pi.cat_id = cg.id
where pi.prd_end_dt is null ;

-- *******************************************************************************
-- Create Table : gold.fact_sales.
-- *******************************************************************************

IF object_id('gold.fact_sales','V') is not null 
	drop view gold.fact_sales ;
GO 
  
create view gold.fact_sales as 
select 
  sd.sls_ord_num as order_number , 
  pr.product_key ,
  cu.customer_key ,
  sd.sls_order_dt as order_date , 
  sd.sls_ship_dt as shipping_date , 
  sd.sls_due_dt due_date, 
  sd.sls_sales as sales_amount , 
  sd.sls_quantity as quantity , 
  sd.sls_price as price
from silver.crm_sales_details as sd	
left join gold_dim_products as pr 
on sd.sls_prd_key = pr.product_number
left join gold_dim_customers as cu 
on sd.sls_cust_id = cu.customer_id ;


 



