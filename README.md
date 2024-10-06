# University Database Management System

This project is a simple university database management system implemented in Python. It allows users to query a database of students, lecturers, and courses to retrieve specific information.

## Features

- View all students in the database.
- Find students enrolled in a specific course taught by a particular lecturer.
- List all students with an average grade above 70% who are in their final year of studies.
- Identify students who haven't registered for any courses in the current semester.
- Retrieve the contact information for the faculty advisor of a specific student.
- Search for lecturers with expertise in a particular research area.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- Python 3.x
- pip (Python package installer)

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ArturoVegal/GroupA_Databases.git
   cd GroupA_Databases
   ```
2. **Install dependencies:**
   ```bash
   pip install -r requirements.txt  # Include Pandas, SQLite libraries
   ```

3. **Set up the database:**
   ```bash
   python src/database/create_database.py
   ```

## Usage

To start the university database management system, run:

```bash
python src/queries/main_assignment.py
```

You will be presented with a menu that allows you to:
1. View all students.
2. Find students enrolled in a specific course taught by a particular lecturer.
3. List students with an average grade above 70% in their final year.
4. Identify students not registered for any courses.
5. Retrieve contact information for a faculty advisor.
6. Search lecturers with expertise in a specific research area.

## Testing

You can run tests to verify CRUD operations and access control:

```bash
python src/queries/CRUD_Test_1.py
python src/queries/AccessControl_Test_1.py
```

## License

This project is licensed under the MIT License.
