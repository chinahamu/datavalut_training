{{ config(materialized='view') }}

{%- set yaml_metadata -%}
 source_model:
  main: currency_rate
derived_columns:
  SOURCE: '!1'
  LOAD_DATETIME: loaded_at
  EFFECTIVE_FROM: loaded_at
  START_DATE: loaded_at
  END_DATE: TO_DATE('9999-12-31','YYYY-MM-DD')
hashed_columns:
  CURRENCY_RATE_HK:
  - currency_rate_id
  - from_currency_code
  - to_currency_code
  FROM_CURRENCY_C_HK: from_currency_code
  TO_CURRENCY_C_HK: to_currency_code
  CURRENCY_RATE_HASHDIFF:
    is_hashdiff: true
    columns:
    - currency_rate_id
    - currency_rate_date
    - from_currency_code
    - to_currency_code
    - average_rate
    - end_of_day_rate
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
