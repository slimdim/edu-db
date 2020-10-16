-- Создадим триггер для проверки трека на предмет только одного главного исполнителя
DROP TRIGGER IF EXISTS track_only_one_main_artist_validation;
DELIMITER //

CREATE TRIGGER track_only_one_main_artist_validation BEFORE INSERT ON track_artists

FOR EACH ROW BEGIN
  IF (EXISTS(SELECT 1 FROM track_artists WHERE track_id = new.track_id AND is_main_artist = TRUE) AND new.is_main_artist = TRUE) THEN
    SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "Error adding song! Only one main artist per track!";
  END IF;
END//

DELIMITER ;