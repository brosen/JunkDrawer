/*
if exists (select * from sysobjects where name = 'cspSnapShotCreate')
	drop procedure cspSnapShotCreate
go
create procedure cspSnapShotCreate (
	@DBName nvarchar(256),
	@SnapDBName nvarchar(256)
)
as
begin
declare 
	@SQLText nvarchar(max),
	@SysFilesName nvarchar(256),
	@SysFilesFileName nvarchar(256),
	@SQuote char(1), @Tab char(1), @CRLF char(2)

set @SQuote = char(39)
set @Tab = char(9)
set @CRLF = char(13) + char(10)

select 
	@SysFilesName = mf.Name,
	@SysFilesFileName = mf.Physical_Name 
from 
	master.sys.databases db
	join master.sys.master_files mf on mf.database_id = db.database_id
where 
	db.name = @DBName
	and mf.type = 0

set @SQLText = 'drop database ' + @SnapDBName
print @SQLText
exec (@SQLText)

set @SQLText =
'CREATE DATABASE ' + @DBName + 'snap ' + @CRLF
+ @Tab + 'ON (NAME =  ' + @SQuote + @SysFilesName + @SQuote + ',' + @CRLF  
+ @Tab + 'FILENAME = ' + @SQuote + @SysFilesFileName + '.' + @SnapDBName + @SQuote + ') '  + @CRLF
+ @Tab + 'AS SNAPSHOT OF ' + @DBName + ';' +  @CRLF

print @SQLText
exec (@SQLText)

end

go

if exists (select * from sysobjects where name = 'cspSnapShotRestore')
	drop procedure cspSnapShotRestore
go
create procedure cspSnapShotRestore (
	@SnapDBName nvarchar(256),
	@DBName nvarchar(256)
)
as
begin
declare 
	@SQLText nvarchar(max),
	@SQuote char(1), @Tab char(1), @CRLF char(2)

set @SQuote = char(39)
set @Tab = char(9)
set @CRLF = char(13) + char(10)

set @SQLText = 'RESTORE DATABASE ' + @DBName + ' from DATABASE_SNAPSHOT = '
	+ @SQuote + @SnapDBName + @SQuote
print @SQLText
exec (@SQLText)
end	
go
*/

declare @DBName nvarchar(max)
declare @SnapDBName nvarchar(max)
declare @IRDBName nvarchar(max)
declare @SnapIRDBName nvarchar(max)

set @DBName = 'db_ps'
set @SnapDBName = @DBName + 'db_ps_snap'
set @IRDBName = 'irdb_' + @DBName
set @SnapIRDBName = 'irdb_' + @SnapDBName


exec cspSnapShotCreate @DBName, @SnapDBName
--exec cspSnapShotCreate @IRDBName, @SnapIRDBName


/*
--exec cspSnapShotRestore @SnapDBName, @DBName

--exec cspSnapShotRestore @SnapIRDBName, @IRDBName
*/
CREATE DATABASE db_pssnap 
	ON (NAME =  'db_data1',
	FILENAME = 'H:\MSSQL.1\DATA\db_data1.ndf.db_psdb_ps_snap') ,
(NAME =  'db_data',
	FILENAME = 'H:\MSSQL.1\DATA\db_data.ndf.db_psdb_ps_snap') 

	AS SNAPSHOT OF db_ps;