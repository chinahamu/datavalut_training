{{ config(materialized='incremental')    }}

{%- set source_model = "stg_state_province"   -%}
{%- set src_pk = ['state_province_hk', 'state_province_c_hk', 'country_region_c_hk', 'territory_hk']          -%}
{%- set src_nk = ['state_province_id', 'state_province_code', 'country_region_code', 'territory_id']          -%}
{%- set src_ldts = "loaded_at"      -%}
{%- set src_source = "source"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
