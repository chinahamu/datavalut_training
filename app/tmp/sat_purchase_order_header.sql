{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: '''stg_purchase_order_header'''
src_hashdiff: '''{''src_hashdiff'': ''purchase_order_header_hashdiff'', ''alias'':
  ''HASHDIFF''}'''
src_pk: '''purchase_order_header_hk'''
src_payload: '''[''revision_number'', ''status'', ''order_date'', ''ship_date'', ''sub_total'',
  ''tax_amt'', ''freight'', ''total_due'', ''modified_date'']'''
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
