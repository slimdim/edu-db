-- 3е задание. Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
-- Поля from, to и label содержат английские названия городов, поле name — русское.
-- Выведите список рейсов flights с русскими названиями городов.

-- Создаём структуру БД flights

CREATE DATABASE flights;

USE flights;

CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  city_from VARCHAR(255) COMMENT 'Город отправления',
  city_to VARCHAR(255) COMMENT 'Город назначения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Полёты';

INSERT INTO flights (city_from, city_to) VALUES
  ('moscow', 'omsk'),
  ('novgorod', 'kazan'),
  ('irkutsk', 'moscow'),
  ('omsk', 'irkutsk'),
  ('moscow', 'kazan');
  
SELECT * FROM flights;

CREATE TABLE cities (
  id SERIAL PRIMARY KEY,
  label VARCHAR(255) COMMENT 'Обозначение города',
  name VARCHAR(255) COMMENT 'Название города',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Города';

INSERT INTO cities (label, name) VALUES
  ('moscow', 'Москва'),
  ('omsk', 'Омск'),
  ('novgorod', 'Новгород'),
  ('kazan', 'Казань'),
  ('irkutsk', 'Иркутск');
  
SELECT * FROM cities;

-- Выполняем запросы
-- Вложенные Select-ы
SELECT
(SELECT c.name FROM cities c WHERE c.label = f.city_from) AS city_from,
(SELECT c.name FROM cities c WHERE c.label = f.city_from) AS city_to
 FROM flights f;
 
-- Вариант с join
SELECT с.name, с2.name
FROM flights f
  JOIN cities с
    ON f.city_from = с.label
  JOIN cities с2
    ON f.city_to = с2.label;