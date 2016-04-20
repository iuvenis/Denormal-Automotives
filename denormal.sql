DROP ROLE denormal_user;

DROP DATABASE denormal_cars;
-----______------______------______------_____

CREATE USER denormal_user;

CREATE DATABASE denormal_cars;

ALTER DATABASE denormal_cars OWNER TO denormal_user;

\c denormal_cars
\i scripts/denormal_data.sql
\dS car_models

SELECT DISTINCT make_title FROM car_models;

SELECT DISTINCT model_title FROM car_models
WHERE make_code = 'VOLKS';

SELECT make_code, model_code, model_title FROM car_models
WHERE make_code = 'LAM';

SELECT * FROM car_models
WHERE year BETWEEN  2010 AND  2015;




