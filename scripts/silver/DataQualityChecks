-- Data Quality Checks
-- Once inserted into the silver layer table, run again the scripts changing bronze for silver

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Results
SELECT cst_id,
COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

-- Check for unwanted spaces
-- Expectation: No Results
SELECT cst_gndr
FROM bronze.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr)

SELECT cst_key
FROM bronze.crm_cust_info
WHERE cst_key != TRIM(cst_key)

SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

SELECT cst_lastname
FROM bronze.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)



-- Data standarization & consistency
-- The objective is to change abreviations into clear and meaningful values (in another script, the one doing the transformations)
-- Check for the possible values of the column, then decide which transformations to apply
SELECT DISTINCT cst_marital_status
FROM bronze.crm_cust_info

SELECT DISTINCT cst_gndr
FROM bronze.crm_cust_info
