{{ config(materialized='incremental')         }}

{%- set source_model = "stg_employee"        -%}
{%- set src_pk = ['business_entity_hk', 'login_hk', 'employee_hk']         -%}
{%- set src_fk = ['business_entity_id', 'national_idnumber', 'login_id'] -%}
{%- set src_ldts = "loaded_at"           -%}
{%- set src_source = "source"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
