-- Insert sample lecturer
INSERT INTO Lecturers (StaffID, FirstName, LastName, Email, Phone, Department, Bio, Password)
VALUES ('LEC-2024-001', 'Ahmad', 'Lecturer', 'lecturer@sims.edu', '+60123456789', 'Computer Science', 'Senior Lecturer', 'password123');

-- Insert sample students
INSERT INTO Students (StudentCode, FirstName, LastName, Email, Phone, Program, IsActive, Password)
VALUES 
('S001', 'Ahmad',  'Ali',      'ahmad@student.edu',  '+60111111111', 'CS', 1, 'pass123'),
('S002', 'Siti',   'Hassan',   'siti@student.edu',   '+60122222222', 'IT', 1, 'pass123'),
('S003', 'Raj',    'Kumar',    'raj@student.edu',    '+60133333333', 'CS', 1, 'pass123'),
('S004', 'Lim',    'Wei Ming', 'lim@student.edu',    '+60144444444', 'CS', 1, 'pass123'),
('S005', 'Nurul',  'Ain',      'nurul@student.edu',  '+60155555555', 'IT', 1, 'pass123');

-- Insert sample courses
INSERT INTO Courses (CourseCode, CourseName, CreditHours, LecturerID, Schedule, Semester)
VALUES 
('WEB3013', 'Web Programming',      3, 1, 'Mon 8AM',  'Semester 1'),
('DBS2023', 'Database Systems',     3, 1, 'Tue 10AM', 'Semester 1'),
('SWE3033', 'Software Engineering', 3, 1, 'Wed 2PM',  'Semester 1');

-- Insert enrollments
INSERT INTO Enrollments (StudentID, CourseID) VALUES
(1,1),(1,2),(2,2),(2,3),(3,1),(3,3),(4,1),(5,2),(5,3);

-- Insert sample attendance
INSERT INTO Attendance (StudentID, CourseID, Date, Status) VALUES
(1, 1, CAST(GETDATE() AS DATE), 'P'),
(2, 1, CAST(GETDATE() AS DATE), 'A'),
(3, 1, CAST(GETDATE() AS DATE), 'P'),
(4, 1, CAST(GETDATE() AS DATE), 'L');

-- Insert sample marks
INSERT INTO Marks (StudentID, CourseID, Assessment, Marks, Grade, IsPublished) VALUES
(1, 1, 'Assignment 1', 85, 'A', 1),
(2, 2, 'Assignment 1', 72, 'B', 1),
(3, 1, 'Assignment 1', 91, 'A', 1),
(4, 1, 'Assignment 1', 55, 'C', 0),
(5, 2, 'Assignment 1', 78, 'B', 1);

-- Insert sample announcements
INSERT INTO Announcements (LecturerID, Title, Message, Target, Type) VALUES
(1, 'Midterm Exam Schedule', 'Midterm exam on 15 June 2026 at 9AM in Hall A.', 'ALL', 'exam'),
(1, 'Assignment 2 Due', 'Submit Assignment 2 before 11:59PM on 10 June.', 'WEB3013', 'assignment');

SELECT * FROM Students
SELECT * FROM Courses  
SELECT * FROM Enrollments
SELECT * FROM Attendance
SELECT * FROM Marks

USE SIMS_DB
SELECT * FROM Users;
