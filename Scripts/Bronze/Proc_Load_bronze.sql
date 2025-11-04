/*
=================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
=================================================================================

Script Purpose:
  This stored procedure loads data into the 'bronze' schema from external CSV files.

It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the "BULK INSERT" command to load data from csv Files to bronze tables.

Parameters:
  None.
  This stored procedure does not accept any parameters or return any values.

Usage Example:
EXEC bronze. load_bronze;
*/

	
create or alter  procedure bronze.load_bronze as 
BEGIN
	declare @start_time datetime , @end_time datetime ,@batch_start_time datetime,@batch_end_time datetime ;
	BEGIN TRY
		set @batch_start_time = getdate();
		print'========================';
		print 'Loading Bronze Layers:';
		print'========================';
		print'-----------------------------------------------------------------------------------------';
		print'========================';
		print 'Loading CRM Tables:';
		print'========================';
		print'-----------------------------------------------------------------------------------------';

		set @start_time = getdate() ;
		print'truncating & insert data into bronze.crm_cust_info Table :' ;
		truncate table bronze.crm_cust_info ;
		bulk insert bronze.crm_cust_info
		from 'C:\Users\asus\Desktop\SQLSever\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			firstrow =2,
			fieldterminator=',',
			tablock
		);
		set @end_time = getdate() ;
		print'Load Duration :' + cast(datediff(second ,@start_time,@end_time)as  nvarchar) +'seconds ';

		print'-----------------------------------------------------------------------------------------';

		set @start_time = getdate() ;
		print'truncating & insert data into bronze.crm_sales_details Table :' ;
		truncate table bronze.crm_sales_details ;
		bulk insert bronze.crm_sales_details
		from 'C:\Users\asus\Desktop\SQLSever\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			firstrow =2,
			fieldterminator=',',
			tablock
		);
		set @end_time = getdate() ;
		print'Load Duration :' + cast(datediff(second ,@start_time,@end_time)as  nvarchar) +'seconds ';

		print'-----------------------------------------------------------------------------------------';

		set @start_time = getdate() ;
		print'truncating & insert data into bronze.crm_prd_info Table :' ;
		truncate table bronze.crm_prd_info ;
		bulk insert bronze.crm_prd_info
		from 'C:\Users\asus\Desktop\SQLSever\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			firstrow =2,
			fieldterminator=',',
			tablock
		);
		set @end_time = getdate() ;
		print'Load Duration :' + cast(datediff(second ,@start_time,@end_time)as  nvarchar) +'seconds ';

		print'-----------------------------------------------------------------------------------------';

		print'========================';
		print 'Loading ERP Tables:';
		print'========================';

		set @start_time = getdate() ;
		print'truncating & insert data into bronze.erp_CUST_AZ12 Table :' ;
		truncate table bronze.erp_CUST_AZ12 ;
		bulk insert bronze.erp_CUST_AZ12
		from 'C:\Users\asus\Desktop\SQLSever\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with (
			firstrow =2,
			fieldterminator=',',
			tablock
		);
		set @end_time = getdate() ;
		print'Load Duration :' + cast(datediff(second ,@start_time,@end_time)as  nvarchar) +'seconds ';

		print'-----------------------------------------------------------------------------------------';

		set @start_time = getdate() ;
		print'truncating & insert data into bronze.erp_LOC_A101 Table:' ;
		truncate table bronze.erp_LOC_A101 ;
		bulk insert bronze.erp_LOC_A101
		from 'C:\Users\asus\Desktop\SQLSever\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with (
			firstrow =2,
			fieldterminator=',',
			tablock
		);
		set @end_time = getdate() ;
		print'Load Duration :' + cast(datediff(second ,@start_time,@end_time)as  nvarchar) +'seconds ';

		print'-----------------------------------------------------------------------------------------';

		set @start_time = getdate() ;
		print'truncating & insert data into bronze.erp_PX_CAT_G1V2 Table :' ;
		truncate table bronze.erp_PX_CAT_G1V2 ;
		bulk insert bronze.erp_PX_CAT_G1V2
		from 'C:\Users\asus\Desktop\SQLSever\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
			firstrow =2,
			fieldterminator=',',
			tablock
		);
		set @end_time = getdate() ;
		print'Load Duration :' + cast(datediff(second ,@start_time,@end_time)as  nvarchar) +'seconds ';

		print'-----------------------------------------------------------------------------------------';
		print'============================================';
		print'Loading Bronze Layer is Completed';
		set @batch_end_time = getdate() ;
		print'  -Loading Bronze Layer Duration time :' + cast(datediff(second ,@batch_start_time,@batch_end_time)as  nvarchar) +'seconds ';
		print'============================================';
	END TRY 
	BEGIN CATCH
		print'==============================================';
		print'Error Occured During Loading Bronze Layer !!!';
		print'Error Message :'+error_message();
		print'Error Number :'+cast(error_number() as varchar);
		print'Error State :'+cast(error_state() as varchar);
		print'Error Line :'+cast(error_Line() as varchar);
		print'==============================================';
	END CATCH
END







