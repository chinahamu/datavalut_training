{{ config(materialized='incremental')         }}

{%- set source_model = "stg_sales_tax_rate"        -%}
{%- set src_pk = ['sales_tax_rate_hk', 'state_province_hk']         -%}
{%- set src_fk = ['sales_tax_rate_id', 'state_province_id'] -%}
{%- set src_ldts = "loaded_at"           -%}
{%- set src_source = "source"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
