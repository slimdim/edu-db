
-- Создаём все необходимые внешние ключи
ALTER TABLE media ADD CONSTRAINT media_media_type_id_fk FOREIGN KEY (media_type_id) REFERENCES media_types(id);

ALTER TABLE tracks ADD CONSTRAINT track_media_id_fk FOREIGN KEY (media_id) REFERENCES media(id);

ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE CASCADE,
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
    ON DELETE SET NULL,
  ADD CONSTRAINT profiles_plan_id_fk
    FOREIGN KEY (plan_id) REFERENCES plans(id);
    
ALTER TABLE friendship
  ADD CONSTRAINT friendship_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_follower_id_fk
    FOREIGN KEY (follower_id) REFERENCES users(id);
    
ALTER TABLE albums 
  ADD CONSTRAINT albums_album_type_id_fk
    FOREIGN KEY (album_type_id) REFERENCES album_types(id),
  ADD CONSTRAINT albums_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
    ON DELETE SET NULL,
  ADD CONSTRAINT albums_label_id_fk
    FOREIGN KEY (label_id) REFERENCES labels(id),
  ADD CONSTRAINT albums_artist_id_fk
    FOREIGN KEY (artist_id) REFERENCES artists(id);
    
   
ALTER TABLE artists
  ADD CONSTRAINT artists_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
    ON DELETE SET NULL;
    
ALTER TABLE labels 
  ADD CONSTRAINT labels_photo_id_fk
    FOREIGN KEY (logo_id) REFERENCES media(id)
    ON DELETE SET NULL;
    
ALTER TABLE album_tracks
  ADD CONSTRAINT album_tracks_album_id_fk
    FOREIGN KEY (album_id) REFERENCES albums(id),
  ADD CONSTRAINT album_tracks_track_id_fk
    FOREIGN KEY (track_id) REFERENCES tracks(id);
    
ALTER TABLE track_artists 
  ADD CONSTRAINT track_artists_artist_id_fk
    FOREIGN KEY (artist_id) REFERENCES artists(id),
  ADD CONSTRAINT track_artists_track_id_fk
    FOREIGN KEY (track_id) REFERENCES tracks(id);
    
ALTER TABLE playback_history 
  ADD CONSTRAINT playback_history_track_id_fk
    FOREIGN KEY (track_id) REFERENCES tracks(id),
  ADD CONSTRAINT playback_history_previous_track_id_fk
    FOREIGN KEY (previous_track_id) REFERENCES tracks(id);
    
ALTER TABLE likes
  ADD CONSTRAINT likes_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT likes_target_type_id_fk
    FOREIGN KEY (target_type_id) REFERENCES target_types(id);