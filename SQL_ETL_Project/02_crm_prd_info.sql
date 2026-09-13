-- ==========================================
-- CRM_PRD_INFO
-- DATA EXPLORATION & QUALITY CHECKS
-- ==========================================

-- checking duplicate records
SELECT prd_id,count(*) FROM project_db.crm_prd_info
group by prd_id
having count(*) >1 or prd_id is null;

-- checking for unwanted spaces in prd_nm column
select * from project_db.crm_prd_info
where prd_nm != Trim(prd_nm);

-- checking for null values or -ve numbers in prd_cost column
select prd_cost from project_db.crm_prd_info
where prd_cost <0 or prd_cost = '';

-- check prd_line column for quality
select distinct prd_line from project_db.crm_prd_info;

-- check for invalid Date order
select * from project_db.crm_prd_info
where prd_end_dt < prd_start_dt;

-- ==========================================
-- DATA CLEANING & TRANSFORMATION
-- ==========================================

create table updated_db.crm_prd_info as
SELECT 
prd_id,
-- creating cat_id and prd_key by using prd_key colmn
replace(substr(prd_key,1,5),'-','_') as cat_id,
replace(substr(prd_key,7,length(prd_key)),'-','_') as prd_key,
prd_nm,
-- replacing empty string as 0
case
 when prd_cost = '' then 0
 else prd_cost END as prd_cost,
-- Giving meaning full name and handaling missing values
case TRIM(prd_line)
	when 'M' then 'Mountain'
    when 'R' then 'Road'
    when 'S' then 'Other Sales'
    when 'T' then 'Touring'
    else 'N/A' END as prd_line,
prd_start_dt,
-- so we can do start date as end date and end date as start date but then date is overlapping so we are using lead function to fix it
lead(prd_start_dt) over(partition by prd_key order by prd_start_dt) - interval 1 day as prd_end_dt from project_db.crm_prd_info;
