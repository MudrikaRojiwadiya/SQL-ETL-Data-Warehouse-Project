-- ==========================================
-- ERP_PX_CAT_G1V2
-- DATA EXPLORATION & QUALITY CHECKS
-- ==========================================

-- checking quality of all columns 
SELECT * FROM project_db.erp_px_cat_g1v2
where cat != Trim(cat) OR subcat != Trim(subcat) OR maintenance != Trim(maintenance);

-- checking irrelavant value from all columns
select distinct cat from project_db.erp_px_cat_g1v2;

select distinct subcat from project_db.erp_px_cat_g1v2;

select distinct maintenance from project_db.erp_px_cat_g1v2;

-- ==========================================
-- DATA CLEANING & TRANSFORMATION
-- ==========================================

create  table updated_db.erp_px_cat_g1v2 as 
SELECT * FROM project_db.erp_px_cat_g1v2;