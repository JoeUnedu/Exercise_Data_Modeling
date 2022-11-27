-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

CREATE TABLE planets_old
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  orbital_period_in_years FLOAT NOT NULL,
  orbits_around TEXT NOT NULL,
  galaxy TEXT NOT NULL,
  moons TEXT[]
);

INSERT INTO planets_old
  (name, orbital_period_in_years, orbits_around, galaxy, moons)
VALUES
  ('Earth', 1.00, 'The Sun', 'Milky Way', '{"The Moon"}'),
  ('Mars', 1.88, 'The Sun', 'Milky Way', '{"Phobos", "Deimos"}'),
  ('Venus', 0.62, 'The Sun', 'Milky Way', '{}'),
  ('Neptune', 164.8, 'The Sun', 'Milky Way', '{"Naiad", "Thalassa", "Despina", "Galatea", "Larissa", "S/2004 N 1", "Proteus", "Triton", "Nereid", "Halimede", "Sao", "Laomedeia", "Psamathe", "Neso"}'),
  ('Proxima Centauri b', 0.03, 'Proxima Centauri', 'Milky Way', '{}'),
  ('Gliese 876 b', 0.23, 'Gliese 876', 'Milky Way', '{}');


-- Normalized Schema
CREATE TABLE galaxies
(
  id SERIAL PRIMARY KEY,
  galaxy_name TEXT NOT NULL
);

CREATE TABLE stars
(
  id SERIAL PRIMARY KEY,
  star_name TEXT NOT NULL,
  galaxy_id INTEGER NOT NULL REFERENCES galaxies(id)
);

CREATE TABLE planets
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  orbital_period_in_years FLOAT NOT NULL,
  orbits_around INTEGER NOT NULL REFERENCES stars(id)
);

CREATE TABLE moons
(
  id SERIAL PRIMARY KEY,
  moon_name TEXT NOT NULL,
  moon_planet INTEGER NOT NULL REFERENCES planets(id)
);

INSERT INTO galaxies
  (galaxy_name)
VALUES
  ('Milky Way')
;

INSERT INTO stars
  (star_name, galaxy_id)
VALUES
    ('The Sun', 1)
  , ('Proxima Centauri', 1)
  , ('Gliese 876', 1)
;

INSERT INTO planets
  (orbits_around, name, orbital_period_in_years)
VALUES
    (1, 'Earth', 1.00)
  , (1, 'Mars', 1.88)
  , (1, 'Venus', 0.62)
  , (1, 'Neptune', 164.8)
  , (2, 'Proxima Centauri b', 0.03)
  , (3, 'Gliese 876 b', 0.23)
;

INSERT INTO moons
  (moon_planet, moon_name)
VALUES
    (1, 'The Moon')
  , (2, 'Phobos')
  , (2, 'Deimos')
  , (4, 'Naiad')
  , (4, 'Thalassa')
  , (4, 'Despina')
  , (4, 'Galatea')
  , (4, 'Larissa')
  , (4, 'S/2004 N 1')
  , (4, 'Proteus')
  , (4, 'Triton')
  , (4, 'Nereid')
  , (4, 'Halimede')
  , (4, 'Sao')
  , (4, 'Laomedeia')
  , (4, 'Psamathe')
  , (4, 'Neso')
;

-- -- CROSSCHECK
SELECT name, orbital_period_in_years, orbits_around, galaxy, moons
FROM   planets_old
ORDER BY name
;

-- -- CROSSCHECK
SELECT name, orbital_period_in_years, star_name, galaxy_name, moons.moon_name
FROM   planets
  JOIN stars ON planets.orbits_around = stars.id 
  JOIN galaxies ON stars.galaxy_id = galaxies.id   
  LEFT JOIN moons ON planets.id = moons.moon_planet   
ORDER BY name
;