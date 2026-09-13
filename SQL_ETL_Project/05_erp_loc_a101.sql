-- ==========================================
-- ERP_LOC_A101
-- DATA EXPLORATION & QUALITY CHECKS
-- ==========================================

-- checking cid from erg_loc_a101 and cst_key from crm_cust_info
SELECT * FROM project_db.erp_loc_a101;

select cst_key from project_db.crm_cust_info;

select distinct cntry,
case WHEN TRIM(cntry) = "DE" THEN 'Germany'
	 WHEN TRIM(cntry) IN ('USA','US') THEN 'United States'
     WHEN TRIM(cntry) = '' OR cntry is null then 'N/A'
	 ELSE TRIM(cntry) END AS cntry
     from project_db.erp_loc_a101;
     
-- ==========================================
-- DATA CLEANING & TRANSFORMATION
-- ==========================================

create table updated_db.erp_loc_a101 as
SELECT 
-- fix cid column acording to cust_key column in crm_cust_info table
replace(cid,'-','') as cid,
-- fixing contry values
case WHEN TRIM(cntry) = "DE" THEN 'Germany'
	 WHEN TRIM(cntry) IN ('USA','US') THEN 'United States'
     WHEN TRIM(cntry) = '' OR cntry is null then 'N/A'
	 ELSE TRIM(cntry) END AS cntry
FROM project_db.erp_loc_a101;