{{ config(materialized='incremental')         }}

{%- set source_model = "stg_customer"        -%}
{%- set src_pk = ['customer_hk', 'person_hk', 'store_hk', 'territory_hk']         -%}
{%- set src_fk = ['customer_id', 'person_id', 'store_id', 'territory_id'] -%}
{%- set src_ldts = "loaded_at"           -%}
{%- set src_source = "source"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
