{{ config(materialized='incremental')    }}

{%- set source_model = "stg_sales_person"   -%}
{%- set src_pk = ['business_entity_hk', 'territory_hk', 'sales_person_hk']          -%}
{%- set src_nk = ['business_entity_id', 'territory_id']          -%}
{%- set src_ldts = "loaded_at"      -%}
{%- set src_source = "source"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
