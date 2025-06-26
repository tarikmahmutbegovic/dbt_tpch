-- models/raw/raw_customer.sql
{{ config(materialized='table') }}

SELECT * 
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER
