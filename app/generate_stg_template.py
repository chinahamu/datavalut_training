import psycopg2
import yaml
from collections import OrderedDict

#from collections import OrderedDict

conn = psycopg2.connect(
    host='172.19.0.2',
    port=5432,
    dbname='main',
    user='dbt',
    password='password'
)

cur = conn.cursor()
cur.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'main'")
tables = cur.fetchall()

for table in tables:
    data = {}
    table_name = table[0]
    data["source_model"] = {
            'main': table_name
    }
    data["derived_columns"] = {
        'SOURCE': '!1',
        'LOAD_DATETIME': 'loaded_at',
        'EFFECTIVE_FROM': 'loaded_at',
        'START_DATE': 'loaded_at',
        'END_DATE': "TO_DATE('9999-12-31','YYYY-MM-DD')"       
    }
    
    data["hashed_columns"] = {}
    
    cur.execute("SELECT column_name FROM information_schema.columns WHERE table_schema = 'main' AND table_name = %s", (table_name,))
    columns = cur.fetchall()

    for column in columns:
        column_name = column[0]
        if column_name.endswith('_id') or column_name.endswith('_code'):
            new_column_name = column_name[:-3].upper() + '_HK'
            data["hashed_columns"][new_column_name] = column_name

    if cur.rowcount >= 2:
        column_list = []
        for column in columns:
            column_name = column[0]
            if column_name.endswith('_id') or column_name.endswith('_code'):
                column_list.append(column_name)
        table_name_upper = table_name.upper()
        table_name_upper_hk = table_name.upper() + "_HK"
        data["hashed_columns"][table_name_upper_hk] = column_list

    hashdiff_key = table_name_upper + '_HASHDIFF'


    all_column_list = []
    for column in columns:
        column_name = column[0]
        all_column_list.append(column_name)


    data["hashed_columns"][hashdiff_key] = {'is_hashdiff': True,'columns': all_column_list}
   

    yaml_data = yaml.safe_dump(data,default_flow_style = False, allow_unicode = True, encoding = None,sort_keys=False)
    with open('template.txt', 'r') as f:
        template = f.read()
    template = template.replace('set_yml', yaml_data)
    with open('tmp/stg_{}.sql'.format(table_name), 'w') as f:
     f.write(template)