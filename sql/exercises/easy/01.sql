/* Prevent negative values for age after table was created */
ALTER TABLE birds ADD CONSTRAINT check_age CHECK (age > 0);
