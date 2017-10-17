/* Create planetary db */

CREATE TABLE stars (
  id serial PRIMARY KEY,
  name varchar(25) NOT NULL UNIQUE,
  distance integer NOT NULL CHECK (distance > 0),
  spectral_type char(1),
  companions integer NOT NULL CHECK (distance > 0)
);

CREATE TABLE planets (
  id serial PRIMARY KEY,
  designation char(1),
  mass integer
);

/* Relate tables */
ALTER TABLE planets
ADD COLUMN star_id integer NOT NULL
REFERENCES stars;
/*
  don't need starts (id) -
  planet FOREIGN KEY of will default reference PRIMARY KEY of stars
*/

/* Lengthen star name */
ALTER TABLE stars
ALTER COLUMN name TYPE varchar(50);

/* Make distance use decimals to any length */
ALTER TABLE stars
ALTER COLUMN distance TYPE numeric;

/* Enforce valid star name */
ALTER TABLE stars
-- ADD CONSTRAINT check_spectral_type CHECK (spectral_type ~ '[OBAFGKM]'),
ADD CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')); also works
ALTER COLUMN spectral_type SET NOT NULL;

/* Use enum as check */
ALTER TABLE stars
DROP CONSTRAINT stars_spectral_type_check;
CREATE TYPE spectral_types AS ENUM ('O', 'B', 'A', 'F', 'G', 'K', 'M');

ALTER TABLE stars
ALTER COLUMN spectral_type TYPE spectral_types
                           USING spectral_type::spectral_types;

/* Make mass decimal flexible and more */
ALTER TABLE planets
ALTER COLUMN mass TYPE numeric,
ALTER COLUMN mass SET NOT NULL,
ADD CHECK (mass > 0),
ALTER COLUMN designation SET NOT NULL;

/* Add column semi_major_axis*/
ALTER TABLE planets
ADD COLUMN semi_major_axis numeric NOT NULL DEFAULT 0;

/* Create moons db*/
CREATE TABLE moons (
  id serial PRIMARY KEY,
  designation integer NOT NULL CHECK (designation > 0),
  semi_major_axis integer CHECK (semi_major_axis > 0),
  mass integer CHECK (semi_major_axis > 0),
  planet_id integer REFERENCES planets
);
