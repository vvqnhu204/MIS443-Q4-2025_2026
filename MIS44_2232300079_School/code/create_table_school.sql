
CREATE TABLE professors (
    professor_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    department VARCHAR(100),
    hire_date DATE
);


CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    enrollment_date DATE,
    graduation_year INTEGER,
    major VARCHAR(100)
);

CREATE TABLE courses (
    course_id VARCHAR(10) PRIMARY KEY,
    course_name VARCHAR(100),
    credits INTEGER,
    department VARCHAR(100),
    professor_id INTEGER,
CONSTRAINT fk_courses_professors FOREIGN KEY (professor_id) REFERENCES professors (professor_id)
);


CREATE TABLE enrollments (
    enrollment_id INTEGER PRIMARY KEY,
    student_id INTEGER,
    course_id VARCHAR(10),
    semester VARCHAR(20),
    year INTEGER,
    grade VARCHAR(2),
CONSTRAINT fk_enrollments_students FOREIGN KEY (student_id) REFERENCES students (student_id),
CONSTRAINT fk_enrollments_courses FOREIGN KEY (course_id) REFERENCES courses (course_id)
);

DROP TABLE students;
DROP TABLE enrollments; 
DROP TABLE courses; 
DROP TABLE professors; 