/* Create workshop db with device and part tables */

CREATE TABLE devices (
  id serial PRIMARY KEY,
  name text NOT NULL,
  created_at timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE parts (
  id serial PRIMARY KEY,
  part_number integer NOT NULL UNIQUE,
  device_id integer REFERENCES devices
);

/* Create two devices */
INSERT INTO devices(name) VALUES
  ('Accelerometer'),
  ('Gyroscope');

-- SELECT random() * 1000 + 1 AS RAND_1_1000;
INSERT INTO parts (part_number) VALUES
  (random() * 1000 + 1);

INSERT INTO parts (part_number, device_id) VALUES
  (random() * 1000 + 1, 1),
  (random() * 1000 + 1, 1),
  (random() * 1000 + 1, 1),
  (random() * 1000 + 1, 2),
  (random() * 1000 + 1, 2),
  (random() * 1000 + 1, 2),
  (random() * 1000 + 1, 2),
  (random() * 1000 + 1, 2);

INSERT INTO parts (part_number) VALUES
  (random() * 1000 + 1),
  (random() * 1000 + 1),
  (random() * 1000 + 1);

/*
  Write an SQL query to display all devices along with all the parts that make them up. We only want to display the name of the devices. It's parts should only display the part_number.
*/

SELECT devices.name, parts.part_number
FROM devices
  INNER JOIN parts ON (parts.device_id = devices.id);

/*
  We want to grab all parts that have a part_number that starts with 3. Write a SELECT query to get this information. This table may show all attributes of the parts table.
*/

SELECT *
FROM parts
WHERE 8 = floor(part_number / power(10, floor(log(part_number))));
/* Or using typecasting to text */
-- WHERE part_number::text LIKE '3%' -- Solution using Postgres typecasting
-- SELECT * FROM parts WHERE CAST(part_number AS text) like '3%'; -- SQL standard alternative

/*
  Write an SQL query that returns a result table with the name of each device in our database together with the number of parts for that device.
*/
SELECT devices.name, COUNT(parts.id)
FROM devices
  INNER JOIN parts ON (parts.device_id = devices.id)
GROUP BY devices.name
ORDER BY count ASC;

/* One that generates a listing of parts that currently belong to a device. */
SELECT parts.part_number, parts.device_id
FROM parts
WHERE device_id IS NOT NULL;

/* One that generates a listing of parts that don't belong to a device. */
SELECT parts.part_number, parts.device_id
FROM parts
WHERE device_id IS NULL;

/*
  Write an SQL statement that will return the name of the oldest device from our devices table.
*/
SELECT *
FROM devices
ORDER BY created_at DESC
LIMIT 1;
/* Selects all rows equal to lowest created_at value */
-- SELECT * FROM devices WHERE created_at IN (SELECT MIN(created_at) FROM devices);


/*
  Write an SQL statement that will associate the last two parts from our parts table with an "Accelerometer" instead of a "Gyroscope".
*/
UPDATE parts
SET device_id = 1
WHERE part_number IS NULL;

/* Set the part with the smallest part_number to be associated with "Gyroscope" */
UPDATE parts
SET device_id = 1
WHERE part_number IN (SELECT min(part_number) FROM parts WHERE device_id = 2 LIMIT 1);


DELETE FROM parts
WHERE device_id = (SELECT id FROM devices WHERE name = 'Accelerometer');

DELETE FROM devices
WHERE name = 'Accelerometer';

/* To change table so associated parts are automatically deleted when associated device is deleted*/
ALTER TABLE parts
  DROP CONSTRAINT parts_device_id_fkey,
  ADD CONSTRAINT parts_device_id_fkey
    FOREIGN KEY (device_id) REFERENCES devices(id) ON DELETE CASCADE;
