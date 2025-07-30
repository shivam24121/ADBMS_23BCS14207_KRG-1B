-- EASY

CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100),
    Country VARCHAR(100)
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

INSERT INTO Authors (AuthorID, AuthorName, Country) VALUES (1, 'PRANAV MEHRA', 'INDIA');
INSERT INTO Authors (AuthorID, AuthorName, Country) VALUES (2, 'ANAYA RATHORE', 'INDIA');
INSERT INTO Authors (AuthorID, AuthorName, Country) VALUES (3, 'VIVAN SHAH', 'INDIA');

INSERT INTO Books (BookID, Title, AuthorID) VALUES (101, 'THE FINAL VERDICT', 1);
INSERT INTO Books (BookID, Title, AuthorID) VALUES (102, 'ECHOES OF TOMORROW', 2);
INSERT INTO Books (BookID, Title, AuthorID) VALUES (103, 'THE SILENT RAIN', 3);

SELECT 
    B.Title AS Book_Title,
    A.AuthorName,
    A.Country
FROM 
    Books B
INNER JOIN 
    Authors A ON B.AuthorID = A.AuthorID;

-- MEDIUM

CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100) NOT NULL
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

INSERT INTO Departments (DeptID, DeptName) VALUES (1, 'COMPUTER APPLICATIONS');
INSERT INTO Departments (DeptID, DeptName) VALUES (2, 'MECHANICAL SYSTEMS');
INSERT INTO Departments (DeptID, DeptName) VALUES (3, 'ELECTRONICS DESIGN');
INSERT INTO Departments (DeptID, DeptName) VALUES (4, 'MATHEMATICAL MODELLING');
INSERT INTO Departments (DeptID, DeptName) VALUES (5, 'PHYSICAL SCIENCES');

INSERT INTO Courses (CourseID, CourseName, DeptID) VALUES (101, 'OBJECT ORIENTED PROGRAMMING', 1);
INSERT INTO Courses (CourseID, CourseName, DeptID) VALUES (102, 'DATABASE CONCEPTS', 1);
INSERT INTO Courses (CourseID, CourseName, DeptID) VALUES (103, 'WEB DEVELOPMENT', 1);
INSERT INTO Courses (CourseID, CourseName, DeptID) VALUES (104, 'KINEMATICS', 2);
INSERT INTO Courses (CourseID, CourseName, DeptID) VALUES (105, 'APPLIED MECHANICS', 2);
INSERT INTO Courses (CourseID, CourseName, DeptID) VALUES (106, 'DIGITAL CIRCUITS', 3);
INSERT INTO Courses (CourseID, CourseName, DeptID) VALUES (107, 'EMBEDDED SYSTEMS', 3);
INSERT INTO Courses (CourseID, CourseName, DeptID) VALUES (108, 'DISCRETE MATHEMATICS', 4);
INSERT INTO Courses (CourseID, CourseName, DeptID) VALUES (109, 'WAVE PHYSICS', 5);
INSERT INTO Courses (CourseID, CourseName, DeptID) VALUES (110, 'THERMODYNAMICS', 5);
INSERT INTO Courses (CourseID, CourseName, DeptID) VALUES (111, 'DATA VISUALIZATION', 1);

SELECT DeptName
FROM Departments
WHERE DeptID IN (
    SELECT DeptID
    FROM Courses
    GROUP BY DeptID
    HAVING COUNT(*) > 2
);

GRANT SELECT ON Courses TO test_user;

-- HARD

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100)
);

CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseTitle VARCHAR(100)
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Grade VARCHAR(2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

INSERT INTO Students (StudentID, StudentName) VALUES (1, 'ARJUN SINGH');
INSERT INTO Students (StudentID, StudentName) VALUES (2, 'MEERA KAPOOR');

INSERT INTO Course (CourseID, CourseTitle) VALUES (101, 'CLOUD COMPUTING');
INSERT INTO Course (CourseID, CourseTitle) VALUES (102, 'CYBER SECURITY');

SET TRANSACTION;

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Grade) VALUES (1001, 1, 101, 'A');

SAVEPOINT valid_enrollment;

INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Grade) VALUES (1002, 99, 102, 'B');

ROLLBACK TO valid_enrollment;

COMMIT;

SELECT 
    S.StudentName,
    C.CourseTitle,
    E.Grade
FROM 
    Enrollments E
JOIN 
    Students S ON E.StudentID = S.StudentID
JOIN 
    Course C ON E.CourseID = C.CourseID;
