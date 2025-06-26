-- models/gold/fact_orders.sql
{{ config(materialized='table') }}

with deduped as (

  select
    o.*,
    l.part_id,
    l.supplier_id,
    l.quantity,
    l.extended_price,
    l.discount,
    l.tax,
    l.return_flag,
    l.line_status

  from {{ ref('silver_orders') }} o
  left join {{ ref('silver_lineitem') }} l
    on o.order_id = l.order_id

  qualify
    row_number() over(
      partition by o.order_id
      order by l.order_id
    ) = 1

),

cust_enriched as (
  select
    d.*,
    c.customer_key
  from deduped d
  left join {{ ref('dim_customer') }} c
    on d.customer_id = c.customer_key   
),

full_enriched as (
  select
    ce.*,
    dd.date_key
  from cust_enriched ce
  left join {{ ref('dim_date') }} dd
    on date_trunc('day', ce.order_date)::date = dd.date_key
)

select
  row_number() over(order by order_id)     as order_key,
  customer_key,
  date_key,
  order_id,
  order_status,
  total_price,
  order_date,
  priority,
  part_id,
  supplier_id,
  quantity,
  extended_price,
  discount,
  tax,
  return_flag,
  line_status
from full_enriched
