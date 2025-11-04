/*
==================================
Create Database and Schemas
==================================

Script Purpose:
	This script creates a new database named 'datawarehouse' after checking if it already exists.
	If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
	within the database: 'bronze", 'silver', and 'gold".

WARNING !!!!!! :
	Running this script will drop the entire 'datawarehouse' database if it exists.
	All data in the database will be permanently deleted. Proceed with caution
	and ensure you have proper backups before running this script.
*/

use master  ;
go


-- Drop and recreate the 'datawarehouse" database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'datawarehouse')
BEGIN
	ALTER DATABASE datawarehouse set SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE datawarehouse;
END;
GO

-- Create the 'datawarehouse' database 
create database datawarehouse ;
go 

use datawarehouse ;

-- Create Schemas
create schema bronze ;
go

create schema silver ;
go

create schema gold ;
go
