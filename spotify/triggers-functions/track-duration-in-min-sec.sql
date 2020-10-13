-- Хранимая процедура, которая возвращает длину трека в формате мин:сек.мс
DROP FUNCTION IF EXISTS track_duration_in_min_sec;
DELIMITER //

CREATE FUNCTION track_duration_in_min_sec (track_id INT)
RETURNS TINYTEXT NO SQL

BEGIN
  DECLARE track_length_ms INT;
  SELECT duration FROM tracks WHERE id = track_id INTO track_length_ms;
  RETURN CONCAT(FLOOR(track_length_ms/(1000*60)%60), ':', FLOOR((track_length_ms/1000)%60), '.', track_length_ms%1000);
  
END//

DELIMITER ;