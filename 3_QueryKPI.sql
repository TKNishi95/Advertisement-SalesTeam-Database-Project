#KPI Query Examples

#How many Clients per Group
SELECT e.GroupID, COUNT(c.ClientID) AS Clients_Acquired
FROM Employees e 
JOIN Clients c ON c.AssignedEmployeeID = e.EmployeeID
WHERE c.AcquisitionTime BETWEEN "2022-01-01" AND "2022-06-06"
GROUP BY e.GroupID
ORDER BY Clients_Acquired DESC;

#Meeting Numbers
SELECT e.EmployeeID, COUNT(m.MeetingID) AS meetings_count
FROM Employees e 
JOIN MeetingParticipants mp ON e.EmployeeID = mp.EmployeeID
JOIN Meetings m ON mp.MeetingID = m.MeetingID 
WHERE (m.Time BETWEEN "2022-01-01" AND "2022-12-31") AND e.GroupID = 'G01' 
GROUP BY e.EmployeeID
ORDER BY meetings_count DESC; 

#Decision Maker Contact Metric
SELECT c.ClientID, c.Name, c.AssignedEmployeeID, c.AcquisitionTime, 
c.IsDecisionMakerContacted FROM Clients c
JOIN Employees e ON e.EmployeeID = c.AssignedEmployeeID
WHERE e.GroupID = 'G01';

#Decision Maker Contact Metric
SELECT ClientID, AssignedEmployeeID, Name FROM CLIENTS
WHERE IsDecisionMakerContacted = False;

#Deal Closing Value
SELECT HandledByEmployeeID, SUM(Value) AS Total_Deal_Value FROM Contracts
GROUP BY HandledByEmployeeID
HAVING Total_Deal_Value > 100000
ORDER BY Total_Deal_Value DESC
LIMIT 3; 

#Deal Closing Value by Groups
SELECT e.GroupID, AVG(c.Value) AS Average_Contract_Value FROM Contracts c
JOIN Employees e ON EmployeeID = c.HandledbyEmployeeID 
GROUP BY e.GroupID 
ORDER BY Average_Contract_Value DESC;

#Client Satisfaction
SELECT c.HandledbyEmployeeID, AVG(s.Score) AS Average_Contract_Survey_Score FROM Contracts c
JOIN Surveys s ON s.SurveyID = c.SurveyID
GROUP BY c.HandledbyEmployeeID
ORDER BY Average_Contract_Survey_Score DESC;

#Client Satisfaction
SELECT ec.GroupID, AVG(s.Score) AS Average_Contract_Survey_Score FROM 
(SELECT e.GroupID, c.SurveyID FROM Employees e 
JOIN Contracts c ON e.EmployeeID = c.HandledbyEmployeeID) AS ec
JOIN Surveys s ON s.SurveyID = ec.SurveyID
GROUP BY ec.GroupID
ORDER BY Average_Contract_Survey_Score DESC;


