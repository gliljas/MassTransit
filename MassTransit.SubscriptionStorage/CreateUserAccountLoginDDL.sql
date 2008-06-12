PRINT '<<- Using Master to set up Login permissions ->>'
GO

USE [master]
GO

IF EXISTS(SELECT * FROM msdb.sys.syslogins WHERE UPPER([name]) = 'APP-MASSTRANSITSUBSCRIPTIONMANAGER') 
  BEGIN
	DROP LOGIN [App-MassTransitSubscriptionManager]
	PRINT '<<< REMOVED INSTANCE LOGIN FOR App-MassTransitSubscriptionManager >>>'
  END
GO

CREATE LOGIN [App-MassTransitSubscriptionManager] WITH PASSWORD=N'MT!sTh3B0mb', DEFAULT_DATABASE=[MassTransitSubscriptions], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
PRINT '<<< CREATED INSTANCE LOGIN FOR App-MassTransitSubscriptionManager >>>'
GO

PRINT '<<- Switching to MassTransit Subscriptions for remainder of permissions ->>'
GO
USE [MassTransitSubscriptions]
GO

IF EXISTS(SELECT * FROM sys.sysusers WHERE UPPER([name]) = 'APP-MASSTRANSITSUBSCRIPTIONMANAGER') 
  BEGIN
	DROP USER [App-MassTransitSubscriptionManager]
	PRINT '<<< REMOVED MassTransitSubscriptions Security Login for App-MassTransitSubscriptionManager >>>'
  END
GO


CREATE USER [App-MassTransitSubscriptionManager] FOR LOGIN [App-MassTransitSubscriptionManager]
GO
PRINT '<<< CREATED MassTransitSubscriptions Security Login for App-MassTransitSubscriptionManager >>>'
GO


EXEC sp_addrolemember N'db_datareader', N'App-MassTransitSubscriptionManager'
GO
PRINT '<<< Added App-MassTransitSubscriptionManager to the db_datareader group for MassTransitSubscriptions >>>'
GO
EXEC sp_addrolemember N'db_datawriter', N'App-MassTransitSubscriptionManager'
GO
PRINT '<<< Added App-MassTransitSubscriptionManager to the db_datawriter group for MassTransitSubscriptions >>>'
GO
