-- 1е задание «Операторы, фильтрация, сортировка и ограничение»
-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем
USE shop;

-- создаём таблицу пользователей и НЕ заполняем параметры created_at и updated_at параметрами по умолчанию
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME,
  updated_at DATETIME
) COMMENT = 'Покупатели';

-- заполняем таблицу
INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');
  
SELECT * FROM users;

-- аполняем created_at и updated_at текущими датой и временем
UPDATE users SET created_at=NOW(), updated_at=NOW();