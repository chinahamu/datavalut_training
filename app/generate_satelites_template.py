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
cur.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'main_staging'")
tables = cur.fetchall()

for table in tables:
    data = {}
    table_name = table[0]
    data["source_model"] =  table_name
    
    cur.execute("SELECT column_name FROM information_schema.columns WHERE table_schema = 'main_staging' AND table_name = %s", (table_name,))
    columns = cur.fetchall()

    table_name = table_name.replace('stg_', '')
    data["src_hashdiff"] = {
        'src_hashdiff': table_name+"_hashdiff",
        'alias': 'HASHDIFF'
    }

    data["src_pk"] = table_name +"_hk"

    all_column_list = []
    for column in columns:
        column_name = column[0]
        if '_id' in column_name or '_hk' in column_name or '_hashdiff' in column_name or 'loaded_at' in column_name or 'start_date' in column_name or 'end_date' in column_name or 'source' in column_name or 'effective_from' in column_name or 'load_datetime' in column_name:
            continue
        all_column_list.append(column_name)

    data["src_payload"] = all_column_list

    data["src_eff"] = "load_datetime"
    data["src_ldts"] = "load_datetime"
    data["src_source"] = "source"

    yaml_data = yaml.dump(data,default_flow_style = False, allow_unicode = True, encoding = None,sort_keys=False,quote='\'')
    with open('satelites_template.txt', 'r') as f:
        template = f.read()
    template = template.replace('set_yml', yaml_data)
    with open('tmp/sat_{}.sql'.format(table_name), 'w') as f:
     f.write(template)