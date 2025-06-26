-- macros/date_dim.sql
{% macro generate_date_dim(source_table, date_column) %}
  with dates as (
    select distinct
      date_trunc('day', {{ date_column }})::date as date_key
    from {{ source_table }}
  )
  select
    date_key,
    date_part('year',   date_key)  as year,
    date_part('quarter',date_key)  as quarter,
    date_part('month',  date_key)  as month,
    date_part('dow',    date_key)  as day_of_week
  from dates
{% endmacro %}

{% macro generate_dim_date() %}
  {{ generate_date_dim(ref('silver_orders'), 'order_date') }}
{% endmacro %}