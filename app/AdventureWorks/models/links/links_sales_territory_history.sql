{{ config(materialized='incremental')         }}

{%- set source_model = "stg_sales_territory_history"        -%}
{%- set src_pk = ['business_entity_hk', 'territory_hk', 'sales_territory_history_hk']         -%}
{%- set src_fk = ['business_entity_id', 'territory_id'] -%}
{%- set src_ldts = "loaded_at"           -%}
{%- set src_source = "source"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
