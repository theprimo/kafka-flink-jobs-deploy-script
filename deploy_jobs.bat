:: deploy flink jobs

@echo off

SET FLINK_BIN=C:\Software\flink-1.6.0\bin
SET PLATFORMS_HOME=C:\Software\git-projects\develop-sp
::SET PULSE_SERVICES=C:\Software\git-projects\pulse-services\develop
::SET WEARABLES_SERVICES_JAR=C:\Software\git-projects\develop-sp\wearables-services\wearable-services\target


echo started deploying jobs ...
timeout 2

::Platform services
start /B /D %FLINK_BIN% flink run -d -c com.prudential.platform.services.BootstrapJob %PLATFORMS_HOME%\platform-core-jobs\target\platform-core-jobs-1.0.0.jar
timeout 8

start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.content.services.ContentJob %PLATFORMS_HOME%\platform-core-services\content-services\target\content-services-1.0.0.jar
timeout 8
start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.content.services.GetResourceJob %PLATFORMS_HOME%\platform-core-services\content-services\target\content-services-1.0.0.jar
timeout 8
start /B /D %FLINK_BIN% flink run -d -c com.prudential.platform.services.read.ReadEntityJob %PLATFORMS_HOME%\platform-core-services\common-read-services\target\common-read-services-1.0.0.jar
timeout 8
start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.event.services.EventServiceJob %PLATFORMS_HOME%\platform-core-services\event-services\target\event-services-1.0.0.jar --config %PLATFORMS_HOME%\pulse-core-deploy\conf\events-exclusions.properties
timeout 8
start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.event.services.GetEventDetailsJob %PLATFORMS_HOME%\platform-core-services\event-services\target\event-services-1.0.0.jar
timeout 8
start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.message.services.MessageSenderJob %PLATFORMS_HOME%\platform-core-services\message-services\target\message-services-1.0.0.jar
timeout 8
::start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.message.services.EmailSenderJob %PLATFORMS_HOME%\platform-core-services\message-services\target\message-services-1.0.0.jar --config %PULSE_SERVICES%\vn-deploy\conf\message_config-vn.properties
::timeout 8

::start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.user.services.UserRegistrationJob %PLATFORMS_HOME%\platform-core-services\user-services\target\user-services-1.0.0.jar --config %PLATFORMS_HOME%\pulse-core-deploy\conf\config.properties
::timeout 8
start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.user.services.UserLoginJob %PLATFORMS_HOME%\platform-core-services\user-services\target\user-services-1.0.0.jar --config %PLATFORMS_HOME%\pulse-core-deploy\conf\config.properties
timeout 8
start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.user.services.UpdateUserJob  %PLATFORMS_HOME%\platform-core-services\user-services\target\user-services-1.0.0.jar
timeout 8
start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.customer.services.GetCustomerJob %PLATFORMS_HOME%\platform-core-services\customer-services\target\customer-services-1.0.0.jar --config %PLATFORMS_HOME%\pulse-core-deploy\conf\config.properties,policy-sources.json
timeout 8
start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.customer.services.UpdateCustomerJob %PLATFORMS_HOME%\platform-core-services\customer-services\target\customer-services-1.0.0.jar --config %PLATFORMS_HOME%\pulse-core-deploy\conf\updatecustomer-services.conf,customerNotification.conf
timeout 8

::start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.customer.services.SubmitFeedbackJob %PLATFORMS_HOME%\platform-core-services\customer-services\target\customer-services-1.0.0.jar 
::timeout 8
::start /B /D %FLINK_BIN% flink run -d -c com.prudential.platform.services.auth.RefreshTokenJob %PLATFORMS_HOME%\platform-core-jobs\target\platform-core-jobs-1.0.0.jar 
::timeout 8

