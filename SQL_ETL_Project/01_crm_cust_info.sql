-- ==========================================
-- CRM_CUST_INFO
-- DATA EXPLORATION & QUALITY CHECKS
-- ==========================================

-- checking duplicate records
SELECT cst_id, COUNT(*) AS record_count
FROM project_db.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1;

SELECT cst_key, COUNT(*) AS record_count
FROM project_db.crm_cust_info
GROUP BY cst_key
HAVING COUNT(*) > 1;

select * from project_db.crm_cust_info
where cst_id = 29466 ;

-- checking for firstname and lastname column 
select * from project_db.crm_cust_info
where cst_firstname != Trim(cst_firstname);

select * from project_db.crm_cust_info
where cst_lastname != Trim(cst_lastname);

-- checking for cst_marital_status and csr_gndr column containing values
select distinct cst_marital_status from project_db.crm_cust_info;

select distinct cst_gndr from project_db.crm_cust_info;

-- ==========================================
-- DATA CLEANING & TRANSFORMATION
-- ==========================================

create table updated_db.crm_cust_info as
select 
cst_id,
cst_key,
-- fixing firstname and lastname column
TRIM(cst_firstname) as cst_firstname,
TRIM(cst_lastname) as cst_lastname, 
-- handaling missing values and readable format
CASE WHEN cst_marital_status = 'S' then 'Single'
	 WHEN cst_marital_status = 'M' THEN 'Married'
	 else 'N/A' 
     END AS cst_marital_status,
Case when cst_gndr = 'F' then 'Female'
 	 when cst_gndr = 'M' then 'Male'
 	 else 'N/A' 
     END AS cst_gndr,
cst_create_date
-- removing duplicate records of customers
from (select *,row_number() over(partition by cst_id order by cst_create_date desc) as flag_last from project_db.crm_cust_info) t
where flag_last = 1 ;

