{{ config(materialized='view') }}

{%- set yaml_metadata -%}
 source_model:
  main: product_model_product_description_culture
derived_columns:
  SOURCE: '!1'
  LOAD_DATETIME: loaded_at
  EFFECTIVE_FROM: loaded_at
  START_DATE: loaded_at
  END_DATE: TO_DATE('9999-12-31','YYYY-MM-DD')
hashed_columns:
  PRODUCT_MODEL_HK: product_model_id
  PRODUCT_DESCRIPTION_HK: product_description_id
  CULTURE_HK: culture_id
  PRODUCT_MODEL_PRODUCT_DESCRIPTION_CULTURE_HK:
  - product_model_id
  - product_description_id
  - culture_id
  PRODUCT_MODEL_PRODUCT_DESCRIPTION_CULTURE_HASHDIFF:
    is_hashdiff: true
    columns:
    - product_model_id
    - product_description_id
    - culture_id
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
