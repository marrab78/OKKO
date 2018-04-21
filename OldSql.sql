USE SYNCO;
/*---------------------ListValueCateGOries Table*/

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListValueCateGOries]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1 AND Type = 'U')
BEGIN
    CREATE TABLE [dbo].ListValueCateGOries
    (
        Id                INT IDENTITY(1, 1) NOT Null,
        Name            NVARCHAR(50) NOT Null,
        AllowAdd        BIT NOT Null,
        AllowEdit        BIT NOT Null,
        [CreatedOn]        [datetimeoffset](7) NOT NULL,
        [CreatedBy]        [INT] NOT NULL,
        [ModifiedOn]    [datetimeoffset](7) NOT NULL,
        [ModifiedBy]    [INT] NOT NULL
    )
END
GO


--

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE  CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_NAME = 'ListValueCateGOries' AND TABLE_SCHEMA ='dbo'
                AND CONSTRAINT_Name = 'PK_ListValueCateGOriesId')
BEGIN
    ALTER TABLE [dbo].ListValueCateGOries ADD  CONSTRAINT PK_ListValueCateGOriesId PRIMARY KEY CLUSTERED ([ID] ASC)
END
GO

---------------------ListValues Table

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[ListValues]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1 AND Type = 'U')
BEGIN
    CREATE TABLE [dbo].ListValues
    (
        Id                INT IDENTITY(1, 1) NOT Null,
        CateGOryId        INT NOT Null,
        Name            NVARCHAR(50) NOT Null,
        Code            NVARCHAR(50) NOT Null,
        Ordinal            INT NOT Null,
        IsEnabled        BIT NOT null,
        [CreatedOn]        [datetimeoffset](7) NOT NULL,
        [CreatedBy]        [INT] NOT NULL,
        [ModifiedOn]    [datetimeoffset](7) NOT NULL,
        [ModifiedBy]    [INT] NOT NULL
    )
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE  CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_NAME = 'ListValues' AND TABLE_SCHEMA ='dbo'
                AND CONSTRAINT_Name = 'PK_ListValuesId')
BEGIN
    ALTER TABLE [dbo].ListValues ADD  CONSTRAINT PK_ListValuesId PRIMARY KEY CLUSTERED ([ID] ASC)
END
GO

If NOT Exists (SELECT * 
           FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_ListValues_CateGOry]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[ListValues]'))
BEGIN
    ALTER TABLE ListValues ADD CONSTRAINT FK_ListValues_CateGOry FOREIGN KEY(CateGOryId)REFERENCES ListValueCateGOries(Id)
END
GO 

---------------------Users Table

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Users]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1 AND Type = 'U')
BEGIN
    CREATE TABLE [dbo].[Users](
        [Id]                [INT] IDENTITY(1,1) NOT NULL,
        [UserName]            [NVARCHAR](50) NOT NULL,
        [HashedPassword]    [NVARCHAR](256) NOT NULL,
        [TypeId]            [INT] NOT NULL,
        [TypeEntityId]        [INT] NOT NULL,
        [LanguageId]        [INT] NOT NULL,
        StatusId            INT NOT NULL,
        [Token]                [NVARCHAR](50) NULL,
        [IpAddress]            [NVARCHAR](50) NOT NULL,
        [FirstName]            [NVARCHAR](50) NOT NULL,
        [LastName]            [NVARCHAR](50) NOT NULL,
        [LastLogin]            [datetimeoffset](7) NULL,
        [Phone]                [NVARCHAR](50) NULL,
        [Fax]                [NVARCHAR](50) NULL,
        [CreatedOn]            [datetimeoffset](7) NOT NULL,
        [CreatedBy]            [INT] NOT NULL,
        [ModifiedOn]        [datetimeoffset](7) NOT NULL,
        [ModifiedBy]        [INT] NOT NULL
    )
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE  CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_NAME = 'Users' AND TABLE_SCHEMA ='dbo'
                AND CONSTRAINT_Name = 'PK_UserId')
