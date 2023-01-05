import psycopg2
import yaml

# Connect to the database
conn = psycopg2.connect(
    host="172.19.0.2",
    user="dbt",
    password="password",
    port=5432,
    dbname="main"
)

# Create a cursor object to execute SQL statements
cur = conn.cursor()

# Query the information_schema.tables table to get a list of table names
cur.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'main'")

# Get the list of table names from the cursor
table_names = [row[0] for row in cur.fetchall()]

# Close the cursor and connection
cur.close()
conn.close()

# Open the YAML file
with open('AdventureWorks/models/staging/staging.yml', 'r') as f:
    # Load the contents of the YAML file
    data = yaml.safe_load(f)

# Add the table names to the YAML file
data['sources'][0]['tables'].extend([{'name': name} for name in table_names])

# Write the modified contents back to the YAML file
with open('AdventureWorks/models/staging/staging.yml', 'w') as f:
    yaml.dump(data, f)
