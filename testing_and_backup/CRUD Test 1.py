#!/usr/bin/env python
# coding: utf-8

# In[3]:


from sqlalchemy import create_engine, Column, Integer, String, Date, ForeignKey
from sqlalchemy.orm import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy.exc import IntegrityError

# Database connection setup
DATABASE_URL = 'mysql+mysqlconnector://root:admin@localhost/ABCU'
engine = create_engine(DATABASE_URL)
Base = declarative_base()
Session = sessionmaker(bind=engine)

class Students(Base):
    __tablename__ = 'Students'

    StudentID = Column(Integer, primary_key=True, autoincrement=True)
    Name = Column(String(100))
    DateOfBirth = Column(Date)
    ContactInfo = Column(String(50), unique=True)
    ProgramEnrolled = Column(String(100))
    YearOfStudy = Column(Integer)
    CurrentGrades = Column(Integer)
    GraduationStatus = Column(String(10))
    DisciplinaryRecords = Column(String(255))

def create_student(session, name, dob, contact_info, program, year, grades, status, records):
    """Create a new student record."""
    new_student = Students(
        Name=name,
        DateOfBirth=dob,
        ContactInfo=contact_info,
        ProgramEnrolled=program,
        YearOfStudy=year,
        CurrentGrades=grades,
        GraduationStatus=status,
        DisciplinaryRecords=records
    )
    session.add(new_student)
    try:
        session.commit()
        print(f"Created: {new_student.Name}")
    except IntegrityError:
        session.rollback()
        print(f"Error: Could not create student {name}. Contact info might be duplicate.")

def read_students(session):
    """Read all student records."""
    students = session.query(Students).all()
    for student in students:
        print(f"Student ID: {student.StudentID}, Name: {student.Name}, Program: {student.ProgramEnrolled}")

def update_student(session, current_name, new_grades, new_status):
    """Update an existing student record."""
    student_to_update = session.query(Students).filter(Students.Name == current_name).first()
    if student_to_update:
        student_to_update.CurrentGrades = new_grades
        student_to_update.GraduationStatus = new_status
        session.commit()
        print(f"Updated: {student_to_update.Name} - New Grades: {student_to_update.CurrentGrades}")

def delete_student(session, name):
    """Delete a student record."""
    student_to_delete = session.query(Students).filter(Students.Name == name).first()
    if student_to_delete:
        session.delete(student_to_delete)
        session.commit()
        print(f"Deleted: {student_to_delete.Name}")

def main():
    """Main function to perform CRUD operations."""
    session = Session()
    
    # Create a student
    create_student(session, 'John Doe', '2000-05-15', '1234567890', 
                   'Computer Science', 1, 85, 'Active', 'None')
    
    # Read all students
    read_students(session)
    
    # Update a student
    update_student(session, 'John Doe', 90, 'Graduated')
    
    # Delete a student
    delete_student(session, 'John Doe')
    
    session.close()

if __name__ == '__main__':
    main()


# In[ ]:




