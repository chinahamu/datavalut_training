{{ config(materialized='incremental')    }}

{%- set source_model = "stg_country_region"   -%}
{%- set src_pk = ['country_region_c_hk', 'country_region_hk']          -%}
{%- set src_nk = ['country_region_code']          -%}
{%- set src_ldts = "loaded_at"      -%}
{%- set src_source = "source"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
