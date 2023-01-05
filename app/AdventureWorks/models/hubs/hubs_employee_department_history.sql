{{ config(materialized='incremental')    }}

{%- set source_model = "stg_employee_department_history"   -%}
{%- set src_pk = ['business_entity_hk', 'department_hk', 'shift_hk', 'employee_department_history_hk']          -%}
{%- set src_nk = ['business_entity_id', 'department_id', 'shift_id']          -%}
{%- set src_ldts = "loaded_at"      -%}
{%- set src_source = "source"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
