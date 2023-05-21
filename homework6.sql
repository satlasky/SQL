USE VK;

-- 1. Вывести имена, фамилии и email пользователей в алфавитном порядке по фамилии --
SELECT lastname, firstname, email FROM users ORDER BY 1 ASC;

-- 2. Вывести имена всех женщин в алфавитном порядке --
SELECT firstname FROM users WHERE id IN (SELECT user_id FROM profiles WHERE gender = 'f');

-- 3. Вывести имена и фамилии 5 первых пользователей --
SELECT lastname, firstname FROM users LIMIT 5;

-- 4. Вывести все названия файлов с фотографиями, у которых размер файла не превышает 100 000 --
SELECT filename FROM media WHERE size < 100000;

-- 5. Вывести все города, в которых находятся пользователи --
SELECT hometown FROM profiles GROUP BY hometown; -----

-- 6. Вывести все файлы, которые загрузил пользователь по имени Frederik Upton --
SELECT filename FROM media WHERE id IN (SELECT u.id FROM users u WHERE u.firstname = 'Frederik' AND u.lastname = 'Upton');

-- 7. Посчитайте количество женщин и количество мужчин --
SELECT (SELECT COUNT(*) FROM profiles WHERE gender = 'f') AS 'Females', (SELECT COUNT(*) FROM profiles WHERE gender = 'm') AS 'Males';

-- 8. Найдите все города пользователей, начинающиеся на букву 'P' --
SELECT hometown FROM profiles WHERE hometown LIKE 'P%' GROUP BY hometown;

-- 9. Выведите имя самого молодого пользователя --
SELECT (SELECT u.firstname FROM users u WHERE u.id = p.user_id) FROM profiles p ORDER by p.birthday DESC LIMIT 1;

-- 10. Выведите количество женщин из каждого города --
SELECT p.hometown, COUNT(*) FROM profiles p WHERE p.gender = 'f' GROUP BY p.hometown;