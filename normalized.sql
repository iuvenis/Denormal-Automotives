
DROP DATABASE IF EXISTS normal_cars;
-----______------______------______------_____

CREATE USER normal_user;

CREATE DATABASE normal_cars;

ALTER DATABASE normal_cars OWNER TO normal_user;

\c normal_cars;
\i scripts/denormal_data.sql;
\dS car_models;

CREATE TABLE maker (
  id SERIAL UNIQUE PRIMARY KEY,
  make_code varchar(125),
  make_title varchar(125)
);

CREATE TABLE models (
  id SERIAL UNIQUE PRIMARY KEY,
  model_code varchar(125),
  model_title varchar(125)
);

CREATE TABLE cars (
  id SERIAL UNIQUE PRIMARY KEY,
  models_id INTEGER REFERENCES models(id),
  maker_id  INTEGER REFERENCES maker(id),
  year INTEGER
  );

INSERT INTO maker (make_title, make_code)
  SELECT DISTINCT make_title, make_code
  FROM car_models;

INSERT INTO models (model_title, model_code)
  SELECT DISTINCT car_models.model_title, car_models.model_code
  FROM car_models;

INSERT INTO cars (models_id, maker_id, year)
  SELECT models.id, maker.id, year
  FROM models, maker, car_models
  WHERE maker.make_title = car_models.make_title
  AND maker.make_code    = car_models.make_code
  AND models.model_title = car_models.model_title
  AND models.model_code  = car_models.model_code;

SELECT maker.make_title FROM cars;

-- Create a query to get a list of all make_title values in the car_models table. (should have 71 results)

SELECT DISTINCT make_code FROM maker;


-- Create a query to list all model_title values where the make_code is 'VOLKS' (should have 27 results)

SELECT DISTINCT models.model_title
FROM cars
INNER JOIN models
ON (cars.models_id = models.id)
Inner JOIN maker
ON (cars.maker_id = maker.id)
WHERE maker.make_code = 'VOLKS';

-- Create a query to list all make_code, model_code, model_title, and year from car_models where the make_code is 'LAM' (should have 136 rows)

SELECT  models.model_title, models.model_code, maker.make_title, maker.make_code
FROM cars
INNER JOIN models
ON (cars.models_id = models.id)
Inner JOIN maker
ON (cars.maker_id = maker.id)
WHERE maker.make_code = 'LAM';

-- Create a query to list all fields from all car_models in years between 2010 and 2015 (should have 7884 rows)

SELECT  *
FROM cars
INNER JOIN models
ON (cars.models_id = models.id)
Inner JOIN maker
ON (cars.maker_id = maker.id)
WHERE year BETWEEN 2010 AND 2015;