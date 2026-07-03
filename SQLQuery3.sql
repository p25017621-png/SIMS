USE SIMS_DB;

-- Run the full setup again
DROP TABLE IF EXISTS Announcements;
DROP TABLE IF EXISTS Marks;
DROP TABLE IF EXISTS Attendance;
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Lecturers;

-- Create all tables fresh
CREATE TABLE Lecturers (
    LecturerID INT IDENTITY(1,1) PRIMARY KEY,
    StaffID NVARCHAR(20) NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20),
    Department NVARCHAR(100),
    Bio NVARCHAR(500),
    Password NVARCHAR(255) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Students (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentCode NVARCHAR(20) NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20),
    Program NVARCHAR(50),
    IsActive BIT DEFAULT 1,
    Password NVARCHAR(255) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Courses (
    CourseID INT IDENTITY(1,1) PRIMARY KEY,
    CourseCode NVARCHAR(20) NOT NULL,
    CourseName NVARCHAR(100) NOT NULL,
    CreditHours INT DEFAULT 3,
    LecturerID INT NOT NULL,
    Schedule NVARCHAR(50),
    Semester NVARCHAR(20),
    FOREIGN KEY (LecturerID) REFERENCES Lecturers(LecturerID)
);

CREATE TABLE Enrollments (
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrolledDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(20) DEFAULT 'Active',
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

CREATE TABLE Attendance (
    AttendanceID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    Date DATE NOT NULL,
    Status NCHAR(1) NOT NULL,
    MarkedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

CREATE TABLE Marks (
    MarkID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    Assessment NVARCHAR(50) NOT NULL,
    Marks DECIMAL(5,2) NOT NULL,
    Grade NVARCHAR(2),
    IsPublished BIT DEFAULT 0,
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

CREATE TABLE Announcements (
    AnnouncementID INT IDENTITY(1,1) PRIMARY KEY,
    LecturerID INT NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    Message NVARCHAR(MAX) NOT NULL,
    Target NVARCHAR(20) NOT NULL,
    Type NVARCHAR(30) DEFAULT 'general',
    PostedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (LecturerID) REFERENCES Lecturers(LecturerID)
);

-- Insert sample data
INSERT INTO Lecturers (StaffID,FirstName,LastName,Email,Phone,Department,Bio,Password)
VALUES ('LEC-2024-001','Ahmad','Lecturer','lecturer@sims.edu','+60123456789','Computer Science','Senior Lecturer','password123');

INSERT INTO Students (StudentCode,FirstName,LastName,Email,Phone,Program,IsActive,Password)
VALUES
('S001','Ahmad','Ali','ahmad@student.edu','+60111111111','CS',1,'pass123'),
('S002','Siti','Hassan','siti@student.edu','+60122222222','IT',1,'pass123'),
('S003','Raj','Kumar','raj@student.edu','+60133333333','CS',1,'pass123'),
('S004','Lim','Wei Ming','lim@student.edu','+60144444444','CS',1,'pass123'),
('S005','Nurul','Ain','nurul@student.edu','+60155555555','IT',1,'pass123');

INSERT INTO Courses (CourseCode,CourseName,CreditHours,LecturerID,Schedule,Semester)
VALUES
('WEB3013','Web Programming',3,1,'Mon 8AM','Semester 1'),
('DBS2023','Database Systems',3,1,'Tue 10AM','Semester 1'),
('SWE3033','Software Engineering',3,1,'Wed 2PM','Semester 1');

INSERT INTO Enrollments (StudentID,CourseID)
VALUES (1,1),(1,2),(2,2),(2,3),(3,1),(3,3),(4,1),(5,2),(5,3);

INSERT INTO Attendance (StudentID,CourseID,Date,Status)
VALUES
(1,1,CAST(GETDATE() AS DATE),'P'),
(2,1,CAST(GETDATE() AS DATE),'A'),
(3,1,CAST(GETDATE() AS DATE),'P'),
(4,1,CAST(GETDATE() AS DATE),'L');

INSERT INTO Marks (StudentID,CourseID,Assessment,Marks,Grade,IsPublished)
VALUES
(1,1,'Assignment 1',85,'A',1),
(2,2,'Assignment 1',72,'B',1),
(3,1,'Assignment 1',91,'A',1),
(4,1,'Assignment 1',55,'C',0),
(5,2,'Assignment 1',78,'B',1);

INSERT INTO Announcements (LecturerID,Title,Message,Target,Type)
VALUES
(1,'Midterm Exam Schedule','Midterm exam on 15 June 2026 at 9AM in Hall A.','ALL','exam'),
(1,'Assignment 2 Due','Submit Assignment 2 before 11:59PM on 10 June.','WEB3013','assignment');

-- Verify
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE='BASE TABLE' ORDER BY TABLE_NAME;


