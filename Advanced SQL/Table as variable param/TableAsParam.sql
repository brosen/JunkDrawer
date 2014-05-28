--select top 1 * from markings
drop proc MarkingsByCRF
GO
drop type MarkingTableType

GO

CREATE TYPE MarkingTableType AS TABLE
 (                     
       MarkingId int,
       MarkingTypeId int,
       EditCheckId int
 )

GO

Create Proc MarkingsByCRF(@markings MarkingTableType READONLY)
AS
BEGIN
	select crfversionid,
		count(m.markingid) MarkingsByCrf
	from @markings m
		join checks c on c.checkid = m.EditCheckId
	group by c.crfversionid
END
GO

declare @mymarkings as MarkingTableType

Insert into @mymarkings
select markingid,MarkingId,EditCheckId
from markings 
where userid=-2

exec MarkingsByCRF @mymarkings


