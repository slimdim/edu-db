-- Создаём необходимые индексы
-- Таблица users, для поиска по username или email
CREATE UNIQUE INDEX users_email_idx ON users(email);
CREATE UNIQUE INDEX users_username_idx ON users(username);

-- Таблица artists, для поиска по имени исполнителя
CREATE INDEX artists_name_idx ON artists(name);

-- Таблица albums, для поиска по названию альбома
CREATE INDEX albums_name_idx ON albums(name);

-- Таблица albums, для сортировки по дате выпуска альбомов
CREATE INDEX albums_release_date_idx ON albums(release_date);

-- Таблица tracks, для поиска по названию трека
CREATE INDEX tracks_name_idx ON tracks(name);

-- Таблица playback_history, составной индекс для поиска по связке текущий трек - предыдущий трек
CREATE INDEX playback_history_track_id_previous_track_id_idx ON playback_history(track_id, previous_track_id);