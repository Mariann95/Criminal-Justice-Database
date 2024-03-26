-- Add locations
INSERT INTO "locations" ("country", "zip_code", "state/county", "city")
VALUES
    ('United States', '12345', 'California', 'Los Angeles'),
    ('United States', '67890', 'New York', 'New York City'),
    ('United States', '54321', 'Texas', 'Houston'),
    ('Hungary', '6725', 'Csongrád', 'Szeged'),
    ('Germany', '10115', 'Berlin', 'Berlin'),
    ('Italy', '00100', 'Lazio', 'Rome'),
    ('Spain', '46001', 'Valencian Community', 'Smalltownia'),
    ('France', '75001', 'Ile-de-France', 'Paris'),
    ('Japan', '100-0001', 'Tokyo', 'Tokyo'),
    ('Australia', '2000', 'New South Wales', 'Sydney'),
    ('Brazil', '20040-010', 'Rio de Janeiro', 'Rio de Janeiro'),
    ('South Africa', '8001', 'Western Cape', 'Cape Town'),
    ('Russia', '101000', 'Moscow', 'Moscow'),
    ('India', '110001', 'Delhi', 'New Delhi'),
    ('China', '100000', 'Beijing', 'Beijing'),
    ('Argentina', 'C1002AAH', 'Buenos Aires', 'Buenos Aires'),
    ('South Korea', '04548', 'Seoul', 'Seoul'),
    ('Nigeria', '23401', 'Lagos', 'Lagos'),
    ('Sweden', '111 20', 'Stockholm', 'Stockholm'),
    ('Egypt', '11511', 'Cairo', 'Cairo'),
    ('Switzerland', '1000', 'Geneva', 'Geneva'),
    ('Australia', '3000', 'Victoria', 'Melbourne'),
    ('United States', '30301', 'Georgia', 'Atlanta'),
    ('Spain', '08001', 'Catalonia', 'Barcelona'),
    ('Japan', '100-0005', 'Tokyo', 'Chiyoda');

-- Add courts
INSERT INTO "courts" ("court_name", "court_location")
VALUES
    ('Alabama Court of Criminal Appeals', 23),
    ('Tennessee Supreme Court', 24),
    ('Federal Court of Justice Germany', 22),
    ('Szeged Regional Court of Appeal', 25);

-- Add prisons
INSERT INTO "prisons" ("name", "prison_location", "security_level")
VALUES
    ('Alcatraz', 1, 'High'),
    ('Sing Sing', 3, 'Medium'),
    ('Kingston Penitentiary', 7, 'High');

-- Add cells
INSERT INTO "cells" ("cell_name", "capacity", "cell_type", "prison_id")
VALUES
    ("58EO", 5, 'Supermax', 1),
    ("HUT85", 1, 'Single', 1),
    ("XG022", 2, 'Double', 2),
    ("90036H", 6, 'Specialized unit', 2),
    ("UPG05", 20, 'Dormitory-style housing', 3),
    ("4425", 2, 'Double', 3),
    ("PUR888", 6, 'Solitary confinement', 3);

-- Add prisoners
INSERT INTO "prisoners" ("first_name", "last_name", "id_number", "race_group", "gender", "date_of_birth", "date_of_death", "birth_location", "contact_number", "escape_times", "prison_id", "cell_id", "is_active")
VALUES
    ('Michael', 'Johnson', '555111222', 'Black/African American', 'Male', '1983-04-18', NULL, 2, '555-9999', NULL, 1, 1, true),
    ('Sarah', 'White', '777888999', 'White', 'Female', '1990-11-05', NULL, 4, '555-1111', 1, 1, 2, true),
    ('Carlos', 'Gonzalez', '888999000', 'American Indian/Alaska Native', 'Male', '1987-08-12', NULL, 5, '555-3333', NULL, 1, 1, true),
    ('Emily', 'Lee', '111222333', 'Asian', 'Female', '1995-02-22', NULL, 6, '555-4444', 2, 2, 3, true),
    ('Daniel', 'Smith', '222333444', 'White', 'Male', '1980-09-28', NULL, 8, '555-6666', NULL, 2, 4, true),
    ('Isabella', 'Lopez', '333444555', 'American Indian/Alaska Native', 'Female', '1988-06-15', NULL, 9, '555-2222', NULL, 2, 4, true),
    ('Liam', 'Taylor', '444555666', 'White', 'Male', '1972-12-30', NULL, 12, '555-7777', NULL, 3, 5, true),
    ('Sophia', 'Martin', '666777888', 'Black/African American', 'Female', '1984-07-11', NULL, 11, '555-8888', NULL, 3, 6, true),
    ('Miguel', 'Garcia', '999000111', 'American Indian/Alaska Native', 'Male', '1986-03-07', NULL, 10, '555-1234', NULL, 3, 5, true);

