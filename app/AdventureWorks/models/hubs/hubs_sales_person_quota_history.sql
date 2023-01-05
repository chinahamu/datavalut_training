{{ config(materialized='incremental')    }}

{%- set source_model = "stg_sales_person_quota_history"   -%}
{%- set src_pk = ['business_entity_hk', 'sales_person_quota_history_hk']          -%}
{%- set src_nk = ['business_entity_id']          -%}
{%- set src_ldts = "loaded_at"      -%}
{%- set src_source = "source"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
