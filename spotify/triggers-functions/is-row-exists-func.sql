-- Функция для проверки существования строки с идентификатором target_id в соответствующей таблице
DROP FUNCTION IF EXISTS is_row_exists;
DELIMITER //

CREATE FUNCTION is_row_exists (target_id INT, target_type_id INT)
RETURNS BOOLEAN READS SQL DATA

BEGIN
  DECLARE table_name VARCHAR(50);
  SELECT name FROM target_types WHERE id = target_type_id INTO table_name;
  
  CASE table_name
    WHEN 'artists' THEN
      RETURN EXISTS(SELECT 1 FROM artists WHERE id = target_id);
    WHEN 'albums' THEN 
      RETURN EXISTS(SELECT 1 FROM albums WHERE id = target_id);
    WHEN 'tracks' THEN
      RETURN EXISTS(SELECT 1 FROM tracks WHERE id = target_id);
    ELSE 
      RETURN FALSE;
  END CASE;
END//

DELIMITER ;