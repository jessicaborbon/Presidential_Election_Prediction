CREATE TABLE Econ_Sent_Data (
    "State" VARCHAR(50),
	"Year" NUMERIC,
    "Candidate" VARCHAR(50),
    "Total Votes" NUMERIC,
    "GDP" NUMERIC,
    "Personal Income" NUMERIC,
    "Total Employment" NUMERIC,
	"Average Sentiment Score" NUMERIC
);

CREATE TABLE Merged_Race_Data (
    "state" VARCHAR(50),
    "white" NUMERIC,
    "black_or_african_american" NUMERIC,
    "american_indian_and_alaska_native" NUMERIC,
    "asian" NUMERIC,
    "native_hawaiian_and_other_pacific-islander" NUMERIC,
    "hispanic_or_latino_any_race" NUMERIC,
    "year" NUMERIC,
	"Candidate" VARCHAR(50)
);

CREATE TABLE Merged_Age_Data (
    "State" VARCHAR(50),
    "Year" NUMERIC,
    "18-20" NUMERIC,
	"20-24" NUMERIC,
    "25-34" NUMERIC,
	"35-44" NUMERIC,
	"45-54" NUMERIC,
    "55-59" NUMERIC,
    "60-64" NUMERIC,
	"65-74" NUMERIC,
    "75-84" NUMERIC,
	"Candidate" VARCHAR(50)
);

-- Verify data in source tables
SELECT * FROM Econ_Sent_Data LIMIT 10;
SELECT * FROM Merged_Race_Data LIMIT 10;
SELECT * FROM Merged_Age_Data LIMIT 10;

-- Create the combined table
CREATE TABLE merged_race_age_data AS
SELECT
    r."state" AS "State",
    r."year" AS "Year",
    r."Candidate" AS "Candidate",
    r."white" AS "White",
    r."black_or_african_american" AS "African American",
    r."american_indian_and_alaska_native" AS "Native Peoples",
    r."asian" AS "Asian",
    r."native_hawaiian_and_other_pacific-islander" AS "Pacific Islanders",
    r."hispanic_or_latino_any_race" AS "Latin",
    a."18-20",
    a."20-24",
    a."25-34",
    a."35-44",
    a."45-54",
    a."55-59",
    a."60-64",
    a."65-74",
    a."75-84"
FROM Merged_Race_Data r
JOIN Merged_Age_Data a
ON r."state" = a."State"
AND r."year" = a."Year"
AND r."Candidate" = a."Candidate";

-- Verify the merged_race_age_data table
SELECT * FROM merged_race_age_data m

-- JOIN Econ_Sent_Data e
-- 	ON m."State" = e."State"
-- 	AND m."Year" = e."Year"
-- 	AND m."Candidate" = e."Candidate";

-- Add new columns to the merged_race_age_data table
ALTER TABLE merged_race_age_data
ADD COLUMN "Total Votes" NUMERIC,
ADD COLUMN "GDP" NUMERIC,
ADD COLUMN "Personal Income" NUMERIC,
ADD COLUMN "Total Employment" NUMERIC,
ADD COLUMN "Average Sentiment Score" NUMERIC;

-- Update the newly added columns with data from Econ_Sent_Data
UPDATE merged_race_age_data m
SET
    "Total Votes" = e."Total Votes",
    "GDP" = e."GDP",
    "Personal Income" = e."Personal Income",
    "Total Employment" = e."Total Employment",
    "Average Sentiment Score" = e."Average Sentiment Score"
FROM Econ_Sent_Data e
WHERE m."State" = e."State"
AND m."Year" = e."Year"
AND m."Candidate" = e."Candidate";

-- Verify the merged_race_age_data table
SELECT * FROM merged_race_age_data;

-- -- Step 1: Create a new table without duplicates
-- CREATE TABLE merged_race_age_data_no_duplicates AS
-- SELECT DISTINCT *
-- FROM merged_race_age_data;

-- -- Step 2: Drop the original table
-- DROP TABLE merged_race_age_data;

-- -- Step 3: Rename the new table to the original table's name
-- ALTER TABLE merged_race_age_data_no_duplicates
-- RENAME TO merged_race_age_data;

-- -- Verify the merged_race_age_data table
-- SELECT * FROM merged_race_age_data;

-- -- First, add the new columns to the merged_race_age_data table
-- ALTER TABLE merged_race_age_data
-- ADD COLUMN "Total Votes" NUMERIC,
-- ADD COLUMN "GDP" NUMERIC,
-- ADD COLUMN "Personal Income" NUMERIC,
-- ADD COLUMN "Total Employment" NUMERIC,
-- ADD COLUMN "Average Sentiment Score" NUMERIC;

-- -- Add Candidate column to merged_race_age_data if it does not exist
-- ALTER TABLE merged_race_age_data
-- ADD COLUMN "Candidate" VARCHAR(50);

-- -- Update the newly added columns with data from Econ_Sent_Data
-- UPDATE merged_race_age_data m
-- SET
--     "Total Votes" = e."Total Votes",
--     "GDP" = e."GDP",
--     "Personal Income" = e."Personal Income",
--     "Total Employment" = e."Total Employment",
--     "Average Sentiment Score" = e."Average Sentiment Score"
-- FROM Econ_Sent_Data e
-- WHERE m."Year" = e."Year"
-- AND m."State" = e."State"
-- AND m."Candidate" = e."Candidate";

