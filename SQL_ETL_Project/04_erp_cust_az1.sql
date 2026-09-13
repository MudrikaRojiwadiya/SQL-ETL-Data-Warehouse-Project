-- ==========================================
-- ERP_CUST_AZ1
-- DATA EXPLORATION & QUALITY CHECKS
-- ==========================================

-- comparing cid column and cust_key id  
SELECT * FROM project_db.erp_cust_az1
where cid like '%AW00011000';

select * from project_db.crm_cust_info;

-- check invalid birthdate
select 
bdate from project_db.erp_cust_az1
where bdate < '1926-01-01' OR bdate > NOW();

-- check values in gender column 
select distinct gen FROM project_db.erp_cust_az1;

-- ==========================================
-- DATA CLEANING & TRANSFORMATION
-- ==========================================

create table updated_db.erp_cust_az1 as
SELECT 
-- Remove NAS prefix if present
CASE when cid like 'NAS%' then substr(cid,4,length(cid))
	 else cid END AS cid,
-- making null if irelavant date present
CASE WHEN bdate > NOW() AND bdate < '1926-01-01' then null
	else bdate END AS bdate,
-- fixing gender value
CASE when UPPER(TRIM(gen)) = 'M' OR UPPER(TRIM(gen)) = 'Male' then 'Male'
    when UPPER(TRIM(gen)) = 'F' OR UPPER(TRIM(gen)) = 'Female' then 'Female'
    else 'N/A' END AS gen
FROM project_db.erp_cust_az1;