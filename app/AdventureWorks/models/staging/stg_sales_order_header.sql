{{ config(materialized='view') }}

{%- set yaml_metadata -%}
 source_model:
  main: sales_order_header
derived_columns:
  SOURCE: '!1'
  LOAD_DATETIME: loaded_at
  EFFECTIVE_FROM: loaded_at
  START_DATE: loaded_at
  END_DATE: TO_DATE('9999-12-31','YYYY-MM-DD')
hashed_columns:
  SALES_ORDER_HK: sales_order_id
  CUSTOMER_HK: customer_id
  SALES_PERSON_HK: sales_person_id
  TERRITORY_HK: territory_id
  BILL_TO_ADDRESS_HK: bill_to_address_id
  SHIP_TO_ADDRESS_HK: ship_to_address_id
  SHIP_METHOD_HK: ship_method_id
  CREDIT_CARD_HK: credit_card_id
  CREDIT_CARD_APPROVAL_C_HK: credit_card_approval_code
  CURRENCY_RATE_HK: currency_rate_id
  SALES_ORDER_HEADER_HK:
  - sales_order_id
  - customer_id
  - sales_person_id
  - territory_id
  - bill_to_address_id
  - ship_to_address_id
  - ship_method_id
  - credit_card_id
  - credit_card_approval_code
  - currency_rate_id
  SALES_ORDER_HEADER_HASHDIFF:
    is_hashdiff: true
    columns:
    - sales_order_id
    - revision_number
    - order_date
    - due_date
    - ship_date
    - status
    - online_order_flag
    - sales_order_number
    - purchase_order_number
    - account_number
    - customer_id
    - sales_person_id
    - territory_id
    - bill_to_address_id
    - ship_to_address_id
    - ship_method_id
    - credit_card_id
    - credit_card_approval_code
    - currency_rate_id
    - sub_total
    - tax_amt
    - freight
    - total_due
    - comment
    - rowguid
    - modified_date
    - loaded_at

{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.stage(include_source_columns=true,
                  source_model=metadata_dict['source_model'],
                  derived_columns=metadata_dict['derived_columns'],
                  null_columns=none,
                  hashed_columns=metadata_dict['hashed_columns'],
                  ranked_columns=none) }}
