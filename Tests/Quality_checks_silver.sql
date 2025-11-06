/* 
********************************************************************************************
Quality Checks 
********************************************************************************************
Script Purpose:
  This script performs various quality checks for data consistency, accuracy,
  and standardization across the 'silver' schemas. It includes checks for:
  - Null or duplicate primary keys.
  - Unwanted spaces in string fields.
  - Data standardization and consistency.
  - Invalid date ranges and orders.
  - Data consistency between related fields.

Usage Notes:
  - Run these checks after data loading Silver Layer.
  - Investigate and resolve any discrepancies found during the checks.
********************************************************************************************
*/

--=====================================
--Cheking :'silver.crm_cust_info'
--=====================================
--Check for NULLs and Duplicates in Pprimary Key 
-- Expectation : No Results

select 
  cst_id , 
  count(*)
from silver.crm_cust_info
group by cst_id
where count(*) >1 or cst_id is null ;

--Check for Unwanted Spaces 
-- Expectation : No Results
select 
  cst_key
from silver.crm_cust_info
where cst_key != trim (cst_key) ;

-- Data standardization & consistency.
select distinct
  cst_marital_status
from silver.crm_cust_info ;



--=====================================
--Cheking :'silver.crm_prd_info'
--=====================================
--Check For NULLs Or Negative Values In Primary Key 
--expectation : No Resultes
select 
  prd_id,
  count(*)
from silver.crm_prd_info
group by prd_id
having   count(*) >1 or  prd_id is null ;

--Check For Unwanted Spaces 
--expectation : No Resultes
select 
  prd_nm
from silver.crm_prd_info
where prd_nm != trim(prd_nm) ;

--Check For NULLs Or Negative Values In Cost 
--expectation : No Resultes

select 
  prd_cost
from silver.crm_prd_info
where prd_cost is null or prd_cost <0 ;

--Data standardization & consistency.
seelct distinct
  prd_line 
from silver.crm_prd_info


--Check For Invalid Date orders (Start ate > End Date )
--expectation : No Resultes

select 
*
from Silver.crm_prd_info
where prd_end_dt < prd_srat_dt

--=====================================
--Cheking :'silver.crm_sales_details'
--=====================================
--Check For Invalid Dates
--Expectation : No Invalid Dates

select 
nullif(sls_due_dt,0) as sls_due_dt ,
from silver.crm_sales_details
where sls_due_dt<=0
  or  sls_due_dt!= 8
  or  sls_due_dt > 20250101
  or  sls_due_dt < 19000101;


--Check For Invalid Date orders (Order Date > Shipping Date / Due Date)
--expectation : No Resultes
select 
  *
from silver.crm_sales_details
where sls_order_dt > sls_ship_dt
   or sls_order_dt > sls_due_dt ;

--Check Data Consistency : Sales = Quantity * Price
--expectation : No Resultes

select 
  sls_sales ,
  sls_quantity ,
  sls_price 
from silver.crm_sales_details
where sls_sales != sls_quantity * sls_price 
  or sls_sales is null or sls_quantity is null or  sls_price is null 
  or sls_sales <=0 or sls_quantity <=0 or sls_price <=0 ;


      

--=====================================
--Cheking :'silver.erp_CUST_AZ12'
--=====================================
--Identify Out-Of_Range Dates
--Expectation :Birthdates between 1924-01-01 and Today 

select 
bdate
from silver.erp_CUST_AZ12
where bdate <'1924-01-01'
   or bdate > getdate() ;

--Data standardization & consistency
select distinct 
gen
from silver.erp_CUST_AZ12 ;

--=====================================
--Cheking :'silver.erp_LOC_A101'
--=====================================
--Data standardization & consistency
select 
cntry 
from silver.erp_LOC_A101
order by cntry ;

--=====================================
--silver.erp_PX_CAT_G1V2'
--=====================================
--Check For Unwanted Spaces.
-- Expectation : No Results

select 
*
from silver.erp_PX_CAT_G1V2
where cat!=trim(cat)
  or subcat!= trim(subcat)
  or maintenance!= trim(maintenance) ;

--Data standardization & consistency
select 
distinct 
  maintenance
from silver.erp_PX_CAT_G1V2 ;

