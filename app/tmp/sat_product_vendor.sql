{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: '''stg_product_vendor'''
src_hashdiff: '''{''src_hashdiff'': ''product_vendor_hashdiff'', ''alias'': ''HASHDIFF''}'''
src_pk: '''product_vendor_hk'''
src_payload: '''[''average_lead_time'', ''standard_price'', ''last_receipt_cost'',
  ''last_receipt_date'', ''min_order_qty'', ''max_order_qty'', ''on_order_qty'', ''unit_measure_code'',
  ''modified_date'']'''
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
