{{ config(materialized='incremental')    }}

{%- set source_model = "stg_person_phone"   -%}
{%- set src_pk = ['business_entity_hk', 'phone_number_type_hk', 'person_phone_hk']          -%}
{%- set src_nk = ['business_entity_id', 'phone_number_type_id']          -%}
{%- set src_ldts = "loaded_at"      -%}
{%- set src_source = "source"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
