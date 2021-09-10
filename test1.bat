@echo off

SET FLINK_BIN=C:\Software\flink-1.6.0\bin
SET PLATFORMS_HOME=C:\Software\git-projects\develop-sp

::start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.user.services.UserLoginJob %PLATFORMS_HOME%\platform-core-services\user-services\target\user-services-1.0.0.jar --config %PLATFORMS_HOME%\pulse-core-deploy\conf\config.properties
::timeout 8
::start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.user.services.UpdateUserJob  %PLATFORMS_HOME%\platform-core-services\user-services\target\user-services-1.0.0.jar
::timeout 8
::start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.customer.services.GetCustomerJob %PLATFORMS_HOME%\platform-core-services\customer-services\target\customer-services-1.0.0.jar --config %PLATFORMS_HOME%\pulse-core-deploy\conf\config.properties,policy-sources.json
::timeout 8
start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.customer.services.UpdateCustomerJob %PLATFORMS_HOME%\platform-core-services\customer-services\target\customer-services-1.0.0.jar --config %PLATFORMS_HOME%\pulse-core-deploy\conf\updatecustomer-services.conf,customerNotification.conf
timeout 8

