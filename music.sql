-- -- from the terminal run:
-- -- psql < music.sql

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

CREATE TABLE songs_old
(
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  release_date DATE NOT NULL,
  artists TEXT[] NOT NULL,
  album TEXT NOT NULL,
  producers TEXT[] NOT NULL
);

INSERT INTO songs_old
  (title, duration_in_seconds, release_date, artists, album, producers)
VALUES
  ('MMMBop', 238, '04-15-1997', '{"Hanson"}', 'Middle of Nowhere', '{"Dust Brothers", "Stephen Lironi"}'),
  ('Bohemian Rhapsody', 355, '10-31-1975', '{"Queen"}', 'A Night at the Opera', '{"Roy Thomas Baker"}'),
  ('One Sweet Day', 282, '11-14-1995', '{"Mariah Cary", "Boyz II Men"}', 'Daydream', '{"Walter Afanasieff"}'),
  ('Shallow', 216, '09-27-2018', '{"Lady Gaga", "Bradley Cooper"}', 'A Star Is Born', '{"Benjamin Rice"}'),
  ('How You Remind Me', 223, '08-21-2001', '{"Nickelback"}', 'Silver Side Up', '{"Rick Parashar"}'),
  ('New York State of Mind', 276, '10-20-2009', '{"Jay Z", "Alicia Keys"}', 'The Blueprint 3', '{"Al Shux"}'),
  ('Dark Horse', 215, '12-17-2013', '{"Katy Perry", "Juicy J"}', 'Prism', '{"Max Martin", "Cirkut"}'),
  ('Moves Like Jagger', 201, '06-21-2011', '{"Maroon 5", "Christina Aguilera"}', 'Hands All Over', '{"Shellback", "Benny Blanco"}'),
  ('Complicated', 244, '05-14-2002', '{"Avril Lavigne"}', 'Let Go', '{"The Matrix"}'),
  ('Say My Name', 240, '11-07-1999', '{"Destiny''s Child"}', 'The Writing''s on the Wall', '{"Darkchild"}'),
  ('Feeling That Way', 208, '01-20-1978', '{"Journey"}', 'Infinity', '{"Roy Thomas Baker"}'),
  ('You''re My Best Friend', 170, '06-18-1976', '{"Queen"}', 'A Night at the Opera', '{"Roy Thomas Baker"}');
  


-- new schema
CREATE TABLE albums 
(
  id SERIAL PRIMARY KEY,
  album_name TEXT NOT NULL,
  album_release_date DATE NOT NULL
);

CREATE TABLE artists 
(
  id SERIAL PRIMARY KEY,
  artist_name TEXT NOT NULL
);

CREATE TABLE producers 
(
  id SERIAL PRIMARY KEY,
  producer_name TEXT NOT NULL
);

CREATE TABLE songs
(
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  release_date DATE NOT NULL
);


CREATE TABLE song_producers
(
  id SERIAL PRIMARY KEY,
  song_id INTEGER NOT NULL REFERENCES songs(id),
  producer_id INTEGER NOT NULL REFERENCES producers(id)
);

CREATE TABLE song_artist
(
  id SERIAL PRIMARY KEY,
  song_id INTEGER NOT NULL REFERENCES songs(id),
  artist_id INTEGER NOT NULL REFERENCES artists(id)
);

CREATE TABLE album_song
(
  id SERIAL PRIMARY KEY,
  album_id INTEGER NOT NULL REFERENCES albums(id),
  song_id INTEGER NOT NULL REFERENCES songs(id)
);


INSERT INTO albums 
  (album_release_date, album_name)
VALUES 
    ('04-15-1997', 'Middle of Nowhere')
  , ('11-01-1975', 'A Night at the Opera')
  , ('11-14-1995', 'Daydream')
  , ('09-27-2018', 'A Star Is Born')
  , ('08-21-2001', 'Silver Side Up')
  , ('10-20-2009', 'The Blueprint 3')
  , ('12-17-2013', 'Prism')
  , ('06-21-2011', 'Hands All Over')
  , ('05-14-2002', 'Let Go')
  , ('11-07-1999', 'The Writing''s on the Wall')
  , ('01-20-1978', 'Infinity')
