/*
 * README: Please be sure to update the database and log file location if it doesn't exist.
 * There are two places below where it says FILENAME that will need to be updated.
 * Press [Ctrl][Shift]M in Sql Management Studio to replace the parameters
 */

USE [master]
GO


IF NOT EXISTS(SELECT * FROM sysdatabases WHERE UPPER([name]) = 'MASSTRANSITSUBSCRIPTIONS')
  BEGIN 
	CREATE DATABASE [MassTransitSubscriptions] ON  PRIMARY 
	(	NAME ='MassTransitSubscriptions'
		,FILENAME = <database_area, sysname, 'E:\mssql\sqldata\'> + 'MassTransitSubscriptions.mdf' 
		,SIZE = 2048KB
		,FILEGROWTH = 1024KB 
	)
	 LOG ON 
	(	NAME ='MassTransitSubscriptions_log'
		,FILENAME =<database_area, sysname, 'E:\mssql\sqldata\'> + 'MassTransitSubscriptions_log.ldf' 
		,SIZE = 1024KB 
		,FILEGROWTH = 10%
	)

	PRINT '<<< CREATED DATABASE FOR MassTransitSubscriptions >>>'
  END
GO

EXEC dbo.sp_dbcmptlevel @dbname='MassTransitSubscriptions', @new_cmptlevel=90
GO
PRINT '<<< SET MassTransitSubscriptions to SQLServer2005 Format (90). >>>'
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MassTransitSubscriptions].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [MassTransitSubscriptions] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MassTransitSubscriptions] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MassTransitSubscriptions] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MassTransitSubscriptions] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MassTransitSubscriptions] SET ARITHABORT OFF 
GO
ALTER DATABASE [MassTransitSubscriptions] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MassTransitSubscriptions] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [MassTransitSubscriptions] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MassTransitSubscriptions] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MassTransitSubscriptions] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MassTransitSubscriptions] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MassTransitSubscriptions] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MassTransitSubscriptions] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MassTransitSubscriptions] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MassTransitSubscriptions] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MassTransitSubscriptions] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MassTransitSubscriptions] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MassTransitSubscriptions] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MassTransitSubscriptions] SET  READ_WRITE 
GO
ALTER DATABASE [MassTransitSubscriptions] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MassTransitSubscriptions] SET  MULTI_USER 
GO
ALTER DATABASE [MassTransitSubscriptions] SET PAGE_VERIFY CHECKSUM  
GO
USE [MassTransitSubscriptions]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [MassTransitSubscriptions] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO
