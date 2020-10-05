-- Триггер для сохранения данных в logs после вставки в users

DELIMITER //

CREATE TRIGGER users_logs_insert AFTER INSERT ON users
FOR EACH ROW BEGIN
  INSERT INTO logs (table_name, id_value, name) VALUES ('users', new.id, new.name);
END//

DELIMITER ;