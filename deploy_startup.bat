:: start the setup

@echo off

SET FLINK_HOME=C:\Software\flink-1.6.0
SET KAFKA_HOME=C:\Software\kafka_2.12-2.5.0
SET DEPLOY_SETUP=C:\Software\deploy-setup\platforms

echo cleaning up the setup ...
timeout 2
start cmd.exe /c "%DEPLOY_SETUP%\deploy_cleanup.bat"
timeout 5

echo starting the setup ...
timeout 2

echo starting zookeeper ...
start cmd.exe /c ""%KAFKA_HOME%\bin\windows\zookeeper-server-start.bat" "%KAFKA_HOME%\config\zookeeper.properties""
timeout 20

echo starting kafka ...
start cmd.exe /c ""%KAFKA_HOME%\bin\windows\kafka-server-start.bat" "%KAFKA_HOME%\config\server.properties""
timeout 40

echo starting flink cluster ...
start cmd.exe /c "%FLINK_HOME%\bin\start-cluster.bat"
timeout 60

echo starting flink jobs ...
start cmd.exe /c "%DEPLOY_SETUP%\deploy_jobs.bat"
timeout 100

echo setup startup is complete ...
timeout 5

