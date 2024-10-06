import sqlite3
import pandas as pd

def connect_db():
    """
    Establishes a connection to the SQLite database.
    Returns:
        tuple: A tuple containing the connection object and the cursor object.
    """
    conn = sqlite3.connect('university.db')
    return conn, conn.cursor()


def get_data(query):
    """
    Executes a SQL query and returns the result as a Pandas DataFrame.
    Supports parameterized queries.
    Args:
        query (str): The SQL query to execute.
        params (tuple): A tuple containing the parameters for the SQL query (optional).
    Returns:
        pd.DataFrame: A Pandas DataFrame containing the query results.
    """
    conn, cursor = connect_db()
    df = pd.read_sql_query(query, conn)
    conn.close()
    return df