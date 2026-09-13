# SQL ETL Data Warehouse Project

##  Project Overview

This project demonstrates an end-to-end **SQL ETL and Data Warehouse workflow** using raw CRM and ERP datasets.

The project focuses on extracting raw data, cleaning and transforming it, validating data quality, and integrating multiple source systems into a structured data warehouse.

---

##  Project Objectives

- Explore and understand raw source data
- Perform data cleaning and standardization
- Handle missing, duplicate, and invalid data
- Transform raw data into business-ready datasets
- Validate data quality and consistency
- Integrate CRM and ERP source systems
- Build a structured data warehouse using SQL

---

## ETL Process

### 1. Extract
Raw data is collected from multiple CRM and ERP source tables.

### 2. Transform
SQL is used for:

- Data cleaning
- Data type conversion
- Removing duplicates
- Handling NULL and invalid values
- Standardizing text and date formats
- Creating derived columns
- Applying business rules

### 3. Load
The cleaned and transformed data is integrated into structured warehouse tables for further analysis.

---

## Project Structure

```text
SQL-ETL-Data-Warehouse-Project/
│
├── SQL_ETL_Project/
│   ├── 01_crm_cust_info.sql
│   ├── 02_crm_prd_info.sql
│   ├── 03_crm_sales_details.sql
│   ├── 04_erp_cust_az1.sql
│   ├── 05_erp_loc_a101.sql
│   └── 06_erp_px_cat_g1v2.sql
│
└── README.md
