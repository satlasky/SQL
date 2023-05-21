/* Урок 8 - Соединения */
USE vk;

/* 1. Вывести все файлы видео с расширениями .avi и .mp4 */
SELECT m.filename 
FROM media m 
WHERE m.filename LIKE '%.avi'
UNION 
SELECT m.filename 
FROM media m 
WHERE m.filename LIKE '%.mp4';


/* 2.Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, 
 который больше всех общался с выбранным пользователем (написал ему сообщений). */
SELECT u.firstname, u.lastname 
FROM users u
JOIN
messages m
WHERE m.from_user_id = u.id AND m.to_user_id = 1 
GROUP BY u.firstname, u.lastname
ORDER BY COUNT(from_user_id) desc
limit 1;


/* 3. Подсчитать общее количество лайков, которые получили пользователи младше 11 лет. */
SELECT COUNT(*) 'Общ. кол. лайков'
FROM likes l 
JOIN
profiles p 
WHERE p.user_id = l.user_id AND floor (DATEDIFF(now(), p.birthday ) / 365) < 11;


/* 4. Определить кто больше поставил лайков (всего): мужчины или женщины. */
SELECT CASE gender
WHEN 'm' THEN 'Мужчины'
WHEN 'f' THEN 'Женщины'
END AS 'Больше', COUNT(*) as 'Кол. лайков:'
FROM profiles p 
JOIN
likes l 
WHERE l.user_id = p.user_id
GROUP BY gender 
limit 1;


/* 5. Вывести количество групп каждого пользователя */
SELECT 
count(*) total,
u.firstname as 'Фамилия',
u.lastname as 'Имя'
FROM users u
JOIN users_communities uc ON u.id = uc.user_id 
GROUP BY u.id
ORDER BY total desc;


/* 6. Найти количество пользователей в сообществах */
SELECT 
COUNT(*) AS 'Количество',
c.name as 'Сообщество'
FROM users_communities u_c 
JOIN communities c ON c.id = u_c.community_id
GROUP BY c.id 
ORDER BY 'Количество' DESC; 


/* 7. Найти 3 пользователей с наибольшим количеством лайков */
SELECT 
CONCAT(u.firstname,' ', u.lastname) AS 'Пользователь', 
count(l.media_id) AS 'Количество лайков:'
FROM media m
JOIN likes l ON l.media_id = m.id
JOIN users u ON u.id = m.user_id
GROUP BY Пользователь
limit 3;

