import sqlite3

# Connect to the SQLite database (or create it if it doesn't exist)
conn = sqlite3.connect('university.db')
# Open and read the modified SQL file
with open('SQL database.sql', 'r') as file:
    sql_script = file.read()
# Execute the SQL script
cursor = conn.cursor()
cursor.executescript(sql_script)
# Commit the changes and close the connection
conn.commit()
conn.close()
print("Database created and populated successfully.")