{{ config(materialized='incremental')    }}

{%- set source_model = "stg_job_candidate"   -%}
{%- set src_pk = ['job_candidate_hk', 'business_entity_hk']          -%}
{%- set src_nk = ['job_candidate_id', 'business_entity_id']          -%}
{%- set src_ldts = "loaded_at"      -%}
{%- set src_source = "source"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
