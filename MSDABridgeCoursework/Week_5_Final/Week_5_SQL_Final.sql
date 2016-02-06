/*Your SQL Bridge Final Exam is due by end of day on Sunday July 26. You should post a single .SQL script to GitHub
that creates and populates the tables, and joins the information as described below. You are also expected to make a
short (3 to 5 minute) presentation during our last Meetup on July 28th.
Please note:

(1) You may substitute a SQL project of your own choosing that demonstrates your understanding of the three
capabilities highlighted below. You will need to provide a requirement document similar to what is below if you
work with your own data and requirement. You may work in a small group if you take on this more ambitious
alternative final.

(2) If you are also taking the R bridge and or the Data Science Math bridge, you may instead design a final project of
your own choosing that incorporates what you have learned in both or all three of your bridge courses. For
example, you might design and populate tables in SQL, analyze the exported data in R, then include some
conditional probability in your analysis. This will require some forethought on your part. You will only be
required to present once if you choose to combine finals.

This project is where you show off your ability to (1) translate a business requirement into a database design, (2) design
a database using one-to-many and many-to-many relationships, and (3) know when to use LEFT and/or RIGHT JOINs to
build result sets for reporting.

An organization grants key-card access to rooms based on groups that key-card holders belong to. You may assume that
users below to only one group. Your job is to design the database that supports the key-card system.

There are six users, and four groups. Modesto and Ayine are in group “I.T.” Christopher and Cheong Woo are in group
“Sales”. There are four rooms: “101”, “102”, “Auditorium A”, and “Auditorium B”. Saulat is in group
“Administration.” Group “Operations” currently doesn’t have any users assigned. I.T. should be able to access Rooms
101 and 102. Sales should be able to access Rooms 102 and Auditorium A. Administration does not have access to any
rooms. Heidy is a new employee, who has not yet been assigned to any group.
*/

DROP TABLE IF EXISTS TBLWORKGROUP CASCADE;

CREATE TABLE TBLWORKGROUP(ID INT PRIMARY KEY,
			  WORK_GROUP TEXT NOT NULL);
INSERT INTO TBLWORKGROUP VALUES (1, 'I.T.'),
				(2, 'SALES'),
				(3, 'ADMINISTRATION'),
				(4, 'OPERATIONS');
SELECT * FROM TBLWORKGROUP;

DROP TABLE IF EXISTS TBLROOMS CASCADE;
CREATE TABLE TBLROOMS (ID INT PRIMARY KEY,
		       ROOM TEXT NULL);
INSERT INTO TBLROOMS VALUES (1, 'ROOM 101'),
			    (2, 'ROOM 102'),
			    (3, 'AUDITORIUM A'),
			    (4, 'AUDITORIUM B');

SELECT * FROM TBLROOMS;

DROP TABLE IF EXISTS TBLROOM_ACCESS;		       
CREATE TABLE TBLROOM_ACCESS (ID INT PRIMARY KEY,
			     ROOM_ID INT REFERENCES TBLROOMS,
			     WORK_GROUP_ID INT REFERENCES TBLWORKGROUP,
			     ACCESS_FLAG INT NOT NULL);
			     
INSERT INTO TBLROOM_ACCESS VALUES (1, 1, 1, 1),
			          (2, 2, 1, 1),
			          (3, 2, 2, 1),
			          (4, 3, 2, 1);
SELECT * FROM TBLROOM_ACCESS;

DROP TABLE IF EXISTS TBLUSERS;
CREATE TABLE TBLUSERS (ID INT PRIMARY KEY,
		       EMP_NAME TEXT,
		       WORK_GROUP_ID INT REFERENCES TBLWORKGROUP);

INSERT INTO TBLUSERS VALUES ( 1, 'MODESTO', 1),
			    ( 2, 'AYINE', 1),
			    ( 3, 'CHRISTOPHER', 2),
			    ( 4, 'CHEONG WOO', 2),
			    ( 5, 'HEIDY', NULL),
			    ( 6, 'SALUT', 3); 
SELECT * FROM TBLUSERS; 

/*

After you determine the tables any relationships between the tables (One to many? Many to one? Many to many?), you
should create the tables and populate them with the information indicated above.
Next, write SELECT statements that provide the following information:

• All groups, and the users in each group. A group should appear even if there are no users assigned to the group.
*/

SELECT WG.WORK_GROUP, STRING_AGG(U.EMP_NAME, ', ') "Employees"
FROM TBLWORKGROUP WG LEFT OUTER JOIN TBLUSERS U ON U.WORK_GROUP_ID = WG.ID
GROUP BY 1;

/*

• All rooms, and the groups assigned to each room. The rooms should appear even if no groups have been
assigned to them.
*/

SELECT R.ROOM, WG.WORK_GROUP
FROM 		TBLROOMS R 
		LEFT OUTER JOIN TBLROOM_ACCESS RA ON R.ID = RA.ROOM_ID 
	        LEFT OUTER JOIN TBLWORKGROUP WG ON WG.ID = RA.WORK_GROUP_ID;


/*
• A list of users, the groups that they belong to, and the rooms to which they are assigned. This should be sorted
alphabetically by user, then by group, then by room.
*/

SELECT U.EMP_NAME, WG.WORK_GROUP, R.ROOM 
FROM 	TBLUSERS U 
	LEFT OUTER JOIN TBLWORKGROUP WG ON U.WORK_GROUP_ID = WG.ID
	LEFT OUTER JOIN TBLROOM_ACCESS RA ON RA.WORK_GROUP_ID = WG.ID
	LEFT OUTER JOIN TBLROOMS R ON R.ID = RA.ROOM_ID
ORDER BY U.EMP_NAME, WG.WORK_GROUP, R.ROOM DESC;


--+---+--+---+--+---+--+---+--+---+--+---+
--     2ND SOLUTION 
--+---+--+---+--+---+--+---+--+---+--+---+

SELECT U.EMP_NAME, WG.WORK_GROUP, STRING_AGG(R.ROOM, ', ' ) "ACCESS TO ROOMS"
FROM 	TBLUSERS U 
	LEFT OUTER JOIN TBLWORKGROUP WG ON U.WORK_GROUP_ID = WG.ID
	LEFT OUTER JOIN TBLROOM_ACCESS RA ON RA.WORK_GROUP_ID = WG.ID
	LEFT OUTER JOIN TBLROOMS R ON R.ID = RA.ROOM_ID
GROUP BY U.EMP_NAME, WG.WORK_GROUP
ORDER BY U.EMP_NAME, WG.WORK_GROUP DESC;

