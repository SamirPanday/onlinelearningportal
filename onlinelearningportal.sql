-- create database
create database onlinelearningportal;


--use database
use onlinelearningportal;


--create tables
create table students(
    student_id int primary key auto_increment,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    date_of_birth date,
    enrollment_date date
);

create table instructors(
    instructor_id int primary key auto_increment,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    hire_date date,
    department varchar(50),
) auto_increment = 1001;

create table courses(
    course_id int primary key auto_increment,
    course_name varchar(50),
    course_description text,
    start_date date,
    end_date date,
    course_fee decimal,
    instructor_id int,
    foreign key(instructor_id) references instructors(instructor_id)
) auto_increment = 101;

create table courses(
    enrollment_id int primary key auto_increment,
    student_id int,
    course_id int,
    enrollment_date date,
    status enum('active','completed','dropped'),
    foreign key(student_id) references instructors(student_id),
    foreign key(course_id) references instructors(course_id)
) auto_increment = 2001;

create table assignments(
    assignment_id int primary key auto_increment,
    course_id int,
    assignment_title varchar(100),
    due_date date,
    max_marks int,
    foreign key(course_id) references instructors(course_id)
);

create table submissions(
    submission_id int primary key auto_increment,
    assignment_id int,
    student_id int,
    submission_date date,
    marks_obtained decimal,
    foreign key(assignment_id) references instructors(assignment_id),
    foreign key(student_id) references instructors(student_id)
);


--describe tables
desc students;
desc instructors;
desc courses;
desc enrollments;
desc assignments;
desc submissions;


-- insert data
insert into students (first_name, last_name, email, date_of_birth, enrollment_date)
values
    ('ram', 'thapa', 'ram.thapa@gmail.com', '2000-01-15', '2023-06-15'),
    ('john', 'cena', 'john.cena@gmail.com', '1998-04-23', '2023-06-15'),
    ('hari', 'lal', 'hari.lal@gmail.com', '1999-11-12', '2023-07-10'),
    ('sita', 'kumari', 'sita.kumari@gmail.com', '2001-02-25', '2023-07-10'),
    ('lisanna', 'rana', 'lisanna.rana@gmail.com', '2000-05-30', '2023-08-01'),
    ('ivanka', 'rana', 'ivanka.rana@gmail.com', '1999-08-08', '2023-08-01'),
    ('om', 'bahadur', 'om.bahadur@gmail.com', '1997-06-18', '2023-08-15'),
    ('jane', 'doe', 'jane.doe@gmail.com', '2002-03-05', '2023-08-15'),
    ('emily', 'wang', 'emily.wang@gmail.com', '2001-12-22', '2023-09-01');

insert into instructors (first_name, last_name, email, hire_date, department)
values
    ('alexander', 'smith', 'alex.smith@gmail.com', '2022-01-15', 'computer science'),
    ('jane', 'johnson', 'jane.johnson@gmail.com', '2021-03-10', 'web development'),
    ('michael', 'brown', 'michael.brown@gmail.com', '2020-05-20', 'data structures'),
    ('rachel', 'davis', 'rachel.davis@gmail.com', '2021-07-25', 'machine learning'),
    ('emily', 'wilson', 'emily.wilson@gmail.com', '2020-09-10', 'cybersecurity'),
    ('kevin', 'taylor', 'kevin.taylor@gmail.com', '2019-11-05', 'full-stack development');

insert into courses (course_name, course_description, start_date, end_date, course_fee, instructor_id) 
values 
    ('Computer Science Basics', 'Introduction to computer science and problem-solving.', '2023-01-10', '2023-06-10', 500.00, 1001),
    ('Web Development', 'Learn how to create websites using HTML, CSS, and JavaScript.', '2023-02-15', '2023-08-15', 600.00, 1002),
    ('Data Structures', 'Understanding and implementing core data structures.', '2023-03-01', '2023-09-01', 700.00, 1003),
    ('Machine Learning', 'Basics of ML algorithms and their applications.', '2023-04-20', '2023-10-20', 800.00, 1004),
    ('Cybersecurity', 'Introduction to security principles and cryptography.', '2023-05-05', '2023-11-05', 750.00, 1005);

insert into enrollments (student_id, course_id, enrollment_date, status)
values
    (1, 101, '2023-01-15', 'active'),
    (2, 102, '2023-02-20', 'active'),
    (3, 103, '2023-03-25', 'completed'),
    (4, 104, '2023-04-30', 'active'),
    (5, 105, '2023-05-15', 'dropped');

