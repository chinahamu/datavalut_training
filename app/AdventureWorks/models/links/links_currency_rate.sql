{{ config(materialized='incremental')         }}

{%- set source_model = "stg_currency_rate"        -%}
{%- set src_pk = ['currency_rate_hk', 'from_currency_c_hk', 'to_currency_c_hk']         -%}
{%- set src_fk = ['currency_rate_id', 'from_currency_code', 'to_currency_code'] -%}
{%- set src_ldts = "loaded_at"           -%}
{%- set src_source = "source"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
