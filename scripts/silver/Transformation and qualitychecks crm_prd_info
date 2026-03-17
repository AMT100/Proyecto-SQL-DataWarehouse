-- Checks for bronze.crm_prd_info in order
-- Check for nulls or duplicates in the Primary Key

SELECT 
prd_id,
COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

-- The column prd_key contains different information in each entry. The first 2 pairs of characters (e.g. CO-RF, 5 characters) are the category id (id from bronze.erp_px_cat_g1v2),
-- so it is divided into substrings

SELECT 
    prd_id,
    prd_key,
    REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,
    SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key,
    prd_nm,
    ISNULL (prd_cost,0) AS prd_cost,
    CASE UPPER(TRIM(prd_line))
         WHEN 'M' THEN 'Mountain'
         WHEN 'R' THEN 'Road'
         WHEN 'S' THEN 'Other Sales'
         WHEN 'T' THEN 'Touring'
         ELSE 'n/a'
    END AS prd_line,
    CAST (prd_start_dt AS DATE) AS prd_start_dt,
    CAST(LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS DATE) AS prd_end_dt

  FROM bronze.crm_prd_info 
  
  


-- If we check the category id, we can see that the pairs are divided by '_' instead of '-', so we have to replace it in order to have matching information between the 2 tables
  SELECT DISTINCT id from bronze.erp_px_cat_g1v2

  SELECT sls_prd_key FROM bronze.crm_sales_details

-- Check for Nulls negative numbers (prices) in prd_cost.
-- Expectation: No Results
-- Result: no negative numbers but some nulls, so we use ISNULL to replace them with 0
SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

-- Check for all possible values in prd_line
-- Result: NULL, M, R, S, T, so we map it to Mountain, Road, Other Sales, Touring and n/a for nulls or other values
SELECT DISTINCT prd_line
FROM bronze.crm_prd_info

-- Check for invalid date orders, where the end date is before the start date
-- Result some end dates are later than the start date. It makes no sense to swap them, as there sould be years within those time periods with different product prices.
-- One solution is to set the end date to match the start date of the next product, subtracting 1 day 
SELECT * 
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt

-- The solution to integrate in the main query would be:
SELECT 
    prd_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt,
    LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS prd_end_dt_test
  FROM bronze.crm_prd_info
  WHERE prd_key IN ('AC-HE-HL-U509-R', 'AC-HE-HL-U509')
-- Using LEAD(), we create a new column with the content of the next row in the same partition (same prd_key), so the end date (new test column) comes from the next start date
-- Then, it is included in the main query
