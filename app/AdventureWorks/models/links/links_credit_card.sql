{{ config(materialized='incremental')         }}

{%- set source_model = "stg_credit_card"        -%}
{%- set src_pk = ['credit_card_hk']         -%}
{%- set src_fk = ['credit_card_id'] -%}
{%- set src_ldts = "loaded_at"           -%}
{%- set src_source = "source"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
