{{ config(materialized='view') }}

{%- set yaml_metadata -%}
 source_model:
  main: bill_of_materials
derived_columns:
  SOURCE: '!1'
  LOAD_DATETIME: loaded_at
  EFFECTIVE_FROM: loaded_at
  START_DATE: loaded_at
  END_DATE: TO_DATE('9999-12-31','YYYY-MM-DD')
hashed_columns:
  BILL_OF_MATERIALS_HK:
  - bill_of_materials_id
  - product_assembly_id
  - component_id
  - unit_measure_code
  PRODUCT_ASSEMBLY_HK: product_assembly_id
  COMPONENT_HK: component_id
  UNIT_MEASURE_C_HK: unit_measure_code
  BILL_OF_MATERIALS_HASHDIFF:
    is_hashdiff: true
    columns:
    - bill_of_materials_id
    - product_assembly_id
    - component_id
    - start_date
    - end_date
    - unit_measure_code
    - bomlevel
    - per_assembly_qty
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
