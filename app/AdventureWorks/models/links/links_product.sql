{{ config(materialized='incremental')         }}

{%- set source_model = "stg_product"        -%}
{%- set src_pk = ['product_hk', 'size_unit_measure_c_hk', 'weight_unit_measure_c_hk', 'product_subcategory_hk', 'product_model_hk']         -%}
{%- set src_fk = ['product_id', 'size_unit_measure_code', 'weight_unit_measure_code', 'product_subcategory_id', 'product_model_id'] -%}
{%- set src_ldts = "loaded_at"           -%}
{%- set src_source = "source"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