BEGIN
    ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [PK_UserId] PRIMARY KEY CLUSTERED ([ID] ASC)
END
GO

IF NOT EXISTS (SELECT * 
           FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_Users_Language]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[Users]'))
BEGIN
    ALTER TABLE [Users] ADD CONSTRAINT FK_Users_Language FOREIGN KEY(LanguageId) REFERENCES ListValues(Id)
END
GO 

IF NOT EXISTS (SELECT * 
           FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_Users_Status]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[Users]'))
BEGIN
    ALTER TABLE [Users] ADD CONSTRAINT FK_Users_Status FOREIGN KEY(StatusId) REFERENCES ListValues(Id)
END
GO

IF NOT EXISTS (SELECT * 
           FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_Users_UserType]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[Users]'))
BEGIN
    ALTER TABLE [Users] ADD CONSTRAINT FK_Users_UserType FOREIGN KEY(TypeId) REFERENCES ListValues(Id)
END
GO 

---------------------Role Table

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Role]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1 AND Type = 'U')
BEGIN
    CREATE TABLE [dbo].[Role]
    (
        [ID]            [INT] IDENTITY(1,1) NOT NULL,
        Description        [NVARCHAR](60) NOT NULL,
        [Active]        [BIT] NOT NULL,
        [CreatedOn]        [datetimeoffset](7) NOT NULL,
        [CreatedBy]        [INT] NOT NULL,
        [ModifiedOn]    [datetimeoffset](7) NOT NULL,
        [ModifiedBy]    [INT] NOT NULL
    )
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE  CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_NAME = 'Role' AND TABLE_SCHEMA ='dbo'
                AND CONSTRAINT_Name = 'PK_RoleId')
BEGIN
    ALTER TABLE [dbo].[Role] ADD  CONSTRAINT [PK_RoleId] PRIMARY KEY CLUSTERED ([ID] ASC)
END
GO


---------------------UserRole Table

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[UserRole]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1 AND Type = 'U')
BEGIN
    CREATE TABLE [dbo].[UserRole]
    (
        Id                INT IDENTITY(1, 1) NOT Null,
        [UserID]        [INT] NOT NULL,
        [RoleID]        [INT] NOT NULL,
        [ExpiryDate]    [datetime] NULL,
        [CreatedOn]        [datetimeoffset](7) NOT NULL,
        [CreatedBy]        [INT] NOT NULL,
        [ModifiedOn]    [datetimeoffset](7) NOT NULL,
        [ModifiedBy]    [INT] NOT NULL
    )
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE  CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_NAME = 'UserRole' AND TABLE_SCHEMA ='dbo'
                AND CONSTRAINT_Name = 'PK_UserRoleId')
BEGIN
    ALTER TABLE [dbo].UserRole ADD  CONSTRAINT [PK_UserRoleId] PRIMARY KEY CLUSTERED ([ID] ASC)
END
GO

If NOT Exists (SELECT * 
           FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRole_User]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[UserRole]'))
BEGIN
    ALTER TABLE [UserRole] ADD CONSTRAINT FK_UserRole_User FOREIGN KEY(UserId)REFERENCES Users(Id)
END
GO 

If NOT Exists (SELECT * 
           FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRole_Role]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[UserRole]'))
BEGIN
    ALTER TABLE [UserRole] ADD CONSTRAINT FK_UserRole_Role FOREIGN KEY(RoleId)REFERENCES [Role](Id)
END
GO 

If NOT Exists(SELECT * from sys.key_CONSTRAINTs Where Name = 'UQ_Usser_Role' AND Type = 'UQ')
BEGIN
    ALTER TABLE [UserRole] ADD CONSTRAINT UQ_Usser_Role UNIQUE NONCLUSTERED
    (
        UserId,
        RoleId
    )
END
GO

