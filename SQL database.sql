-- Create the ABC University Database
--CREATE DATABASE ABCU;

-- Use the ABC University Database
--USE ABCU;

DROP TABLE IF EXISTS ResearchGroups;
CREATE TABLE ResearchGroups (
    ResearchGroupID INTEGER PRIMARY KEY,
    GroupName VARCHAR(100) UNIQUE,
    FocusArea TEXT,
    LeadResearcherID INT
);

-- Lecturers Table
DROP TABLE IF EXISTS Lecturers;
CREATE TABLE Lecturers (
    LecturerID INTEGER PRIMARY KEY,
    Name VARCHAR(100) UNIQUE, -- Assume lectures are in smaller pool, might be unique within university
    Department VARCHAR(100),
    AcademicQualifications VARCHAR(50),
    AreasOfExpertise VARCHAR(100),
    CourseLoad INT,
    ResearchInterests VARCHAR(100),
    Publications VARCHAR(255),
    ResearchGroupID INT,
    FOREIGN KEY (ResearchGroupID) REFERENCES ResearchGroups(ResearchGroupID)
);

-- Students Table
DROP TABLE IF EXISTS Students;
CREATE TABLE Students (
    StudentID INTEGER PRIMARY KEY,
    Name VARCHAR(100), -- bigger pool, common name may appear, so did not assign unique
    DateOfBirth DATE,
    ContactInfo VARCHAR(50) UNIQUE, -- Assume each student has unique contact number.
    ProgramEnrolled VARCHAR(100),
    YearOfStudy INT,
    CurrentGrades INT,
    GraduationStatus VARCHAR(10),
    DisciplinaryRecords VARCHAR(255),
    FacultyAdvisorID INT, -- Added for the one-to-one relationship with Lecturers
    FOREIGN KEY (FacultyAdvisorID) REFERENCES Lecturers(LecturerID) 
);

-- Non-Academic Staff Table
DROP TABLE IF EXISTS NonAcademicStaff;
CREATE TABLE NonAcademicStaff (
    StaffID INTEGER PRIMARY KEY,
    Name VARCHAR(100) UNIQUE,  -- Assume staff names unique within university for administrative.
    JobTitle VARCHAR(100),
    Department VARCHAR(100),
    EmploymentType VARCHAR(20),
    ContractDetails VARCHAR(50),
    SalaryInfo DECIMAL(10, 0),
    EmergencyContactInfo VARCHAR(50) UNIQUE  -- assume each staff has unique contact
);

-- Courses Table
DROP TABLE IF EXISTS Courses;
CREATE TABLE Courses (
    CourseCode VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100) UNIQUE, -- each course has distinct name to avoid confusion
    Description TEXT,
    Department VARCHAR(100),
    Level INT,
    Credits INT,
    Prerequisites VARCHAR(100),
    Schedule VARCHAR(100),
    Materials TEXT,
    Lecturers TEXT,
    EnrolledStudents INT,
	ProgramManagerID INT, 
    FOREIGN KEY (ProgramManagerID) REFERENCES NonAcademicStaff(StaffID)
);

-- Departments Table
DROP TABLE IF EXISTS Departments;
CREATE TABLE Departments (
    DepartmentName VARCHAR(100) PRIMARY KEY UNIQUE, -- assume department has distinct name 
    Faculty VARCHAR(100),
    ResearchAreas TEXT,
    CourseOffered TEXT,
    StaffMembers TEXT
);

-- Programs Table (managed by program manager)
DROP TABLE IF EXISTS Programs;
CREATE TABLE Programs (
    ProgramName VARCHAR(100) PRIMARY KEY UNIQUE, -- assume each program has a distinct name
    DegreeAwarded VARCHAR(50),
    Duration INT,
    CourseRequirements TEXT,
    ProgramManagerID INT, 
    FOREIGN KEY (ProgramManagerID) REFERENCES NonAcademicStaff(StaffID)
);

-- Program Enrollment Details Table (Managed by Enrollment Manager)
DROP TABLE IF EXISTS ProgramEnrollmentDetails;
CREATE TABLE ProgramEnrollmentDetails (
    ProgramName VARCHAR(100),
    EnrollmentDetails TEXT,
    FOREIGN KEY (ProgramName) REFERENCES Programs(ProgramName)
);

