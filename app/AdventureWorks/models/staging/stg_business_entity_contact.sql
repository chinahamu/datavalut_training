{{ config(materialized='view') }}

{%- set yaml_metadata -%}
 source_model:
  main: business_entity_contact
derived_columns:
  SOURCE: '!1'
  LOAD_DATETIME: loaded_at
  EFFECTIVE_FROM: loaded_at
  START_DATE: loaded_at
  END_DATE: TO_DATE('9999-12-31','YYYY-MM-DD')
hashed_columns:
  BUSINESS_ENTITY_HK: business_entity_id
  PERSON_HK: person_id
  CONTACT_TYPE_HK: contact_type_id
  BUSINESS_ENTITY_CONTACT_HK:
  - business_entity_id
  - person_id
  - contact_type_id
  BUSINESS_ENTITY_CONTACT_HASHDIFF:
    is_hashdiff: true
    columns:
    - business_entity_id
    - person_id
    - contact_type_id
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
