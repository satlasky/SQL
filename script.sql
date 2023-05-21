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

CREATE TABLE `student` (
  `id_student` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `surname` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(30) NOT NULL,

  PRIMARY KEY (`id_student`)
);

CREATE TABLE `lesson` (
  `id_lesson` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `description` varchar(500) NOT NULL,
  `course_id` int NOT NULL,

  PRIMARY KEY (`id_lesson`),
  FOREIGN KEY (`course_id`) REFERENCES `course`(`id_course`)
);

CREATE TABLE `enrollment` (
  `id_enrollment` int NOT NULL AUTO_INCREMENT,
  `enrollment`_date DATE NOT NULL,
  `student_id` int NOT NULL,
  `course_id` int NOT NULL,

  PRIMARY KEY (`id_enrollment`),
  FOREIGN KEY (`student_id`) REFERENCES `student`(`id_student`),
  FOREIGN KEY (`course_id`) REFERENCES `course`(`id_course`)
);

CREATE TABLE `assignment` (
  `id_assignment` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `description` varchar(500) NOT NULL,
  `deadline_date` DATE NOT NULL,
  `course_id` int NOT NULL,

  PRIMARY KEY (`id_assignment`),
  FOREIGN KEY (`course_id`) REFERENCES `course`(`id_course`)
);

CREATE TABLE `submission` (
  `id_submission` int NOT NULL AUTO_INCREMENT,
  `submission_date` DATE NOT NULL,
  `grade` int NOT NULL,
  `assignment_id` int NOT NULL,
  `student_id` int NOT NULL,

  PRIMARY KEY (`id_submission`),
  FOREIGN KEY (`assignment_id`) REFERENCES `assignment`(`id_assignment`),
  FOREIGN KEY (`student_id`) REFERENCES `student`(`id_student`)
);
