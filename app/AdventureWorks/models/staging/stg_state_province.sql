{{ config(materialized='view') }}

{%- set yaml_metadata -%}
 source_model:
  main: state_province
derived_columns:
  SOURCE: '!1'
  LOAD_DATETIME: loaded_at
  EFFECTIVE_FROM: loaded_at
  START_DATE: loaded_at
  END_DATE: TO_DATE('9999-12-31','YYYY-MM-DD')
hashed_columns:
  STATE_PROVINCE_HK:
  - state_province_id
  - state_province_code
  - country_region_code
  - territory_id
  STATE_PROVINCE_C_HK: state_province_code
  COUNTRY_REGION_C_HK: country_region_code
  TERRITORY_HK: territory_id
  STATE_PROVINCE_HASHDIFF:
    is_hashdiff: true
    columns:
    - state_province_id
    - state_province_code
    - country_region_code
    - is_only_state_province_flag
    - name
    - territory_id
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
