-- Транзакции, переменные и представления

-- 1е задание. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции

START TRANSACTION;

INSERT INTO sample.users(id, name) SELECT u.id, u.name FROM shop.users u WHERE u.id = 1;

COMMIT;

SELECT * FROM sample.users u;

-- 2е задание. Создайте представление, которое выводит название name товарной позиции из таблицы
-- products и соответствующее название каталога name из таблицы catalogs

USE shop;

CREATE VIEW products_catalogs AS
  SELECT p.name AS product_name, c.name AS catalog_name
    FROM products p
    JOIN catalogs c
    ON p.catalog_id = c.id;
    
SELECT * FROM products_catalogs;

-- Хранимые процедуры и функции, триггеры
-- 1е задание. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи"

-- см. файл hello_func.sql

SELECT hello();

-- 2е задание. В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение
-- необходимо отменить операцию

-- см. файл check_name_desc_update.sql
SELECT * from products p;

UPDATE products p SET p.name = NULL, p.description = NULL WHERE p.id = '7';
SELECT * from products p;

UPDATE products p SET p.name = NULL WHERE p.id = '7';
SELECT * from products p;

UPDATE products p SET p.description = NULL WHERE p.id = '7';
SELECT * from products p;

UPDATE products p SET p.description = NULL WHERE p.id = '6';
SELECT * from products p;

UPDATE products p SET p.name = NULL WHERE p.id = '6';
SELECT * from products p;