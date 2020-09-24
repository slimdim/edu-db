-- Заполняю тестовыми данными таблицы
INSERT INTO users (name, birthday_at) VALUES
  ('Алексей', '1990-10-05'),
  ('Жорж', '1984-11-12'),
  ('Микки Маус', '1985-05-20'),
  ('Билл Гейтс', '1988-02-14'),
  ('Вова', '1998-01-12'),
  ('Алевтина', '1992-08-29');

INSERT INTO orders(user_id) VALUES
('1'),
('2'),
('3'),
('4'),
('5'),
('6'),
('1'),
('2'),
('4'),
('2');

INSERT INTO orders_products(order_id, product_id, total) VALUES
('1', '5', '2'),
('1', '3', '1'),
('2', '1', '1'),
('2', '6', '1'),
('3', '7', '1'),
('4', '2', '3'),
('5', '4', '1'),
('5', '7', '1'),
('5', '1', '1'),
('5', '2', '1'),
('6', '7', '1'),
('7', '2', '1'),
('7', '6', '1'),
('8', '3', '1'),
('9', '3', '1'),
('9', '7', '1'),
('10', '1', '2');

-- 1е задание. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине
-- Вложенные Select-ы
SELECT
  (SELECT u.name FROM users u WHERE u.id = o.user_id) AS user_name
 FROM orders o
 GROUP BY user_name;

-- Вариант с join
SELECT u.name
  FROM users u
    JOIN orders o
    ON u.id = o.user_id
  GROUP BY u.name;
  
-- 2е задание. Выведите список товаров products и разделов catalogs, который соответствует товару.
-- Вложенные Select-ы
SELECT p.name, p.description, p.price,
  (SELECT c.name FROM catalogs c WHERE c.id = p.catalog_id) AS category
 FROM products p;

-- Вариант с join
SELECT p.name, p.description, p.price, c.name AS category
  FROM products p
    LEFT JOIN catalogs c
    ON p.catalog_id = c.id;
