{{ config(materialized='incremental')    }}

{%- set source_model = "stg_purchase_order_detail"   -%}
{%- set src_pk = ['purchase_order_hk', 'purchase_order_detail_hk', 'product_hk']          -%}
{%- set src_nk = ['purchase_order_id', 'purchase_order_detail_id', 'product_id']          -%}
{%- set src_ldts = "loaded_at"      -%}
{%- set src_source = "source"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
