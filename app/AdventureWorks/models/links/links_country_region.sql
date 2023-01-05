{{ config(materialized='incremental')         }}

{%- set source_model = "stg_country_region"        -%}
{%- set src_pk = ['country_region_c_hk', 'country_region_hk']         -%}
{%- set src_fk = ['country_region_code'] -%}
{%- set src_ldts = "loaded_at"           -%}
{%- set src_source = "source"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
