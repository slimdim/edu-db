
-- 1е задание. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs
-- помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

-- Помимо создание самой таблицы logs необходимо создать триггеры, которые срабатывают после вставки в таблицы users, catalogs и products.
-- триггеры также приложены.
 USE shop;

DROP TABLE IF EXISTS logs;

CREATE TABLE logs ( created_at DATETIME DEFAULT CURRENT_TIMESTAMP, table_name VARCHAR(255) COMMENT 'Название таблицы', id_value INT UNSIGNED COMMENT 'Значение ключа', name VARCHAR(255) COMMENT 'Содержимое поля name' ) COMMENT = 'Логи' ENGINE = Archive;

INSERT
	INTO
	users (name, birthday_at)
VALUES ('Семён', '1978-08-28');

SELECT
	*
FROM
	logs;

INSERT
	INTO
	catalogs (name)
VALUES ('Мониторы');

SELECT
	*
FROM
	logs;

INSERT
	INTO
	products (name, description, price, catalog_id)
VALUES ('Samsung LC32HG70QQUXEN', '32" изогнутый WQHD QLED-монитор', 44000, 6);

SELECT
	*
FROM
	logs;