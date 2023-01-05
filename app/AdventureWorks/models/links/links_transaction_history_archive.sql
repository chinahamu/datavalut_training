{{ config(materialized='incremental')         }}

{%- set source_model = "stg_transaction_history_archive"        -%}
{%- set src_pk = ['transaction_hk', 'product_hk', 'reference_order_hk', 'reference_order_line_hk', 'transaction_history_archive_hk']         -%}
{%- set src_fk = ['transaction_id', 'product_id', 'reference_order_id', 'reference_order_line_id'] -%}
{%- set src_ldts = "loaded_at"           -%}
{%- set src_source = "source"         -%}

{{ dbtvault.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                 src_source=src_source, source_model=source_model) }}
