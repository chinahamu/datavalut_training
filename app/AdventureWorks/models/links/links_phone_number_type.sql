{{ config(materialized='incremental')         }}

{%- set source_model = "stg_phone_number_type"        -%}
{%- set src_pk = ['phone_number_type_hk']         -%}
{%- set src_fk = ['phone_number_type_id'] -%}
{%- set src_ldts = "loaded_at"           -%}
{%- set src_source = "source"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
