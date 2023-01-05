{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: '''stg_business_entity_address'''
src_hashdiff: '''{''src_hashdiff'': ''business_entity_address_hashdiff'', ''alias'':
  ''HASHDIFF''}'''
src_pk: '''business_entity_address_hk'''
src_payload: '''[''rowguid'', ''modified_date'']'''
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
