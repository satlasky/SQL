DROP DATABASE IF EXISTS `vk`;
CREATE DATABASE `vk`;
USE `vk`;

CREATE TABLE `users` (
	      `id` SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    `firstname` VARCHAR(100),
    `lastname` VARCHAR(100) COMMENT 'Фамилия',
    `email` VARCHAR(100) UNIQUE,
    `password_hash` varchar(100),
    `phone` BIGINT,
    is_deleted bit default 0,
    -- INDEX users_phone_idx(phone),
    INDEX users_firstname_lastname_idx(firstname, lastname)
);


CREATE TABLE `profiles` (
	`user_id` SERIAL PRIMARY KEY,
    `gender` CHAR(1),
    `birthday` DATE,
	`photo_id` BIGINT UNSIGNED,
    `created_at` DATETIME DEFAULT NOW(),
    `hometown` VARCHAR(100)
    -- , FOREIGN KEY (photo_id) REFERENCES media(id)
);

ALTER TABLE `profiles` ADD CONSTRAINT fk_user_id
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
    ON UPDATE CASCADE ON DELETE CASCADE;

CREATE TABLE `messages` (
	`id` SERIAL PRIMARY KEY,
	`from_user_id` BIGINT UNSIGNED NOT NULL,
    `to_user_id` BIGINT UNSIGNED NOT NULL,
    `body` TEXT,
    `created_at` DATETIME DEFAULT NOW(),

    FOREIGN KEY (`from_user_id`) REFERENCES `users(`id`) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (`to_user_id`) REFERENCES `users(`id`) ON UPDATE CASCADE ON DELETE CASCADE
);



CREATE TABLE `media_types`(
	`id` SERIAL PRIMARY KEY,
    `name` VARCHAR(255),
    `created_at` DATETIME DEFAULT NOW(),
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

);


CREATE TABLE `media`(
	`id` SERIAL PRIMARY KEY,
    `media_type_id` BIGINT UNSIGNED,
    `user_id BIGINT UNSIGNED NOT NULL,
  	`body` text,
    `filename` VARCHAR(255),
    `size` INT,
	`metadata` JSON,
    `created_at` DATETIME DEFAULT NOW(),
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (`media_type_id`) REFERENCES ``media_types`(`id`) ON UPDATE CASCADE ON DELETE SET NULL
);


CREATE TABLE `photo_albums` (
	`id` SERIAL,
	`name` varchar(255) DEFAULT NULL,
    `user_id` BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON UPDATE CASCADE ON DELETE SET NULL,
  	PRIMARY KEY (`id`)
);

CREATE TABLE `photos` (
	`id` SERIAL PRIMARY KEY,
	`album_id` BIGINT unsigned NOT NULL,
	`media_id` BIGINT unsigned NOT NULL,

	FOREIGN KEY (`album_id`) REFERENCES `photo_albums`(`id`) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (`media_id`) REFERENCES `media`(`id`) ON UPDATE CASCADE ON DELETE CASCADE
);

ALTER TABLE `profiles` ADD CONSTRAINT fk_photo_id
    FOREIGN KEY (`photo_id`) REFERENCES `photos`(`id`)
    ON UPDATE CASCADE ON DELETE set NULL;





INSERT `users`(`firstname`, `lastname`, `email`, `password_hash`, `phone`, `is_deleted`) VALUES ('Роман', 'Шкляев', 'roma@ebmail.top', '0#2at3#3sj%15#4fs', 89534568038, 0);
INSERT `users`(`firstname`, `lastname`, `email`, `password_hash`, `phone`, `is_deleted)` VALUES ('Дмитрий', 'Дубровин', 'dima@ebmail.top', '0#2am3#3sw%it5#4ff', 89234528677, 0);
SELECT * FROM  `users`;

INSERT `messages`(`from_user_id`, `to_user_id`, `body`, `created_at`) VALUES (1, 2, 'Hollo mySQL', '2022-12-05 12:32:39');
SELECT * FROM  `messages`;

INSERT `photo_albums`(`name`, `user_id`) VALUES ('Лето 2022', 1);
INSERT `photo_albums`(`name`, `user_id`) VALUES ('Ялта', 2);
SELECT * FROM  `photo_albums`;

INSERT `media_types`(`name`, `created_at`, `updated_at`) VALUES ('photo', '2022-12-05 12:32:39', '2023-10-03 14:35:19');
INSERT `media_types`(`name`, `created_at`, `updated_at`) VALUES ('photo', '2020-11-05 11:32:39', '2023-10-11 15:31:19');
SELECT * FROM  `media_types`;

INSERT `media`(`media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES (1, 1, 'texttext', 'photo1', 12, '{"a": 10, "b": 25}', '2022-12-05 12:32:39', '2023-10-03 14:35:19');
INSERT `media`(`media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`) VALUES (2, 2, 'texttext', 'photo2', 113, '{"a": 10, "b": 25}', '2022-12-05 12:32:39', '2023-10-03 14:35:19');
SELECT * FROM  `media`;

INSERT `photos`(`album_id`, `media_id`) VALUES (1, 1);
INSERT `photos`(`album_id`, `media_id`) VALUES (2, 2);
SELECT * FROM  `photos`;

INSERT `profiles`(`gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('m', '1993-02-04', 1, '2012-12-01 22:54:53', 'St. Petersburg');
INSERT `profiles`(`gender`, `birthday`, `photo_id`, `created_at`, `hometown`) VALUES ('m', '1990-12-09', 2, '2010-02-13 13:23:04', 'Moscow');
SELECT * FROM  `profiles`;
