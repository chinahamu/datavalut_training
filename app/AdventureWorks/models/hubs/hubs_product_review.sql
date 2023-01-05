{{ config(materialized='incremental')    }}

{%- set source_model = "stg_product_review"   -%}
{%- set src_pk = ['product_review_hk', 'product_hk']          -%}
{%- set src_nk = ['product_review_id', 'product_id']          -%}
{%- set src_ldts = "loaded_at"      -%}
{%- set src_source = "source"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