-- Research Projects Table
DROP TABLE IF EXISTS ResearchProjects;
CREATE TABLE ResearchProjects (
    ProjectTitle VARCHAR(100) PRIMARY KEY,
    PrincipalInvestigator VARCHAR(100),
    FundingSources TEXT,
    TeamMembers TEXT,
    Publications TEXT,
    Outcomes TEXT
);

-- Relationship Tables
-- These tables handle the many-to-many relationships between entities

-- Students and Courses (Enrollments)
-- To handle the many-to-many relationship between students and courses. Each enrollment record will link a student to a course they are enrolled in.
DROP TABLE IF EXISTS Enrollments;
CREATE TABLE Enrollments (
    EnrollmentID INTEGER PRIMARY KEY,
    StudentID INT,
    CourseCode VARCHAR(10),
    Semester VARCHAR(10),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseCode) REFERENCES Courses(CourseCode)
);

-- Students and Lecturers (Advisors)
-- To handle the one-to-one relationship between students and their faculty advisors. Assume each student has only one advisor.
DROP TABLE IF EXISTS Advisors;
CREATE TABLE Advisors (
    AdvisorID INTEGER PRIMARY KEY,
    StudentID INT,
    LecturerID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (LecturerID) REFERENCES Lecturers(LecturerID)
);

-- Lecturers and Courses (Teaching Assignments)
-- To handle the many-to-many relationship between lecturers and the courses they teach.
DROP TABLE IF EXISTS TeachingAssignments;
CREATE TABLE TeachingAssignments (
    AssignmentID INTEGER PRIMARY KEY,
    LecturerID INT,
    CourseCode VARCHAR(10),
    FOREIGN KEY (LecturerID) REFERENCES Lecturers(LecturerID),
    FOREIGN KEY (CourseCode) REFERENCES Courses(CourseCode)
);

-- Lecturers and Research Projects (Research Supervision)
-- To handle the one-to-many relationship between lecturers and research projects. 
DROP TABLE IF EXISTS ResearchSupervision;
CREATE TABLE ResearchSupervision (
    SupervisionID INTEGER PRIMARY KEY,
    LecturerID INT,
    ProjectTitle VARCHAR(100),
    FOREIGN KEY (LecturerID) REFERENCES Lecturers(LecturerID),
    FOREIGN KEY (ProjectTitle) REFERENCES ResearchProjects(ProjectTitle)
);

-- Departments and Staff (Department Staff)
-- To handle the one-to-many relationship between departments and staff members. Each record will link a staff member to a department.
DROP TABLE IF EXISTS DepartmentStaff;
CREATE TABLE DepartmentStaff (
    DepartmentStaffID INTEGER PRIMARY KEY,
    DepartmentName VARCHAR(100),
    LecturerID INT,
    FOREIGN KEY (DepartmentName) REFERENCES Departments(DepartmentName),
    FOREIGN KEY (LecturerID) REFERENCES Lecturers(LecturerID)
);

-- Committees Table
-- To handle the one-to-many relationship between lecturers and committees.
DROP TABLE IF EXISTS Committees;
CREATE TABLE Committees (
    CommitteeID INTEGER PRIMARY KEY AUTOINCREMENT,
    CommitteeName VARCHAR(100) NOT NULL,
    Purpose TEXT,
    ChairpersonID INT,
    FOREIGN KEY (ChairpersonID) REFERENCES Lecturers(LecturerID)
);

-- Dummy data
-- 5 Research Groups
INSERT INTO ResearchGroups (GroupName, FocusArea, LeadResearcherID) VALUES
('AI Research Group', 'Artificial Intelligence', 1),
('Algebra Research Group', 'Algebra', 2),
('Quantum Physics Group', 'Quantum Mechanics', 3),
('Organic Chemistry Group', 'Organic Chemistry', 4),
('Genetics Research Group', 'Genetics', 5);

