IF EXISTS(SELECT NULL FROM sys.tables WHERE Name = 'tbl1')
	Drop Table tbl1

GO

create table tbl1 
(
	col1 int identity(1,1) not null,
	col2 nvarchar(20) not null,
	constraint pk_tbl1 primary key clustered (col1 asc)
)
	
GO

Insert into tbl1 (col2) values ('One')
Insert into tbl1 (col2) values ('Two')
Insert into tbl1 (col2) values ('Three')
Insert into tbl1 (col2) values ('Four')

Select * from tbl1

GO
--Upsert Seven

/*
If exists
	update
else
	insert
*/

Merge into tbl1
	using (select 'Seven' as col2) tbl2 on (tbl1.col2= tbl2.col2)
	when matched then
		update set col2='Eight'
	when not matched then
		insert (col2) values ('seven');

Select * from tbl1
GO