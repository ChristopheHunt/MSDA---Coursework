
![](https://github.com/ChristopheHunt/MSDABridgeCoursework/blob/master/Week_4/Images/GE_ORG_CHART.JPG)

```{sql}
--Please create an organization chart for a real or imagined organization, implemented in a single SQL table. Your deliverable script should:

--1. Create the table. Each row should minimally include the person’s name, the person’s supervisor, and the person’s job title. Using ID columns is encouraged.

DROP TABLE IF EXISTS tblORG_STRUCTURE;

CREATE TABLE tblORG_STRUCTURE (ID INT PRIMARY KEY, 
		      EMP_NAME TEXT NOT NULL, 
		      TITLE TEXT NOT NULL, 
		      DIVISION TEXT NOT NULL,
		      SUP_ID INT REFERENCES tblORG_STRUCTURE);

--2. Populate the table with a few sample rows.

INSERT INTO tblORG_STRUCTURE VALUES  ( 1, 'JEFFREY R. IMMELT', 'CEO', 'GE', NULL ),
				     ( 2, 'DAVID L. JOYCE', 'SVP AND PRESIDENT & CEO', 'GE AVIATION', 1),
				     ( 3, 'KEITH S. SHERIN', 'VICE CHAIRMAN, CHAIRMAN & CEO', 'GE CAPITAL', 1),
				     ( 4, 'TOM SMITH', 'DIRECTOR OF AVIATION', 'GE AVIATION', 2),
				     ( 5, 'SUE SMITH', 'DIRECTOR OF CAPITAL', 'GE CAPITAL',3),
				     ( 6, 'ZAC SMITH', 'EXECUTIVE ASSISTANT', 'GE', 1);

SELECT * FROM tblORG_STRUCTURE ;

/*3. Provide a single SELECT statement that displays the information in the table, showing who reports to whom.
You might have an organization with a depth of three levels. For example: there could be a CEO, two vice presidents
that report to the CEO, and two managers that report to each of the two vice presidents. An assistant might also report
directly to the CEO. Your table should be designed so that the reporting hierarchy could go to any practical depth. You
may use the example below if you are not able to come up with your own hierarchical data example.*/

SELECT T1.EMP_NAME "EMPLOYEE NAME", T1.TITLE "TITLE", T1.DIVISION "WORK DIVISION", T2.EMP_NAME "SUPERVISOR", T2.TITLE "SUPERVISOR TITLE" 
FROM tblORG_STRUCTURE T1 LEFT OUTER JOIN tblORG_STRUCTURE T2 ON T1.SUP_ID = T2.ID
ORDER BY T1.DIVISION, T1.ID ASC;
```
