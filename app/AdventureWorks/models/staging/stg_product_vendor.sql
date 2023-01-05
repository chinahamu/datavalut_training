{{ config(materialized='view') }}

{%- set yaml_metadata -%}
 source_model:
  main: product_vendor
derived_columns:
  SOURCE: '!1'
  LOAD_DATETIME: loaded_at
  EFFECTIVE_FROM: loaded_at
  START_DATE: loaded_at
  END_DATE: TO_DATE('9999-12-31','YYYY-MM-DD')
hashed_columns:
  PRODUCT_HK: product_id
  BUSINESS_ENTITY_HK: business_entity_id
  UNIT_MEASURE_C_HK: unit_measure_code
  PRODUCT_VENDOR_HK:
  - product_id
  - business_entity_id
  - unit_measure_code
  PRODUCT_VENDOR_HASHDIFF:
    is_hashdiff: true
    columns:
    - product_id
    - business_entity_id
    - average_lead_time
    - standard_price
    - last_receipt_cost
    - last_receipt_date
    - min_order_qty
    - max_order_qty
    - on_order_qty
    - unit_measure_code
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
