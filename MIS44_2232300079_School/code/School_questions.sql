-- Q1: Return the complete student roster from the students table.
SELECT * FROM students ; 

-- Q2: Return students who are majoring in Computer Science.
SELECT first_name, last_name, graduation_year
FROM students
WHERE major LIKE '%Computer Science%'; 

--Q3: Return all courses ordered by credit hours from highest to lowest.
SELECT course_name, credits 
FROM courses courses
ORDER BY credits DESC;  

--Q4: Return students who are expected to graduate in 2026.
SELECT first_name, last_name, major
FROM students 
WHERE graduation_year = 2026; 

--Q5:Count the total number of courses available.
SELECT COUNT(course_id) AS total_courses
FROM courses ; 

--Q6: Calculate the average number of credits per course.
SELECT AVG(credits) AS average_credits 
FROM courses ; 

--Q7: Return students who enrolled after December 31, 2022.
SELECT first_name, last_name, enrollment_date
FROM students 
WHERE enrollment_date > '2022-12-31'; 

--Q8: Return professors who work in the Computer Science department.
SELECT first_name, last_name, hire_date 
FROM professors 
WHERE department LIKE  '%Computer Science%'; 

--Q9: SELECT first_name, last_name, email, major
SELECT first_name, last_name, email, major
FROM students 
WHERE email LIKE '%university.edu%'
ORDER BY last_name; 

--Q10: A department administrator wants to see which professors are teaching which courses. 
--Show each professor's name, department, and the courses they are responsible for. 
--Order by professor last name, then course name.
SELECT p.first_name, p.last_name, p.department, c.credits
FROM professors p
JOIN courses c ON p.professor_id = c.professor_id 
ORDER BY p.last_name, c.course_name; 

--Q11: The curriculum office wants to know how many different academic majors are represented in the student body. 
--Write a query that lists each unique major offered — no duplicates. 
--Exclude students who have not yet declared a major. Order alphabetically.
SELECT DISTINCT(major)
FROM students 
WHERE major IS NOT NULL 
ORDER BY major ASC;

--Q12: The admissions department needs to identify students who enrolled during the 2022–2023 academic period for a program evaluation. 
--Find all students whose enrollment_date falls within that range (inclusive). 
--Show first name, last name, enrollment_date, and major. Order by enrollment_date, then last name.
SELECT first_name, last_name, enrollment_date, major
FROM students 
WHERE enrollment_date BETWEEN '2022-01-01' AND '2023-12-31'
ORDER BY enrollment_date ASC, last_name ASC; 

--Q13: Academic advisors need to contact students who have not yet chosen a major so they can schedule advising sessions. 
--Find all students whose major has not been declared (stored as NULL). Show first name, last name, and email.
SELECT first_name, last_name, email
FROM students 
WHERE major IS NULL; 

--Q14: Return student names together with their enrolled courses and grades.
SELECT s.first_name, s.last_name, c.course_name, e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
ORDER BY s.student_id, e.enrollment_id;

--Q15: Count the number of students enrolled in each course.
SELECT c.course_name, COUNT(e.student_id) AS enrollment_count
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY c.course_name;

--Q16: Return courses with more than one student enrolled.
SELECT c.course_name,
COUNT(e.student_id) AS enrollment_count
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
HAVING COUNT(e.student_id) > 1
ORDER BY c.course_name;

--Q17: Return pairs of students who share the same graduation year.
SELECT
  s1.first_name AS student1_first,
  s1.last_name AS student1_last,
  s2.first_name AS student2_first,
  s2.last_name AS student2_last,
  s1.graduation_year,
  s1.major AS major1,
  s2.major AS major2
FROM students s1
JOIN students s2 ON s1.graduation_year = s2.graduation_year
AND s1.student_id < s2.student_id
ORDER BY s1.graduation_year, s1.student_id;

--Q18: Return course count, total credits, and average credits per department.
SELECT department, COUNT(*) AS course_count, SUM(credits) AS total_credits, AVG(credits) AS avg_credits
FROM courses
GROUP BY department
HAVING COUNT(*) >= 1
ORDER BY course_count DESC, department;

--Q19: The student services team needs to identify students who have not yet registered for any courses — 
--they may need outreach or academic advising. Find these students and show their first name, last name, and major.
SELECT s.first_name, s.last_name, s.major
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

--Q20: The admissions office wants to track enrollment trends over the years. 
--Count how many students enrolled each year, extracted from their enrollment_date. 
--Show enrollment_year and student_count ordered by year.
SELECT TO_CHAR (enrollment_date, 'YYYY') AS enrollment_year, COUNT(*) AS student_count
FROM students
GROUP BY enrollment_year
ORDER BY enrollment_year;


