{{ config(materialized='incremental')    }}

{%- set source_model = "stg_business_entity_address"   -%}
{%- set src_pk = ['business_entity_hk', 'address_hk', 'address_type_hk', 'business_entity_address_hk']          -%}
{%- set src_nk = ['business_entity_id', 'address_id', 'address_type_id']          -%}
{%- set src_ldts = "loaded_at"      -%}
{%- set src_source = "source"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
