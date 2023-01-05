{{ config(materialized='incremental')         }}

{%- set source_model = "stg_unit_measure"        -%}
{%- set src_pk = ['unit_measure_c_hk', 'unit_measure_hk']         -%}
{%- set src_fk = ['unit_measure_code'] -%}
{%- set src_ldts = "loaded_at"           -%}
{%- set src_source = "source"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
