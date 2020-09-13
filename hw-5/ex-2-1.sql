-- 1е задание «Агрегация данных»
-- Подсчитайте средний возраст пользователей в таблице users
USE shop;

SELECT
  AVG(FLOOR((TO_DAYS(NOW()) - TO_DAYS(birthday_at))/365.25))
FROM users;