-- Add crimes
INSERT INTO "crimes" ("crime_type", "datetime", "crime_location")
VALUES
    ('Assault', '2023-01-15 10:30:00', 13),
    ('Fraud', '2023-02-20 15:45:00', 14),
    ('Drug cases', '2023-03-05 08:00:00', 15),
    ('Arson', '2024-03-20 17:45:00', 18),
    ('Human smuggling', '2024-03-05 11:30:00', 19),
    ('Sex crimes', '2024-04-10 01:20:00', 19),
    ('Money laundering', '2024-04-10 20:00:00', 17),
    ('Robbery', '2024-03-20 18:00:00', 21),
    ('Homicide', '2024-03-25 03:30:00', 20),
    ('Cybercrime', '2024-03-03 12:00:00', 16);

-- Add sentences
INSERT INTO "sentences" ("sentence_type", "crime_id", "duration", "start_date", "end_date", "parole", "parole_date", "prison_id")
VALUES
    ('Imprisonment', 1, '5 years', '2024-05-01', '2029-05-01', false, NULL, 1),
    ('Life imprisonment', 2, 'Life', '2024-04-10', NULL, false, NULL, 2),
    ('Mandatory minimum', 3, '10 years', '2024-04-15', '2034-04-15', true, '2030-04-15', 1),
    ('Probation with imprisonment', 4, '3 years', '2024-04-10', '2027-03-20', true, '2026-01-01', 3),
    ('Consecutive', 5, '15 years', '2024-03-25', '2039-03-25', true, '2035-03-25', 1),
    ('Consecutive', 6, '5 years', NULL, '2044-03-25', false, NULL, 1),
    ('Imprisonment', 7, '8 years', '2024-04-25', '2032-04-26', false, NULL, 1),
    ('Life imprisonment', 8, 'Life', '2024-04-16', NULL, false, NULL, 2),
    ('Mandatory minimum', 9, '12 years', '2024-04-15', '2036-04-15', true, '2032-04-15', 3),
    ('Probation with imprisonment', 10, '4 years', '2024-03-28', '2028-03-20', true, '2027-01-01', 1);

-- Add visits
INSERT INTO "visits" ("prisoner_id", "prison_id", "visitor_name", "visitdatetime", "visit_duration_minutes")
VALUES
    (1, 1, 'John Doe', '2024-05-01 14:30:00', 60),
    (2, 1, 'Mary Johnson', '2024-05-02 10:00:00', 45),
    (3, 1, 'David Rodriguez', '2024-05-03 16:15:00', 30),
    (4, 2, 'Emma Brown', '2024-05-05 09:45:00', 75),
    (4, 2, 'Keely Black', '2024-06-08 08:35:00', 30),
    (5, 2, 'Christopher Kim', '2024-05-07 13:00:00', 90),
    (6, 2, 'Alma Harvey', '2024-06-15 14:27:00', 60),
    (8, 3, 'Micah Arnold', '2024-12-05 16:05:00', 10);

-- Make connections between the prisoners and the crimes
INSERT INTO "prisoner_crime" ("prisoner_id", "crime_id")
VALUES
    (1, 3),
    (1, 5),
    (2, 2),
    (3, 9),
    (4, 4),
    (5, 5),
    (5, 6),
    (6, 10),
    (7, 8),
    (8, 7),
    (9, 1);

