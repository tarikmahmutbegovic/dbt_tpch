-- models/gold/dim_customer.sql
{{ config(materialized='table') }}

SELECT
    customer_id as customer_key,
    customer_name,
    address,
    phone_number,
    market_segment
FROM {{ ref('silver_customer') }}
