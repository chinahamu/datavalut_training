{{ config(materialized='incremental')    }}

{%- set source_model = "stg_sales_order_header"   -%}
{%- set src_pk = ['sales_order_hk', 'customer_hk', 'sales_person_hk', 'territory_hk', 'bill_to_address_hk', 'ship_to_address_hk', 'ship_method_hk', 'credit_card_hk', 'credit_card_approval_c_hk', 'currency_rate_hk', 'sales_order_header_hk']          -%}
{%- set src_nk = ['sales_order_id', 'customer_id', 'sales_person_id', 'territory_id', 'bill_to_address_id', 'ship_to_address_id', 'ship_method_id', 'credit_card_id', 'credit_card_approval_code', 'currency_rate_id']          -%}
{%- set src_ldts = "loaded_at"      -%}
{%- set src_source = "source"    -%}

{{ dbtvault.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}
