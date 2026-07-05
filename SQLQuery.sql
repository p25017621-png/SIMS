USE SIMS_DB;
SELECT * FROM Users;

USE SIMS_DB;

-- Check Users table
SELECT * FROM Users;

-- Check Lecturers table
SELECT * FROM Lecturers;

-- Check if lecturerID 1 exists
SELECT l.lecturerID, u.name, u.email, u.password, u.role
FROM Lecturers l
JOIN Users u ON l.userID = u.userID;

USE SIMS_DB;
SELECT * FROM Users;
SELECT * FROM Students;
SELECT * FROM Lecturer;