-- Триггер для сохранения данных в logs после вставки в catalogs

DELIMITER //

CREATE TRIGGER catalogs_logs_insert AFTER INSERT ON catalogs
FOR EACH ROW BEGIN
  INSERT INTO logs (table_name, id_value, name) VALUES ('catalogs', new.id, new.name);
END//

DELIMITER ;