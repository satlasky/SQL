/* Урок 11 - Администрирование баз данных */

/* 1. Создайте резервную копию вашей базы данных */
# mysqldump -u root –p1234 vk > dump_vk.sql

/* 2. Создайте 3х пользователей с хэшированными паролями: superuser, admin,
 username. superuser имеет полный доступ к вашей базе данных, admin может
 выполнять все типы запросов (SELECT, UPDATE, DELETE, INSERT), username
 имеет доступ только к SELECT запросам к одной любой таблице*/
CREATE USER 'superuser'@'localhost' IDENTIFIED WITH sha256_password BY 'qwerty';
CREATE USER 'admin'@'localhost' IDENTIFIED WITH sha256_password BY '1234';
CREATE USER 'username'@'localhost' IDENTIFIED WITH sha256_password BY 'password';
FLUSH PRIVILEGES;

GRANT ALL PRIVILEGES ON *.* TO 'superuser'@'localhost';
GRANT SELECT, INSERT, DELETE, UPDATE ON *.* TO 'admin';
GRANT SELECT ON vk.media TO 'username';

SELECT USER FROM mysql.user;

/* 3. Переименуйте пользователя username на user, добавьте ему привилегий, чтобы он
 мог делать SELECT и INSERT запросы к любой другой таблице */
RENAME USER 'username'@'localhost' TO 'user'@'127.0.0.1';
GRANT SELECT, INSERT ON vk.users TO 'user';

/* 4. Удалите пользователя admin */
DROP USER 'admin';