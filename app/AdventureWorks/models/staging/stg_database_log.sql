{{ config(materialized='view') }}

{%- set yaml_metadata -%}
 source_model:
  main: database_log
derived_columns:
  SOURCE: '!1'
  LOAD_DATETIME: loaded_at
  EFFECTIVE_FROM: loaded_at
  START_DATE: loaded_at
  END_DATE: TO_DATE('9999-12-31','YYYY-MM-DD')
hashed_columns:
  DATABASE_LOG_HK:
  - database_log_id
  DATABASE_LOG_HASHDIFF:
    is_hashdiff: true
    columns:
    - database_log_id
    - post_time
    - database_user
    - event
    - schema
    - object
    - tsql
    - xml_event
    - loaded_at

{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.stage(include_source_columns=true,
                  source_model=metadata_dict['source_model'],
                  derived_columns=metadata_dict['derived_columns'],
                  null_columns=none,
                  hashed_columns=metadata_dict['hashed_columns'],
                  ranked_columns=none) }}