-- 10 lecturers
INSERT INTO Lecturers (Name, Department, AcademicQualifications, AreasOfExpertise, CourseLoad, ResearchInterests, Publications, ResearchGroupID) VALUES
('Emily White', 'Computer Science', 'PhD', 'Artificial Intelligence', 3, 'Machine Learning', 'AI for Good', 1),
('John Brown', 'Mathematics', 'PhD', 'Algebra', 2, 'Number Theory', 'Algebraic Structures', 2),
('Kathy Adams', 'Physics', 'PhD', 'Quantum Mechanics', 3, 'Particle Physics', 'Quantum Fields', 3),
('Larry Hughes', 'Chemistry', 'PhD', 'Organic Chemistry', 2, 'Synthetic Methods', 'Chemical Reactions', 4),
('Monica Bell', 'Biology', 'PhD', 'Genetics', 3, 'Evolutionary Biology', 'Genome Mapping', 5),
('Nathan Drake', 'Computer Science', 'PhD', 'Cybersecurity', 2, 'Network Security', 'Encryption Methods', 1),
('Olivia Grant', 'Mathematics', 'PhD', 'Statistics', 3, 'Probability Theory', 'Statistical Models', 2),
('Peter Scott', 'Physics', 'PhD', 'Thermodynamics', 2, 'Heat Transfer', 'Energy Efficiency', 3),
('Quinn Fabray', 'Chemistry', 'PhD', 'Inorganic Chemistry', 3, 'Coordination Chemistry', 'Metal Complexes', 4),
('Rachel Green', 'Biology', 'PhD', 'Microbiology', 2, 'Infectious Diseases', 'Bacterial Pathogens', 5);

-- 10 students
INSERT INTO Students (Name, DateOfBirth, ContactInfo, ProgramEnrolled, YearOfStudy, CurrentGrades, GraduationStatus, DisciplinaryRecords, FacultyAdvisorID) VALUES
('Alice Smith', '1999-04-12', '555-1234', 'Computer Science', 3, 85, 'No', 'None', 1),
('Bob Johnson', '1998-08-23', '555-5678', 'Mathematics', 4, 78, 'Yes', 'None', 2),
('Carol Taylor', '2000-11-01', '555-9012', 'Physics', 2, 65, 'No', 'None', 3),
('David Lee', '1997-05-15', '555-3456', 'Chemistry', 1, 55, 'No', 'None', 4),
('Eva Long', '2001-03-22', '555-7890', 'Biology', 3, 88, 'No', 'None', 5),
('Frank Wright', '1999-07-30', '555-6543', 'Computer Science', 4, 92, 'Yes', 'None', 1),
('Grace Hall', '1998-02-19', '555-3210', 'Mathematics', 2, 72, 'No', 'None', 2),
('Henry Ford', '2000-12-05', '555-2134', 'Physics', 1, 68, 'No', 'None', 3),
('Ivy Green', '1997-08-17', '555-4321', 'Chemistry', 3, 90, 'No', 'None', 4),
('Jack Black', '2001-06-29', '555-8765', 'Biology', 4, 75, 'Yes', 'None', 5);

-- 2 non-academic staffs
INSERT INTO NonAcademicStaff (Name, JobTitle, Department, EmploymentType, ContractDetails, SalaryInfo, EmergencyContactInfo) VALUES
('Mark Spencer', 'Enrolment manager', 'Admin office', 'Full-time', '2020-2025', 50000.00, '555-9876'),
('Lucy Adams', 'Program manager', 'Admin Office', 'Part-time', '2021-2023', 30000.00, '555-6543');

-- 10 courses (continued)
INSERT INTO Courses (CourseCode, Name, Description, Department, Level, Credits, Prerequisites, Schedule, Materials, Lecturers, EnrolledStudents, ProgramManagerID) VALUES
('CS101', 'Introduction to Computer Science', 'Learn the basics of computer science.', 'Computer Science', 1, 3, 'None', 'MWF 9-10', 'Textbook', 'Emily White', 2, 2),
('MATH201', 'Advanced Algebra', 'Dive into the complexities of algebra.', 'Mathematics', 2, 4, 'Algebra I', 'TR 10-12', 'Workbook', 'John Brown', 2, 2),
('PHYS301', 'Quantum Physics', 'Explore the principles of quantum mechanics.', 'Physics', 3, 4, 'Physics I', 'MWF 11-12', 'Lab Kit', 'Kathy Adams', 2, 2),
('CHEM401', 'Organic Synthesis', 'Study the methods of organic compound synthesis.', 'Chemistry', 4, 5, 'Chemistry I', 'TR 1-3', 'Lab Manual', 'Larry Hughes', 2, 2),
('BIO101', 'General Biology', 'Understand the fundamentals of biology.', 'Biology', 1, 3, 'None', 'MWF 2-3', 'Textbook', 'Monica Bell', 2, 2),
('CS102', 'Data Structures', 'An in-depth look at data organization and manipulation.', 'Computer Science', 1, 4, 'CS101', 'TR 9-11', 'Textbook', 'Nathan Drake', 2, 2),
('MATH202', 'Calculus II', 'Continuation of Calculus I, focusing on integral calculus.', 'Mathematics', 2, 4, 'MATH201', 'MWF 10-11', 'Workbook', 'Olivia Grant', 2, 2),
('PHYS102', 'Electromagnetism', 'Study the interactions of electric and magnetic fields.', 'Physics', 1, 4, 'PHYS101', 'TR 2-4', 'Lab Kit', 'Peter Scott', 2, 2),
('CHEM102', 'Inorganic Chemistry', 'Examine the properties and reactions of inorganic compounds.', 'Chemistry', 1, 4, 'CHEM101', 'MWF 1-2', 'Lab Manual', 'Quinn Fabray', 2, 2),
('BIO102', 'Cell Biology', 'Explore the structure and function of cells.', 'Biology', 1, 4, 'BIO101', 'TR 11-1', 'Textbook', 'Rachel Green', 2, 2);

-- 5 departments
INSERT INTO Departments (DepartmentName, Faculty, ResearchAreas, CourseOffered, StaffMembers) VALUES
('Computer Science', 'Engineering', 'AI, Cybersecurity', 'CS101, CS102', 'Emily White, Nathan Drake'),
('Mathematics', 'Science', 'Algebra, Statistics', 'MATH201, MATH202', 'John Brown, Olivia Grant'),
('Physics', 'Science', 'Quantum Mechanics, Thermodynamics', 'PHYS101, PHYS102', 'Kathy Adams, Peter Scott'),
('Chemistry', 'Science', 'Organic Chemistry, Inorganic Chemistry', 'CHEM101, CHEM102', 'Larry Hughes, Quinn Fabray'),
('Biology', 'Science', 'Genetics, Microbiology', 'BIO101, BIO102', 'Monica Bell, Rachel Green');

-- 5 programs
INSERT INTO Programs (ProgramName, DegreeAwarded, Duration, CourseRequirements, ProgramManagerID) VALUES
('Computer Science', 'BSc', 4, 'CS101, CS102, CS201, CS202', 2), -- Lucy Adams
('Mathematics', 'BSc', 4, 'MATH201, MATH202, MATH301, MATH302', 2), -- Lucy Adams
('Physics', 'BSc', 4, 'PHYS101, PHYS102, PHYS201, PHYS202', 2), -- Lucy Adams
('Chemistry', 'BSc', 4, 'CHEM101, CHEM102, CHEM201, CHEM202', 2), -- Lucy Adams
('Biology', 'BSc', 4, 'BIO101, BIO102, BIO201, BIO202', 2); -- Lucy Adams

-- Program Enrollment Details
INSERT INTO ProgramEnrollmentDetails (ProgramName, EnrollmentDetails) VALUES
('Computer Science', 'Open Enrollment'),
('Mathematics', 'Open Enrollment'),
('Physics', 'Open Enrollment'),
('Chemistry', 'Open Enrollment'),
('Biology', 'Open Enrollment');

-- 10 research projects
INSERT INTO ResearchProjects (ProjectTitle, PrincipalInvestigator, FundingSources, TeamMembers, Publications, Outcomes) VALUES
('AI for Healthcare', 'Emily White', 'National Science Foundation', 'Alice Smith, Bob Johnson', 'AI Medicine Journal', 'Developed new algorithm for patient data analysis'),
('Algebraic Structures', 'John Brown', 'Mathematics Research Grant', 'Carol Davis, Dave Wilson', 'Algebra Today', 'Proved new theorem in algebraic geometry'),
('Quantum Computing', 'Rachel Green', 'Technology Research Grant', 'Grace Hall, Henry Ford', 'Quantum Computing Today', 'Achieved a breakthrough in quantum bit stability'),
('Ocean Conservation Strategies', 'Monica Bell', 'Environmental Protection Agency', 'Ivy Green, Jack Black', 'Marine Biology Today', 'Implemented a new coral reef protection program'),
('Artificial Photosynthesis', 'Larry Hughes', 'National Science Foundation', 'Kathy Adams, Nathan Drake', 'Journal of Synthetic Biology', 'Synthesized a new light-absorbing material'),
('Cybersecurity Advances', 'Nathan Drake', 'Technology Security Grant', 'Alice Smith, Bob Johnson', 'Cybersecurity Today', 'Developed a new encryption method for secure communications'),
('Statistical Methods for Big Data', 'Olivia Grant', 'Data Science Institute', 'Carol Davis, Dave Wilson', 'Big Data Analytics Journal', 'Created innovative statistical models for analyzing large datasets'),
('Thermodynamic Efficiency', 'Peter Scott', 'Energy Research Association', 'Grace Hall, Henry Ford', 'Thermodynamics Monthly', 'Designed a new process for improving energy efficiency in industrial systems'),
('Coordination Chemistry Innovations', 'Quinn Fabray', 'Chemical Research Society', 'Ivy Green, Jack Black', 'Inorganic Chemistry Review', 'Synthesized novel metal complexes with unique properties'),
('Evolutionary Genetics', 'Monica Bell', 'Biology Research Council', 'Kathy Adams, Nathan Drake', 'Genetics and Evolution Journal', 'Mapped a new genetic pathway related to evolutionary adaptation');

