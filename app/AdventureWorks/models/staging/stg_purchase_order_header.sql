{{ config(materialized='view') }}

{%- set yaml_metadata -%}
 source_model:
  main: purchase_order_header
derived_columns:
  SOURCE: '!1'
  LOAD_DATETIME: loaded_at
  EFFECTIVE_FROM: loaded_at
  START_DATE: loaded_at
  END_DATE: TO_DATE('9999-12-31','YYYY-MM-DD')
hashed_columns:
  PURCHASE_ORDER_HK: purchase_order_id
  EMPLOYEE_HK: employee_id
  VENDOR_HK: vendor_id
  SHIP_METHOD_HK: ship_method_id
  PURCHASE_ORDER_HEADER_HK:
  - purchase_order_id
  - employee_id
  - vendor_id
  - ship_method_id
  PURCHASE_ORDER_HEADER_HASHDIFF:
    is_hashdiff: true
    columns:
    - purchase_order_id
    - revision_number
    - status
    - employee_id
    - vendor_id
    - ship_method_id
    - order_date
    - ship_date
    - sub_total
    - tax_amt
    - freight
    - total_due
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
