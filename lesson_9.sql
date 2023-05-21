/* Урок 9 - Представления, временные таблицы, транзакции */
USE vk;

/* 1. Создайте динамический запрос, который будет выводить имя, email, город и
 все файлы пользователя в зависимости от введенного id */
PREPARE dynamicQuery
FROM 
'SELECT
	users.id AS "ID",
	users.firstname AS "Name",
	users.email AS "E-mail",
	profiles.hometown AS "Hometown",
	media.filename AS "Files"
FROM users
JOIN profiles ON profiles.user_id = users.id
JOIN media ON media.user_id = users.id 
WHERE users.id = ?';

SET @id = 69;
EXECUTE dynamicQuery USING @id;

/* 2. Создайте временную таблицу для вычисления количество файлов согласно
 категориям ( музыка, видео, фото) */
DROP TABLE IF EXISTS tmp_table;
CREATE TEMPORARY TABLE tmp_table
SELECT
media_types.name AS 'Category',
count(media.id) AS 'Files'
FROM media
JOIN media_types ON media_types.id = media.media_type_id
WHERE
media_types.name = 'Photo' OR
media_types.name = 'Music' OR
media_types.name = 'Video'
GROUP BY Category;
SELECT * FROM tmp_table;

/* 3. Создайте представление, в котором будут отображены сгруппированные по
 городам пользовательские атрибуты ( name = firstname+lastname,
 age(возраст)) */
DROP VIEW IF EXISTS groupAttribute;
CREATE VIEW groupAttribute AS 
SELECT 
profiles.hometown AS 'Hometown',
concat(users.firstname, ' ', users.lastname) AS 'Name',
timestampdiff (YEAR, profiles.birthday, curdate()) AS 'Age'
FROM users
JOIN profiles ON profiles.user_id = users.id
ORDER BY Hometown;
SELECT * FROM groupAttribute;

/* 4. Создайте представление, в котором будут отображены сгруппированные по
 группам имена пользователей */
DROP VIEW IF EXISTS groupUsersname;
CREATE VIEW groupUsersname AS 
SELECT
communities.name AS 'Community',
concat(users.firstname, ' ', users.lastname) AS 'Name'
FROM users
JOIN users_communities ON users.id = users_communities.user_id
JOIN communities ON communities.id = users_communities.community_id
ORDER BY Community;

SELECT * FROM groupUsersname;

 /* 5. Создайте транзакцию, которая будет вводить нового пользователя:
 Jack Nicholson 22-04-1937 Neptune JackNIk@gmail.com +123456789 */
START TRANSACTION;
	INSERT INTO users(id, firstname, lastname, email, phone)
	VALUES(101, 'Jack', 'Nicholson', 'JackNIk@gmail.com', 1234567899);
	INSERT INTO profiles(user_id, gender, birthday, photo_id, created_at, hometown)
	VALUES(101, 'm', '1937-04-22', DEFAULT, current_timestamp(), 'Neptune');
COMMIT;

 /* 6. Создайте транзакцию, которая изменяет город пользователя по имени
 Frederik Upton на NewYork */
START TRANSACTION;
    UPDATE profiles, users SET hometown = 'NewYork' 
    WHERE users.id = profiles.user_id AND users.firstname = 'Frederik' AND users.lastname = 'Upton';
COMMIT;