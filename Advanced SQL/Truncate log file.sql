BACKUP LOG  databasename  WITH TRUNCATE_ONLY
GO
DBCC SHRINKFILE (  databasename_Log, 1)
