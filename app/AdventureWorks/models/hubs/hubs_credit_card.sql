{{ config(materialized='incremental')    }}

{%- set source_model = "stg_credit_card"   -%}
{%- set src_pk = ['credit_card_hk']          -%}
{%- set src_nk = ['credit_card_id']          -%}
{%- set src_ldts = "loaded_at"      -%}
{%- set src_source = "source"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
