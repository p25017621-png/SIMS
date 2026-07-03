USE SIMS_DB;
GO

-- DROP ALL OLD TABLES FIRST
IF OBJECT_ID('dbo.Announcements','U')              IS NOT NULL DROP TABLE dbo.Announcements;
IF OBJECT_ID('dbo.Marks','U')                      IS NOT NULL DROP TABLE dbo.Marks;
IF OBJECT_ID('dbo.Attendance','U')                 IS NOT NULL DROP TABLE dbo.Attendance;
IF OBJECT_ID('dbo.Enrolments','U')                 IS NOT NULL DROP TABLE dbo.Enrolments;
IF OBJECT_ID('dbo.Enrollments','U')                IS NOT NULL DROP TABLE dbo.Enrollments;
IF OBJECT_ID('dbo.LecturerCourseAssignments','U')  IS NOT NULL DROP TABLE dbo.LecturerCourseAssignments;
IF OBJECT_ID('dbo.Courses','U')                    IS NOT NULL DROP TABLE dbo.Courses;
IF OBJECT_ID('dbo.Programmes','U')                 IS NOT NULL DROP TABLE dbo.Programmes;
IF OBJECT_ID('dbo.Lecturers','U')                  IS NOT NULL DROP TABLE dbo.Lecturers;
IF OBJECT_ID('dbo.Students','U')                   IS NOT NULL DROP TABLE dbo.Students;
IF OBJECT_ID('dbo.Users','U')                      IS NOT NULL DROP TABLE dbo.Users;
IF OBJECT_ID('dbo.LecturerProfile','U')            IS NOT NULL DROP TABLE dbo.LecturerProfile;
IF OBJECT_ID('dbo.StudentMarks','U')               IS NOT NULL DROP TABLE dbo.StudentMarks;
GO

-- CREATE USERS TABLE
CREATE TABLE Users (
    userID   INT PRIMARY KEY IDENTITY(1,1),
    name     VARCHAR(100) NOT NULL,
    email    VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    role     VARCHAR(20)  NOT NULL
);
GO

-- CREATE STUDENTS TABLE
CREATE TABLE Students (
    studentID   INT PRIMARY KEY IDENTITY(1,1),
    userID      INT UNIQUE,
    phone       VARCHAR(20),
    gender      VARCHAR(10),
    dateOfBirth DATE,
    address     VARCHAR(255),
    FOREIGN KEY (userID) REFERENCES Users(userID)
);
GO

-- CREATE LECTURERS TABLE
CREATE TABLE Lecturers (
    lecturerID    INT PRIMARY KEY IDENTITY(1,1),
    userID        INT UNIQUE,
    department    VARCHAR(100),
    qualification VARCHAR(100),
    phone         VARCHAR(20),
    FOREIGN KEY (userID) REFERENCES Users(userID)
);
GO

-- CREATE PROGRAMMES TABLE
CREATE TABLE Programmes (
    programmeID   INT PRIMARY KEY IDENTITY(1,1),
    programmeName VARCHAR(100) NOT NULL,
    programmeCode VARCHAR(20)  NOT NULL UNIQUE
);
GO

-- CREATE COURSES TABLE
CREATE TABLE Courses (
    courseID    INT PRIMARY KEY IDENTITY(1,1),
    courseName  VARCHAR(100) NOT NULL,
    courseCode  VARCHAR(20)  NOT NULL UNIQUE,
    credits     INT,
    programmeID INT,
    FOREIGN KEY (programmeID) REFERENCES Programmes(programmeID)
);
GO

-- CREATE LECTURER COURSE ASSIGNMENTS TABLE
CREATE TABLE LecturerCourseAssignments (
    assignmentID INT PRIMARY KEY IDENTITY(1,1),
    lecturerID   INT,
    courseID     INT,
    semester     INT,
    FOREIGN KEY (lecturerID) REFERENCES Lecturers(lecturerID),
    FOREIGN KEY (courseID)   REFERENCES Courses(courseID)
);
GO

-- CREATE ENROLMENTS TABLE
CREATE TABLE Enrolments (
    enrolmentID INT PRIMARY KEY IDENTITY(1,1),
    studentID   INT,
    courseID    INT,
    programmeID INT,
    semester    INT,
    enrolDate   DATE DEFAULT GETDATE(),
    FOREIGN KEY (studentID)   REFERENCES Students(studentID),
    FOREIGN KEY (courseID)    REFERENCES Courses(courseID),
    FOREIGN KEY (programmeID) REFERENCES Programmes(programmeID)
);
GO

-- CREATE ATTENDANCE TABLE
CREATE TABLE Attendance (
    attendanceID   INT PRIMARY KEY IDENTITY(1,1),
    studentID      INT,
    courseID       INT,
    attendanceDate DATE,
    status         VARCHAR(20),
    FOREIGN KEY (studentID) REFERENCES Students(studentID),
    FOREIGN KEY (courseID)  REFERENCES Courses(courseID)
);
GO

-- CREATE MARKS TABLE
CREATE TABLE Marks (
    markID    INT PRIMARY KEY IDENTITY(1,1),
    studentID INT,
    courseID  INT,
    score     DECIMAL(5,2),
    remarks   VARCHAR(255),
    FOREIGN KEY (studentID) REFERENCES Students(studentID),
    FOREIGN KEY (courseID)  REFERENCES Courses(courseID)
);
GO