;

INSERT INTO artists 
  (artist_name)
VALUES 
    ('Hanson')
  , ('Queen')
  , ('Mariah Cary')
  , ('Boyz II Men')
  , ('Lady Gaga')
  , ('Bradley Cooper')
  , ('Nickelback')
  , ('Jay Z')
  , ('Alicia Keys')
  , ('Katy Perry')
  , ('Juicy J')
  , ('Maroon 5')
  , ('Christina Aguilera')
  , ('Avril Lavigne')
  , ('Destiny''s Child')
  , ('Journey')
;

INSERT INTO producers 
  (producer_name)
VALUES 
    ('Dust Brothers')
  , ('Stephen Lironi')
  , ('Roy Thomas Baker')
  , ('Walter Afanasieff')
  , ('Benjamin Rice')
  , ('Rick Parashar')
  , ('Al Shux')
  , ('Max Martin')
  , ('Cirkut')
  , ('Shellback')
  , ('Benny Blanco')
  , ('The Matrix')
  , ('Darkchild')
;

INSERT INTO songs
  (duration_in_seconds, release_date, title)
VALUES
    (238, '04-15-1997', 'MMMBop')
  , (355, '10-31-1975', 'Bohemian Rhapsody')
  , (282, '11-14-1995', 'One Sweet Day')
  , (216, '09-27-2018', 'Shallow')
  , (223, '08-21-2001', 'How You Remind Me')
  , (276, '10-20-2009', 'New York State of Mind')
  , (215, '12-17-2013', 'Dark Horse')
  , (201, '06-21-2011', 'Moves Like Jagger')
  , (244, '05-14-2002', 'Complicated')
  , (240, '11-07-1999', 'Say My Name')
  , (208, '01-20-1978', 'Feeling That Way')
  , (170, '06-18-1976', 'You''re My Best Friend')
;

INSERT INTO song_producers
  (song_id, producer_id)
VALUES
    ( 1,  1)
  , ( 1,  2)
  , ( 2,  3)
  , ( 3,  4)
  , ( 4,  5)
  , ( 5,  6)
  , ( 6,  7)
  , ( 7,  8)
  , ( 7,  9)
  , ( 8, 10)
  , ( 8, 11)
  , ( 9, 12)
  , (10, 13)
  , (11,  3)
  , (12,  3)
;

INSERT INTO album_song
  (album_id, song_id)
VALUES
    ( 1,  1)
  , ( 2,  2)
  , ( 3,  3)
  , ( 4,  4)
  , ( 5,  5)
  , ( 6,  6)
  , ( 7,  7)
  , ( 8,  8)
  , ( 9,  9)
  , (10, 10)
  , (11, 11)
  , ( 2, 12)
;

INSERT INTO song_artist
  (song_id, artist_id)
VALUES
    ( 1,  1)
  , ( 2,  2)
  , ( 3,  3)
  , ( 3,  4)
  , ( 4,  5)
  , ( 4,  6)
  , ( 5,  7)
  , ( 6,  8)
  , ( 6,  9)
  , ( 7,  10)
  , ( 7,  11)
  , ( 8,  12)
  , ( 8,  13)
  , ( 9,  14)
  , (10,  15)
  , (11,  16)
  , (12,   2)
;

-- -- relationships not considered:
-- -- artist_album - an album could consist of multiple artists
-- -- album_producers - an album could consist of multiple producers

-- -- crosscheck
SELECT title, duration_in_seconds, release_date, artists, album, producers
FROM songs_old
ORDER BY title, artists, album
;

SELECT song.title, song.duration_in_seconds, song.release_date, artist_name, album_name
  , prod.producer_name
FROM songs song
LEFT JOIN song_artist s_art ON song.id = s_art.song_id
LEFT JOIN artists ON s_art.artist_id = artists.id
LEFT JOIN song_producers s_prod ON song.id = s_prod.song_id
LEFT JOIN producers prod ON s_prod.producer_id = prod.id
LEFT JOIN album_song al_song ON song.id = al_song.song_id
LEFT JOIN albums alb ON al_song.album_id = alb.id
ORDER BY song.title, artist_name, album_name, producer_name
;
