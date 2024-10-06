#!/usr/bin/env python
# coding: utf-8

# In[7]:


import mysql.connector
from mysql.connector import Error

# Define a list of users with their expected access rights
users = [
    {'username': 'admin', 'password': 'admin_pass', 'expected_access': 'full'},
    {'username': 'editor', 'password': 'editor_pass', 'expected_access': 'write'},
    {'username': 'viewer', 'password': 'viewer_pass', 'expected_access': 'read'},
    {'username': 'invalid_user', 'password': 'wrong_pass', 'expected_access': 'none'},
]

# Function to test access rights based on Students table
def test_access_rights(user):
    try:
        # Attempt to connect to the database
        connection = mysql.connector.connect(
            host='localhost',
            user=user['username'],
            password=user['password'],
            database='ABCU'  # Update with your database name
        )

        if connection.is_connected():
            print(f"User: {user['username']} - Access Granted")
            cursor = connection.cursor()

            # Check access based on expected access level
            if user['expected_access'] == 'full':
                # Check full access by selecting from the Students table
                cursor.execute("SELECT * FROM Students LIMIT 1;")
                print("Full access confirmed. Data:", cursor.fetchone())

            elif user['expected_access'] == 'write':
                # Check write access by attempting to insert a record
                cursor.execute("INSERT INTO Students (Name, DateOfBirth, ContactInfo, ProgramEnrolled, YearOfStudy, CurrentGrades, GraduationStatus, DisciplinaryRecords, FacultyAdvisorID) VALUES ('Test Student 1', '2000-01-01', '9765 4321', 'Computer Science', 2, 85, 'Active', NULL, NULL);")
                connection.commit()
                print("Write access confirmed.")

            elif user['expected_access'] == 'read':
                # Check read access by selecting from the Students table
                cursor.execute("SELECT * FROM Students LIMIT 1;")
                print("Read access confirmed. Data:", cursor.fetchone())

            else:
                print("Unexpected access level for user:", user['username'])

    except Error as e:
        if "Access denied" in str(e):
            print(f"User: {user['username']} - Access Denied")
        elif "Table 'your_database.Students' doesn't exist" in str(e):
            print("Error: The Students table does not exist.")
        else:
            print(f"User: {user['username']} - Connection Error: {e}")

    finally:
        # Close the connection if it was established
        if 'connection' in locals() and connection.is_connected():
            connection.close()

# Iterate over the users and test their access rights
for user in users:
    test_access_rights(user)


# In[ ]:




