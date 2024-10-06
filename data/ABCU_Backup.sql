-- MySQL dump 10.13  Distrib 8.0.39, for Win64 (x86_64)
--
-- Host: localhost    Database: ABCU
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `advisors`
--

DROP TABLE IF EXISTS `advisors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advisors` (
  `AdvisorID` int NOT NULL AUTO_INCREMENT,
  `StudentID` int DEFAULT NULL,
  `LecturerID` int DEFAULT NULL,
  PRIMARY KEY (`AdvisorID`),
  KEY `StudentID` (`StudentID`),
  KEY `LecturerID` (`LecturerID`),
  CONSTRAINT `advisors_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `students` (`StudentID`),
  CONSTRAINT `advisors_ibfk_2` FOREIGN KEY (`LecturerID`) REFERENCES `lecturers` (`LecturerID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advisors`
--

LOCK TABLES `advisors` WRITE;
/*!40000 ALTER TABLE `advisors` DISABLE KEYS */;
INSERT INTO `advisors` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,1),(7,7,2),(8,8,3),(9,9,4),(10,10,5);
/*!40000 ALTER TABLE `advisors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `committees`
--

DROP TABLE IF EXISTS `committees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `committees` (
  `CommitteeID` int NOT NULL AUTO_INCREMENT,
  `CommitteeName` varchar(100) NOT NULL,
  `Purpose` text,
  `ChairpersonID` int DEFAULT NULL,
  PRIMARY KEY (`CommitteeID`),
  KEY `ChairpersonID` (`ChairpersonID`),
  CONSTRAINT `committees_ibfk_1` FOREIGN KEY (`ChairpersonID`) REFERENCES `lecturers` (`LecturerID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `committees`
--

LOCK TABLES `committees` WRITE;
/*!40000 ALTER TABLE `committees` DISABLE KEYS */;
INSERT INTO `committees` VALUES (1,'Curriculum Committee','Oversees the development and approval of academic courses and curricula',1),(2,'Research Committee','Facilitates and reviews research activities and grant proposals',2),(3,'Disciplinary Committee','Handles cases of academic misconduct and disciplinary issues',3),(4,'Admissions Committee','Reviews and decides on student applications for admission',4),(5,'Scholarship Committee','Manages the awarding of scholarships and financial aid',5);
/*!40000 ALTER TABLE `committees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `CourseCode` varchar(10) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Description` text,
  `Department` varchar(100) DEFAULT NULL,
  `Level` int DEFAULT NULL,
  `Credits` int DEFAULT NULL,
  `Prerequisites` varchar(100) DEFAULT NULL,
  `Schedule` varchar(100) DEFAULT NULL,
  `Materials` text,
  `Lecturers` text,
  `EnrolledStudents` int DEFAULT NULL,
  `ProgramManagerID` int DEFAULT NULL,
  PRIMARY KEY (`CourseCode`),
  UNIQUE KEY `Name` (`Name`),
  KEY `ProgramManagerID` (`ProgramManagerID`),
  CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`ProgramManagerID`) REFERENCES `nonacademicstaff` (`StaffID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES ('BIO101','General Biology','Understand the fundamentals of biology.','Biology',1,3,'None','MWF 2-3','Textbook','Monica Bell',2,2),('BIO102','Cell Biology','Explore the structure and function of cells.','Biology',1,4,'BIO101','TR 11-1','Textbook','Rachel Green',2,2),('CHEM102','Inorganic Chemistry','Examine the properties and reactions of inorganic compounds.','Chemistry',1,4,'CHEM101','MWF 1-2','Lab Manual','Quinn Fabray',2,2),('CHEM401','Organic Synthesis','Study the methods of organic compound synthesis.','Chemistry',4,5,'Chemistry I','TR 1-3','Lab Manual','Larry Hughes',2,2),('CS101','Introduction to Computer Science','Learn the basics of computer science.','Computer Science',1,3,'None','MWF 9-10','Textbook','Emily White',2,2),('CS102','Data Structures','An in-depth look at data organization and manipulation.','Computer Science',1,4,'CS101','TR 9-11','Textbook','Nathan Drake',2,2),('MATH201','Advanced Algebra','Dive into the complexities of algebra.','Mathematics',2,4,'Algebra I','TR 10-12','Workbook','John Brown',2,2),('MATH202','Calculus II','Continuation of Calculus I, focusing on integral calculus.','Mathematics',2,4,'MATH201','MWF 10-11','Workbook','Olivia Grant',2,2),('PHYS102','Electromagnetism','Study the interactions of electric and magnetic fields.','Physics',1,4,'PHYS101','TR 2-4','Lab Kit','Peter Scott',2,2),('PHYS301','Quantum Physics','Explore the principles of quantum mechanics.','Physics',3,4,'Physics I','MWF 11-12','Lab Kit','Kathy Adams',2,2);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `DepartmentName` varchar(100) NOT NULL,
  `Faculty` varchar(100) DEFAULT NULL,
  `ResearchAreas` text,
  `CourseOffered` text,
  `StaffMembers` text,
  PRIMARY KEY (`DepartmentName`),
  UNIQUE KEY `DepartmentName` (`DepartmentName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES ('Biology','Science','Genetics, Microbiology','BIO101, BIO102','Monica Bell, Rachel Green'),('Chemistry','Science','Organic Chemistry, Inorganic Chemistry','CHEM101, CHEM102','Larry Hughes, Quinn Fabray'),('Computer Science','Engineering','AI, Cybersecurity','CS101, CS102','Emily White, Nathan Drake'),('Mathematics','Science','Algebra, Statistics','MATH201, MATH202','John Brown, Olivia Grant'),('Physics','Science','Quantum Mechanics, Thermodynamics','PHYS101, PHYS102','Kathy Adams, Peter Scott');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departmentstaff`
--

DROP TABLE IF EXISTS `departmentstaff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departmentstaff` (
  `DepartmentStaffID` int NOT NULL AUTO_INCREMENT,
  `DepartmentName` varchar(100) DEFAULT NULL,
  `LecturerID` int DEFAULT NULL,
  PRIMARY KEY (`DepartmentStaffID`),
  KEY `DepartmentName` (`DepartmentName`),
  KEY `LecturerID` (`LecturerID`),
  CONSTRAINT `departmentstaff_ibfk_1` FOREIGN KEY (`DepartmentName`) REFERENCES `departments` (`DepartmentName`),
  CONSTRAINT `departmentstaff_ibfk_2` FOREIGN KEY (`LecturerID`) REFERENCES `lecturers` (`LecturerID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departmentstaff`
--

LOCK TABLES `departmentstaff` WRITE;
/*!40000 ALTER TABLE `departmentstaff` DISABLE KEYS */;
INSERT INTO `departmentstaff` VALUES (1,'Computer Science',1),(2,'Computer Science',6),(3,'Mathematics',2),(4,'Mathematics',7),(5,'Physics',3),(6,'Physics',8),(7,'Chemistry',4),(8,'Chemistry',9),(9,'Biology',5),(10,'Biology',10);
/*!40000 ALTER TABLE `departmentstaff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollments`
--

DROP TABLE IF EXISTS `enrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollments` (
  `EnrollmentID` int NOT NULL AUTO_INCREMENT,
  `StudentID` int DEFAULT NULL,
  `CourseCode` varchar(10) DEFAULT NULL,
  `Semester` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`EnrollmentID`),
  KEY `StudentID` (`StudentID`),
  KEY `CourseCode` (`CourseCode`),
  CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `students` (`StudentID`),
  CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`CourseCode`) REFERENCES `courses` (`CourseCode`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollments`
--

LOCK TABLES `enrollments` WRITE;
/*!40000 ALTER TABLE `enrollments` DISABLE KEYS */;
INSERT INTO `enrollments` VALUES (1,1,'CS101','Fall 2024'),(2,2,'MATH201','Fall 2024'),(3,3,'PHYS301','Fall 2024'),(4,4,'CHEM401','Fall 2024'),(5,5,'BIO101','Fall 2024'),(6,6,'CS102','Fall 2024'),(7,7,'MATH202','Fall 2024'),(8,8,'PHYS102','Fall 2024'),(9,9,'CHEM102','Fall 2024'),(10,10,'BIO102','Fall 2024');
/*!40000 ALTER TABLE `enrollments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lecturers`
--

DROP TABLE IF EXISTS `lecturers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lecturers` (
  `LecturerID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  `Department` varchar(100) DEFAULT NULL,
  `AcademicQualifications` varchar(50) DEFAULT NULL,
  `AreasOfExpertise` varchar(100) DEFAULT NULL,
  `CourseLoad` int DEFAULT NULL,
  `ResearchInterests` varchar(100) DEFAULT NULL,
  `Publications` varchar(255) DEFAULT NULL,
  `ResearchGroupID` int DEFAULT NULL,
  PRIMARY KEY (`LecturerID`),
  UNIQUE KEY `Name` (`Name`),
  KEY `ResearchGroupID` (`ResearchGroupID`),
  CONSTRAINT `lecturers_ibfk_1` FOREIGN KEY (`ResearchGroupID`) REFERENCES `researchgroups` (`ResearchGroupID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lecturers`
--

LOCK TABLES `lecturers` WRITE;
/*!40000 ALTER TABLE `lecturers` DISABLE KEYS */;
INSERT INTO `lecturers` VALUES (1,'Emily White','Computer Science','PhD','Artificial Intelligence',3,'Machine Learning','AI for Good',1),(2,'John Brown','Mathematics','PhD','Algebra',2,'Number Theory','Algebraic Structures',2),(3,'Kathy Adams','Physics','PhD','Quantum Mechanics',3,'Particle Physics','Quantum Fields',3),(4,'Larry Hughes','Chemistry','PhD','Organic Chemistry',2,'Synthetic Methods','Chemical Reactions',4),(5,'Monica Bell','Biology','PhD','Genetics',3,'Evolutionary Biology','Genome Mapping',5),(6,'Nathan Drake','Computer Science','PhD','Cybersecurity',2,'Network Security','Encryption Methods',1),(7,'Olivia Grant','Mathematics','PhD','Statistics',3,'Probability Theory','Statistical Models',2),(8,'Peter Scott','Physics','PhD','Thermodynamics',2,'Heat Transfer','Energy Efficiency',3),(9,'Quinn Fabray','Chemistry','PhD','Inorganic Chemistry',3,'Coordination Chemistry','Metal Complexes',4),(10,'Rachel Green','Biology','PhD','Microbiology',2,'Infectious Diseases','Bacterial Pathogens',5);
/*!40000 ALTER TABLE `lecturers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nonacademicstaff`
--

DROP TABLE IF EXISTS `nonacademicstaff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nonacademicstaff` (
  `StaffID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  `JobTitle` varchar(100) DEFAULT NULL,
  `Department` varchar(100) DEFAULT NULL,
  `EmploymentType` varchar(20) DEFAULT NULL,
  `ContractDetails` varchar(50) DEFAULT NULL,
  `SalaryInfo` decimal(10,0) DEFAULT NULL,
  `EmergencyContactInfo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`StaffID`),
  UNIQUE KEY `Name` (`Name`),
  UNIQUE KEY `EmergencyContactInfo` (`EmergencyContactInfo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nonacademicstaff`
--

LOCK TABLES `nonacademicstaff` WRITE;
/*!40000 ALTER TABLE `nonacademicstaff` DISABLE KEYS */;
INSERT INTO `nonacademicstaff` VALUES (1,'Mark Spencer','Enrolment manager','Admin office','Full-time','2020-2025',50000,'555-9876'),(2,'Lucy Adams','Program manager','Admin Office','Part-time','2021-2023',30000,'555-6543');
/*!40000 ALTER TABLE `nonacademicstaff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programenrollmentdetails`
--

DROP TABLE IF EXISTS `programenrollmentdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programenrollmentdetails` (
  `ProgramName` varchar(100) DEFAULT NULL,
  `EnrollmentDetails` text,
  KEY `ProgramName` (`ProgramName`),
  CONSTRAINT `programenrollmentdetails_ibfk_1` FOREIGN KEY (`ProgramName`) REFERENCES `programs` (`ProgramName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programenrollmentdetails`
--

LOCK TABLES `programenrollmentdetails` WRITE;
/*!40000 ALTER TABLE `programenrollmentdetails` DISABLE KEYS */;
INSERT INTO `programenrollmentdetails` VALUES ('Computer Science','Open Enrollment'),('Mathematics','Open Enrollment'),('Physics','Open Enrollment'),('Chemistry','Open Enrollment'),('Biology','Open Enrollment');
/*!40000 ALTER TABLE `programenrollmentdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programs`
--

DROP TABLE IF EXISTS `programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programs` (
  `ProgramName` varchar(100) NOT NULL,
  `DegreeAwarded` varchar(50) DEFAULT NULL,
  `Duration` int DEFAULT NULL,
  `CourseRequirements` text,
  `ProgramManagerID` int DEFAULT NULL,
  PRIMARY KEY (`ProgramName`),
  UNIQUE KEY `ProgramName` (`ProgramName`),
  KEY `ProgramManagerID` (`ProgramManagerID`),
  CONSTRAINT `programs_ibfk_1` FOREIGN KEY (`ProgramManagerID`) REFERENCES `nonacademicstaff` (`StaffID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programs`
--

LOCK TABLES `programs` WRITE;
/*!40000 ALTER TABLE `programs` DISABLE KEYS */;
INSERT INTO `programs` VALUES ('Biology','BSc',4,'BIO101, BIO102, BIO201, BIO202',2),('Chemistry','BSc',4,'CHEM101, CHEM102, CHEM201, CHEM202',2),('Computer Science','BSc',4,'CS101, CS102, CS201, CS202',2),('Mathematics','BSc',4,'MATH201, MATH202, MATH301, MATH302',2),('Physics','BSc',4,'PHYS101, PHYS102, PHYS201, PHYS202',2);
/*!40000 ALTER TABLE `programs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `researchgroups`
--

DROP TABLE IF EXISTS `researchgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `researchgroups` (
  `ResearchGroupID` int NOT NULL AUTO_INCREMENT,
  `GroupName` varchar(100) DEFAULT NULL,
  `FocusArea` text,
  `LeadResearcherID` int DEFAULT NULL,
  PRIMARY KEY (`ResearchGroupID`),
  UNIQUE KEY `GroupName` (`GroupName`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `researchgroups`
--

LOCK TABLES `researchgroups` WRITE;
/*!40000 ALTER TABLE `researchgroups` DISABLE KEYS */;
INSERT INTO `researchgroups` VALUES (1,'AI Research Group','Artificial Intelligence',1),(2,'Algebra Research Group','Algebra',2),(3,'Quantum Physics Group','Quantum Mechanics',3),(4,'Organic Chemistry Group','Organic Chemistry',4),(5,'Genetics Research Group','Genetics',5);
/*!40000 ALTER TABLE `researchgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `researchprojects`
--

DROP TABLE IF EXISTS `researchprojects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `researchprojects` (
  `ProjectTitle` varchar(100) NOT NULL,
  `PrincipalInvestigator` varchar(100) DEFAULT NULL,
  `FundingSources` text,
  `TeamMembers` text,
  `Publications` text,
  `Outcomes` text,
  PRIMARY KEY (`ProjectTitle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `researchprojects`
--

LOCK TABLES `researchprojects` WRITE;
/*!40000 ALTER TABLE `researchprojects` DISABLE KEYS */;
INSERT INTO `researchprojects` VALUES ('AI for Healthcare','Emily White','National Science Foundation','Alice Smith, Bob Johnson','AI Medicine Journal','Developed new algorithm for patient data analysis'),('Algebraic Structures','John Brown','Mathematics Research Grant','Carol Davis, Dave Wilson','Algebra Today','Proved new theorem in algebraic geometry'),('Artificial Photosynthesis','Larry Hughes','National Science Foundation','Kathy Adams, Nathan Drake','Journal of Synthetic Biology','Synthesized a new light-absorbing material'),('Coordination Chemistry Innovations','Quinn Fabray','Chemical Research Society','Ivy Green, Jack Black','Inorganic Chemistry Review','Synthesized novel metal complexes with unique properties'),('Cybersecurity Advances','Nathan Drake','Technology Security Grant','Alice Smith, Bob Johnson','Cybersecurity Today','Developed a new encryption method for secure communications'),('Evolutionary Genetics','Monica Bell','Biology Research Council','Kathy Adams, Nathan Drake','Genetics and Evolution Journal','Mapped a new genetic pathway related to evolutionary adaptation'),('Ocean Conservation Strategies','Monica Bell','Environmental Protection Agency','Ivy Green, Jack Black','Marine Biology Today','Implemented a new coral reef protection program'),('Quantum Computing','Rachel Green','Technology Research Grant','Grace Hall, Henry Ford','Quantum Computing Today','Achieved a breakthrough in quantum bit stability'),('Statistical Methods for Big Data','Olivia Grant','Data Science Institute','Carol Davis, Dave Wilson','Big Data Analytics Journal','Created innovative statistical models for analyzing large datasets'),('Thermodynamic Efficiency','Peter Scott','Energy Research Association','Grace Hall, Henry Ford','Thermodynamics Monthly','Designed a new process for improving energy efficiency in industrial systems');
/*!40000 ALTER TABLE `researchprojects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `researchsupervision`
--

DROP TABLE IF EXISTS `researchsupervision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `researchsupervision` (
  `SupervisionID` int NOT NULL AUTO_INCREMENT,
  `LecturerID` int DEFAULT NULL,
  `ProjectTitle` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`SupervisionID`),
  KEY `LecturerID` (`LecturerID`),
  KEY `ProjectTitle` (`ProjectTitle`),
  CONSTRAINT `researchsupervision_ibfk_1` FOREIGN KEY (`LecturerID`) REFERENCES `lecturers` (`LecturerID`),
  CONSTRAINT `researchsupervision_ibfk_2` FOREIGN KEY (`ProjectTitle`) REFERENCES `researchprojects` (`ProjectTitle`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `researchsupervision`
--

LOCK TABLES `researchsupervision` WRITE;
/*!40000 ALTER TABLE `researchsupervision` DISABLE KEYS */;
INSERT INTO `researchsupervision` VALUES (1,1,'AI for Healthcare'),(2,2,'Algebraic Structures'),(3,3,'Quantum Computing'),(4,4,'Ocean Conservation Strategies'),(5,5,'Artificial Photosynthesis'),(6,6,'Cybersecurity Advances'),(7,7,'Statistical Methods for Big Data'),(8,8,'Thermodynamic Efficiency'),(9,9,'Coordination Chemistry Innovations'),(10,10,'Evolutionary Genetics');
/*!40000 ALTER TABLE `researchsupervision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `StudentID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  `DateOfBirth` date DEFAULT NULL,
  `ContactInfo` varchar(50) DEFAULT NULL,
  `ProgramEnrolled` varchar(100) DEFAULT NULL,
  `YearOfStudy` int DEFAULT NULL,
  `CurrentGrades` int DEFAULT NULL,
  `GraduationStatus` varchar(10) DEFAULT NULL,
  `DisciplinaryRecords` varchar(255) DEFAULT NULL,
  `FacultyAdvisorID` int DEFAULT NULL,
  PRIMARY KEY (`StudentID`),
  UNIQUE KEY `ContactInfo` (`ContactInfo`),
  KEY `FacultyAdvisorID` (`FacultyAdvisorID`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`FacultyAdvisorID`) REFERENCES `lecturers` (`LecturerID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'Alice Smith','1999-04-12','555-1234','Computer Science',3,85,'No','None',1),(2,'Bob Johnson','1998-08-23','555-5678','Mathematics',4,78,'Yes','None',2),(3,'Carol Taylor','2000-11-01','555-9012','Physics',2,65,'No','None',3),(4,'David Lee','1997-05-15','555-3456','Chemistry',1,55,'No','None',4),(5,'Eva Long','2001-03-22','555-7890','Biology',3,88,'No','None',5),(6,'Frank Wright','1999-07-30','555-6543','Computer Science',4,92,'Yes','None',1),(7,'Grace Hall','1998-02-19','555-3210','Mathematics',2,72,'No','None',2),(8,'Henry Ford','2000-12-05','555-2134','Physics',1,68,'No','None',3),(9,'Ivy Green','1997-08-17','555-4321','Chemistry',3,90,'No','None',4),(10,'Jack Black','2001-06-29','555-8765','Biology',4,75,'Yes','None',5);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachingassignments`
--

DROP TABLE IF EXISTS `teachingassignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teachingassignments` (
  `AssignmentID` int NOT NULL AUTO_INCREMENT,
  `LecturerID` int DEFAULT NULL,
  `CourseCode` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`AssignmentID`),
  KEY `LecturerID` (`LecturerID`),
  KEY `CourseCode` (`CourseCode`),
  CONSTRAINT `teachingassignments_ibfk_1` FOREIGN KEY (`LecturerID`) REFERENCES `lecturers` (`LecturerID`),
  CONSTRAINT `teachingassignments_ibfk_2` FOREIGN KEY (`CourseCode`) REFERENCES `courses` (`CourseCode`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachingassignments`
--

LOCK TABLES `teachingassignments` WRITE;
/*!40000 ALTER TABLE `teachingassignments` DISABLE KEYS */;
INSERT INTO `teachingassignments` VALUES (1,1,'CS101'),(2,2,'MATH201'),(3,3,'PHYS301'),(4,4,'CHEM401'),(5,5,'BIO101'),(6,6,'CS102'),(7,7,'MATH202'),(8,8,'PHYS102'),(9,9,'CHEM102'),(10,10,'BIO102');
/*!40000 ALTER TABLE `teachingassignments` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-29 21:07:44
