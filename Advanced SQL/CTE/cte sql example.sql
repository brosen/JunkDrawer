/*
--Syntax

WITH cte_name ( column_name [,...n] )
AS
(
CTE_query_definition -- Anchor member is defined.
UNION ALL
CTE_query_definition -- Recursive member is defined referencing cte_name.
)
SELECT * FROM cte_name -- Statement using the CTE
*/

--Example 1
CREATE TABLE MyEmployees
(
	EmployeeID smallint NOT NULL,
	FirstName nvarchar(30)  NOT NULL,
	LastName  nvarchar(40) NOT NULL,
	Title nvarchar(50) NOT NULL,
	DeptID smallint NOT NULL,
	ManagerID int NULL,
 CONSTRAINT PK_EmployeeID PRIMARY KEY CLUSTERED (EmployeeID ASC) 
);

GO

-- Populate the table with values.
INSERT INTO MyEmployees VALUES 
 (1, N'Ken', N'Sánchez', N'Chief Executive Officer',16,NULL)
,(273, N'Brian', N'Welcker', N'Vice President of Sales',3,1)
,(274, N'Stephen', N'Jiang', N'North American Sales Manager',3,273)
,(275, N'Michael', N'Blythe', N'Sales Representative',3,274)
,(276, N'Linda', N'Mitchell', N'Sales Representative',3,274)
,(285, N'Syed', N'Abbas', N'Pacific Sales Manager',3,273)
,(286, N'Lynn', N'Tsoflias', N'Sales Representative',3,285)
,(16,  N'David',N'Bradley', N'Marketing Manager', 4, 273)
,(23,  N'Mary', N'Gibson', N'Marketing Specialist', 4, 16);

GO

WITH DirectReports (ManagerID, EmployeeID, Title, Level)
AS
(
    SELECT e.ManagerID, e.EmployeeID, e.Title,0 AS Level
    FROM MyEmployees AS e
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.ManagerID, e.EmployeeID, e.Title,Level + 1
    FROM MyEmployees AS e
    INNER JOIN DirectReports AS d
        ON e.ManagerID = d.EmployeeID
)
SELECT ManagerID, EmployeeID, Title, Level
FROM DirectReports

GO

--Example 2
With FolderStructure (Parentfolderid, folderid,crfversionid,Level)
AS
(
	select 0, folderid,
		crfversionid,0 Level
	from folders fl
	where isnull(Parentfolderid,0)=0
	union all
	select flp.Parentfolderid, flp.folderid,
		fl.crfversionid,Level + 1
	from folders flp
		join FolderStructure fl on fl.folderid = flp.Parentfolderid
)
select Parentfolderid, folderid ,Level
from FolderStructure
where crfversionid=15