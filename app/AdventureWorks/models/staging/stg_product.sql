{{ config(materialized='view') }}

{%- set yaml_metadata -%}
 source_model:
  main: product
derived_columns:
  SOURCE: '!1'
  LOAD_DATETIME: loaded_at
  EFFECTIVE_FROM: loaded_at
  START_DATE: loaded_at
  END_DATE: TO_DATE('9999-12-31','YYYY-MM-DD')
hashed_columns:
  PRODUCT_HK:
  - product_id
  - size_unit_measure_code
  - weight_unit_measure_code
  - product_subcategory_id
  - product_model_id
  SIZE_UNIT_MEASURE_C_HK: size_unit_measure_code
  WEIGHT_UNIT_MEASURE_C_HK: weight_unit_measure_code
  PRODUCT_SUBCATEGORY_HK: product_subcategory_id
  PRODUCT_MODEL_HK: product_model_id
  PRODUCT_HASHDIFF:
    is_hashdiff: true
    columns:
    - product_id
    - name
    - product_number
    - make_flag
    - finished_goods_flag
    - color
    - safety_stock_level
    - reorder_point
    - standard_cost
    - list_price
    - size
    - size_unit_measure_code
    - weight_unit_measure_code
    - weight
    - days_to_manufacture
    - product_line
    - class
    - style
    - product_subcategory_id
    - product_model_id
    - sell_start_date
    - sell_end_date
    - discontinued_date
    - rowguid
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
