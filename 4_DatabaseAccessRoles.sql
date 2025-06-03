#Setting Security System
#Designing Specific Roles

-- Step 1: Create Roles
CREATE ROLE sales_rep;
CREATE ROLE manager;
CREATE ROLE db_admin;

-- Step 2: Grant Privileges to Roles

-- sales_rep permissions
GRANT SELECT ON *.* TO sales_rep;
GRANT INSERT, UPDATE ON Clients TO sales_rep;
GRANT INSERT, UPDATE ON Meetings TO sales_rep;
GRANT INSERT, UPDATE ON MeetingParticipants TO sales_rep;
GRANT INSERT ON Surveys TO sales_rep;

-- manager permissions: everything sales_rep can do +
GRANT sales_rep TO manager;
GRANT INSERT, UPDATE ON Contracts TO manager;
GRANT INSERT, UPDATE ON Payments TO manager;

-- db_admin permissions: everything
GRANT ALL PRIVILEGES ON *.* TO db_admin WITH GRANT OPTION;

-- Step 3: Create Test Users
CREATE USER 'test_sales'@'localhost' IDENTIFIED BY 'test_pass';
CREATE USER 'test_manager'@'localhost' IDENTIFIED BY 'test_pass';
CREATE USER 'test_admin'@'localhost' IDENTIFIED BY 'test_pass';

-- Step 4: Assign Roles to Users
GRANT sales_rep TO 'test_sales'@'localhost';
GRANT manager TO 'test_manager'@'localhost';
GRANT db_admin TO 'test_admin'@'localhost';

-- Step 5: Set Default Role, auto activate when user login
SET DEFAULT ROLE sales_rep TO 'test_sales'@'localhost';
SET DEFAULT ROLE manager TO 'test_manager'@'localhost';
SET DEFAULT ROLE db_admin TO 'test_admin'@'localhost';