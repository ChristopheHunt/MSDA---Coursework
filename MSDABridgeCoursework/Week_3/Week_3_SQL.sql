/*
1. Videos table. Create one table to keep track of the videos. This table should
include a unique ID, the title of the video, the length in minutes, and the URL.
Populate the table with at least three related videos from YouTube or other publicly
available resources. 
*/

--ONCE THE BELOW STATEMENT IS RUN THE NEW DATABASE IS CREATED 
CREATE DATABASE CHRISTOPHE_VIDEOS;

--DROPS TABLE AND CASCADE STATMENT ACCOUNTS FOR THE REVIEW TABLE DEPENDENCY
DROP TABLE IF EXISTS tblVIDEOS CASCADE; 

--CREATES VIDEO TABLE 
CREATE TABLE tblVIDEOS  (ID INT PRIMARY KEY, 
		      TITLE TEXT NOT NULL, 
		      LENGTH_MINUTES NUMERIC(6,2) NOT NULL, -- I divided the seconds by 60 to get a minute numeric value with two decimal places. 
		      URL TEXT NOT NULL UNIQUE);

--INSERT STATEMENT FOR VIDEO INFORMATION		      
INSERT INTO tblVIDEOS VALUES   ( 1, 'Intermediate Java Tutorial - 32 - Getting the Data from the HTML File', '9.95', 
			    'https://www.youtube.com/watch?v=FMV1eMapiSY'),
			    ( 2, 'Retrieve text from a html document with XML package of R', '6.53', 
			    'https://www.youtube.com/watch?v=Mx-Dzu-Q1cE'),
			    ( 3, 'Parse HTML Page using BeautifulSoup Python', '6.36', 
			    'https://www.youtube.com/watch?v=U2y6deNKyFM');

--TESTS THE INSERT STATEMENT TO MAKE SURE THE TABLE IS POPULATED
SELECT * FROM tblVIDEOS;

/*
2. Reviewers table. Create a second table that provides at least two user reviews for
each of at least two of the videos. These should be imaginary reviews that include
columns for the user’s name (“Mohan”, “Joy”, etc.), the rating (which could be NULL,
or a number between 0 and 5), and a short text review (“Loved it!”). There should
be a column that links back to the ID column in the table of videos.
*/

--DROPS TABLE IF IT EXISTS 
DROP TABLE IF EXISTS tblREVIEWS; 

--CREATES TABLE WITH THE CONSTRAINTS AS SPECIFIED IN PARAGRAPH 
CREATE TABLE tblREVIEWS       (ID INT PRIMARY KEY,
			       VIDEOS_ID INT REFERENCES tblVIDEOS,
			       USER_NAME TEXT NOT NULL,
			       RATING INT NULL CHECK (RATING >= 0 AND RATING <= 5), 
			       REVIEW TEXT NOT NULL);

--INSERTS VALUES INTO NEWLY CREATED TABLE 
INSERT INTO tblREVIEWS VALUES ( 1, 1, 'JOHN', NULL, 'GREAT!!'),
			      ( 2, 1, 'BETH', 4, 'BEST VIDEO YET'),
			      ( 3, 2, 'SUE', 2, 'JUST OK'),
			      ( 4, 2, 'TOM', 5, 'MY FAVORITE'),
			      ( 5, 3, 'MAX', NULL, 'NOT GOOD'),
			      ( 6, 3, 'TONY', NULL, 'UNWATCHABLE');

--TESTS INSERT STATEMENT 
SELECT * FROM tblREVIEWS;

/*
3. Report on Video Reviews. Write a JOIN statement that shows information from
both tables.
*/

--QUERY ON BOTH TABLES, PROVIDES THE TITLE, URL, RATING, AND REVIEW 

SELECT V.TITLE, V.URL, R.RATING, R.REVIEW 
FROM tblVIDEOS V INNER JOIN tblREVIEWS R ON V.ID = R.VIDEOS_ID
ORDER BY V.TITLE DESC;

/*
For you to receive full credit, I should be able to run your delivered script twice
consecutively without errors. It's acceptable to create your database using pgadmin,
instead of scripting the database create in code.
Please post your script to your GitHub repository, and include an appropriate link in your
assignment submission.
*/
