{{ config(materialized='incremental')    }}

{%- set source_model = "stg_work_order"   -%}
{%- set src_pk = ['work_order_hk', 'product_hk', 'scrap_reason_hk']          -%}
{%- set src_nk = ['work_order_id', 'product_id', 'scrap_reason_id']          -%}
{%- set src_ldts = "loaded_at"      -%}
{%- set src_source = "source"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
