{{ config(materialized='incremental')    }}

{%- set source_model = "stg_unit_measure"   -%}
{%- set src_pk = ['unit_measure_c_hk', 'unit_measure_hk']          -%}
{%- set src_nk = ['unit_measure_code']          -%}
{%- set src_ldts = "loaded_at"      -%}
{%- set src_source = "source"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
