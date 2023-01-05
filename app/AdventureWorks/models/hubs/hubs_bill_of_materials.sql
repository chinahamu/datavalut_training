{{ config(materialized='incremental')    }}

{%- set source_model = "stg_bill_of_materials"   -%}
{%- set src_pk = ['bill_of_materials_hk', 'product_assembly_hk', 'component_hk', 'unit_measure_c_hk']          -%}
{%- set src_nk = ['bill_of_materials_id', 'product_assembly_id', 'component_id', 'unit_measure_code']          -%}
{%- set src_ldts = "loaded_at"      -%}
{%- set src_source = "source"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
