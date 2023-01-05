import psycopg2
import datetime

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

# Get the current time in Japan
japan_time = datetime.datetime.now(datetime.timezone(datetime.timedelta(hours=9)))

# Make a list of tables in the main schema
cur.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'main'")
tables = [row[0] for row in cur.fetchall()]

# Add the loaded_at column to each table
for table in tables:
    cur.execute(f"ALTER TABLE main.{table} ADD COLUMN loaded_at TIMESTAMP WITH TIME ZONE")

# Add the current time to the loaded_at column in each table
for table in tables:
    cur.execute(f"UPDATE main.{table} SET loaded_at = %s", (japan_time,))

# Commit the changes to the database
conn.commit()

# Close the cursor and connection
cur.close()
conn.close()
