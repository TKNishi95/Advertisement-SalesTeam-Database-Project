#Step 1: Creating the Database Relation

CREATE DATABASE salesdb;

CREATE TABLE Employees (
    EmployeeID VARCHAR(255) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    GroupID VARCHAR(255)
);

CREATE TABLE SalesGroups (
    GroupID VARCHAR(255) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    ManagerEmployeeID VARCHAR(255) UNIQUE NOT NULL,
    FOREIGN KEY (ManagerEmployeeID) REFERENCES Employees(EmployeeID)
);

ALTER TABLE Employees
ADD CONSTRAINT fk_employees_group
FOREIGN KEY (GroupID) REFERENCES SalesGroups(GroupID);

CREATE TABLE Clients (
    ClientID VARCHAR(255) PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    AssignedEmployeeID VARCHAR(255) NOT NULL,
    AcquiredByEmployeeID VARCHAR(255) NOT NULL,
    IsDecisionMakerContacted BOOLEAN NOT NULL,
    AcquisitionTime TIMESTAMP NOT NULL,
    FOREIGN KEY (AssignedEmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (AcquiredByEmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Meetings (
    MeetingID VARCHAR(255) PRIMARY KEY,
    ClientID VARCHAR(255) NOT NULL,
    DecisionMakerLevel INT CHECK (DecisionMakerLevel IN (1, 2, 3)),
    Time TIMESTAMP NOT NULL,
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);

CREATE TABLE MeetingParticipants (
    MeetingID VARCHAR(255) NOT NULL,
    EmployeeID VARCHAR(255) NOT NULL,
    FOREIGN KEY (MeetingID) REFERENCES Meetings(MeetingID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Surveys (
    SurveyID VARCHAR(255) PRIMARY KEY,
    Score DECIMAL NOT NULL CHECK (Score >= 0 AND Score <= 100)
);

CREATE TABLE Contracts (
    ContractID VARCHAR(255) PRIMARY KEY,
    ClientID VARCHAR(255) NOT NULL,
    Value DECIMAL(10, 2) NOT NULL CHECK (Value > 0),
    Status VARCHAR(255) NOT NULL CHECK (Status IN ('draft', 'signed', 'fulfilled')),
    HandledByEmployeeID VARCHAR(255) NOT NULL,
    SignedTime TIMESTAMP,
    PaymentDueTime TIMESTAMP,
    SurveyID VARCHAR(255) UNIQUE,  -- NULL if not yet surveyed
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (HandledByEmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (SurveyID) REFERENCES Surveys(SurveyID)
);

CREATE TABLE Payments (
    PaymentID VARCHAR(255) PRIMARY KEY,
    ContractID VARCHAR(255) NOT NULL,
    Time TIMESTAMP NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL CHECK (Amount > 0),
    FOREIGN KEY (ContractID) REFERENCES Contracts(ContractID)
);
