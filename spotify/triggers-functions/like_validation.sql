-- Создадим триггер для проверки валидности target_id и target_type_id
DROP TRIGGER IF EXISTS like_validation;
DELIMITER //

CREATE TRIGGER likes_validation BEFORE INSERT ON likes

FOR EACH ROW BEGIN
  IF !is_row_exists(NEW.target_id, NEW.target_type_id) THEN
    SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "Error adding like! Target table doesn't contain row id provided!";
  END IF;
END//

DELIMITER ;