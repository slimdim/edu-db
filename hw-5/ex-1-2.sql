-- 2е задание «Операторы, фильтрация, сортировка и ограничение»
-- Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR
-- и в них долгое время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME,
-- сохранив введённые ранее значения
USE shop;

-- создаём таблицу пользователей, в которой столбцы created_at и updated_at имеют тип VARCHAR()
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(16),
  updated_at VARCHAR(16)
) COMMENT = 'Покупатели';

-- заполняем таблицу
INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Наталья', '1984-11-12', '11.12.2017 10:16', '21.07.2018 14:45'),
  ('Александр', '1985-05-20', '20.05.2018 19:35', '20.04.2020 6:06'),
  ('Сергей', '1988-02-14', '14.02.2018 22:34', '30.06.2019 10:20'),
  ('Иван', '1998-01-12', '12.01.2018 18:10', '20.10.2019 15:18'),
  ('Мария', '1992-08-29', '29.08.2018 4:40', '24.02.2020 18:15');

SELECT * FROM users;

-- добавляем в таблицу столбцы для конвертированных значений дата-время
ALTER TABLE users ADD COLUMN created_at_converted DATETIME DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE users ADD COLUMN updated_at_converted DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- заполняем столбцы конвертированными значениями дата-время
UPDATE users SET created_at_converted=STR_TO_DATE(created_at, '%d.%m.%Y %T'), updated_at_converted=STR_TO_DATE(updated_at, '%d.%m.%Y %T');

-- удаляем столбцы created_at и updated_at
ALTER TABLE users DROP COLUMN created_at;
ALTER TABLE users DROP COLUMN updated_at;

-- переименовываем столбцы created_at_converted и updated_at_converted в created_at и updated_at
ALTER TABLE users RENAME COLUMN created_at_converted TO created_at;
ALTER TABLE users RENAME COLUMN updated_at_converted TO updated_at;

SELECT * FROM users;