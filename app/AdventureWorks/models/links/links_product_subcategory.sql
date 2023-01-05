{{ config(materialized='incremental')         }}

{%- set source_model = "stg_product_subcategory"        -%}
{%- set src_pk = ['product_subcategory_hk', 'product_category_hk']         -%}
{%- set src_fk = ['product_subcategory_id', 'product_category_id'] -%}
{%- set src_ldts = "loaded_at"           -%}
{%- set src_source = "source"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
