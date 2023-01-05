{{ config(materialized='incremental')         }}

{%- set source_model = "stg_product_vendor"        -%}
{%- set src_pk = ['product_hk', 'business_entity_hk', 'unit_measure_c_hk', 'product_vendor_hk']         -%}
{%- set src_fk = ['product_id', 'business_entity_id', 'unit_measure_code'] -%}
{%- set src_ldts = "loaded_at"           -%}
{%- set src_source = "source"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
