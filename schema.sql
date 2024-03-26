-- Represent sentenced prisoners in a cell in a prison
CREATE TABLE "prisoners" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL DEFAULT 'Under identification',
    "last_name" TEXT NOT NULL DEFAULT 'Under identification',
    "id_number" TEXT NOT NULL DEFAULT 'Under identification',
    "race_group" TEXT NOT NULL CHECK("race_group" IN('White', 'Black/African American', 'American Indian/Alaska Native', 'Asian', 'Native Hawaiian/Other Pacific Islander',
        'Hispanic', 'Multiracial or some other race')),
    "gender" TEXT NOT NULL CHECK("gender" IN('Female', 'Male')),
    "date_of_birth" NUMERIC,
    "date_of_death" NUMERIC DEFAULT NULL,
    "birth_location" INTEGER,
    "contact_number" TEXT,
    "escape_times" INTEGER DEFAULT NULL,
    "prison_id" INTEGER,
    "cell_id" INTEGER,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    PRIMARY KEY("id"),
    FOREIGN KEY("birth_location") REFERENCES "locations"("id"),
    FOREIGN KEY("prison_id") REFERENCES "prisons"("id"),
    FOREIGN KEY("cell_id") REFERENCES "cells"("id")
);

-- Represent crimes committed by prisoners
CREATE TABLE "crimes" (
    "id" INTEGER,
    "crime_type" TEXT NOT NULL CHECK("crime_type" IN('Arms trafficking', 'Arson', 'Assault', 'Corporate crime', 'Counterfeiting', 'Crimes against morality', 'Cybercrime',
        'Drug cases', 'Felony', 'Fraud', 'Gun crimes', 'Hate crime', 'Homicide', 'Human smuggling', 'Money laundering', 'Offense', 'Organised crime', 'Police investigation',
        'Rape', 'Robbery', 'Sex crimes', 'Vehicle crime', 'Victimless crime', 'Violent crime')),
    "datetime" NUMERIC DEFAULT CURRENT_TIMESTAMP,
    "crime_location" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("crime_location") REFERENCES "locations"("id")
);

-- Junction table between crimes and prisoners
CREATE TABLE "prisoner_crime" (
    "prisoner_id" INTEGER,
    "crime_id" INTEGER,
    PRIMARY KEY("prisoner_id", "crime_id"),
    FOREIGN KEY("prisoner_id") REFERENCES "prisoners"("id"),
    FOREIGN KEY("crime_id") REFERENCES "crimes"("id")
);

-- Represent sentences decided by courts that will be served in prisons
CREATE TABLE "sentences" (
    "id" INTEGER,
    "sentence_type" TEXT NOT NULL CHECK("sentence_type" IN('Imprisonment', 'Life imprisonment', 'Indeterminate', 'Mandatory minimum', 'Consecutive', 'Probation with imprisonment')),
    "crime_id" INTEGER,
    "duration" TEXT NOT NULL,
    "start_date" NUMERIC,
    "end_date" NUMERIC,
    "parole" BOOLEAN NOT NULL DEFAULT false,
    "parole_date" NUMERIC,
    "prison_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("crime_id") REFERENCES "crimes"("id"),
    FOREIGN KEY("prison_id") REFERENCES "prisons"("id")
);

-- Represent prisons that the sentences served in
CREATE TABLE "prisons" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "prison_location" INTEGER,
    "security_level" TEXT NOT NULL CHECK("security_level" IN('Minimum', 'Low', 'Medium', 'High', 'Administrative')),
    PRIMARY KEY("id"),
    FOREIGN KEY("prison_location") REFERENCES "locations"("id")
);

-- Represent visits that prisoners have
CREATE TABLE "visits" (
    "id" INTEGER,
    "prisoner_id" INTEGER,
    "prison_id" INTEGER,
    "visitor_name" TEXT NOT NULL,
    "visitdatetime" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "visit_duration_minutes" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("prisoner_id") REFERENCES "prisoners"("id"),
    FOREIGN KEY("prison_id") REFERENCES "prisons"("id")
);

-- Represent cells inside prisons
CREATE TABLE "cells" (
    "id" INTEGER,
    "cell_name" TEXT NOT NULL,
    "capacity" INTEGER NOT NULL,
    "cell_type" TEXT NOT NULL CHECK("cell_type" IN('Single', 'Double', 'Dormitory-style housing', 'Solitary confinement', 'Specialized unit', 'Supermax')),
    "prison_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("prison_id") REFERENCES "prisons"("id")
);

