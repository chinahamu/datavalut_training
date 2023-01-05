{{ config(materialized='incremental')         }}

{%- set source_model = "stg_purchase_order_header"        -%}
{%- set src_pk = ['purchase_order_hk', 'employee_hk', 'vendor_hk', 'ship_method_hk', 'purchase_order_header_hk']         -%}
{%- set src_fk = ['purchase_order_id', 'employee_id', 'vendor_id', 'ship_method_id'] -%}
{%- set src_ldts = "loaded_at"           -%}
{%- set src_source = "source"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
