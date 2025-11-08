# Data Warehouse and analytics Project

Welcone to the **Data Warehouse and Analytics Project** repository! 🚀
This project showcases a comprehensive solution for data warehousing and analytics. It encompasses the entire data pipeline — from designing and building a scalable data warehouse to extracting valuable insights through analytics.

---

## 🔎 Project Overview
🎯 This project involves:
 1. **Data Architecture**: Designing a Modern Data Warehouse Using Medallion Architecture Bronze, Silver, and Gold layers.
 2. **ETL Pipelines**: Extracting, transforming, and loading data from source systems into the warehouse.
 3. **Data Modeling**: Developing fact and dimension tables optimized for analytical queries.
 4. **Analytics & Reporting**: Creating SQL-based reports and dashboards for actionable insights.
---

## 🚀 Project Requirements.

### Building the Data Warehouse (Data Engineering).
 
### Objective:
Develop a modern data warehouse using SQl Server to consolidate sales data, enabling analytical reporting and informed decision-making.

### Specifications :
   **•Data Sources**: Import data from two source systems (ERP and CRM) provided as CSV files.
   
   **•Data Quality**: Cleanse and resolve data quality issues prior to analysis.
   
   **•Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
   
   **•Scope"**: Focus on the latest dataset only; historization of data is not required.
   
   **•Documentation**: Provide clear documentation of the data model to support both business stakeholders and analytics  teams.

### BI: Analytics & Reporting (Data Analytics)

### Objective:
Develop SQL-based analytics to deliver detailed insights into:

  **•Custoner Behavior** .
  
  **•Product Performance** .
  
  **•Sales trends** .
  
These insights empower stakeholders with key business metrics, enabline strategic decision-making.

---
## 📚 Data Architecture :

The data architecture for this project follows Medallion Architecture Bronze, Silver, and Gold layers:

<img width="1035" height="567" alt="data_layers" src="https://github.com/user-attachments/assets/f9caca25-6e49-441c-9f69-622b4b1ac350" />

1. **Bronze Layer**. Stores raw data as-is from the source systems. Data is ingested from CSV Files into SQL Server Database.
2. **Silver Layer**: This layer includes data cleansing, standardization, and normalization processes to prepare data for
analysis
3. **Gold Layer**: Houses business-ready data modeled into a star schema required for reporting and analytics.
---
## 🏳️ License
This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and share this project with proper attribution.

## 🙋 About Me 
Hi there! I'm **Houssem Gharbi**, i'm a Junior Data Engineer passionate about building scalable data solutions and deriving actionable insights. I enjoy transforming raw data into meaningful stories that drive decision-making. This project reflects my skills and interest in creating efficient data pipelines and analytics platforms.