-- 5 commmittes
INSERT INTO Committees (CommitteeName, Purpose, ChairpersonID) VALUES
('Curriculum Committee', 'Oversees the development and approval of academic courses and curricula', 1),
('Research Committee', 'Facilitates and reviews research activities and grant proposals', 2),
('Disciplinary Committee', 'Handles cases of academic misconduct and disciplinary issues', 3),
('Admissions Committee', 'Reviews and decides on student applications for admission', 4),
('Scholarship Committee', 'Manages the awarding of scholarships and financial aid', 5);

-- Enrollments
INSERT INTO Enrollments (StudentID, CourseCode, Semester) VALUES
(1, 'CS101', 'Fall 2024'),
(2, 'MATH201', 'Fall 2024'),
(3, 'PHYS301', 'Fall 2024'),
(4, 'CHEM401', 'Fall 2024'),
(5, 'BIO101', 'Fall 2024'),
(6, 'CS102', 'Fall 2024'),
(7, 'MATH202', 'Fall 2024'),
(8, 'PHYS102', 'Fall 2024'),
(9, 'CHEM102', 'Fall 2024'),
(10, 'BIO102', 'Fall 2024');

-- Advisors
INSERT INTO Advisors (StudentID, LecturerID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 1),
(7, 2),
(8, 3),
(9, 4),
(10, 5);

-- TeachingAssignments
INSERT INTO TeachingAssignments (LecturerID, CourseCode) VALUES
(1, 'CS101'),
(2, 'MATH201'),
(3, 'PHYS301'),
(4, 'CHEM401'),
(5, 'BIO101'),
(6, 'CS102'),
(7, 'MATH202'),
(8, 'PHYS102'),
(9, 'CHEM102'),
(10, 'BIO102');

-- ResearchSupervision
INSERT INTO ResearchSupervision (LecturerID, ProjectTitle) VALUES
(1, 'AI for Healthcare'),
(2, 'Algebraic Structures'),
(3, 'Quantum Computing'),
(4, 'Ocean Conservation Strategies'),
(5, 'Artificial Photosynthesis'),
(6, 'Cybersecurity Advances'),
(7, 'Statistical Methods for Big Data'),
(8, 'Thermodynamic Efficiency'),
(9, 'Coordination Chemistry Innovations'),
(10, 'Evolutionary Genetics');

-- DepartmentStaff
INSERT INTO DepartmentStaff (DepartmentName, LecturerID) VALUES
('Computer Science', 1), -- Emily White
('Computer Science', 6), -- Nathan Drake
('Mathematics', 2), -- John Brown
('Mathematics', 7), -- Olivia Grant
('Physics', 3), -- Kathy Adams
('Physics', 8), -- Peter Scott
('Chemistry', 4), -- Larry Hughes
('Chemistry', 9), -- Quinn Fabray
('Biology', 5), -- Monica Bell
('Biology', 10); -- Rachel Green



-- To view data of Students
SELECT * FROM Students;

-- To view data of Lecturers
SELECT * FROM Lecturers;

-- To view data of NonAcademicStaff
SELECT * FROM NonAcademicStaff;

-- To view data of Courses
SELECT * FROM Courses;

-- To view data of Departments
SELECT * FROM Departments;

-- To view data of programs
SELECT * FROM Programs;

-- To view data of research projects
SELECT * FROM ResearchProjects;

-- To view data of Committees
SELECT * FROM Committees;

