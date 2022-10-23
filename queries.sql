-- USING JOINS
-- Write and execute a SQL query to list the school names, community names and average attendance for communities with a hardship index of 98.
SELECT SCHOOL.NAME_OF_SCHOOL, SCHOOL.COMMUNITY_AREA_NAME, SCHOOL.AVERAGE_STUDENT_ATTENDANCE
	FROM CHICAGO_PUBLIC_SCHOOLS AS SCHOOL
	INNER JOIN CENSUS_DATA AS CENSUS
	ON SCHOOL.COMMUNITY_AREA_NUMBER = CENSUS.COMMUNITY_AREA_NUMBER
	WHERE CENSUS.HARDSHIP_INDEX = 98;

-- Write and execute a SQL query to list all crimes that took place at a school. Include case number, crime type and community name.
SELECT CRIME.CASE_NUMBER, CRIME.PRIMARY_TYPE, CENSUS.COMMUNITY_AREA_NAME
	FROM CHICAGO_CRIME_DATA AS CRIME
	LEFT JOIN CENSUS_DATA AS CENSUS
	ON CRIME.COMMUNITY_AREA_NUMBER = CENSUS.COMMUNITY_AREA_NUMBER
	WHERE CRIME.LOCATION_DESCRIPTION LIKE '%SCHOOL%';
  
-- CREATING A VIEW
-- Write and execute a SQL statement to create a view showing the columns listed in the following table, with new column names as shown in the second column.
CREATE VIEW REVISED_SCHOOL
	AS SELECT NAME_OF_SCHOOL AS School_Name, Safety_Icon AS Safety_Rating, 
		Family_Involvement_Icon AS Family_Rating, Environment_Icon AS Environment_Rating,
		Instruction_Icon AS Instruction_Rating, Leaders_Icon AS Leaders_Rating,
		Teachers_Icon AS Teachers_Rating
	FROM CHICAGO_PUBLIC_SCHOOLS;

-- Write and execute a SQL statement that returns all of the columns from the view.
SELECT * FROM REVISED_SCHOOL;

-- Write and execute a SQL statement that returns just the school name and leaders rating from the view.
SELECT SCHOOL_NAME, LEADERS_RATING FROM REVISED_SCHOOL;

-- CREATING A STORED PROCEDURE
-- Write the structure of a query to create or replace a stored procedure called UPDATE_LEADERS_SCORE that takes a in_School_ID parameter as an integer and a in_Leader_Score parameter as an integer. Don't forget to use the #SET TERMINATOR statement to use the @ for the CREATE statement terminator.
-- Inside your stored procedure, write a SQL statement to update the Leaders_Score field in the CHICAGO_PUBLIC_SCHOOLS table for the school identified by in_School_ID to the value in the in_Leader_Score parameter.
-- Inside your stored procedure, write a SQL IF statement to update the Leaders_Icon field in the CHICAGO_PUBLIC_SCHOOLS table for the school identified by in_School_ID using the following information.

--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE (IN in_School_ID INTEGER, IN in_Leader_Score INTEGER)
	LANGUAGE SQL
	BEGIN
		UPDATE CHICAGO_PUBLIC_SCHOOLS
			SET LEADERS_SCORE = in_Leader_Score
			WHERE SCHOOL_ID = in_School_ID;
		IF in_Leader_Score > 0 AND in_Leader_Score <20 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOLS 
			SET LEADERS_ICON = 'VERY WEAK';
		ELSEIF in_Leader_Score < 40 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOLS 
			SET LEADERS_ICON = 'WEAK';
		ELSEIF in_Leader_Score < 60 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOLS 
			SET LEADERS_ICON = 'AVERAGE';
		ELSEIF in_Leader_Score < 80 THEN
			UPDATE CHICAGO_PUBLIC_SCHOOLS 
			SET LEADERS_ICON = 'STRONG';
		ELSE
			UPDATE CHICAGO_PUBLIC_SCHOOLS 
			SET LEADERS_ICON = 'VERY STRONG';
		END IF;
	END
@



-- Run your code to create the stored procedure


-- Write a query to call the stored procedure, passing a valid school ID and a leader score of 50, to check that the procedure works as expected


-- USING TRANSACTIONS
-- Update your stored procedure definition. Add a generic ELSE clause to the IF statement that rolls back the current work if the score did not fit any of the preceding categories.

-- Update your stored procedure definition again. Add a statement to commit the current unit of work at the end of the procedure.

-- Run your code to replace the stored procedure

-- Write and run one query to check that the updated stored procedure works as expected when you use a valid score of 38.


-- Write and run another query to check that the updated stored procedure works as expected when you use an invalid score of 101.



