{{ config(materialized='incremental')         }}

{%- set source_model = "stg_product_model_product_description_culture"        -%}
{%- set src_pk = ['product_model_hk', 'product_description_hk', 'culture_hk', 'product_model_product_description_culture_hk']         -%}
{%- set src_fk = ['product_model_id', 'product_description_id', 'culture_id'] -%}
{%- set src_ldts = "loaded_at"           -%}
{%- set src_source = "source"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
