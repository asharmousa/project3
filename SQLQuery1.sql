--2/1/2026
create database Course_Registration_last;

use Course_Registration_last ;

create table Courses (
Course_ID int primary key identity,
Course_Name varchar(100),
Credits varchar(4),
Instructor_ID int ,
Department_ID int,
Department varchar(10),
foreign key (Instructor_ID) references Instructors(Instructor_ID),
foreign key (Department_ID) references Departments(Department_ID)
);

create table Students (
Student_ID int primary key identity,
First_Name varchar(20) ,
Last_Name varchar(20) ,
Email varchar(50),
phonr_Number varchar (10),
Enrollment_Date date 
);

create table Enrollments(
Enrollment_ID int primary key identity,
Student_ID int ,
Course_ID int ,
Enrollment_Date date , 
status VARCHAR(20), 
foreign key (Student_ID) references Students(Student_ID),
foreign key (Course_ID) references Courses(Course_ID)
);

create table Instructors(
Instructor_ID int primary key identity,
Name varchar(20),
Department varchar(10),
Email varchar(50),
Department_ID int ,
foreign key (Department_ID) references Departments(Department_ID)
);

create table Departments (
Department_ID int primary key identity ,
Department_Name varchar(20)
);


INSERT INTO Departments (Department_Name)
VALUES 
('Math'),
('Computer'),
('Physics'),
('English'),
('Business');

select * from Departments;

INSERT INTO Instructors ( Name,	Department	,Email)
values
('Ahmad Saleh', 'Math', 'ahmad.saleh@uni.edu'),
('Sara Hassan', 'Computer', 'sara.hassan@uni.edu'),
('Omar Khalid', 'Physics', 'omar.khalid@uni.edu'),
('Mona Ali', 'English ', 'mona.ali@uni.edu'),
('Yousef Nasser', 'Business ', 'yousef.nasser@uni.edu');


select * from Instructors;

INSERT INTO Students (First_Name ,	Last_Name	,Email,	phonr_Number ,	Enrollment_Date)
VALUES
('Ali', 'Khalid', 'ali.khalid@uni.edu', '077111111', '2026-01-02'),
('Sara', 'Omar', 'sara.omar@uni.edu', '078222222', '2026-01-02'),
('Yousef', 'Ahmad', 'yousef.ahmad@uni.edu', '079333333', '2026-01-02'),
('Mona', 'Hassan', 'mona.hassan@uni.edu', '077444444', '2026-01-02'),
('Khalid', 'Saleh', 'khalid.saleh@uni.edu', '078555555', '2026-01-02');

select * from Students ;

INSERT INTO Courses (Course_Name, Credits, Instructor_ID, Department)
VALUES
('Calculus I', 4, 1, 'Math'),
('Database Systems', 3, 2, 'Computer'),
('Physics I', 4, 3, 'Physics'),
('English Composition', 3, 4, 'English'),
('Principles of Management', 3, 5, 'Business');

select * from Courses;

SELECT Course_ID, Course_Name FROM Courses ; --to check the courese id 

INSERT INTO Enrollments (Student_ID, Course_ID, Enrollment_Date, Status)
VALUES
(1, 16, '2026-01-03', 'Enrolled'),
(2, 17, '2026-01-03', 'Completed'),
(3, 20, '2026-01-03', 'Enrolled'),
(4, 18, '2026-01-03', 'Withdrawn'),
(5, 19, '2026-01-03', 'Enrolled');

select * from Enrollments ;

--create table Course_Requirements (
--foreign key (Courses_id ) references Courses(ID),
--foreign key (Departments_id ) references Departments(ID));
--INSERT INTO Course_Requirements (Course_ID, Prerequisite_Course_ID)
--VALUES
--(2, 1), -- Database Systems requires Calculus I
--(3, 1), -- Physics I requires Calculus I
--(4, 2), -- English Composition requires Database Systems (example)
--(5, 2), -- Principles of Management requires Database Systems
--(5, 4); -- Principles of Management also requires English Composition

--SQL Queries

--Select students enrolled in a specific course.

select s.Student_id , s.First_Name , s.Last_Name 
from Enrollments e
join Students s
	on e.Student_ID = s.Student_ID
join Courses c
	on e.Course_ID = c.Course_ID
where c.course_name = 'Calculus I';

--Add a new student.

insert into Students (First_Name ,	Last_Name	,Email,	phonr_Number ,	Enrollment_Date)
values ('Layla' , 'Hussein', 'layla.hussein@uni.edu', '077666666', '2026-01-05');

select * from Students ;

--Update the enrollment status of a student.

update Enrollments 
set status = 'Withdrawn' 
where Student_ID = 1 and Course_ID=16;

select * from Enrollments;

--Find courses taught by a specific instructor.

select c.Course_ID, c.Course_Name as instructor 
from Courses c
join Instructors i on c.Instructor_ID = i.Instructor_ID
where i.Name ='Omar Khalid' ;

SELECT * FROM Courses;
SELECT * FROM Instructors;

--List all students who have completed a specific course.

select s.Student_ID , s.First_Name , s.Last_Name
from Enrollments e
join Students s
	on e.Student_ID = s.Student_ID
join Courses c
	on e.Course_ID = c.Course_ID
where c.course_name = 'Database Systems' AND e.Status = 'Completed';

--Query for all courses in a particular department.

select c.Course_ID, c.Course_Name
from Courses c 
where c.Department= 'math';

--Handle late registration by adding records for courses after the enrollment deadline.
insert into Enrollments (Student_ID, Course_ID, Enrollment_Date, Status)
values (1, 20, '2026-02-01', 'Late Registered'); 

select * from Enrollments;
