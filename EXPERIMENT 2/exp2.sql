-- MEDIUM

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    ManagerID INT NULL
);

ALTER TABLE Employee
ADD CONSTRAINT FK_Manager FOREIGN KEY (ManagerID) REFERENCES Employee(EmpID);

INSERT INTO Employee (EmpID, EmpName, Department, ManagerID) VALUES (1, 'Alice', 'HR', NULL);
INSERT INTO Employee (EmpID, EmpName, Department, ManagerID) VALUES (2, 'Bob', 'Finance', 1);
INSERT INTO Employee (EmpID, EmpName, Department, ManagerID) VALUES (3, 'Charlie', 'IT', 1);
INSERT INTO Employee (EmpID, EmpName, Department, ManagerID) VALUES (4, 'David', 'Finance', 2);
INSERT INTO Employee (EmpID, EmpName, Department, ManagerID) VALUES (5, 'Eve', 'IT', 3);
INSERT INTO Employee (EmpID, EmpName, Department, ManagerID) VALUES (6, 'Frank', 'HR', 1);

SELECT 
    E.EmpName AS EmployeeName,
    E.Department AS EmployeeDept,
    M.EmpName AS ManagerName,
    M.Department AS ManagerDept
FROM 
    Employee E
LEFT JOIN 
    Employee M 
ON 
    E.ManagerID = M.EmpID;



-- HARD



CREATE TABLE Year_tbl (
    id INT,
    year INT,
    NPV INT
);

INSERT INTO Year_tbl (id, year, NPV) VALUES (1, 2018, 100);
INSERT INTO Year_tbl (id, year, NPV) VALUES (7, 2020, 30);
INSERT INTO Year_tbl (id, year, NPV) VALUES (13, 2019, 40);
INSERT INTO Year_tbl (id, year, NPV) VALUES (1, 2019, 113);
INSERT INTO Year_tbl (id, year, NPV) VALUES (2, 2008, 121);
INSERT INTO Year_tbl (id, year, NPV) VALUES (3, 2009, 12);
INSERT INTO Year_tbl (id, year, NPV) VALUES (11, 2020, 99);
INSERT INTO Year_tbl (id, year, NPV) VALUES (7, 2019, 0);

CREATE TABLE Queries_tbl (
    id INT,
    year INT
);

INSERT INTO Queries_tbl (id, year) VALUES (1, 2019);
INSERT INTO Queries_tbl (id, year) VALUES (2, 2008);
INSERT INTO Queries_tbl (id, year) VALUES (3, 2009);
INSERT INTO Queries_tbl (id, year) VALUES (7, 2018);
INSERT INTO Queries_tbl (id, year) VALUES (7, 2019);
INSERT INTO Queries_tbl (id, year) VALUES (7, 2020);
INSERT INTO Queries_tbl (id, year) VALUES (13, 2019);

SELECT 
    Y.id AS ID,
    Y.year AS Year,
    COALESCE(Q.NPV, 0)AS NPV
FROM 
    Queries_tbl Y
LEFT JOIN 
    Year_tbl Q
ON 
    Y.id=Q.id AND Y.year=Q.year
ORDER BY  Y.id , Y.Year;



