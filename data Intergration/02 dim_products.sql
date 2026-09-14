-- ==========================================
-- CRM_CUST_INFO + ERP_CUST_AZ1 + ERP_LOC_A101
-- DATA INTEGRATION AND GIVING MEANINGFUL NAME
-- ==========================================

create table combined_db.dim_products as
SELECT 
t1.prd_id AS product_id,
t1.prd_key AS product_number,
t1.prd_nm as product_name,
t1.prd_cst as cost,
t1.prd_line as product_line,
t1.prd_start_dt as start_date,
t1.cat_id as category_id,
t2.cat as category,
t2.subcat as subcategory,
t2.maintenance
FROM updated_db.crm_prd_info t1
-- we are intersted in present value not past value so Filter out all NUll records because current info is not close yet
LEFT JOIN updated_db.erp_px_cat_g1v2 t2
ON t1.cat_id = t2.id
where prd_end_dt is null;

-- making customer_id as a primary key
alter table combined_db.dim_products
ADD PRIMARY KEY (product_id);


