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

# Open the input file and read its contents
with open('links_template.txt', 'r') as f:
    contents_raw = f.read()

cur = conn.cursor()
cur.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'main_staging'")
tables = cur.fetchall()

for table in tables:
    data = {}
    table_name = table[0]
    contents = contents_raw

    # Replace "v_stg_orders" with "hoge_table"
    contents = contents.replace("v_stg_orders", table_name)
    
    cur.execute("SELECT column_name FROM information_schema.columns WHERE table_schema = 'main_staging' AND table_name = %s", (table_name,))
    columns = cur.fetchall()
    hk = []
    hk_list = [x[0] for x in columns if "_hk" in x[0]]
    for s in hk_list:
        hk.append("'" + s + "'")
        
    hk = "[" + ", ".join(hk) + "]"
    contents = contents.replace("\"CUSTOMER_ORDER_HK\"", hk)

    id = []
    id_list = [x[0] for x in columns if "_id" in x[0] or "_code" in x[0]]
    for s in id_list:
        id.append("'" + s + "'")
    id = "[" + ", ".join(id) + "]"
    contents = contents.replace("\"CUSTOMER_ID\"", id)

    
    table_name = table_name.replace('stg_', '')
    # Open the output file and write the modified contents
    with open(f'tmp/links_{table_name}.sql', 'w') as f:
        f.write(contents)
