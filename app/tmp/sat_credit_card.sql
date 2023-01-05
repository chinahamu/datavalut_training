{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: '''stg_credit_card'''
src_hashdiff: '''{''src_hashdiff'': ''credit_card_hashdiff'', ''alias'': ''HASHDIFF''}'''
src_pk: '''credit_card_hk'''
src_payload: '''[''card_type'', ''card_number'', ''exp_month'', ''exp_year'', ''modified_date'']'''
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