::Wearables services
::start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.wearable.registration.jobs.WearableConnectionJob %WEARABLES_SERVICES_JAR%\wearable-services-1.0.0.jar --config %PLATFORMS_HOME%\wearables-deploy\conf\devices-conf.json --authConfig %PLATFORMS_HOME%\wearables-deploy\conf\wearables.properties
::timeout 8
::start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.wearable.reader.jobs.GetCustomerActivitiesJob %WEARABLES_SERVICES_JAR%\wearable-services-1.0.0.jar --config %PLATFORMS_HOME%\wearables-deploy\conf\devices-conf.json --authConfig %PLATFORMS_HOME%\wearables-deploy\conf\wearables.properties
::timeout 8
::start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.wearable.fetcher.jobs.ActivityFetcherJob %WEARABLES_SERVICES_JAR%\wearable-services-1.0.0.jar --config %PLATFORMS_HOME%\wearables-deploy\conf\devices-conf.json --authConfig %PLATFORMS_HOME%\wearables-deploy\conf\wearables.properties
::timeout 8
::start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.wearable.persister.jobs.ActivityPersisterJob %WEARABLES_SERVICES_JAR%\wearable-services-1.0.0.jar --config %PLATFORMS_HOME%\wearables-deploy\conf\devices-conf.json --authConfig %PLATFORMS_HOME%\wearables-deploy\conf\wearables.properties
::timeout 8
::start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.wearable.registration.jobs.WearableAuthorizationJob %WEARABLES_SERVICES_JAR%\wearable-services-1.0.0.jar --config %PLATFORMS_HOME%\wearables-deploy\conf\wearables.properties
::timeout 8

::Wearables http jobs
::start /B /D %FLINK_BIN% HttpJobDeployer run -d -c com.prudential.platform.services.transport.HttpSinkJob %PLATFORMS_HOME%\platform-core-jobs\target\platform-core-jobs-1.0.0.jar --config %PLATFORMS_HOME%\wearables-deploy\conf\fitbitapi.conf
::timeout 8
::start /B /D %FLINK_BIN% HttpJobDeployer run -d -c com.prudential.platform.services.transport.HttpSinkJob %PLATFORMS_HOME%\platform-core-jobs\target\platform-core-jobs-1.0.0.jar --config %PLATFORMS_HOME%\wearables-deploy\conf\googlefit.conf
::timeout 8
::start /B /D %FLINK_BIN% HttpJobDeployer run -d -c com.prudential.platform.services.transport.HttpSinkJob %PLATFORMS_HOME%\platform-core-jobs\target\platform-core-jobs-1.0.0.jar --config %PLATFORMS_HOME%\wearables-deploy\conf\googlefitapi.conf
::timeout 8
::start /B /D %FLINK_BIN% HttpJobDeployer run -d -c com.prudential.platform.services.transport.HttpSinkJob %PLATFORMS_HOME%\platform-core-jobs\target\platform-core-jobs-1.0.0.jar --config %PLATFORMS_HOME%\wearables-deploy\conf\garminAPI.conf
::timeout 8
::start /B /D %FLINK_BIN% HttpJobDeployer run -d -c com.prudential.platform.services.transport.HttpSinkJob %PLATFORMS_HOME%\platform-core-jobs\target\platform-core-jobs-1.0.0.jar --config %PLATFORMS_HOME%\wearables-deploy\conf\garminAuth.conf
::timeout 8

::ID services
::start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.policy.services.PolicyReadJob  C:\Software\flink-1.6.0\deploy\jobs\policy-services-0.0.1-SNAPSHOT.jar  --config C:\Software\flink-1.6.0\deploy\config\dpas-services-id.conf
::timeout 8
::start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.eclaim.services.GetEClaimReadJob C:\Software\flink-1.6.0\deploy\jobs\eclaim-services-0.0.1-SNAPSHOT.jar
::timeout 8
::start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.claim.services.ClaimReadJob C:\Software\flink-1.6.0\deploy\jobs\claim-services-0.0.1-SNAPSHOT.jar
::timeout 8
::start /B /D %FLINK_BIN% flink run -d -c com.prudential.prutopia.eclaim.services.SubmitEclaimJobNew C:\Software\flink-1.6.0\deploy\jobs\eclaim-services-0.0.1-SNAPSHOT.jar --config C:\Software\flink-1.6.0\deploy\config\eclaim-config.conf
::timeout 8

echo finished deploying jobs ...
timeout 3

