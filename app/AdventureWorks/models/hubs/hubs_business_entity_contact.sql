{{ config(materialized='incremental')    }}

{%- set source_model = "stg_business_entity_contact"   -%}
{%- set src_pk = ['business_entity_hk', 'person_hk', 'contact_type_hk', 'business_entity_contact_hk']          -%}
{%- set src_nk = ['business_entity_id', 'person_id', 'contact_type_id']          -%}
{%- set src_ldts = "loaded_at"      -%}
{%- set src_source = "source"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
