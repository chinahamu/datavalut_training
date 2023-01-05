{{ config(materialized='view') }}

{%- set yaml_metadata -%}
 source_model:
  main: email_address
derived_columns:
  SOURCE: '!1'
  LOAD_DATETIME: loaded_at
  EFFECTIVE_FROM: loaded_at
  START_DATE: loaded_at
  END_DATE: TO_DATE('9999-12-31','YYYY-MM-DD')
hashed_columns:
  BUSINESS_ENTITY_HK: business_entity_id
  EMAIL_ADDRESS_HK:
  - business_entity_id
  - email_address_id
  EMAIL_ADDRESS_HASHDIFF:
    is_hashdiff: true
    columns:
    - business_entity_id
    - email_address_id
    - email_address
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
