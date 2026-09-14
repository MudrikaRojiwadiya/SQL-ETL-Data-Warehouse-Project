-- ===================================
-- DATA EXPLORATION & QUALITY CHECKS
-- ==================================

-- checking customers in CRM that do not exist in ERP customer table
SELECT cst_key from updated_db.crm_cust_info
where cst_key Not in (select cid from updated_db.erp_cust_az1);

-- checking customers in CRM that do not exist in ERP loaction table
SELECT cst_key from updated_db.crm_cust_info
where cst_key Not in (select cid from updated_db.erp_loc_a101);

-- check columns which is containg gender values
SELECT distinct
	t1.cst_gndr,
    t2.gen
FROM updated_db.crm_cust_info t1
left join updated_db.erp_cust_az1 t2
ON t1.cst_key = t2.cid;

-- ==========================================
-- CRM_CUST_INFO + ERP_CUST_AZ1 + ERP_LOC_A101
-- DATA INTEGRATION AND GIVING MEANINGFUL NAME
-- ==========================================

create table combined_db.dim_customers as
SELECT 
	t1.cst_id as customer_id,
	t1.cst_key as customer_number,
	t1.cst_firstname as first_name,
	t1.cst_lastname as last_name,
	t1.cst_marital_status as marital_status,
--  fixing the values of gender column
    CASE
    WHEN t1.cst_gndr != 'N/A' THEN t1.cst_gndr -- because master table is crm_cust_info
    WHEN t1.cst_gndr = 'N/A' AND t2.gen IS NULL THEN 'N/A'
    ELSE t2.gen
    END as gender,
	t1.cst_create_date as create_date,
	t2.bdate as birth_date,
	t3.cntry as country
FROM updated_db.crm_cust_info t1
left join updated_db.erp_cust_az1 t2
ON t1.cst_key = t2.cid
left join updated_db.erp_loc_a101 t3
ON t1.cst_key = t3.cid;

-- making customer_id as a primary key
ALTER TABLE combined_db.dim_customers
ADD PRIMARY KEY(customer_id);