-- CREATE ANNOUNCEMENTS TABLE
CREATE TABLE Announcements (
    announcementID INT PRIMARY KEY IDENTITY(1,1),
    lecturerID     INT,
    title          VARCHAR(200),
    message        VARCHAR(MAX),
    datePosted     DATE DEFAULT GETDATE(),
    FOREIGN KEY (lecturerID) REFERENCES Lecturers(lecturerID)
);
GO

-- INSERT SAMPLE DATA

-- Users
INSERT INTO Users (name, email, password, role) VALUES
('Ahmad Lecturer',    'lecturer@sims.edu',          'password123', 'Lecturer'),
('Ahmad Bin Ali',     'ahmad@student.sims.edu',      'pass123',     'Student'),
('Siti Binti Hassan', 'siti@student.sims.edu',       'pass123',     'Student'),
('Raj Kumar',         'raj@student.sims.edu',        'pass123',     'Student'),
('Lim Wei Ming',      'lim@student.sims.edu',        'pass123',     'Student'),
('Nurul Ain',         'nurul@student.sims.edu',      'pass123',     'Student');

-- Lecturer
INSERT INTO Lecturers (userID, department, qualification, phone)
VALUES (1, 'Computer Science', 'PhD in Computer Science', '+60123456789');

-- Students
INSERT INTO Students (userID, phone, gender, dateOfBirth, address) VALUES
(2, '+60111111111', 'Male',   '2002-01-15', 'Kuala Lumpur'),
(3, '+60122222222', 'Female', '2002-03-20', 'Penang'),
(4, '+60133333333', 'Male',   '2001-07-10', 'Ipoh'),
(5, '+60144444444', 'Male',   '2002-05-25', 'Johor Bahru'),
(6, '+60155555555', 'Female', '2001-11-08', 'Penang');

-- Programmes
INSERT INTO Programmes (programmeName, programmeCode) VALUES
('Bachelor of Computer Science',   'BCS'),
('Bachelor of Information Technology', 'BIT'),
('Diploma in Information Technology',  'DIT');

-- Courses
INSERT INTO Courses (courseName, courseCode, credits, programmeID) VALUES
('Web Programming',      'WEB3013', 3, 1),
('Database Systems',     'DBS2023', 3, 1),
('Software Engineering', 'SWE3033', 3, 2);

-- Lecturer Course Assignments
INSERT INTO LecturerCourseAssignments (lecturerID, courseID, semester) VALUES
(1, 1, 1),
(1, 2, 1),
(1, 3, 1);

-- Enrolments
INSERT INTO Enrolments (studentID, courseID, programmeID, semester, enrolDate) VALUES
(1, 1, 1, 1, '2026-01-01'),
(1, 2, 1, 1, '2026-01-01'),
(2, 2, 1, 1, '2026-01-01'),
(2, 3, 2, 1, '2026-01-01'),
(3, 1, 1, 1, '2026-01-01'),
(3, 3, 2, 1, '2026-01-01'),
(4, 1, 1, 1, '2026-01-01'),
(5, 2, 1, 1, '2026-01-01'),
(5, 3, 2, 1, '2026-01-01');

-- Attendance
INSERT INTO Attendance (studentID, courseID, attendanceDate, status) VALUES
(1, 1, CAST(GETDATE() AS DATE), 'Present'),
(2, 1, CAST(GETDATE() AS DATE), 'Absent'),
(3, 1, CAST(GETDATE() AS DATE), 'Present'),
(4, 1, CAST(GETDATE() AS DATE), 'Late'),
(1, 2, CAST(GETDATE() AS DATE), 'Present'),
(2, 2, CAST(GETDATE() AS DATE), 'Present'),
(5, 2, CAST(GETDATE() AS DATE), 'Late');

-- Marks
INSERT INTO Marks (studentID, courseID, score, remarks) VALUES
(1, 1, 85.00, 'Excellent'),
(1, 2, 78.00, 'Good'),
(2, 2, 72.00, 'Average'),
(3, 1, 91.00, 'Outstanding'),
(4, 1, 55.00, 'Needs improvement'),
(5, 2, 78.00, 'Good'),
(5, 3, 65.00, 'Average');

-- Announcements
INSERT INTO Announcements (lecturerID, title, message, datePosted) VALUES
(1, 'Midterm Exam Schedule', 'Midterm exam on 15 June 2026 at 9AM in Hall A.', CAST(GETDATE() AS DATE)),
(1, 'Assignment 2 Due',      'Submit Assignment 2 before 11:59PM on 10 June.', CAST(GETDATE() AS DATE));

GO

-- VERIFY
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE' ORDER BY TABLE_NAME;

SELECT 'Users'                    AS TableName, COUNT(*) AS Records FROM Users                    UNION ALL
SELECT 'Lecturers',                              COUNT(*)            FROM Lecturers                UNION ALL
SELECT 'Students',                               COUNT(*)            FROM Students                 UNION ALL
SELECT 'Programmes',                             COUNT(*)            FROM Programmes               UNION ALL
SELECT 'Courses',                                COUNT(*)            FROM Courses                  UNION ALL
SELECT 'LecturerCourseAssignments',              COUNT(*)            FROM LecturerCourseAssignments UNION ALL
SELECT 'Enrolments',                             COUNT(*)            FROM Enrolments               UNION ALL
SELECT 'Attendance',                             COUNT(*)            FROM Attendance               UNION ALL
SELECT 'Marks',                                  COUNT(*)            FROM Marks                    UNION ALL
SELECT 'Announcements',                          COUNT(*)            FROM Announcements;
GO