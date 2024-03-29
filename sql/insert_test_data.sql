-- This code adds some test data to the database.

-- Run me using:
--   heroku pg:psql --app [APP_CODE] < [PATH_TO_SCRIPT].sql

INSERT INTO UserLoginDetails (
    id,
    username,
    hashed_password
) VALUES (
    1,
    'admin',
    '84983c60f7daadc1cb8698621f802c0d9f9a3c3c295c810748fb048115c186ec' -- Hash of "guest".
);

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
    has_childrens_liturgy,
    childrens_liturgy_remarks,
    remarks
) VALUES (
    1,
    6,
    null,
    null,
    null,
    18,
    0,
    'st-marys-edlington',
    'Mass',
    true,
    null,
    null
), (
    2,
    0,
    null,
    null,
    null,
    9,
    0,
    'sacred-heart-balby',
    'Mass',
    true,
    'Only on the first and third Sundays of each month.',
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

INSERT INTO Pilgrimage (
    id,
    destination,
    start_day,
    start_month,
    end_day,
    end_month,
    end_year,
    email,
    telephone,
    other_text
) VALUES (
    1,
    'Lourdes',
    24,
    5,
    30,
    5,
    3000,
    'hallamlourdespilgrimage@gmail.com',
    '01302247910',
    'See <a href="https://www.hallam-lourdes.com/">the Hallam Lourdes website</a> for further information.'
);

INSERT INTO OtherDocument (
    name
) VALUES (
    'Test'
);
