#Data Dictionary for Gold Layer

##Overview
  The Gold Layer is the business-level data representation, structured to support analytical and reporting use cases.
  It consists of dimension tables and fact tables for specific business metrics.

-----------------------------------------------------------------------------------------------------------------------

### 1. gold.dim_customers
    • Purpose: Stores customer details enriched with demographic and geographic data.
    • Columns:

| Column Name    | Data Type    | Description                                                                          |
| --------       | --------     | -----------------------------------------------------------------------------------  |
| customer_key   | INT          | Surrogate key uniquely identifying each customer record in the dimension table.      |
| customer_id    | INT          | Unique numerical identifier assianed to each customer.                               |
|customer_number | nvarchar(50) | Alphanumeric identifier representing the customer, used for tracking and referencing.|
| first_name     | nvarchar(50) | The customer's first name, as recorded in the system.                                |
| last_name      | nvarchar(50) | The customer's last name or family name.                                              |
| country        | nvarchar(50) | The country of residence for the customer (e.g. 'Australia').                        |       
| marital_status | nvarchar(50) | The marital status of the customer (e.q. 'Married', 'Single").                       |
| gender         | nvarchar(50) | The gender of the customer (e.g. 'Male", 'Female", 'n/a').                           |
|birth_date      | Date         | The date of birth of the customer, formatted as YYYY-MM-DD (e.g., 1971-10-06).       |  
|create_date     | Date         | The date and time when the customer record was created in the system .              |
