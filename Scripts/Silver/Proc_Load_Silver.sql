/*
=================================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
=================================================================================

Script Purpose:
  This stored procedure performs the ETL(Extract , Transform , Load) process to 
	populate the 'silver' schema tables from the 'Bronze' schema.

It performs the following actions:
    - Truncate Silver tables.
    - Inserts transformed and cleansed data from Bronze into Silver tables .

Parameters:
  None.
  This stored procedure does not accept any parameters or return any values.

Usage Example:
EXEC bronze. load_bronze;
=================================================================================
*/

create or alter procedure silver.load_silver as 
BEGIN
DECLARE @Start_time datetime , @end_time datetime , @batch_start_time datetime ,  @batch_end_time datetime;
	BEGIN TRY
		set @batch_start_time = getdate();
		print'========================';
		print 'Loading Silver Layers:';
		print'========================';
		print'-----------------------------------------------------------------------------------------';
		print'========================';
		print 'Loading CRM Tables:';
		print'========================';
		print'-----------------------------------------------------------------------------------------';

		set @Start_time = getdate() ;
		print 'Table 1'
		print'Truncating table : silver.crm_cust_info ' ;
		truncate table silver.crm_cust_info ;
		print'inserting data into : silver.crm_cust_info ' ;
		insert into silver.crm_cust_info (
		cst_id , 
		cst_key, 
		cst_firstname ,
		cst_lastname , 
		cst_marital_status , 
		cst_gndr , 
		cst_create_date
		)

		select
		cst_id , 
		cst_key,
		trim(cst_firstname) as first_name ,
		trim(cst_lastname) as last_name ,
		case when upper(trim(cst_marital_status)) = 'S' then 'Single' 
			 when upper(trim(cst_marital_status)) = 'M' then 'Maried'
			 else 'N/A' 
		end cst_marital_status ,
		case when upper(trim(cst_gndr)) = 'F' then 'Female' 
			 when upper(trim(cst_gndr)) = 'M' then 'Male'
			 else 'N/A' 
		end cst_gndr,
		cst_create_date
		from (
		select
		*,
		row_number() over (partition by cst_id order by cst_create_date desc ) as flag
		from bronze.crm_cust_info)t 
		where flag = 1 ;
		set @end_time = getdate() ;
		print'Load Duration Table 1 : ' + cast(datediff(second ,@start_time,@end_time) as nvarchar) + 'seconds' ;

print'-------------------------------------------------------------------------------------------------------------------------' ;		
		set @Start_time = getdate() ;
		print 'Table 2'
		print'Truncating table :silver.crm_prd_info ' ;
		truncate table silver.crm_prd_info ;
		print'inserting data into : silver.crm_prd_info ' ;
		insert into silver.crm_prd_info (
			prd_id,
			cat_id	,		
			prd_key	,		
			prd_nm	,		
			prd_cost,		
			prd_line,		
			prd_start_dt,	
			prd_end_dt		
		)
		select 
		prd_id , 
		replace(substring(prd_key,1,5),'-','_') as cat_id , 
		substring(prd_key,7,len(prd_key))as prd_key , 
		prd_nm , 
		isnull(prd_cost , 0 ) as  prd_cost,
		case upper(trim(prd_line))
			when 'M' then 'Mountain'
			when 'R' then 'Road'
			when 'S' then 'Other Sales'
			when 'T' then 'Touring'
			else 'N/A'
		end prd_line, 
		cast(prd_start_dt as date ) as prd_start_dt ,
		cast(lead(prd_start_dt) over (partition by prd_key order by prd_start_dt asc ) -1 as date ) as prd_end_dt
		from bronze.crm_prd_info;
		set @end_time = getdate() ;
		print'Load Duration Table 2 : ' + cast(datediff(second ,@start_time,@end_time) as nvarchar) + 'seconds' ;

