# University Database Management System

A Python system for querying a university database of students, lecturers, and courses
through a command-line interface. Built as a group project for CSCK542 (Databases &
Information Systems), MSc Data Science & AI, University of Liverpool.

## Features

- View all students in the database.
- Find students enrolled in a specific course taught by a particular lecturer.
- List all students with an average grade above 70% who are in their final year of studies.
- Identify students who haven't registered for any courses in the current semester.
- Retrieve the contact information for the faculty advisor of a specific student.
- Search for lecturers with expertise in a particular research area.

## Prerequisites

- Python 3.x
- pip (Python package installer)

## Installation

1. **Clone the repository:**
```bash
   git clone https://github.com/ArturoVegal/university-database.git
   cd university-database
```
2. **Install dependencies:**
```bash
   pip install -r requirements.txt
```
3. **Set up the database:**
```bash
   python src/database/create_database.py
```

## Usage

To start the system, run:
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

```bash
python src/queries/CRUD_Test_1.py
python src/queries/AccessControl_Test_1.py
```

## Team & my contribution

A group project (CSCK542, MSc Data Science & AI, University of Liverpool).

- **Jose Arturo Vega López — Software Engineer:** built the Python query layer (CLI
  querying the database) and managed the repository.
- Teammates covered schema design, testing, and project coordination.

## License

MIT
