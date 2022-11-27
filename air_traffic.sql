-- -- from the terminal run:
-- -- psql < air_traffic.sql

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

CREATE TABLE tickets_old
(
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  seat TEXT NOT NULL,
  departure TIMESTAMP NOT NULL,
  arrival TIMESTAMP NOT NULL,
  airline TEXT NOT NULL,
  from_city TEXT NOT NULL,
  from_country TEXT NOT NULL,
  to_city TEXT NOT NULL,
  to_country TEXT NOT NULL
);

INSERT INTO tickets_old
  (first_name, last_name, seat, departure, arrival, airline, from_city, from_country, to_city, to_country)
VALUES
  ('Jennifer', 'Finch', '33B', '2018-04-08 09:00:00', '2018-04-08 12:00:00', 'United', 'Washington DC', 'United States', 'Seattle', 'United States'),
  ('Thadeus', 'Gathercoal', '8A', '2018-12-19 12:45:00', '2018-12-19 16:15:00', 'British Airways', 'Tokyo', 'Japan', 'London', 'United Kingdom'),
  ('Sonja', 'Pauley', '12F', '2018-01-02 07:00:00', '2018-01-02 08:03:00', 'Delta', 'Los Angeles', 'United States', 'Las Vegas', 'United States'),
  ('Jennifer', 'Finch', '20A', '2018-04-15 16:50:00', '2018-04-15 21:00:00', 'Delta', 'Seattle', 'United States', 'Mexico City', 'Mexico'),
  ('Waneta', 'Skeleton', '23D', '2018-08-01 18:30:00', '2018-08-01 21:50:00', 'TUI Fly Belgium', 'Paris', 'France', 'Casablanca', 'Morocco'),
  ('Thadeus', 'Gathercoal', '18C', '2018-10-31 01:15:00', '2018-10-31 12:55:00', 'Air China', 'Dubai', 'UAE', 'Beijing', 'China'),
  ('Berkie', 'Wycliff', '9E', '2019-02-06 06:00:00', '2019-02-06 07:47:00', 'United', 'New York', 'United States', 'Charlotte', 'United States'),
  ('Alvin', 'Leathes', '1A', '2018-12-22 14:42:00', '2018-12-22 15:56:00', 'American Airlines', 'Cedar Rapids', 'United States', 'Chicago', 'United States'),
  ('Berkie', 'Wycliff', '32B', '2019-02-06 16:28:00', '2019-02-06 19:18:00', 'American Airlines', 'Charlotte', 'United States', 'New Orleans', 'United States'),
  ('Cory', 'Squibbes', '10D', '2019-01-20 19:30:00', '2019-01-20 22:45:00', 'Avianca Brasil', 'Sao Paolo', 'Brazil', 'Santiago', 'Chile');


CREATE TABLE airlines
(
  id SERIAL,
  airline_code CHAR(5) PRIMARY KEY,
  airline_name TEXT NOT NULL
);

CREATE TABLE countries
(
  id SERIAL PRIMARY KEY,
  country_name TEXT NOT NULL
);

CREATE TABLE airports
(
  id SERIAL NOT NULL,
  code_iata CHAR(3) PRIMARY KEY,
  airport_name TEXT NOT NULL,
  airport_city TEXT NOT NULL,
  airport_country_id INTEGER NOT NULL REFERENCES countries(id)
);

CREATE TABLE tickets 
(
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL
);
-- CREATE INDEX tickets_lname_idx ON tickets (last_name);

CREATE TABLE itinerary
(
  id SERIAL PRIMARY KEY,
  ticket_id INTEGER NOT NULL REFERENCES tickets(id),
  ticket_seq SMALLINT NOT NULL CHECK (ticket_seq > 0),
  airline_code CHAR(5) NOT NULL REFERENCES airlines(airline_code),
  seat CHAR(3) NOT NULL,
  boarding TIMESTAMP NOT NULL,
  departure TIMESTAMP NOT NULL,
  departure_airport_code CHAR(3) NOT NULL REFERENCES airports(code_iata),
  arrival TIMESTAMP NOT NULL,
  arrival_airport_code CHAR(3) NOT NULL REFERENCES airports(code_iata)
);
-- CREATE INDEX itinerary_tix_seq_idx ON itinerary (ticket_id, ticket_seq);

INSERT INTO airlines
  (airline_code,airline_name)
VALUES
  ('CA',  'Air China'),
  ('AA',  'American Airlines'),
  ('BTQ', 'Avianca Brasil'),
  ('BA',  'British Airways'),
  ('DL',  'Delta'),
  ('UA',  'United'),
  ('TB',  'TUI Fly Belgium')
;

INSERT INTO countries
  (country_name)
VALUES
  ('Brazil'),
  ('Chile'),
  ('China'),
  ('France'),
  ('Japan'),
  ('Mexico'),
  ('Morocco'),
  ('UAE'),
  ('United Kingdom'),
  ('United States')
;

INSERT INTO airports
  (code_iata, airport_name, airport_city, airport_country_id)
VALUES
  ('CLT', 'Charlotte Douglas International Airport', 'Charlotte', 10),
  ('CID', 'Eastern Iowa Airport', 'Cedar Rapids', 10),
  ('CDG', 'Charles de Gaulle Airport', 'Paris', 4), 
  ('CMN', 'Casablanca Mohammed V International Airport', 'Casablanca', 7),
  ('DXB', 'Dubai International Airport', 'Dubai', 8), 
  ('DCA', 'Ronald Reagan Washington National Airport', 'Washington DC', 10), 
  ('EWR', 'Newark/Liberty International Airport', 'New York', 10),
