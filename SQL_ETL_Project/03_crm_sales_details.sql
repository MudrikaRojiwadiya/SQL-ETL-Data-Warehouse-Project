-- ==========================================
-- CRM_SALES_DETAILS
-- DATA EXPLORATION & QUALITY CHECKS
-- ==========================================

-- check sls_ord_num column for quality
select * from project_db.crm_sales_details
where sls_ord_num != trim(sls_ord_num) OR sls_ord_num = '';

-- check records in prd_key and sls_prd_key
select sls_prd_key from project_db.crm_sales_details where sls_prd_key NOT IN
(select prd_key from updated_db.crm_prd_info);

-- check records in prd_key and sls_prd_key
select sls_cust_id from project_db.crm_sales_details where sls_cust_id NOT IN
(select cst_id from updated_db.crm_cust_info);

-- checking for invalid dates

select * from project_db.crm_sales_details 
where sls_order_dt <= 0 OR length(sls_order_dt) != 8;

select * from project_db.crm_sales_details 
where sls_ship_dt <= 0 OR length(sls_ship_dt) != 8;

select * from project_db.crm_sales_details 
where sls_due_dt <= 0 OR length(sls_due_dt) != 8;

-- checking for invalid date
select * from project_db.crm_sales_details
where sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt;

-- check data consistancy : sales should be equals to Quantity * price and
-- check for null or and invalid data

select sls_sales,sls_quantity,sls_price,
CASE 
	when sls_sales IS NULL OR sls_sales = '' OR sls_sales <= 0 OR sls_sales != sls_quantity * sls_price
    then sls_quantity * ABS(sls_price) END AS sls_sales,
case 
	when sls_price is null OR sls_price <= 0 OR sls_price =''
	then round(sls_sales / sls_quantity)
    else sls_price END AS sls_price
from project_db.crm_sales_details
where sls_sales != sls_quantity * sls_price OR
sls_sales is null OR sls_sales = '' OR 
sls_quantity is null  or sls_quantity = '' or
sls_price is null or sls_price = '' OR
sls_price <= 0 OR sls_quantity <= 0 OR sls_sales <= 0;

-- ==========================================
-- DATA CLEANING & TRANSFORMATION
-- ==========================================

create table updated_db.crm_sales_details as
SELECT 
sls_ord_num,
sls_prd_key,
sls_cust_id,
-- change data type and check irrelavant order date
case 
	when sls_order_dt <= 0 OR length(sls_order_dt) != 8 then null
	else CAST(sls_order_dt as date) END as sls_order_dt,
-- change data type of sls_ship_dt and sls_due_dt
CAST(sls_ship_dt as date) as sls_ship_dt,
CAST(sls_due_dt as date) as sls_due_dt,
-- fix irrelavant values in sls_sales , sls_quantity columns
CASE 
	when sls_sales IS NULL OR sls_sales = '' OR sls_sales <= 0 OR sls_sales != sls_quantity * sls_price
    then sls_quantity * ABS(sls_price)
    ELSE sls_sales END AS sls_sales,
case 
	when sls_price is null OR sls_price <= 0 OR sls_price =''
	then round(sls_sales / sls_quantity)
    else sls_price END AS sls_price,
sls_quantity
FROM project_db.crm_sales_details;