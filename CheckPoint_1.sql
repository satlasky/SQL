DROP DATABASE IF EXISTS `online_courses`;
CREATE DATABASE `online_courses`;
USE `online_courses`;

CREATE TABLE `course` (
  `id_course` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(500) NOT NULL,
  `price` int NOT NULL,

  PRIMARY KEY (`id_course`)
);

INSERT INTO `course` (`name`, `description`, `price`) VALUES
('Web Development', 'Learn how to build websites using HTML, CSS, JavaScript, and other web technologies', 200),
('Data Science', 'Learn how to analyze large amounts of data using tools like Python and SQL', 250),
('Mobile App Development', 'Learn how to build and publish your own mobile apps for iOS and Android', 300);

CREATE TABLE `student` (
  `id_student` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `surname` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(30) NOT NULL,

  PRIMARY KEY (`id_student`)
);

INSERT INTO `student` (`name`, `surname`, `email`, `password`) VALUES
('John', 'Doe', 'johndoe@example.com', 'password1'),
('Jane', 'Smith', 'janesmith@example.com', 'password2'),
('Bob', 'Johnson', 'bobjohnson@example.com', 'password3');

CREATE TABLE `lesson` (
  `id_lesson` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `description` varchar(500) NOT NULL,
  `course_id`
  
  PRIMARY KEY (`id_lesson`),
  FOREIGN KEY (`course_id`) REFERENCES `course`(`id_course`)
);

INSERT INTO `lesson` (`name`, `description`, `course_id`) VALUES
('Introduction to HTML', 'Learn the basics of HTML and how to create web pages', 1),
('Introduction to CSS', 'Learn how to style HTML documents using CSS', 1),
('Introduction to Python', 'Learn the basics of Python programming language', 2),
('Introduction to SQL', 'Learn how to query relational databases using SQL', 2),
('Introduction to iOS App Development', 'Learn how to build iOS apps using Swift programming language', 3),
('Introduction to Android App Development', 'Learn how to build Android apps using Java programming language', 3);

CREATE TABLE `enrollment` (
  `id_enrollment` int NOT NULL `AUTO_INCREMENT`,
  `enrollment_date` DATE NOT NULL,
  `student_id` int NOT NULL,
  `course_id` int NOT NULL,

  PRIMARY KEY (`id_enrollment`),
  FOREIGN KEY (`student_id`) REFERENCES `student`(`id_student`),
  FOREIGN KEY (`course_id`) REFERENCES `course`(`id_course`)
);

INSERT INTO `enrollment` (`enrollment_date`, `student_id`, `course_id`) VALUES
('2021-01-01', 1, 1),
('2021-02-01', 2, 1),
('2021-03-01', 3, 2),
('2021-04-01', 1, 3),
('2021-05-01', 2, 3),
('2021-06-01', 3, 2);

CREATE TABLE `assignment` (
  `id_assignment` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `description` varchar(500) NOT NULL,
  `deadline_date` DATE NOT NULL,
  `course_id` int NOT NULL,

  PRIMARY KEY (`id_assignment`),
  FOREIGN KEY (`course_id`) REFERENCES `course`(`id_course`)
);

INSERT INTO `assignment` (`name`, `description`, `deadline_date`, `course_id`) VALUES
('Website Development Project', 'Build a complete website using HTML, CSS, and JavaScript', '2021-07-31', 1),
('Data Analysis Project', 'Analyze a real-world dataset using Python and present your findings', '2021-08-31', 2),
('Mobile App Project', 'Build and publish a mobile app on the App Store or Google Play', '2021-09-30', 3);

CREATE TABLE `submission` (
  `id_submission` int NOT NULL AUTO_INCREMENT,
  `submission_date` DATE NOT NULL,
  `grade` int NOT NULL,
  `assignment_id` int NOT NULL,
  `student_id` int NOT NULL,

  PRIMARY KEY (`id_submission`),
  FOREIGN KEY (`assignment_id`) REFERENCES assignment(`id_assignment`),
  FOREIGN KEY (`student_id`) REFERENCES `student`(`id_student`)
);

INSERT INTO `submission` (`submission_date`, `grade`, `assignment_id`, `student_id`) VALUES
('2021-08-01', 90, 1, 1),
('2021-08-15', 80, 1, 2),
('2021-09-01', 95, 1, 3),
('2021-09-15', 85, 2, 1),
('2021-10-01', 92, 2, 2),
('2021-10-15', 88, 3, 3);