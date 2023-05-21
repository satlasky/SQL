/* Контрольная Точка №2 */

USE online_courses;

/*1. Простыми запросами 1-2*/

-- Выбрать все курсы:
SELECT * FROM course;

-- Выбрать всех студентов:
SELECT * FROM student;

/* 2. Запросами с агрегациями 1-2 */

-- Посчитать количество студентов:
SELECT COUNT(*) FROM student;

-- Посчитать среднюю цену курса:
SELECT AVG(price) FROM course;

/* 3. Сложными запросами с объединением 2-3 таблиц с помощью Join 2-3 */

-- Показать список студентов, записавшихся на курс с названием "Python":
SELECT s.name, s.surname 
FROM student s 
JOIN enrollment e ON s.id_student = e.student_id 
JOIN course c ON e.course_id = c.id_course 
WHERE c.name = "Python";

-- Показать список курсов, на которые не записалось ни одного студента:
SELECT c.name 
FROM course c 
LEFT JOIN enrollment e ON c.id_course = e.course_id 
WHERE e.enrollment_date IS NULL;

/* 4. Сложными запросами с объединениями 2-3 таблиц подзапросами 2-3 */

-- Показать список студентов, их оценки за задания и общее количество заданий по курсу с названием "JavaScript":
SELECT s.name, s.surname, 
(SELECT COUNT(*) FROM assignment WHERE course_id = (SELECT id_course FROM course WHERE name = "JavaScript")) AS total_assignments,
(SELECT COUNT(*) FROM submission WHERE student_id = s.id_student AND grade IS NOT NULL AND assignment_id IN (SELECT id_assignment FROM assignment WHERE course_id = (SELECT id_course FROM course WHERE name = "JavaScript"))) as total_grades
FROM student s
WHERE s.id_student IN (SELECT student_id FROM enrollment WHERE course_id = (SELECT id_course FROM course WHERE name = "JavaScript"));

-- Показать список курсов и количество выполненных студентами заданий по каждому курсу:
SELECT c.name,
(SELECT COUNT(*) FROM submission WHERE assignment_id IN (SELECT id_assignment FROM assignment WHERE course_id = c.id_course)) AS total_submissions
FROM course c;

