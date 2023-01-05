{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: '''stg_sales_order_header'''
src_hashdiff: '''{''src_hashdiff'': ''sales_order_header_hashdiff'', ''alias'': ''HASHDIFF''}'''
src_pk: '''sales_order_header_hk'''
src_payload: '''[''revision_number'', ''order_date'', ''due_date'', ''ship_date'',
  ''status'', ''online_order_flag'', ''sales_order_number'', ''purchase_order_number'',
  ''account_number'', ''credit_card_approval_code'', ''sub_total'', ''tax_amt'', ''freight'',
  ''total_due'', ''comment'', ''rowguid'', ''modified_date'']'''
src_eff: '''load_datetime'''
src_ldts: '''load_datetime'''
src_source: '''source'''

{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.sat(src_pk=metadata_dict["src_pk"],
                src_hashdiff=metadata_dict["src_hashdiff"],
                src_payload=metadata_dict["src_payload"],
                src_eff=metadata_dict["src_eff"],
                src_ldts=metadata_dict["src_ldts"],
                src_source=metadata_dict["src_source"],
                source_model=metadata_dict["source_model"])   }}
