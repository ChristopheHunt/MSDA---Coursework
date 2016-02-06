--QUESTION 1 Show the total number of flights 
SELECT COUNT(*) "TOTAL # OF FLIGHTS" 
FROM FLIGHTS;

--QUESTION 2 Show the total number of flights by airline (carrier).
SELECT A.NAME, 
       COUNT(*) "TOTAL # OF FLIGHTS" 
FROM FLIGHTS F INNER JOIN AIRLINES A ON F.CARRIER = A.CARRIER 
GROUP BY A.NAME;

--QUESTION 3 Show all of the airlines, ordered by number of flights in descending order 
SELECT A.NAME, 
       COUNT(*) "TOTAL # OF FLIGHTS" 
FROM FLIGHTS F INNER JOIN AIRLINES A ON F.CARRIER = A.CARRIER 
GROUP BY A.NAME 
ORDER BY COUNT(*) DESC;

--QUESTION 4 Show only the top 5 airlines, by number of flights, ordered by number of flights in descending order
SELECT A.NAME, 
       COUNT(*) "TOTAL # OF FLIGHTS" 
FROM FLIGHTS F INNER JOIN AIRLINES A ON F.CARRIER = A.CARRIER 
GROUP BY A.NAME      
ORDER BY COUNT(*) DESC limit 5;

--QUESTION 5 Show only the top 5 airlines, by number of flights of distance 1,000 miles or greater, ordered by number of flights in descending order.		
SELECT A.NAME, 
       COUNT(*) "TOTAL # OF FLIGHTS" 
FROM FLIGHTS F INNER JOIN AIRLINES A ON F.CARRIER = A.CARRIER
WHERE DISTANCE >= 1000 
GROUP BY A.NAME
ORDER BY COUNT(*) DESC limit 5;

--QUESTION 6 show all of the airlines, by the average distance for flights equal to or longer than 4 hours, order by the average distance in descending order.  
SELECT A.NAME, 
       ROUND(AVG(DISTANCE),2)  "AVG DISTANCE" 
FROM FLIGHTS F INNER JOIN AIRLINES A ON F.CARRIER = A.CARRIER 
WHERE F.HOUR >= 4 
GROUP BY A.NAME
ORDER BY AVG(DISTANCE) DESC;