-- Make connections between the crimes and the courts
INSERT INTO "court_case" ("court_id", "crime_id", "case_law_identifier", "hearing_datetime")
VALUES
    (1, 1, "X456Y", '2024-01-15 12:00:00'),
    (2, 2, "L234P", '2023-12-05 09:42:00'),
    (3, 3, "ZAB567", '2023-05-12 08:00:00'),
    (4, 4, "Q23R", '2024-04-01 14:05:00'),
    (4, 5, "PQ678RS", '2024-03-15 10:35:00'),
    (2, 6, "K901JKL", '2024-03-15 10:35:00'),
    (3, 7, "123ABC", '2024-04-11 11:18:00'),
    (4, 8, "FG890H", '2024-04-01 09:22:00'),
    (1, 9, "WXY567Z", '2024-04-10 08:07:00'),
    (2, 10, "UV12", '2024-03-20 15:12:00');


-- Typical queries that users will commonly run in the database
-- 1. Find which cell is in a prisoner given the prisoner first and last name
SELECT "cell_name", "prison_name"
FROM "prisoner_and_cell_info"
WHERE "first_name" = 'Emily' AND "last_name" = 'Lee';

-- 2. List all the prisoners name(s) in a specific cell given the cell name
SELECT "first_name", "last_name"
FROM "prisoner_and_cell_info"
WHERE "cell_name" = '58EO';

-- 3. What is the active prisoners distribution by race group
SELECT "race_group", COUNT(*) AS "prisoners", ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM "prisoners" WHERE "is_active" = true), 1) AS "percentage"
FROM "prisoners"
WHERE "is_active" = true
GROUP BY "race_group";

-- 4. What is the active prisoners distribution by gender in a specific prison
SELECT "gender", COUNT(*) AS "prisoners", ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM "prisoner_and_cell_info" WHERE "prison_name" = 'Alcatraz'), 1) AS "percentage"
FROM "prisoner_and_cell_info"
WHERE "prison_name" = 'Alcatraz'
GROUP BY "gender";

-- 5. Update the contact number for a prisoner given the prisoner first and last name
UPDATE "prisoners"
SET "contact_number" = '685-12994'
WHERE "prisoners"."first_name" = 'Miguel' AND "prisoners"."last_name" = 'Garcia';

-- 6. What is the capacity of a prison given the prison name
SELECT "prison_name", SUM("total_capacity") AS "total_capacity", SUM("available_capacity") AS "available_capacity"
FROM "prisons_capacity_and_available_capacity"
WHERE "prison_name" = 'Sing Sing'
GROUP BY "prison_name";

-- 7. List all the cell names in a given prison along with their capacity and available capacity
SELECT "prison_name", "cell_name", "total_capacity", "available_capacity"
FROM "prisons_capacity_and_available_capacity"
WHERE "prison_name" = 'Alcatraz';

-- 8. What crimes a prisoner committed and what sentence the crime resulted in given the prisoner first name and last name
SELECT *
FROM "prisoner_crime_court_sentence"
WHERE "first_name" = 'Daniel' AND "last_name" = 'Smith';

-- 9. Which court heard and where and when a prisoner crime given the prisoner first name and last name
SELECT "court_name", "hearing_datetime", "country", "zip_code", "state/county", "city"
FROM "prisoner_crime_court_sentence"
JOIN "locations" ON "prisoner_crime_court_sentence"."court_location" = "locations"."id"
WHERE "first_name" = 'Emily' AND "last_name" = 'Lee';

-- 10. List of all the visits a prisoner got by first name, last name
SELECT *
FROM "prisoner_visitors"
WHERE "first_name" = 'Emily' AND "last_name" = 'Lee'
ORDER BY "visitdatetime";

