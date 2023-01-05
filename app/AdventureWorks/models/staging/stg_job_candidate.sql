{{ config(materialized='view') }}

{%- set yaml_metadata -%}
 source_model:
  main: job_candidate
derived_columns:
  SOURCE: '!1'
  LOAD_DATETIME: loaded_at
  EFFECTIVE_FROM: loaded_at
  START_DATE: loaded_at
  END_DATE: TO_DATE('9999-12-31','YYYY-MM-DD')
hashed_columns:
  JOB_CANDIDATE_HK:
  - job_candidate_id
  - business_entity_id
  BUSINESS_ENTITY_HK: business_entity_id
  JOB_CANDIDATE_HASHDIFF:
    is_hashdiff: true
    columns:
    - job_candidate_id
    - business_entity_id
    - resume
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
