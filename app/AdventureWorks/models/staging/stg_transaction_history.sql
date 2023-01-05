{{ config(materialized='view') }}

{%- set yaml_metadata -%}
 source_model:
  main: transaction_history
derived_columns:
  SOURCE: '!1'
  LOAD_DATETIME: loaded_at
  EFFECTIVE_FROM: loaded_at
  START_DATE: loaded_at
  END_DATE: TO_DATE('9999-12-31','YYYY-MM-DD')
hashed_columns:
  TRANSACTION_HK: transaction_id
  PRODUCT_HK: product_id
  REFERENCE_ORDER_HK: reference_order_id
  REFERENCE_ORDER_LINE_HK: reference_order_line_id
  TRANSACTION_HISTORY_HK:
  - transaction_id
  - product_id
  - reference_order_id
  - reference_order_line_id
  TRANSACTION_HISTORY_HASHDIFF:
    is_hashdiff: true
    columns:
    - transaction_id
    - product_id
    - reference_order_id
    - reference_order_line_id
    - transaction_date
    - transaction_type
    - quantity
    - actual_cost
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