---------------------RoleActionPermission Table

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[RoleActionPermission]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1 AND Type = 'U')
BEGIN
    CREATE TABLE [dbo].[RoleActionPermission]
    (
        Id                INT IDENTITY(1, 1) NOT Null,
        [RoleId]        [INT] NOT NULL,
        Controller        NVARCHAR(50) NOT Null,
        [Action]        NVARCHAR(50) NOT NULL,
        IsReadOnly        BIT NOT Null,
        ExcludeAccess    BIT NOT Null,
        [CreatedOn]        [datetimeoffset](7) NOT NULL,
        [CreatedBy]        [INT] NOT NULL,
        [ModifiedOn]    [datetimeoffset](7) NOT NULL,
        [ModifiedBy]    [INT] NOT NULL
    )
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE  CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_NAME = 'RoleActionPermission' AND TABLE_SCHEMA ='dbo'
                AND CONSTRAINT_Name = 'PK_RoleActionPermissionId')
BEGIN
    ALTER TABLE [dbo].[RoleActionPermission] ADD  CONSTRAINT PK_RoleActionPermissionId PRIMARY KEY CLUSTERED ([ID] ASC)
END
GO

If NOT Exists (SELECT * 
           FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_RoleActionPermission_Role]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[RoleActionPermission]'))
BEGIN
    ALTER TABLE [RoleActionPermission] ADD CONSTRAINT FK_RoleActionPermission_Role FOREIGN KEY(RoleId)REFERENCES [Role](Id)
END
GO 

---------------------LanguageTranslations Table

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[LanguageTranslations]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1 AND Type = 'U')
BEGIN
    CREATE TABLE [dbo].LanguageTranslations
    (
        Id                INT IDENTITY(1, 1) NOT Null,
        Language        NVARCHAR(10) NOT Null,
        Prefix            NVARCHAR(100) NOT Null,
        Name            NVARCHAR(100) NOT Null,
        Translation        NVARCHAR(500) NOT Null,
        [CreatedOn]        [datetimeoffset](7) NOT NULL,
        [CreatedBy]        [INT] NOT NULL,
        [ModifiedOn]    [datetimeoffset](7) NOT NULL,
        [ModifiedBy]    [INT] NOT NULL
    )
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE  CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_NAME = 'LanguageTranslations' AND TABLE_SCHEMA ='dbo'
                AND CONSTRAINT_Name = 'PK_LanguageTranslationsId')
BEGIN
    ALTER TABLE [dbo].LanguageTranslations ADD  CONSTRAINT PK_LanguageTranslationsId PRIMARY KEY CLUSTERED ([ID] ASC)
END
GO

If NOT Exists(SELECT * from sys.key_CONSTRAINTs Where Name = 'UQ_Language_Prefix' AND Type = 'UQ')
BEGIN
    ALTER TABLE LanguageTranslations ADD CONSTRAINT UQ_Language_Prefix UNIQUE NONCLUSTERED
    (
        Language,
        Prefix,
        Name
    )
END
GO

---------------------Applicant Table

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Applicant]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1 AND Type = 'U')
BEGIN
        CREATE TABLE [dbo].[Applicant](
            [Id]            [INT] IDENTITY(1,1) NOT NULL,
            [First_Name]    [NVARCHAR](50) NOT NULL,
            [Last_Name]        [nchar](50) NOT NULL,
            [CreatedOn]        [datetimeoffset](7) NOT NULL,
            [CreatedBy]        [INT] NOT NULL,
            [ModifiedOn]    [datetimeoffset](7) NOT NULL,
            [ModifiedBy]    [INT] NOT NULL
        )
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE  CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_NAME = 'Applicant' AND TABLE_SCHEMA ='dbo'
                AND CONSTRAINT_Name = 'PK_Applicant')
BEGIN
    ALTER TABLE [dbo].Applicant ADD  CONSTRAINT [PK_Applicant] PRIMARY KEY CLUSTERED ([ID] ASC)
