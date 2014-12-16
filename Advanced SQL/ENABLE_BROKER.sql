/*
Enable Broker
*/

USE [master]
GO
--Next 2 if Borker is not unique
ALTER DATABASE [brad20140] SET DISABLE_BROKER
GO
ALTER DATABASE [brad20140] SET NEW_BROKER
GO
ALTER DATABASE [brad20140] SET ENABLE_BROKER



GO
ALTER DATABASE csl3_nov25_AT SET ENABLE_BROKER WITH ROLLBACK IMMEDIATE
GO
SELECT is_broker_enabled FROM sys.databases WHERE name = 'MyDB'
GO

--Kill Any processes
DECLARE @dbname sysname
SET @dbname = 'MyDB'
DECLARE @spid int
SELECT @spid = min(spid) from master.dbo.sysprocesses where dbid = db_id(@dbname)
WHILE @spid IS NOT NULL
BEGIN
	EXECUTE ('KILL ' + @spid)
	SELECT @spid = min(spid) from master.dbo.sysprocesses where dbid = db_id(@dbname) AND spid > @spid
END