insert into assignments (course_id, assignment_title, due_date, max_marks)
values
    (101, 'Introduction to Algorithms', '2023-02-15', 100),
    (102, 'Build a Static Website', '2023-03-20', 50),
    (103, 'Implement Linked Lists', '2023-04-10', 75),
    (104, 'Linear Regression Project', '2023-05-30', 100),
    (105, 'Network Security Report', '2023-06-25', 80);


-- select query
select * from students;
select * from instructors;
select * from assignments;
select * from courses;
select * from enrollments;
select * from submissions;


-- projection operation
select first_name, date_of_birth from students;


-- list of all the students and their enrolled courses
select 
    students.student_id,
    concat(students.first_name, ' ', students.last_name) as student_name,
    courses.course_name,
    enrollments.status
from 
    students
join
    enrollments on students.student_id = enrollments.student_id
join
    courses on enrollments.course_id = courses.course_id;


-- list of the instructors and their courses;
select 
    instructors.instructor_id,
    concat(instructors.first_name, ' ', instructors.last_name) as instructor_name,
    courses.course_name,
    courses.start_date,
    courses.end_date
from 
    instructors
join
    courses on instructors.instructor_id = courses.instructor_id;


-- list of all the courses with their instructors and enrolled students
select 
    courses.course_name,
    concat(instructors.first_name, ' ', instructors.last_name) as instructor_name,
    concat(students.first_name, ' ', students.last_name) as student_name,
    enrollments.status
from 
    courses
join
    instructors on courses.instructor_id = instructors.instructor_id
join
    enrollments on courses.course_id = enrollments.course_id
join
    students on enrollments.student_id = students.student_id;


-- inner join
select concat(students.first_name, ' ', students.last_name) as student_name, courses.course_name
from students
join enrollments on students.student_id = enrollments.student_id
join courses on courses.course_id = enrollments.course_id;


-- left join
select concat(students.first_name, ' ', students.last_name) as student_name, courses.course_name
from students
left join enrollments on students.student_id = enrollments.student_id
left join courses on courses.course_id = enrollments.course_id;


-- right join
select concat(students.first_name, ' ', students.last_name) as student_name, courses.course_name
from students
right join enrollments on students.student_id = enrollments.student_id
right join courses on courses.course_id = enrollments.course_id;


-- full outer join
select concat(students.first_name, ' ', students.last_name) as student_name, courses.course_name
from students
right join enrollments on students.student_id = enrollments.student_id
right join courses on courses.course_id = enrollments.course_id
union
select concat(students.first_name, ' ', students.last_name) as student_name, courses.course_name
from students
left join enrollments on students.student_id = enrollments.student_id
left join courses on courses.course_id = enrollments.course_id;


-- cross product
select * from courses, instructors;


-- selection operation
select * from students
where first_name like 'i%';


-- demonstrate normalization

-- unnormalized table
create table unnormalized_table(
    student_id int,
    student_name varchar(100),
    instructor_name varchar(255),
    course_info varchar(255)
);

alter table unnormalized_table
rename column instructor_name to instructor_info;

desc unnormalized_table;

insert into unnormalized_table (student_id, student_name, instructor_info, course_info)
values
    (1, 'Ivanka Rana', '101:john, 102:mary', '201:math, 202:cs'),
    (2, 'Lisanna Dahal', '103:peter', '203:physics');

select * from unnormalized_table;

-- 1NF
create table first_normal_form (
    student_id int,
    first_name varchar(100),
    last_name varchar(100),
    instructor_id int,
    instructor_name varchar(100),
    course_id int,
    course_name varchar(100)
);

insert into first_normal_form (student_id, first_name, last_name, instructor_id, instructor_name, course_id, course_name)
values
    (1, 'Ivanka', 'Rana', 101, 'john', 201, 'math'),
    (1, 'Ivanka', 'Rana', 102, 'mary', 202, 'cs'),
    (2, 'Lisanna', 'Dahal', 103, 'peter', 203, 'physics');

select * from first_normal_form;

-- 2NF
create table student(
    student_id int primary key,
    first_name varchar(100),
    last_name varchar(100)
);

insert into student (student_id, first_name, last_name)
values 
    (1, 'Ivanka', 'Rana'),
    (2, 'Lisanna', 'Dahal');

create table instructor(
    instructor_id int primary key,
    instructor_name varchar(100)
);

insert into instructor(instructor_id, instructor_name)
values
    (101, 'john'),
    (102, 'mary'),
    (103, 'peter');

create table course(
    course_id int primary key,
    course_name varchar(100)
);

insert into course(course_id, course_name)
values
    (201, 'math'),
    (202, 'cs'),
    (203, 'physics');

create table enroll(
    student_id int,
    instructor_id int,
    course_id int,
    primary key (student_id, instructor_id, course_id)
);

