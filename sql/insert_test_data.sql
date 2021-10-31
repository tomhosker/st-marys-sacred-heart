-- This code adds some test data to the database.

-- Run me using:
--   heroku pg:psql --app [APP_CODE] < create_drop.sql

INSERT INTO RealWorldAddress (
    code,
    short_name,
    house_name,
    house_number,
    road_name,
    town,
    post_town,
    postcode
) VALUES (
    'st-marys-edlington',
    'St Mary''s Edlington',
    'St Mary''s Catholic Church',
    null,
    'Bungalow Road',
    'Edlington',
    'Doncaster',
    'DN12 1DL'
), (
    'sacred-heart-balby',
    'Sacred Heart Balby',
    'Sacred Heart Catholic Church',
    44,
    'Warmsworth Road',
    'Balby',
    'Doncaster',
    'DN4 0RR'
);

INSERT INTO Contact (
    code,
    short_name,
    full_name,
    landline,
    mobile,
    email,
    address
) VALUES (
    'father-john',
    'Father John',
    'The Reverend Father John Adikwu',
    '01302859167',
    '07485609642',
    'sacredheartandstmary@gmail.com',
    'sacred-heart-balby'
), (
    'tom-hosker',
    'Tom',
    'Thomas Hosker',
    '01302751132',
    '07312121996',
    'tomdothosker@gmail.com',
    null
);

INSERT INTO ServiceTime (
    id,
    weekday,
    day,
    month,
    year,
    hours,
    minutes,
    location,
    service_type,
    remarks
) VALUES (
    1,
    6,
    18,
    0,
    'st-marys-edlington',
    'Mass',
    null,
    null,
    null,
    null
);

INSERT INTO ParishRole (
    code,
    description,
    contact
) VALUES (
    'parish-priest',
    'Parish Priest',
    'father-john'
), (
    'computer-guy',
    'Computer Guy',
    'tom-hosker'
);

CREATE TABLE Newsletter (
    id SERIAL PRIMARY KEY,
    week_beginning_day INT NOT NULL DEFAULT 1, -- Day of the month
    week_beginning_month INT NOT NULL DEFAULT 0, -- 0 = January, 11 = December.
    week_beginning_year INT NOT NULL DEFAULT 2000,
    link VARCHAR(99) NOT NULL DEFAULT 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
);

INSERT INTO Newsletter (
    id,
    week_beginning_day,
    week_beginning_month,
    week_beginning_year,
    link
) VALUES (
    1,
    25,
    9,
    2021,
    'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
);
