-- Run me on the database for the HGMJ app using:
--   heroku pg:psql --app hgmj < create_drop.sql

-- Remember that PostgreSQL will changes the names of columns, tables, etc
-- to all lower case unless quotation marks are used.

DROP TABLE IF EXISTS RealWorldAddress;
CREATE TABLE RealWorldAddress
(
    code VARCHAR(99) PRIMARY KEY,
    short_name VARCHAR(99) NOT NULL,
    house_name VARCHAR(99),
    house_number INT,
    road_name VARCHAR(99),
    post_town VARCHAR(99),
    postcode VARCHAR(99)
);

DROP TABLE IF EXISTS Contact;
CREATE TABLE Contact
(
    code VARCHAR(99) PRIMARY KEY,
    short_name VARCHAR(99) NOT NULL,
    full_name VARCHAR(99) NOT NULL,
    landline VARCHAR(99),
    mobile VARCHAR(99),
    email VARCHAR(99),
    address VARCHAR(99),
    CONSTRAINT fk_address
        FOREIGN KEY(haddress)
            REFERENCES RealWorldAddress(code)
);

DROP TABLE IF EXISTS ServiceTime;
CREATE TABLE ServiceTime
(
    id SERIAL PRIMARY KEY,
    weekday INT NOT NULL DEFAULT 0, -- 0 = Sunday.
    hours INT NOT NULL DEFAULT 12, -- In twenty-four hour time.
    minutes INT NOT NULL DEFAULT 0,
    length_in_minutes INT,
    location VARCHAR(99) NOT NULL DEFAULT 'st-marys-edlington',
    one_off BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_location
        FOREIGN KEY(location)
            REFERENCES RealWorldAddress(code)
)