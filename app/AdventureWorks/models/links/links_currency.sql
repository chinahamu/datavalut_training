{{ config(materialized='incremental')         }}

{%- set source_model = "stg_currency"        -%}
{%- set src_pk = ['currency_c_hk', 'currency_hk']         -%}
{%- set src_fk = ['currency_code'] -%}
{%- set src_ldts = "loaded_at"           -%}
{%- set src_source = "source"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
