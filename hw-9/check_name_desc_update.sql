DELIMITER //
CREATE TRIGGER check_name_desc_update BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
  IF ((NEW.name IS NULL AND NEW.description IS NULL) OR
      (OLD.name IS NULL AND NEW.description IS NULL) OR
      (NEW.name IS NULL AND OLD.description IS NULL)) THEN 
	SET NEW.name = OLD.name;
	SET NEW.description = OLD.description;
  END IF;
END//
DELIMITER ;