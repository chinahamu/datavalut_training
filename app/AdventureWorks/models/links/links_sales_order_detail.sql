{{ config(materialized='incremental')         }}

{%- set source_model = "stg_sales_order_detail"        -%}
{%- set src_pk = ['sales_order_hk', 'sales_order_detail_hk', 'product_hk', 'special_offer_hk']         -%}
{%- set src_fk = ['sales_order_id', 'sales_order_detail_id', 'product_id', 'special_offer_id'] -%}
{%- set src_ldts = "loaded_at"           -%}
{%- set src_source = "source"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
