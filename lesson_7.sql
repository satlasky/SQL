/* Домашнее задание к уроку №7 */

/* 
 1. Создайте запрос, в котором выбирается имена и фамилии в одном 
 столбце, пол, дату рождения пользователей. Дату рождения отформатируйте по образцу: 
 11 April 2023, в графе Пол укажите "Мужчина" или "Женщина"
 */
SELECT
CONCAT(users.firstname, ' ', users.lastname)
AS 'Full name',
IF(profiles.gender = 'f', 'Женщина', 'Мужчина')
AS 'Gender',
DATE_FORMAT(profiles.birthday, '%d %M %Y')
AS 'Birthday'
FROM users, profiles
WHERE users.id = profiles.user_id;


/*
2. Создайте запрос, который выводит имена пользователя и его контакт, если указан email - то email,
если не указан email, но указан телефон, то выдает его, если не указано ничего, то выдает строку "Не задан"
**/
SELECT
firstname,
coalesce(email, phone, 'Не задано')
AS 'Contact'
FROM users;


/* 
 3. Создайте запрос, который выдает уникальные почтовые сервера email у пользователей. 
 для справки: example@test.ru  - test.ru - почтовый сервер
 */
SELECT
DISTINCT SUBSTRING(email, INSTR(email, '@') + 1)
AS 'Mail domain'
FROM users;


/*
4. Создайте запрос, который выводит имена пользователей (Имя + фамилия) и их возраст, в отдельном столбце 
выводит строку "совершеннолетний" или "не совершеннолетний"
*/
SELECT
CONCAT(users.firstname, ' ', users.lastname)
AS 'Full name',
TIMESTAMPDIFF(YEAR, profiles.birthday, curdate())
AS 'Age',
IF(TIMESTAMPDIFF(YEAR, profiles.birthday, curdate()) >= 18, 'Совершеннолетний', 'Не совершеннолетний')
FROM users, profiles
WHERE users.id = profiles.user_id;


/*
5. Создайте запрос, который выводит название файла без расширения и его размер, округленный до 10 000.
для справки: test.avi - .avi это расширение файла 
*/
SELECT
SUBSTRING(filename, 1, INSTR(filename, '.') - 1)
AS 'File name',
ROUND(size , 10000) 
AS 'Size'
FROM media;


/*
6. Создайте запрос, который меняет дату всех медиа, созданных пользователем Frederik Upton на текущую дату
*/
UPDATE media
SET created_at = NOW()
WHERE user_id = (
	SELECT id
	FROM users
	WHERE firstname = 'Frederik' && lastname = 'Upton'
);


/*
7. Создайте запрос, который выводит количество пользователей с днями рождениями по месяцам
*/
SELECT
DISTINCT MONTH(birthday)
AS 'Month',
COUNT(*)
AS 'Count of birthdays'
FROM profiles GROUP BY MONTH(birthday)
ORDER BY MONTH(birthday);