{{ config(materialized='incremental')    }}

{%- set source_model = "stg_special_offer_product"   -%}
{%- set src_pk = ['special_offer_hk', 'product_hk', 'special_offer_product_hk']          -%}
{%- set src_nk = ['special_offer_id', 'product_id']          -%}
{%- set src_ldts = "loaded_at"      -%}
{%- set src_source = "source"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
