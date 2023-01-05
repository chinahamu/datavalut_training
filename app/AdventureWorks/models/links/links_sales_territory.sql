{{ config(materialized='incremental')         }}

{%- set source_model = "stg_sales_territory"        -%}
{%- set src_pk = ['territory_hk', 'country_region_c_hk', 'sales_territory_hk']         -%}
{%- set src_fk = ['territory_id', 'country_region_code'] -%}
{%- set src_ldts = "loaded_at"           -%}
{%- set src_source = "source"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
