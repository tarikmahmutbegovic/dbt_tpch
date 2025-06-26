

```mermaid
erDiagram
    DIM_CUSTOMER {
        INTEGER customer_key PK
        VARCHAR customer_name
        VARCHAR address
        VARCHAR phone_number
        VARCHAR market_segment
    }
    DIM_DATE {
        DATE date_key PK
        INTEGER year
        INTEGER quarter
        INTEGER month
        INTEGER day_of_week
    }
    FACT_ORDERS {
        INTEGER order_key PK
        INTEGER customer_key FK
        DATE date_key FK
        INTEGER order_id
        VARCHAR order_status
        FLOAT total_price
        TIMESTAMP order_date
        VARCHAR priority
        INTEGER part_id
        INTEGER supplier_id
        INTEGER quantity
        FLOAT extended_price
        FLOAT discount
        FLOAT tax
        VARCHAR return_flag
        VARCHAR line_status
    }
    DIM_CUSTOMER ||--o{ FACT_ORDERS : "customer_key"
    DIM_DATE    ||--o{ FACT_ORDERS : "date_key"
