-- ==========================================
-- CRM_SALES_DETAILS
-- GIVING MEANINGFUL NAME
-- ==========================================

create table combined_db.fact_sales as
SELECT 
t1.sls_ord_num as order_number,
t1.sls_prd_key as product_number,
t1.sls_cust_id as customer_id,
t1.sls_order_dt as order_date,
t1.sls_ship_dt as shipping_date,
t1.sls_due_dt as due_date,
t1.sls_sales as sales_amount,
t1.sls_price as price,
t1.sls_quantity as quantity
FROM updated_db.crm_sales_details t1;
