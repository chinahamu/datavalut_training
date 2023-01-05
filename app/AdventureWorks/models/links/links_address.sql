{{ config(materialized='incremental')         }}

{%- set source_model = "stg_address"        -%}
{%- set src_pk = ['address_hk', 'state_province_hk', 'postal_c_hk']         -%}
{%- set src_fk = ['address_id', 'state_province_id', 'postal_code'] -%}
{%- set src_ldts = "loaded_at"           -%}
{%- set src_source = "source"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