END

GO

---------------------Dealer Table

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Dealer]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1 AND Type = 'U')
BEGIN
        CREATE TABLE [dbo].[Dealer](
            [ID]            [INT] NOT NULL,
            [DealerName]    [varchar](max) NOT NULL,
            [CreatedOn]        [datetimeoffset](7) NOT NULL,
            [CreatedBy]        [INT] NOT NULL,
            [ModifiedOn]    [datetimeoffset](7) NOT NULL,
            [ModifiedBy]    [INT] NOT NULL
        )
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE  CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_NAME = 'Dealer' AND TABLE_SCHEMA ='dbo'
                AND CONSTRAINT_Name = 'PK_Dealer')
BEGIN
    ALTER TABLE [dbo].[Dealer] ADD  CONSTRAINT [PK_Dealer] PRIMARY KEY CLUSTERED ([ID] ASC)
END

---------------------Transaction Table

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Transaction]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1 AND Type = 'U')
BEGIN
        CREATE TABLE [dbo].[Transaction](
            [ID]            [INT] NOT NULL,
            [Type]            [nchar](10) NOT NULL,
            [DealerID]        [INT] NOT NULL,
            [CreatedOn]        [datetimeoffset](7) NOT NULL,
            [CreatedBy]        [INT] NOT NULL,
            [ModifiedOn]    [datetimeoffset](7) NOT NULL,
            [ModifiedBy]    [INT] NOT NULL
        )
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE  CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_NAME = 'Transaction' AND TABLE_SCHEMA ='dbo'
                AND CONSTRAINT_Name = 'PK_Transaction')
BEGIN
    ALTER TABLE [dbo].[Transaction] ADD  CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED ([ID] ASC)
END


If NOT Exists (SELECT * 
           FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_Transaction_Dealer]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[Transaction]'))
BEGIN
    ALTER TABLE [Transaction] ADD CONSTRAINT FK_Transaction_Dealer FOREIGN KEY([ID])REFERENCES [dbo].[Dealer] ([ID])
END
GO

If NOT Exists (SELECT * 
           FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_Transaction_Applicant]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[Transaction]'))
BEGIN
    ALTER TABLE [Transaction] ADD CONSTRAINT FK_Transaction_Applicant FOREIGN KEY([ID]) REFERENCES [dbo].[Applicant] ([Id])
END
GO

---------------------TransApplicant Table

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[TransApplicant]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1 AND Type = 'U')
BEGIN
        CREATE TABLE [dbo].[TransApplicant](
            [TransId]        [INT] NOT NULL,
            [ApplicantId]    [INT] NOT NULL,
            [CoApplicant]    [BIT] NOT NULL,
            [CreatedOn]        [datetimeoffset](7) NOT NULL,
            [CreatedBy]        [INT] NOT NULL,
            [ModifiedOn]    [datetimeoffset](7) NOT NULL,
            [ModifiedBy]    [INT] NOT NULL
        )
END
GO

If NOT Exists (SELECT * 
           FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_TransApplicant_Applicant]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[TransApplicant]'))
BEGIN
    ALTER TABLE [TransApplicant] ADD CONSTRAINT FK_TransApplicant_Applicant FOREIGN KEY([ApplicantId]) REFERENCES [dbo].[Applicant] ([Id])
END
GO

If NOT Exists (SELECT * 
           FROM sys.foreign_keys 
           WHERE object_id = OBJECT_ID(N'[dbo].[FK_TransApplicant_Transaction]') 
             AND parent_object_id = OBJECT_ID(N'[dbo].[TransApplicant]'))
BEGIN
    ALTER TABLE [TransApplicant] ADD CONSTRAINT FK_TransApplicant_Transaction FOREIGN KEY([TransId]) REFERENCES [dbo].[Transaction] ([ID])
END
GO


