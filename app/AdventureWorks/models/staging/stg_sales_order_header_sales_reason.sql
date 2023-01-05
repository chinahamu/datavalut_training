{{ config(materialized='view') }}

{%- set yaml_metadata -%}
 source_model:
  main: sales_order_header_sales_reason
derived_columns:
  SOURCE: '!1'
  LOAD_DATETIME: loaded_at
  EFFECTIVE_FROM: loaded_at
  START_DATE: loaded_at
  END_DATE: TO_DATE('9999-12-31','YYYY-MM-DD')
hashed_columns:
  SALES_ORDER_HK: sales_order_id
  SALES_REASON_HK: sales_reason_id
  SALES_ORDER_HEADER_SALES_REASON_HK:
  - sales_order_id
  - sales_reason_id
  SALES_ORDER_HEADER_SALES_REASON_HASHDIFF:
    is_hashdiff: true
    columns:
    - sales_order_id
    - sales_reason_id
    - modified_date
    - loaded_at

{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.stage(include_source_columns=true,
                  source_model=metadata_dict['source_model'],
                  derived_columns=metadata_dict['derived_columns'],
                  null_columns=none,
                  hashed_columns=metadata_dict['hashed_columns'],
                  ranked_columns=none) }}
