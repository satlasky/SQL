/* Урок 10 - Хранимые процедуры и триггеры */

USE vk;

/* 1. Создайте хранимую процедуру, которая создает временную таблицу для
 подсчета из каких городов пользователи в бд */
DROP PROCEDURE IF EXISTS fromWhichCitiesUsers;
DELIMITER //
CREATE PROCEDURE fromWhichCitiesUsers()
BEGIN
    CREATE TEMPORARY TABLE tmp_table (
        hometown VARCHAR(100) NOT NULL,
        count_users INT DEFAULT 0
    );
    INSERT INTO tmp_table (tmp_table.hometown, tmp_table.count_users)
    SELECT
    DISTINCT profiles.hometown,
    COUNT(*) AS count_users
    FROM profiles, users
    WHERE profiles.user_id = users.id
    GROUP BY profiles.hometown
    ORDER BY count_users DESC;
END//
DELIMITER ;

CALL fromWhichCitiesUsers();
SELECT * FROM tmp_table;

/* 2. Создайте триггер, который при удалении пользователя удаляет также его
 файлы */
DROP TRIGGER IF EXISTS delFiles;
DELIMITER //
CREATE TRIGGER delFiles AFTER DELETE ON users
FOR EACH ROW
BEGIN
    DELETE FROM media WHERE media.user_id = OLD.id;
END//
DELIMITER ;

DELETE FROM users WHERE id = 1;
SELECT * FROM users WHERE id = 1;
SELECT * FROM media WHERE user_id = 1;

/* 3. Создайте триггер, который при добавлении пользователя проверяет его дату
 рождения и устанавливает текущую дату, если дата из "будущего" */
DROP TRIGGER IF EXISTS backToTheFuture;
DELIMITER //
CREATE TRIGGER backToTheFuture BEFORE INSERT ON profiles
FOR EACH ROW
BEGIN
    SET NEW.birthday = IF (NEW.birthday > NOW(), NOW(), NEW.birthday);
END//
DELIMITER ;

INSERT INTO users (id, firstname, lastname, email, phone) VALUES ('101', 'Test', 'Test', 'test@mail.net', '9365829503');
INSERT INTO profiles (user_id, gender, birthday) VALUES ('101', 'f', '2077-11-08');
SELECT * FROM profiles WHERE user_id = 101;

/* 4. Создайте триггер, который при обновлении данных в таблице media будет
 ставить текущую дату и время в колонку updated_at */
DROP TRIGGER IF EXISTS mediaUpdate;
DELIMITER //
CREATE TRIGGER mediaUpdate BEFORE UPDATE ON media
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
END//
DELIMITER ;

SELECT * FROM media WHERE user_id = 100;
UPDATE media SET filename = 'test.jpg' WHERE user_id = 100;
SELECT * FROM media WHERE user_id = 100;

/* 5. Создайте триггер, который проверяет на правильность ввод данных о
 пользователе при вставке нового пользователя ( fristname и lastname, email
 не должны быть пустыми, phone начинается с 7), и выводит на экран ошибку
 "Invalid user data" */
DROP TRIGGER IF EXISTS inputCheck;
DELIMITER //
CREATE TRIGGER inputCheck BEFORE INSERT ON users
FOR EACH ROW
IF NEW.firstname IS NULL OR NEW.lastname IS NULL OR NEW.email IS NULL OR LEFT(NEW.phone, 1) != 7 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Invalid user data';
END IF//
DELIMITER ;

INSERT INTO users (id, lastname, phone) VALUES ('102', 'Test', '19365829503'); -- Invalid user data

/* 6. Создайте функцию, которая удаляет пользователя по id вместе с его
 профилем */
DROP FUNCTION IF EXISTS delUser; 
DELIMITER //
CREATE FUNCTION delUser(_id_ INT)
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
    DELETE FROM users WHERE id = _id_;
    DELETE FROM profiles WHERE user_id = _id_;
    RETURN CONCAT('Пользователь с id', _id_, ' удалён');
END //
DELIMITER ;

SELECT delUser(102);

/* 7. Создайте функцию hello(), которая будет возвращать приветствие, в
 зависимости от текущего времени суток. С 6:00 до 12:00 функция должна
 возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна
 возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00
 до 6:00 — "Доброй ночи" */
DROP FUNCTION IF EXISTS hello; 
DELIMITER //
CREATE FUNCTION hello()
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
    DECLARE hour INT DEFAULT DATE_FORMAT(NOW(), "%k");
    CASE
        WHEN hour >= 6 AND hour <= 11 THEN RETURN 'Доброе утро';
        WHEN hour >= 12 AND hour <= 17 THEN RETURN 'Добрый день';
        WHEN hour >= 18 AND hour <= 23 THEN RETURN 'Добрый вечер';
        WHEN hour >= 0 AND hour <= 5 THEN RETURN 'Доброй ночи';
        ELSE RETURN hour;
    END CASE;
END //
DELIMITER ;

SELECT hello();
