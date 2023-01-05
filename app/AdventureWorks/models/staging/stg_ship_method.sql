{{ config(materialized='view') }}

{%- set yaml_metadata -%}
 source_model:
  main: ship_method
derived_columns:
  SOURCE: '!1'
  LOAD_DATETIME: loaded_at
  EFFECTIVE_FROM: loaded_at
  START_DATE: loaded_at
  END_DATE: TO_DATE('9999-12-31','YYYY-MM-DD')
hashed_columns:
  SHIP_METHOD_HK:
  - ship_method_id
  SHIP_METHOD_HASHDIFF:
    is_hashdiff: true
    columns:
    - ship_method_id
    - name
    - ship_base
    - ship_rate
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
