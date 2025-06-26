# Medallion Architecture on Snowflake (TPC-H SF1)

A fully-scoped end-to-end Snowflake + dbt implementation of the Bronze/Silver/Gold (Medallion) architecture, with a dimensional star schema in the Gold layer.  

---

## 🚀 Project Overview

We ingest raw TPC-H SF1 tables via Snowpipe into a **Raw** schema, cleanse & conform in a **Silver** schema, then build a star schema (1 fact + 2 dims) in a **Gold** schema:

- **Raw**: Snowpipe / Snowflake stages on `RAW_*` tables  
- **Silver**: `silver_customer`, `silver_orders`, `silver_lineitem` (clean, typed, de-duplicated)  
- **Gold**: `dim_customer`, `dim_date`, `fact_orders` (star schema ready for BI)  

Full data lineage is captured via dbt’s DAG + Snowflake INFO_SCHEMA views, with automated tests & incremental models for cost-efficient builds.

---

## ⚙️ Prerequisites

- **Snowflake** account with `SNOWFLAKE_SAMPLE_DATA.TPCH_SF1` access  
- **Python 3.8+**  
- **dbt-snowflake** adapter (tested on dbt v1.10.2)  
- **Git** & GitHub account  

---

## 🛠️ Setup & Installation

1. **Clone the repo**  
   ```bash
   git clone git@github.com:<you>/dbt-medallion-tpch.git
   cd dbt-medallion-tpch
   pip install dbt-snowflake
   dbt debug --target dev
