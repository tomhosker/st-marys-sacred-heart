-- Run me on the database for the HGMJ app using:
--     heroku pg:psql --app hgmj < create_drop.sql

-- Remember that PostgreSQL will changes the names of columns, tables, etc
-- to all lower case unless quotation marks are used.

DROP TABLE IF EXISTS Newsletter;
DROP TABLE IF EXISTS ParishRole;
DROP TABLE IF EXISTS ServiceTime;
DROP TABLE IF EXISTS Contact;
DROP TABLE IF EXISTS RealWorldAddress;

CREATE TABLE RealWorldAddress (
    code VARCHAR(99) PRIMARY KEY,
    short_name VARCHAR(99) NOT NULL,
    house_name VARCHAR(99),
    house_number INT,
    road_name VARCHAR(99),
    town VARCHAR(99),
    post_town VARCHAR(99),
    postcode VARCHAR(99)
);

CREATE TABLE Contact (
    code VARCHAR(99) PRIMARY KEY,
    short_name VARCHAR(99) NOT NULL,
    full_name VARCHAR(99) NOT NULL,
    landline VARCHAR(99),
    mobile VARCHAR(99),
    email VARCHAR(99),
    address VARCHAR(99),
    CONSTRAINT fk_address
        FOREIGN KEY(address)
            REFERENCES RealWorldAddress(code)
);

CREATE TABLE ServiceTime (
    id SERIAL PRIMARY KEY,
    weekday INT NOT NULL DEFAULT -1, -- 0 = Sunday.
    day INT, -- Day of the month.
    month INT, -- 0 = January, 11 = December.
    year INT,
    hours INT NOT NULL DEFAULT 12, -- In twenty-four hour time.
    minutes INT NOT NULL DEFAULT 0,
    location VARCHAR(99) NOT NULL DEFAULT 'st-marys-edlington',
    service_type VARCHAR(99) NOT NULL DEFAULT 'Mass',
    remarks VARCHAR(99),
    CONSTRAINT fk_location
        FOREIGN KEY(location)
            REFERENCES RealWorldAddress(code)
);

CREATE TABLE ParishRole (
    code VARCHAR(99) PRIMARY KEY,
    description VARCHAR(99) NOT NULL DEFAULT 'INSERT ROLE DESCRIPTION HERE',
    contact VARCHAR(99) NOT NULL DEFAULT 'father-john',
    CONSTRAINT fk_contact
        FOREIGN KEY(contact)
            REFERENCES Contact(code)
);

CREATE TABLE Newsletter (
    id SERIAL PRIMARY KEY,
    week_beginning_day INT NOT NULL DEFAULT 1, -- Day of the month
    week_beginning_month INT NOT NULL DEFAULT 0, -- 0 = January, 11 = December.
    week_beginning_year INT NOT NULL DEFAULT 2000,
    link VARCHAR(99) NOT NULL DEFAULT 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
);
