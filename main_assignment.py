from dbconnect import get_data

def find_students_in_course():
    lecturer_name = input("Enter the lecturer's name: ")
    course_code = input("Enter the course code: ")
    query = f"""
    SELECT s.Name 
    FROM Students s
    JOIN Enrollments e ON s.StudentID = e.StudentID
    JOIN TeachingAssignments t ON e.CourseCode = t.CourseCode
    JOIN Lecturers l ON t.LecturerID = l.LecturerID
    WHERE l.Name = '{lecturer_name}' AND e.CourseCode = '{course_code}'
    """
    students = get_data(query)
    print("Students enrolled in the course:")
    print(students)


def list_students_above_avg():
    """
    Lists all students with an average grade above 70% who are in their final year of studies.
    Queries the database for students who meet the criteria and prints the results.
    Returns:
        None
    """
    query = """
    SELECT Name 
    FROM Students 
    WHERE CurrentGrades > 70 AND YearOfStudy = 4
    """
    students = get_data(query)
    print("Final year students with an average grade above 70%:")
    print(students)


def identify_students_without_courses():
    """
    Identifies students who haven't registered for any courses in the current semester.
    Queries the database for such students and prints the results.
    Returns:
        None
    """
    query = """
    SELECT Name 
    FROM Students 
    WHERE StudentID NOT IN (
        SELECT StudentID FROM Enrollments WHERE Semester = 'Fall 2024'
    )
    """
    students = get_data(query)
    print(students)


def retrieve_faculty_advisor_info():
    """
    Retrieves the contact information for the faculty advisor of a specific student.
    Prompts the user for a student's name and queries the database to find the
    corresponding faculty advisor's contact information.
    Returns:
        None
    """
    student_name = input("Enter the student's name: ")
    query = f"""
    SELECT *
    FROM Lecturers l
    JOIN Students s ON l.LecturerID = s.FacultyAdvisorID
    WHERE s.Name = '{student_name}'
    """
    advisor_info = get_data(query)
    print(advisor_info)


def search_lecturers_by_expertise():
    """
    Searches for lecturers with expertise in a particular research area. 
    Prompts the user for a research area and queries the database to find lecturers
    with expertise in that area.
    Returns:
        None
    """
    research_area = input("Enter the research area: ")
    query = f"""
    SELECT Name, Department 
    FROM Lecturers 
    WHERE AreasOfExpertise LIKE '%{research_area}%'
    """
    lecturers = get_data(query)
    print(lecturers)


def view_students():
    """
    Retrieves and displays all students in the database.
    Returns:
        None
    """
    query = "SELECT * FROM Students"
    return get_data(query)


def main_menu():
    """
    Displays the main menu for the university database management system.
    Allows users to select and execute various queries.
    Returns:
        None
    """
    while True:
        print("\nUniversity Database Management")
        print("1. View Students")
        print("2. Find students enrolled in a specific course taught by a particular lecturer")
        print("3. List all students with an average grade above 70% who are in their final year of studies")
        print("4. Identify students who haven't registered for any courses in the current semester")
        print("5. Retrieve the contact information for the faculty advisor of a specific student")
        print("6. Search for lecturers with expertise in a particular research area")
        print("7. Exit")
        choice = input("Select an option (1-7): ")
        if choice == '1':
            students = view_students()
            print(students)
        elif choice == '2':
            find_students_in_course()
        elif choice == '3':
            list_students_above_avg()
        elif choice == '4':
            identify_students_without_courses()
        elif choice == '5':
            retrieve_faculty_advisor_info()
        elif choice == '6':
            search_lecturers_by_expertise()
        elif choice == '7':
            break
        else:
            print("Invalid option, please try again.")


if __name__ == "__main__":
    main_menu()