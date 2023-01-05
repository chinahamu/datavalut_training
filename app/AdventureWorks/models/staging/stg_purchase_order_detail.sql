{{ config(materialized='view') }}

{%- set yaml_metadata -%}
 source_model:
  main: purchase_order_detail
derived_columns:
  SOURCE: '!1'
  LOAD_DATETIME: loaded_at
  EFFECTIVE_FROM: loaded_at
  START_DATE: loaded_at
  END_DATE: TO_DATE('9999-12-31','YYYY-MM-DD')
hashed_columns:
  PURCHASE_ORDER_HK: purchase_order_id
  PURCHASE_ORDER_DETAIL_HK:
  - purchase_order_id
  - purchase_order_detail_id
  - product_id
  PRODUCT_HK: product_id
  PURCHASE_ORDER_DETAIL_HASHDIFF:
    is_hashdiff: true
    columns:
    - purchase_order_id
    - purchase_order_detail_id
    - due_date
    - order_qty
    - product_id
    - unit_price
    - line_total
    - received_qty
    - rejected_qty
    - stocked_qty
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