insert into enroll(student_id, instructor_id, course_id)
values
    (1, 101, 201),
    (1, 102, 202),
    (2, 103, 203);

select * from student;
select * from instructor;
select * from course;
select * from enroll;

-- BCNF
create table student_instructor (
    student_id int,
    instructor_id int,
    primary key (student_id, instructor_id)
);

insert into student_instructor (student_id, instructor_id)
values
    (1, 101),
    (1, 102),
    (2, 103);

select * from student_instructor;
select * from student;
select * from instructor;
select * from course;
select * from enroll;

create table instructor_course (
    instructor_id int primary key,
    course_id int
);

insert into instructor_course (instructor_id, course_id)
values
    (101, 201),
    (102, 202),
    (103, 203);

select * from instructor_course;

-- demonstration of 3NF with a new table which is in 2NF

create database test;

use test;

-- create second normal form table (denormalized)
create table second_normal_form(
    student_id int,
    first_name varchar(100),
    last_name varchar(100),
    instructor_id int,
    instructor_name varchar(100),
    course_id int,
    course_name varchar(100)
);

-- insert data into second normal form table
insert into second_normal_form(student_id, first_name, last_name, instructor_id, instructor_name, course_id, course_name)
values
    (1, 'Ivanka', 'Rana', 101, 'john', 201, 'math'),
    (1, 'Ivanka', 'Rana', 102, 'mary', 202, 'cs'),
    (2, 'Lisanna', 'Dahal', 103, 'peter', 203, 'physics');

create table instructors (
    instructor_id int primary key,
    instructor_name varchar(255) not null
);

create table courses (
    course_id int primary key,
    course_name varchar(255) not null
);

create table students (
    student_id int primary key,
    first_name varchar(255) not null,
    last_name varchar(255) not null
);

create table enrollment (
    student_id int,
    course_id int,
    instructor_id int,
    primary key (student_id, course_id),
    foreign key (student_id) references students(student_id),
    foreign key (course_id) references courses(course_id),
    foreign key (instructor_id) references instructors(instructor_id)
);

insert into students (student_id, first_name, last_name)
values
    (1, 'ivanka', 'rana'),
    (2, 'lisanna', 'dahal');

insert into instructors (instructor_id, instructor_name)
values
    (101, 'john'),
    (102, 'mary'),
    (103, 'peter');

insert into courses (course_id, course_name)
values
    (201, 'math'),
    (202, 'cs'),
    (203, 'physics');

insert into enrollment (student_id, course_id, instructor_id)
values
    (1, 201, 101),
    (1, 202, 102),
    (2, 203, 103);

select * from enrollment;


-- transaction and stored procedure
use onlinelearningportal;

-- create tables
create table t_courses(
   course_id int primary key,
   course_name varchar(50),
   available_seats int not null
);

create table t_students(
   student_id int primary key,
   student_name varchar(50)
);

create table t_enrollments(
   enrollment_id int primary key auto_increment,
   student_id int,
   course_id int,
   enrollment_date date,
   foreign key (student_id) references t_students(student_id),
   foreign key (course_id) references t_courses(course_id)
);

-- insert data
insert into t_courses(course_id, course_name, available_seats)
values
   (1, 'Python Basics', 10),
   (2, 'Web Development', 7),
   (3, 'Machine Learning', 5);

insert into t_students(student_id, student_name)
values
   (101, 'Alice'),
   (102, 'Bob'),
   (103, 'Hari');

-- create stored procedure for enrollment
delimiter //
create procedure enroll_student (in student_id int, in input_course_id int)
begin
   declare seats int;
   
   -- retrieve available seats for the specified course
   select available_seats INTO seats
   from t_courses
   where course_id = input_course_id;
   
   -- check if seats are available
   if seats > 0 then
       -- insert into enrollments table
       insert into t_enrollments(student_id, course_id, enrollment_date)
       values (student_id, input_course_id, CURDATE());
       
       -- update available seats
       update t_courses
       set available_seats = available_seats - 1
       where course_id = input_course_id;
       
       commit;
   else
       rollback;
   end if;
end //
delimiter ;

-- using the stored procedure
call enroll_student(101, 1);

-- transaction example for enrollment
delimiter //
start transaction;
   -- insert into enrollments table if seats are available
   insert into t_enrollments(student_id, course_id, enrollment_date)
   select 101, course_id, CURDATE()
   from t_courses
   where course_id = 2 and available_seats > 0;
   
   -- update available seats
   update t_courses
   set available_seats = available_seats - 1
   where course_id = 2 and available_seats > 0;
   
   -- check if changes were made and commit or rollback
   if ROW_COUNT() > 0 then
       commit;
   else
       rollback;
   end if;
//


