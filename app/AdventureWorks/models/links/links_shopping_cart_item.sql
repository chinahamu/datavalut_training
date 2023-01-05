{{ config(materialized='incremental')         }}

{%- set source_model = "stg_shopping_cart_item"        -%}
{%- set src_pk = ['shopping_cart_item_hk', 'shopping_cart_hk', 'product_hk']         -%}
{%- set src_fk = ['shopping_cart_item_id', 'shopping_cart_id', 'product_id'] -%}
{%- set src_ldts = "loaded_at"           -%}
{%- set src_source = "source"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
