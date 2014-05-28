create PROCEDURE [dbo].[spMigrationAuditBulkInsert]
(
	@SubjectId int,
	@MigrationRunId int,
	@inputTable Audits_T READONLY
)
AS
BEGIN
    DECLARE @output AuditsOut_T;
    
	MERGE Audits AS targetTable
	USING @inputTable AS udt
	ON (targetTable.AuditId = udt.AuditId )
	WHEN MATCHED 
		THEN UPDATE SET 
			Property = udt.Property,
			Value = udt.Value,
			Readable = udt.Readable,
			AuditUserID = udt.AuditUserID,
			AuditTime = udt.AuditTime,
			ObjectID = udt.ObjectID,
			[Guid] = udt.[Guid],
			ServerSyncDate = udt.ServerSyncDate,
			ObjectTypeID = udt.ObjectTypeID,
			AuditSubCategoryID = udt.AuditSubCategoryID
	WHEN NOT MATCHED THEN
		INSERT (
			Property,
			Value,
			Readable,
			AuditUserID,
			AuditTime,
			ObjectID,
			[Guid],
			ServerSyncDate,
			ObjectTypeID,
			AuditSubCategoryID
		)
		VALUES (
			udt.Property,
			udt.Value,
			udt.Readable,
			udt.AuditUserID,
			udt.AuditTime,
			udt.ObjectID,
			udt.[Guid],
			udt.ServerSyncDate,
			udt.ObjectTypeID,
			udt.AuditSubCategoryID
		)
	OUTPUT 
		$action,
		CASE WHEN $action = 'INSERT' then udt.AuditId else null END,
		CASE WHEN $action = 'INSERT' then inserted.AuditId else deleted.AuditId END
	INTO @output 
	OPTION (loop JOIN);


	insert into MigrationEventAudits(AuditId,SubjectId,MigrationRunId)
	select AuditId,@SubjectId,@MigrationRunId
	FROM @output
	
	SELECT  CurrentAction, 
			OldId, 
			Id
	FROM @output
END


--endregion

