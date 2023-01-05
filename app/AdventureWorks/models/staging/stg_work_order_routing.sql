{{ config(materialized='view') }}

{%- set yaml_metadata -%}
 source_model:
  main: work_order_routing
derived_columns:
  SOURCE: '!1'
  LOAD_DATETIME: loaded_at
  EFFECTIVE_FROM: loaded_at
  START_DATE: loaded_at
  END_DATE: TO_DATE('9999-12-31','YYYY-MM-DD')
hashed_columns:
  WORK_ORDER_HK: work_order_id
  PRODUCT_HK: product_id
  LOCATION_HK: location_id
  WORK_ORDER_ROUTING_HK:
  - work_order_id
  - product_id
  - location_id
  WORK_ORDER_ROUTING_HASHDIFF:
    is_hashdiff: true
    columns:
    - work_order_id
    - product_id
    - operation_sequence
    - location_id
    - scheduled_start_date
    - scheduled_end_date
    - actual_start_date
    - actual_end_date
    - actual_resource_hrs
    - planned_cost
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
