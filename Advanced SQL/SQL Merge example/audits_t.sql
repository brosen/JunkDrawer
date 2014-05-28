CREATE TYPE [dbo].[Audits_T] AS TABLE
(
	  [AuditID] int,
      [Property] [nvarchar](50) NOT NULL,
      [Value] [nvarchar](2048) NOT NULL,
      [Readable] [nvarchar](2200) NOT NULL,
      [AuditUserID] [int] NOT NULL,
      [AuditTime] [datetime] NOT NULL,
      [ObjectID] [int] NULL,
      [Guid] [char](36) ,
      [ServerSyncDate] [datetime] NULL,
      [ObjectTypeID] [tinyint] NULL,
      [AuditSubCategoryID] [int] NULL
)
GO

CREATE TYPE [dbo].[AuditsOut_T] AS TABLE(
	[CurrentAction] [nvarchar](10) NULL,
	[OldId] [int] NULL,
	[Id] [int] NULL
)

