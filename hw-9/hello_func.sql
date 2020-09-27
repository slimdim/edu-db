DELIMITER //
DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello()
RETURNS TEXT DETERMINISTIC
BEGIN
	DECLARE my_time, morning_time_s, morning_time_e, day_time_s, day_time_e, evening_time_s, evening_time_e, night_time_s, night_time_e TIME;
	DECLARE greeting TEXT DEFAULT '';
	SET my_time = DATE_FORMAT(NOW(), '%H:%i:%s');
	SET morning_time_s = TIME_FORMAT('06:00:00', '%H:%i:%s');
	SET morning_time_e = TIME_FORMAT('11:59:59', '%H:%i:%s');
	SET day_time_s = TIME_FORMAT('12:00:00', '%H:%i:%s');
	SET day_time_e = TIME_FORMAT('17:59:59', '%H:%i:%s');
	SET evening_time_s = TIME_FORMAT('18:00:00', '%H:%i:%s');
	SET evening_time_e = TIME_FORMAT('23:59:59', '%H:%i:%s');
	SET night_time_s = TIME_FORMAT('00:00:00', '%H:%i:%s');
	SET night_time_e = TIME_FORMAT('05:59:59', '%H:%i:%s');
	IF (morning_time_s <= my_time AND my_time <= morning_time_e) THEN
		SET greeting = 'Доброе утро!';
	ELSEIF (day_time_s <= my_time AND my_time <= day_time_e) THEN
		SET greeting = 'Добрый день!';
	ELSEIF (evening_time_s <= my_time AND my_time <= evening_time_e) THEN
		SET greeting = 'Добрый вечер!';
	ELSEIF (night_time_s <= my_time AND my_time <= night_time_e) THEN
		SET greeting = 'Доброй ночи!';
	END IF;
	RETURN greeting;
END//
DELIMITER ;