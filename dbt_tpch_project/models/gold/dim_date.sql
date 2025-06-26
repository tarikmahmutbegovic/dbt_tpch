-- models/gold/dim_date.sql
{{ 
  config(materialized='table')
}}

{{ generate_dim_date() }}
