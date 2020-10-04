-- Триггер для сохранения данных в logs после вставки в products

DELIMITER //

CREATE TRIGGER products_logs_insert AFTER INSERT ON products
FOR EACH ROW BEGIN
  INSERT INTO logs (table_name, id_value, name) VALUES ('products', new.id, new.name);
END//

DELIMITER ;