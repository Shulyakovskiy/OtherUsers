﻿/*
Deployment script for Willow.Kermit.Database

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Willow.Kermit.Database"
:setvar DefaultFilePrefix "Willow.Kermit.Database"
:setvar DefaultDataPath "C:\Users\Peter\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\Projects\"
:setvar DefaultLogPath "C:\Users\Peter\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\Projects\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating [dbo].[Address]...';


GO
CREATE TABLE [dbo].[Address] (
    [Id]           INT            NOT NULL,
    [Adressee]     VARCHAR (1000) NULL,
    [Street]       INT            NULL,
    [NumberAndBus] VARCHAR (50)   NULL,
    [PTABegin]     DATETIME       NOT NULL,
    [PTAEnd]       DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Child]...';


GO
CREATE TABLE [dbo].[Child] (
    [Person]   INT      NOT NULL,
    [PTABegin] DATETIME NOT NULL,
    [PTAEnd]   DATETIME NULL,
    PRIMARY KEY CLUSTERED ([Person] ASC)
);


GO
PRINT N'Creating [dbo].[City]...';


GO
CREATE TABLE [dbo].[City] (
    [Id]      INT            NOT NULL,
    [ZipCode] VARCHAR (100)  NULL,
    [Name]    VARCHAR (1000) NOT NULL,
    [Country] INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Country]...';


GO
CREATE TABLE [dbo].[Country] (
    [Id]     INT           NOT NULL,
    [Name]   VARCHAR (200) NOT NULL,
    [Male]   VARCHAR (200) NULL,
    [Female] VARCHAR (200) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Family]...';


GO
CREATE TABLE [dbo].[Family] (
    [Id]       INT           NOT NULL,
    [Name]     VARCHAR (500) NULL,
    [PTABegin] DATETIME      NOT NULL,
    [PTAEnd]   DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[FamilyAddress]...';


GO
CREATE TABLE [dbo].[FamilyAddress] (
    [Id]       INT      NOT NULL,
    [Family]   INT      NOT NULL,
    [Address]  INT      NOT NULL,
    [PTABegin] DATETIME NOT NULL,
    [PTAEnd]   DATETIME NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[FamilyParticipants]...';


GO
CREATE TABLE [dbo].[FamilyParticipants] (
    [Id]       INT      NOT NULL,
    [Family]   INT      NOT NULL,
    [Person]   INT      NOT NULL,
    [Relation] INT      NULL,
    [PTABegin] DATETIME NOT NULL,
    [PTAEnd]   DATETIME NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Person]...';


GO
CREATE TABLE [dbo].[Person] (
    [Id]               INT            IDENTITY (1, 1) NOT NULL,
    [FirstName]        VARCHAR (500)  NULL,
    [LastName]         VARCHAR (1000) NULL,
    [MiddleName]       VARCHAR (1000) NULL,
    [BirthDate]        DATE           NULL,
    [BirthPlace]       INT            NULL,
    [Nationality]      INT            NULL,
    [Sex]              CHAR (1)       NULL,
    [IdentityCard]     VARCHAR (100)  NULL,
    [NationalRegister] VARCHAR (100)  NULL,
    [PTABegin]         DATETIME       NOT NULL,
    [PTAEnd]           DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Relation]...';


GO
CREATE TABLE [dbo].[Relation] (
    [Id]   INT           NOT NULL,
    [Name] VARCHAR (500) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating [dbo].[Relative]...';


GO
CREATE TABLE [dbo].[Relative] (
    [Person]     INT            NOT NULL,
    [Profession] VARCHAR (1000) NULL,
    [Comment]    VARCHAR (5000) NULL,
    [PTABegin]   DATETIME       NOT NULL,
    [PTAEnd]     DATETIME       NULL,
    PRIMARY KEY CLUSTERED ([Person] ASC)
);


GO
PRINT N'Creating [dbo].[Street]...';


GO
CREATE TABLE [dbo].[Street] (
    [Id]   INT           NOT NULL,
    [Name] VARCHAR (500) NOT NULL,
    [City] INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating FK_Address_To_Street...';


GO
ALTER TABLE [dbo].[Address]
    ADD CONSTRAINT [FK_Address_To_Street] FOREIGN KEY ([Street]) REFERENCES [dbo].[Street] ([Id]);


GO
PRINT N'Creating FK_Child_To_Person...';


GO
ALTER TABLE [dbo].[Child]
    ADD CONSTRAINT [FK_Child_To_Person] FOREIGN KEY ([Person]) REFERENCES [dbo].[Person] ([Id]);


GO
PRINT N'Creating FK_City_To_Country...';


GO
ALTER TABLE [dbo].[City]
    ADD CONSTRAINT [FK_City_To_Country] FOREIGN KEY ([Country]) REFERENCES [dbo].[Country] ([Id]);


GO
PRINT N'Creating FK_FamilyAddress_ToFamily...';


GO
ALTER TABLE [dbo].[FamilyAddress]
    ADD CONSTRAINT [FK_FamilyAddress_ToFamily] FOREIGN KEY ([Family]) REFERENCES [dbo].[Family] ([Id]);


GO
PRINT N'Creating FK_FamilyAddress_ToAddress...';


GO
ALTER TABLE [dbo].[FamilyAddress]
    ADD CONSTRAINT [FK_FamilyAddress_ToAddress] FOREIGN KEY ([Address]) REFERENCES [dbo].[Address] ([Id]);


GO
PRINT N'Creating FK_FamilyParticipants_To_Family...';


GO
ALTER TABLE [dbo].[FamilyParticipants]
    ADD CONSTRAINT [FK_FamilyParticipants_To_Family] FOREIGN KEY ([Family]) REFERENCES [dbo].[Family] ([Id]);


GO
PRINT N'Creating FK_FamilyParticipants_To_Person...';


GO
ALTER TABLE [dbo].[FamilyParticipants]
    ADD CONSTRAINT [FK_FamilyParticipants_To_Person] FOREIGN KEY ([Person]) REFERENCES [dbo].[Person] ([Id]);


GO
PRINT N'Creating FK_FamilyParticipants_To_Relation...';


GO
ALTER TABLE [dbo].[FamilyParticipants]
    ADD CONSTRAINT [FK_FamilyParticipants_To_Relation] FOREIGN KEY ([Relation]) REFERENCES [dbo].[Relation] ([Id]);


GO
PRINT N'Creating FK_Person_To_Country...';


GO
ALTER TABLE [dbo].[Person]
    ADD CONSTRAINT [FK_Person_To_Country] FOREIGN KEY ([Nationality]) REFERENCES [dbo].[Country] ([Id]);


GO
PRINT N'Creating FK_Person_To_City...';


GO
ALTER TABLE [dbo].[Person]
    ADD CONSTRAINT [FK_Person_To_City] FOREIGN KEY ([BirthPlace]) REFERENCES [dbo].[City] ([Id]);


GO
PRINT N'Creating FK_Relative_To_Person...';


GO
ALTER TABLE [dbo].[Relative]
    ADD CONSTRAINT [FK_Relative_To_Person] FOREIGN KEY ([Person]) REFERENCES [dbo].[Person] ([Id]);


GO
PRINT N'Creating FK_Street_To_City...';


GO
ALTER TABLE [dbo].[Street]
    ADD CONSTRAINT [FK_Street_To_City] FOREIGN KEY ([City]) REFERENCES [dbo].[City] ([Id]);


GO
PRINT N'Creating CK_Person_Sex...';


GO
ALTER TABLE [dbo].[Person]
    ADD CONSTRAINT [CK_Person_Sex] CHECK (Sex IN ('M','V'));


GO
PRINT N'Creating [dbo].[Address].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PTA Candidate', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Address';


GO
PRINT N'Creating [dbo].[Child].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PTA Candidate', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Child';


GO
PRINT N'Creating [dbo].[Family].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PTA Candidate', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Family';


GO
PRINT N'Creating [dbo].[FamilyAddress].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PTA Candidate', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FamilyAddress';


GO
PRINT N'Creating [dbo].[FamilyParticipants].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PTA Candidate', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FamilyParticipants';


GO
PRINT N'Creating [dbo].[Person].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PTA Candidate', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Person';


GO
PRINT N'Creating [dbo].[Relative].[MS_Description]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PTA Candidate', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Relative';


GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'cdcdf74f-fd15-4403-bc8e-fa0e046014f3')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('cdcdf74f-fd15-4403-bc8e-fa0e046014f3')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6197efea-2baf-46df-9545-a4dd81c34b8b')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6197efea-2baf-46df-9545-a4dd81c34b8b')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '470993a0-0775-46d6-8946-fbd13a0cbf93')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('470993a0-0775-46d6-8946-fbd13a0cbf93')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '9f6e563a-2200-484e-b059-e5f898f987ef')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('9f6e563a-2200-484e-b059-e5f898f987ef')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a0aeac4e-9f7c-476c-b50f-a243adeeb696')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a0aeac4e-9f7c-476c-b50f-a243adeeb696')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '0cf7dc00-dd16-4bdd-8b6c-7af0685b7139')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('0cf7dc00-dd16-4bdd-8b6c-7af0685b7139')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '416de8c2-e379-41c8-a348-5532fbf570ef')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('416de8c2-e379-41c8-a348-5532fbf570ef')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '30006b75-12f7-4b3c-8aa5-348ff15e3590')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('30006b75-12f7-4b3c-8aa5-348ff15e3590')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.'
GO