-- Table that log activities with a trigger that happens to prisoners
CREATE TABLE "activity_log" (
    "id" INTEGER,
    "prisoner_id" INTEGER,
    "previous_cell_id" INTEGER,
    "current_cell_id" INTEGER,
    "action" TEXT NOT NULL CHECK("action" IN ('Placed into', 'Released', 'Relocated', 'Escaped', 'Died')),
    "datetime" NUMERIC NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("prisoner_id") REFERENCES "prisoners"("id"),
    FOREIGN KEY("previous_cell_id") REFERENCES "cells"("id"),
    FOREIGN KEY("current_cell_id") REFERENCES "cells"("id")
);

-- Represent birth locations, prison locations, crime locations and court locations
CREATE TABLE "locations" (
    "id" INTEGER,
    "country" TEXT NOT NULL,
    "zip_code" TEXT NOT NULL,
    "state/county" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- Junction table between courts and crimes
CREATE TABLE "court_case" (
    "court_id" INTEGER,
    "crime_id" INTEGER,
    "case_law_identifier" TEXT NOT NULL UNIQUE,
    "hearing_datetime" NUMERIC NOT NULL,
    PRIMARY KEY("court_id", "crime_id"),
    FOREIGN KEY("court_id") REFERENCES "courts"("id"),
    FOREIGN KEY("crime_id") REFERENCES "crimes"("id")
);

-- Represent courts that decide on sentences
CREATE TABLE "courts" (
    "id" INTEGER,
    "court_name" TEXT NOT NULL,
    "court_location" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("court_location") REFERENCES "locations"("id")
);

-- Create views:
-- Display the prisons names, cell names, total capacity and available capacity by each cell
CREATE VIEW "prisons_capacity_and_available_capacity" AS SELECT
    "prisons"."name" AS "prison_name",
    "prisons"."id" AS "prison_id",
    "cells"."cell_name",
    "cells"."capacity" AS "total_capacity",
    "cells"."capacity" - COALESCE(active_prisoners_count, 0) AS "available_capacity"
    FROM "prisons"
    JOIN "cells" ON "prisons"."id" = "cells"."prison_id"
    LEFT JOIN (SELECT "cell_id", "prison_id", COUNT(*) AS active_prisoners_count
        FROM "prisoners"
        WHERE "is_active" = true
        GROUP BY "cell_id", "prison_id") AS active_prisoners ON "cells"."id" = "active_prisoners"."cell_id" AND "prisons"."id" = "active_prisoners"."prison_id";

-- Display all the visits a prisoner got
CREATE VIEW "prisoner_visitors" AS SELECT
    "first_name",
    "last_name",
    "prisons"."name" AS "prison_name",
    "country",
    "zip_code",
    "state/county",
    "city",
    "visits"."id" AS "visit_id",
    "visitor_name",
    "visitdatetime",
    "visit_duration_minutes"
    FROM "visits"
    JOIN "prisoners" ON "visits"."prisoner_id" = "prisoners"."id"
    JOIN "prisons" ON "visits"."prison_id" = "prisons"."id"
    JOIN "locations" ON "prisons"."prison_location" = "locations"."id";

-- Display all active prisoners along with their cell information
CREATE VIEW "prisoner_and_cell_info" AS SELECT
    "first_name",
    "last_name",
    "id_number",
    "race_group",
    "gender",
    "date_of_birth",
    "birth_location",
    "contact_number",
    "cell_name",
    "capacity" AS "cell_capacity",
    "cell_type",
    "name" AS "prison_name",
    "security_level"
    FROM "prisoners"
    JOIN "cells" ON "prisoners"."cell_id" = "cells"."id"
    JOIN "prisons" ON "prisoners"."prison_id" = "prisons"."id"
    WHERE "is_active" = true;

-- Display the given prisoner crimes, the sentence they got along with the court that heard the case
CREATE VIEW "prisoner_crime_court_sentence" AS SELECT
    "first_name",
    "last_name",
    "id_number",
    "crime_type",
    "crime_location",
    "datetime" AS "crime_date",
    "sentence_type",
    "duration" AS "sentence_duration",
    "start_date" AS "sentence_start",
    "end_date" AS "sentence_end",
    "parole",
    "parole_date",
    "court_name",
    "court_location",
    "case_law_identifier",
    "hearing_datetime"
    FROM "prisoner_crime"
    JOIN "prisoners" ON "prisoner_crime"."prisoner_id" = "prisoners"."id"
    JOIN "crimes" ON "prisoner_crime"."crime_id" = "crimes"."id"
    JOIN "sentences" ON "sentences"."crime_id" = "crimes"."id"
    JOIN "court_case" ON "prisoner_crime"."crime_id" = "court_case"."crime_id"
    JOIN "courts" ON "court_case"."court_id" = "courts"."id"
    JOIN "locations" AS "court_location" ON "courts"."court_location" = "court_location"."id"
    JOIN "locations" AS "crime_location" ON "crimes"."crime_location" = "crime_location"."id";


-- Create indexes:
CREATE INDEX "prisoner_activity_log" ON "activity_log" ("prisoner_id");
CREATE INDEX "prisoner_name_search" ON "prisoners" ("first_name", "last_name");
CREATE INDEX "prison_name_search" ON "prisons" ("name");
CREATE INDEX "prisoner_active" ON "prisoners" ("is_active");
CREATE INDEX "cells_prison_id" ON "cells" ("prison_id");


-- Create triggers:
-- If a new prisoner is INSERTED to a prisoners table, a new row is added to the activity_log table with the action "placed into".
CREATE TRIGGER "new_prisoner"
AFTER INSERT ON "prisoners"
FOR EACH ROW
BEGIN
    INSERT INTO "activity_log" ("prisoner_id", "current_cell_id", "action", "datetime")
    VALUES (NEW."id", NEW."cell_id", 'Placed into', DATETIME('now'));
END;


-- This trigger only activates when the prisoner table cell_id or is_active or escape_times or date_of_death column value got changed or the cell_id is changed from a NULL value to a NOT NULL value.
-- If a prisoner is active row will be changed to 'false', cell_id is changed to NULL, and the date_of_death is changed to a not NULL value, a new row is added to the activity_log table with the action "died".
-- If a prisoner is_active row will be changed to 'false', cell_id is changed to NULL, a new row is added to the activity_log table with the action "released".
-- If a prisoner is_active row will remain 'true', cell_id is changed to NULL, and the escape_times got modified, a new row is added to the activity_log table with the action "escaped".
-- If a prisoner is active row will remain 'true', cell_id got modified to a not NULL value, a new row is added to the activity_log table with the action "relocated".
-- When a prisoner who already exist in the prisoner table became a recidivist criminal and is imprisoned again or got caught after escpaing this trigger activates.
-- If a prisoner cell_id is changed to NOT NULL from the NULL value, a new row is added to the activity_log table with the action "placed into".
CREATE TRIGGER "prisoner_update"
AFTER UPDATE ON "prisoners"
FOR EACH ROW
WHEN
    (NEW."cell_id" != OLD."cell_id" OR
    NEW."is_active" != OLD."is_active" OR
    NEW."escape_times" != OLD."escape_times" OR
    NEW."date_of_death" != OLD."date_of_death")
    OR (NEW."cell_id" IS NOT NULL AND OLD."cell_id" IS NULL)
BEGIN
    INSERT INTO "activity_log" ("prisoner_id", "previous_cell_id", "current_cell_id", "action", "datetime")
    VALUES (OLD."id", OLD."cell_id", NEW."cell_id",
        CASE
            WHEN OLD."cell_id" IS NULL AND NEW."cell_id" IS NOT NULL THEN 'Placed into'
            WHEN OLD."is_active" = true AND NEW."is_active" = false AND NEW."cell_id" IS NULL AND NEW."date_of_death" IS NOT NULL THEN 'Died'
            WHEN OLD."is_active" = true AND NEW."is_active" = false AND NEW."cell_id" IS NULL THEN 'Released'
            WHEN OLD."is_active" = true AND NEW."is_active" = true AND OLD."cell_id" IS NOT NULL AND NEW."cell_id" IS NULL AND NEW."escape_times" NOT NULL THEN 'Escaped'
            WHEN OLD."cell_id" IS NOT NULL AND NEW."cell_id" IS NOT NULL THEN 'Relocated'
        END,
        DATETIME('now')
    );
END;