print'-------------------------------------------------------------------------------------------------------------------------' ;		set @end_time = getdate() ;
		print 'Table 3'
		print'Truncating table :silver.crm_sales_details ' ;
		truncate table silver.crm_sales_details ;
		print'inserting data into : silver.crm_sales_details ' ;
		insert into silver.crm_sales_details (
			sls_ord_num,
			sls_prd_key,
			sls_cust_id,
			sls_order_dt,
			sls_ship_dt,
			sls_due_dt,
			sls_sales,
			sls_quantity,	
			sls_price		
		)

		select 
		sls_ord_num,
		sls_prd_key	,
		sls_cust_id	,	
		case when len(sls_order_dt)!=8 or  sls_order_dt = 0  
			 then null 
			 else cast(cast(sls_order_dt as varchar) as date ) 
		end as sls_order_dt,
		cast(cast(sls_ship_dt as varchar) as date ) as sls_ship_dt	,
		cast(cast(sls_due_dt as varchar) as date ) as sls_due_dt	,
		case when sls_sales != sls_quantity* abs(sls_price) or sls_sales <=0 or sls_sales is null 
			 then sls_quantity* abs(sls_price) 
			 else sls_sales
		end sls_sales ,
		sls_quantity,	
		case when  sls_price <=0 or sls_price is null 
			 then sls_sales / nullif(sls_quantity,0) 
			 else sls_price
		end sls_price 
		from bronze.crm_sales_details;
		set @end_time = getdate() ;
		print'Load Duration Table 3 : ' + cast(datediff(second ,@start_time,@end_time) as nvarchar) + 'seconds' ;

print'-------------------------------------------------------------------------------------------------------------------------' ;
		print'========================';
		print 'Loading ERP Tables:';
		print'========================';
print'-------------------------------------------------------------------------------------------------------------------------' ;

		set @end_time = getdate() ;
		print 'Table 4'
		print'Truncating table :silver.erp_CUST_AZ12' ;
		truncate table silver.erp_CUST_AZ12 ;
		print'inserting data into : silver.erp_CUST_AZ12 ' ;
		insert into silver.erp_CUST_AZ12(
		cid , 
		bdate , 
		gen
		)

		select  
		case when cid like 'NAS%' then substring(cid,4 ,len(cid))
			 else cid 
		end cid ,
		case when bdate > getdate() then Null 
			 else bdate 
		end bdate ,
		case upper(trim(gen))
				when 'F' then 'Female'
				when 'M' then 'Male'
				when 'Female' then 'Female'
				when 'Male' then 'Male'
				else 'N/A'
		end gen 
		from bronze.erp_CUST_AZ12 ;
		set @end_time = getdate() ;
		print'Load Duration Table 4 : ' + cast(datediff(second ,@start_time,@end_time) as nvarchar) + 'seconds' ;

print'-------------------------------------------------------------------------------------------------------------------------' ;
		
		set @end_time = getdate() ;
		print 'Table 5'
		print'Truncating table :silver.erp_LOC_A101' ;
		truncate table silver.erp_LOC_A101 ;
		print'inserting data into : silver.erp_LOC_A101 ' ;
		insert into silver.erp_LOC_A101( 
		cid ,
		cntry
		)

		select 
		replace(cid , '-','') as cid   , 
		case
			 when trim(cntry) = 'DE' then 'Germany' 
			 when trim(cntry) in ('US','USA') then 'United States'
			 when trim(cntry) is null or trim(cntry) ='' then 'N/A'
			 else trim(cntry)
		end cntry 
		from bronze.erp_LOC_A101 ;
		set @end_time = getdate() ;
		print'Load Duration Table 5 : ' + cast(datediff(second ,@start_time,@end_time) as nvarchar) + 'seconds' ;

print'-------------------------------------------------------------------------------------------------------------------------' ;
		
		set @end_time = getdate() ;
		print 'Table 6'
		print'Truncating table :silver.erp_PX_CAT_G1V2' ;
		truncate table silver.erp_PX_CAT_G1V2 ;
		print'inserting data into : silver.erp_PX_CAT_G1V2 ' ;
		insert into silver.erp_PX_CAT_G1V2(
		id , 
		cat , 
		subcat ,
		maintenance
		)
		select  
		id , 
		cat , 
		subcat ,
		maintenance
		from bronze.erp_PX_CAT_G1V2 ;
		set @end_time = getdate() ;
		print'Load Duration Table 5 : ' + cast(datediff(second ,@start_time,@end_time) as nvarchar) + 'seconds' ;
print'-------------------------------------------------------------------------------------------------------------------------' ;		

		print'============================================';
		print'Loading Silver Layer is Completed';
		set @batch_end_time = getdate() ;		
		print'  -Loading Silver Layer Duration time :' + cast(datediff(second ,@batch_start_time,@batch_end_time)as  nvarchar) +'seconds ';
		print'============================================';
	END TRY 
	BEGIN CATCH 
	print'==================================';
	print'Error occured :';
	Print'Error Message :'+error_message() ;
	Print'Error State :'+cast(error_state() as varchar ) ;
	print'Error Number :'+cast(error_number() as varchar);
	Print'Error line :'+ cast(error_Line() as varchar) ;
	print'==================================';
	END CATCH
END



















