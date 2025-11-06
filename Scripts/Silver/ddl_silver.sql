/*
********************************************************************************************************
DDL Script : create Silver Tables
********************************************************************************************************

Script Purpose :
  This script creates tables in the 'Silver' schema, dropping existing tables if they are already exist .
  Run this script to Re-define the ddl structure of the 'Bronze' tables.
*********************************************************************************************************
*/


if OBJECT_ID('silver.crm_cust_info','U') is not null 
	drop table silver.crm_cust_info ;
create table silver.crm_cust_info (
	cst_id				int , 
	cst_key				nvarchar(50),
	cst_firstname		nvarchar(50),
	cst_lastname		nvarchar(50),
	cst_marital_status	nvarchar(20),
	cst_gndr			nvarchar(20) , 
	cst_create_date		date ,
	dwh_create_date datetime2 default getdate()
);

if OBJECT_ID('silver.crm_prd_info','U') is not null 
	drop table silver.crm_prd_info ;
create table silver.crm_prd_info (
	prd_id			int  ,
	cat_id			nvarchar(20),
	prd_key			nvarchar(50),
	prd_nm			nvarchar(50),
	prd_cost		int ,
	prd_line		nvarchar(50) ,
	prd_start_dt	datetime ,
	prd_end_dt		datetime ,
	dwh_create_date datetime2 default getdate()

);
if OBJECT_ID('silver.crm_sales_details','U') is not null 
	drop table silver.crm_sales_details ;
create table silver.crm_sales_details (
	sls_ord_num		nvarchar(50) ,
	sls_prd_key		nvarchar(50),
	sls_cust_id		int,
	sls_order_dt	date ,
	sls_ship_dt		date ,
	sls_due_dt		date ,
	sls_sales		int,
	sls_quantity	int,
	sls_price		int,
	dwh_create_date datetime2 default getdate()

);

if OBJECT_ID('silver.erp_CUST_AZ12','U') is not null 
	drop table silver.erp_CUST_AZ12 ;
create table silver.erp_CUST_AZ12(
	cid		nvarchar(50) ,
	bdate	date  , 
	gen		nvarchar(50),
	dwh_create_date datetime2 default getdate()

);

if OBJECT_ID('silver.erp_LOC_A101','U') is not null 
	drop table silver.erp_LOC_A101 ;
create table silver.erp_LOC_A101(
	cid		nvarchar(50),
	cntry	nvarchar(50),
	dwh_create_date datetime2 default getdate()
);

if OBJECT_ID('silver.erp_PX_CAT_G1V2','U') is not null 
	drop table silver.erp_PX_CAT_G1V2 ;
create table silver.erp_PX_CAT_G1V2(
	id			nvarchar(50) ,
	cat			nvarchar(50) ,
	subcat		nvarchar(50),
	maintenance nvarchar(50),
	dwh_create_date datetime2 default getdate()
);