--  ('GRU', 'São Paulo–Guarulhos International Airport', 'Sao Paolo', 1), 
  ('GRU', 'Sao Paulo-Guarulhos International Airport', 'Sao Paolo', 1), 
  ('JFK', 'John F. Kennedy International Airport', 'New York', 10),
  ('LAS', 'McCarran International Airport', 'Las Vegas', 10),
  ('LAX', 'Los Angeles International Airport', 'Los Angeles', 10), 
  ('LGA', 'LaGuardia Airport', 'New York', 10),
  ('LHR', 'Heathrow Airport', 'London', 9),
--  ('MEX', 'Benito Juárez International Airport (Mexico City International Airport)', 'Mexico City', 6),
  ('MEX', 'Benito Juarez International Airport (Mexico City International Airport)', 'Mexico City', 6),
  ('MSY', 'Louis Armstrong New Orleans International Airport', 'New Orleans', 10),
  ('NRT', 'Narita International Airport', 'Tokyo', 5), 
  ('ORD', 'O''Hare International Airport', 'Chicago' ,10),
  ('PEK', 'Beijing Capital International Airport', 'Beijing', 3),
  ('SEA', 'Seattle-Tacoma International Airport - Sea-Tac', 'Seattle', 10),
--  ('SCL', 'Comodoro Arturo Merino Benítez International Airport', 'Santiago', 2)
  ('SCL', 'Comodoro Arturo Merino Bennitez International Airport', 'Santiago', 2)
;

INSERT INTO tickets 
  (first_name, last_name)
VALUES
  ('Jennifer', 'Finch'),
  ('Thadeus', 'Gathercoal'),
  ('Sonja', 'Pauley'),
  ('Jennifer', 'Finch'),
  ('Waneta', 'Skeleton'),
  ('Thadeus', 'Gathercoal'),
  ('Berkie', 'Wycliff'),
  ('Alvin', 'Leathes'),
  ('Berkie', 'Wycliff'),
  ('Cory', 'Squibbes')
;

INSERT INTO itinerary
  (ticket_id, ticket_seq, airline_code, seat, boarding, departure, departure_airport_code, arrival, arrival_airport_code)
VALUES
  ( 1, 1, 'UA',  '33B', '2018-04-08 08:40:00', '2018-04-08 09:00:00', 'DCA', '2018-04-08 12:00:00', 'SEA'), 
  ( 2, 1, 'BA',  '8A',  '2018-12-19 12:25:00', '2018-12-19 12:45:00', 'NRT', '2018-12-19 16:15:00', 'LHR'), 
  ( 3, 1, 'DL',  '12F', '2018-01-02 06:40:00', '2018-01-02 07:00:00', 'LAX', '2018-01-02 08:03:00', 'LAS'), 
  ( 4, 1, 'DL',  '20A', '2018-04-15 16:30:00', '2018-04-15 16:50:00', 'SEA', '2018-04-15 21:00:00', 'MEX'), 
  ( 5, 1, 'TB',  '23D', '2018-08-01 18:10:00', '2018-08-01 18:30:00', 'CDG', '2018-08-01 21:50:00', 'CMN'), 
  ( 6, 1, 'CA',  '18C', '2018-10-31 12:55:00', '2018-10-31 01:15:00', 'DXB', '2018-10-31 12:55:00', 'PEK'), 
  ( 7, 1, 'UA',  '9E',  '2019-02-06 05:40:00', '2019-02-06 06:00:00', 'LGA', '2019-02-06 07:47:00', 'CLT'), 
  ( 8, 1, 'AA',  '1A',  '2018-12-22 14:22:00', '2018-12-22 14:42:00', 'CID', '2018-12-22 15:56:00', 'ORD'), 
  ( 9, 1, 'AA',  '32B', '2019-02-06 16:08:00', '2019-02-06 16:28:00', 'CLT', '2019-02-06 19:18:00', 'MSY'), 
  (10, 1, 'BTQ', '10D', '2019-01-20 19:10:00', '2019-01-20 19:30:00', 'GRU', '2019-01-20 22:45:00', 'SCL')  
;

-- create indexes
CREATE INDEX tickets_lname_idx ON tickets (last_name);
CREATE INDEX itinerary_tix_seq_idx ON itinerary (ticket_id, ticket_seq);

SELECT first_name, last_name, airline, seat, from_city, from_country, departure, to_city, to_country, arrival
FROM tickets_old 
ORDER BY  last_name, first_name
;

SELECT first_name, last_name, airline_name, seat, CONCAT(departure_airport_code, ': ', LEFT(dep.airport_name, 20)) AS from_airport
  , CONCAT(dep.airport_city, ', ', ctry_d.country_name) AS departure_city_country, boarding, departure
  , CONCAT(arrival_airport_code, ': ', LEFT(arr.airport_name, 20)) AS to_airport
  , CONCAT(arr.airport_city, ', ', ctry_a.country_name) AS arrival_city_country, arrival   
FROM tickets tix 
  JOIN itinerary itin ON tix.id = itin.ticket_id 
  JOIN airlines ON itin.airline_code = airlines.airline_code 
  JOIN airports dep ON departure_airport_code = dep.code_iata 
  JOIN airports arr ON arrival_airport_code = arr.code_iata 
  JOIN countries ctry_d ON dep.airport_country_id = ctry_d.id 
  JOIN countries ctry_a ON arr.airport_country_id = ctry_a.id 
ORDER BY last_name, first_name
;