-- 11. Test the triggers:
    -- Insert into a prisoners table a new prisoner
    INSERT INTO "prisoners" ("first_name", "last_name", "id_number", "race_group", "gender", "date_of_birth", "date_of_death", "birth_location", "contact_number",
        "escape_times", "prison_id", "cell_id", "is_active")
    VALUES ('John', 'Doe', '123456789', 'White', 'Male', '1980-01-01', NULL, 1, '555-1234', 0, 1, 1, true);

    -- Modify the prisoners table that a prisoner gets relocated
    UPDATE "prisoners"
    SET "cell_id" = '1', "prison_id" = '1'
    WHERE "first_name" = 'Emily' AND "last_name" = 'Lee';

    -- Modify the prisoners table that a prisoner escaped
    UPDATE "prisoners"
    SET "cell_id" = NULL, "prison_id" = NULL, "escape_times" = 3
    WHERE "first_name" = 'Emily' AND "last_name" = 'Lee';

    -- Modify the prisoners table that a prisoner died
    UPDATE "prisoners"
    SET "is_active" = false, "cell_id" = NULL, "prison_id" = NULL, "date_of_death" = '2024-04-05'
    WHERE "first_name" = 'John' AND "last_name" = 'Doe';

    -- Modify the prisoners table that a prisoner is released
    UPDATE "prisoners"
    SET "is_active" = false, "cell_id" = NULL, "prison_id" = NULL
    WHERE "first_name" = 'Liam' AND "last_name" = 'Taylor';

    -- Modify the prisoners table that a prisoner is imprisoned again
    UPDATE "prisoners"
    SET "is_active" = true, "cell_id" = '5', "prison_id" = '3'
    WHERE "first_name" = 'Liam' AND "last_name" = 'Taylor';

    -- Modify the prisoners table that a prisoner is imprisoned again after escape
    UPDATE "prisoners"
    SET "cell_id" = '5', "prison_id" = '3'
    WHERE "first_name" = 'Emily' AND "last_name" = 'Lee';


-- 12. List all of the activities given the prisoner first name and last name
SELECT "first_name", "last_name", COALESCE("prisons"."name", 'Unknown') AS "prison_name", COALESCE("cells"."cell_name", 'Unknown') AS "cell_name", "action", "datetime"
FROM "activity_log"
LEFT JOIN "cells" ON "activity_log"."current_cell_id" = "cells"."id"
LEFT JOIN "prisons" ON "cells"."prison_id" = "prisons"."id"
JOIN "prisoners" ON "activity_log"."prisoner_id" = "prisoners"."id"
WHERE "first_name" = 'Emily' AND "last_name" = 'Lee';


-- Extra queries
-- 1. Order the countries by the amount of crimes in 2024 in descending order.
SELECT "country", COUNT("crime_id") AS "amount"
FROM "locations"
JOIN "crimes" ON "locations"."id" = "crimes"."crime_location"
WHERE "datetime" BETWEEN '2024-01-01 00:00:00' AND '2024-12-31 23:59:59'
GROUP BY "country"
ORDER BY "amount" DESC;

-- 2. What is the average days between a crime is committed and the hearing of the case in court
SELECT ROUND(AVG(julianday("hearing_datetime") - julianday("crime_date")), 1) AS average_days_between
FROM "prisoner_crime_court_sentence";

-- 3. How many crimes resulted in life imprisonment
SELECT "crime_type", COUNT("crime_id") AS "amount"
FROM "prisoner_crime_court_sentence"
WHERE "sentence_type" = 'Life imprisonment'
GROUP BY "crime_type";

-- 4. How many cases each court heared in a given year
SELECT "court_name", COUNT(*) AS "heard_cases"
FROM "prisoner_crime_court_sentence"
WHERE "hearing_datetime" BETWEEN '2024-01-01 00:00:00' AND '2024-12-31 23:59:59'
GROUP BY "court_name";

-- 5. What percentage of sentences have parole
SELECT (COUNT(*) FILTER (WHERE "parole" = 1) * 100.0) / COUNT(*) AS "parole_percentage"
FROM "sentences";

-- 6. What is the name and location of the prison, that had the most visitors in 2024
SELECT "prison_name", COUNT("visit_id") AS visit_count, "country", "zip_code", "state/county", "city"
FROM "prisoner_visitors"
WHERE "visitdatetime" BETWEEN '2024-01-01 00:00:00' AND '2024-12-31 23:59:59'
GROUP BY "prison_name"
ORDER BY visit_count DESC
LIMIT 1;

-- 7. List all the prisons along with the escape times
SELECT "prisons"."name", COALESCE(COUNT(*) FILTER (WHERE "action" = 'Escaped'), 0) AS "escape_times"
FROM "activity_log"
JOIN "cells" ON "activity_log"."previous_cell_id" = "cells"."id"
JOIN "prisons" ON "cells"."prison_id" = "prisons"."id"
GROUP BY "prisons"."name";
