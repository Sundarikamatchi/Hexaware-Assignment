-- CREATE DATABASE CrimeBranch;
USE CrimeBranch;

 SET foreign_key_checks = 0; 
DROP TABLE IF EXISTS Crime;
DROP TABLE IF EXISTS Victim;
DROP TABLE IF EXISTS Suspect;
SET foreign_key_checks = 1; 


CREATE TABLE Crime (
 CrimeID INT PRIMARY KEY,
IncidentType VARCHAR(255),
IncidentDate DATE NOT NULL,
Location VARCHAR(255) NOT NULL,
Description TEXT,
Status VARCHAR(20) NOT NULL
);


CREATE TABLE Victim (
  VictimID INT PRIMARY KEY,
CrimeID INT,
Name VARCHAR(255) NOT NULL,
ContactInfo VARCHAR(255) NOT NULL,
Injuries VARCHAR(255) ,
FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);

CREATE TABLE Suspect (
SuspectID INT PRIMARY KEY,
CrimeID INT,
Name VARCHAR(255) NOT NULL,
Description TEXT,
CriminalHistory TEXT,
FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);

INSERT INTO Crime (CrimeID, IncidentType, IncidentDate, Location, Description, Status)
VALUES
(1, 'Robbery', '2023-09-15', '123 Main St, Cityville', 'Armed robbery at a convenience store', 'Open'),
(2, 'Homicide', '2023-09-20', '456 Elm St, Townsville', 'Investigation into a murder case', 'Under
Investigation'),
(3, 'Theft', '2023-09-10', '789 Oak St, Villagetown', 'Shoplifting incident at a mall', 'Closed');

INSERT INTO Victim (VictimID, CrimeID, Name, ContactInfo, Injuries)
VALUES
(1, 1, 'John Doe', 'johndoe@example.com', 'Minor injuries'),
(2, 2, 'Jane Smith', 'janesmith@example.com', 'Deceased'),
(3, 3, 'Alice Johnson', 'alicejohnson@example.com', 'None');

INSERT INTO Suspect (SuspectID, CrimeID, Name, Description, CriminalHistory)
VALUES
(1, 1, 'Robber 1', 'Armed and masked robber', 'Previous robbery convictions'),
(2, 2, 'Unknown', 'Investigation ongoing', NULL),
(3, 3, 'Suspect 1', 'Shoplifting suspect', 'Prior shoplifting arrests');



-- 1. Select all open incidents.
SELECT*FROM Crime WHERE Status = 'open';

-- 2. Find the total number of incidents.
SELECT COUNT(*) AS No_of_Incidents FROM Crime;

-- 3. List all unique incident types.
SELECT DISTINCT IncidentType from Crime;

-- 4. Retrieve incidents that occurred between '2023-09-01' and '2023-09-10'.
SELECT*FROM Crime WHERE IncidentDate BETWEEN  '2023-09-01' and '2023-09-10';

-- 5. List persons involved in incidents in descending order of age.
ALTER TABLE Victim ADD Age INT ;
ALTER TABLE Suspect ADD Age INT ;

UPDATE victim SET Age = 30 WHERE VictimId = 1;
UPDATE victim SET Age = 45 WHERE VictimId = 2;
UPDATE victim SET Age = 28 WHERE VictimId = 3;

UPDATE suspect SET Age = 35 WHERE SuspectId = 1;
UPDATE suspect SET Age = 40 WHERE SuspectId = 2;
UPDATE suspect SET Age = 25 WHERE SuspectId = 3;

SELECT Name,Age, 'Victim' AS Role FROM Victim UNION SELECT Name,Age ,'Suspect' AS Role FROM Suspect ORDER BY Age DESC;

-- 6. Find the average age of persons involved in incidents.
SELECT ROUND(AVG(age),2) AS average_age FROM Victim UNION SELECT ROUND(AVG(age),2) AS average_age FROM Suspect;

-- 7. List incident types and their counts, only for open cases.
SELECT IncidentType,Count(IncidentType) as No_of_Incidents FROM Crime WHERE Status = 'open' GROUP BY IncidentType;

-- 8. Find persons with names containing 'Doe'.
SElECT Name,'Victim' AS Role FROM Victim WHERE Name LIKE '%DOe%' UNION SELECT Name,'Suspect' AS Role FROM Suspect WHERE Name LIKE '%DOe%';

-- 9. Retrieve the names of persons involved in open cases and closed cases.
SELECT Name, 'victim' AS role,status, CrimeId FROM victim LEFT JOIN Crime USING (crimeid) WHERE status IN ('open', 'closed')UNION
SELECT Name, 'suspect' AS role,status, CrimeId FROM suspect LEFT JOIN Crime USING (crimeid) WHERE status IN ('open', 'closed');

-- 10. List incident types where there are persons aged 30 or 35 involved.
SELECT Name,Age, 'victim' AS role, CrimeId,IncidentType FROM victim LEFT JOIN Crime USING (crimeid) WHERE Age IN (30,35)UNION
SELECT Name,Age, 'suspect' AS role, CrimeId,IncidentType FROM suspect LEFT JOIN Crime USING (crimeid) WHERE Age IN (30,35);

-- 11. Find persons involved in incidents of the same type as 'Robbery'.
SELECT Name, 'victim' AS role, CrimeId,IncidentType FROM victim LEFT JOIN Crime USING (crimeid) WHERE IncidentType = 'Robbery' UNION
SELECT Name, 'suspect' AS role, CrimeId,IncidentType FROM suspect LEFT JOIN Crime USING (crimeid) WHERE IncidentType = 'Robbery';

-- 12. List incident types with more than one open case.
SELECT IncidentType,CrimeId FROM Crime WHERE Status = 'open' GROUP BY IncidentType,CrimeId HAVING Count(*) > 1;

-- 13. List all incidents with suspects whose names also appear as victims in other incidents.
SELECT c.IncidentType,c.CrimeId,v.Name AS Victim_name from Crime c JOIN Victim v USING(CrimeId)  WHERE v.Name IN
(SELECT Name FROM Suspect S where s.Name = v.Name);

-- 14. Retrieve all incidents along with victim and suspect details.
SELECT c.CrimeId,c.Description, c.IncidentType, c.Status, v.name AS Victim_name, s.name AS Suspect_name FROM Crime c
LEFT JOIN Victim v ON c.CrimeId = v.CrimeId LEFT JOIN Suspect s ON c.CrimeId = s.CrimeId;

-- 15. Find incidents where the suspect is older than any victim.
SELECT c.CrimeId, c.IncidentType, v.name AS Victim_name, s.name AS Suspect_name FROM Crime c
LEFT JOIN Victim v ON c.CrimeId = v.CrimeId LEFT JOIN Suspect s ON c.CrimeId = s.CrimeId WHERE s.Age > v.Age;

-- 16. Find suspects involved in multiple incidents:
SELECT s.Name, COUNT(*) AS Incident_count FROM Suspect s GROUP BY s.Name HAVING COUNT(*) > 1;

-- 17. List incidents with no suspects involved.
SELECT c.IncidentType,c.CrimeId,s.Name as Suspect_name FROM Crime c JOIN Suspect s USING(CrimeID) WHERE s.Name = 'unknown' OR 'Null';

-- 18. List all cases where at least one incident is of type 'Homicide' and all other incidents are of type'Robbery'.
SELECT CrimeId,Description, IncidentType FROM Crime WHERE IncidentType IN('Homicide','Robbery') GROUP BY CrimeId
 HAVING  SUM(incidenttype = 'homicide') > 0 AND SUM(incidenttype = 'robbery') = COUNT(*) - 1;

-- 19. Retrieve a list of all incidents and the associated suspects, showing suspects for each incident, or'No Suspect' if there are none.
SELECT c.CrimeId, c.IncidentType, COALESCE(NULLIF(s.name, 'Unknown'), 'NoSuspect') AS Suspect_name FROM Crime c LEFT JOIN Suspect s ON c.CrimeId = s.CrimeId;

-- 20. List all suspects who have been involved in incidents with incident types 'Robbery' or 'Assault'
SELECT DISTINCT s.Name FROM Suspect s JOIN Crime c ON s.CrimeId = c.CrimeId WHERE c.IncidentType IN ('Robbery', 'Assault');