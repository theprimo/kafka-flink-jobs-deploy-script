:: clean up setup logs

@echo off

SET FLINK_HOME=C:\Software\flink-1.6.0
SET KAFKA_HOME=C:\Software\kafka_2.12-2.5.0
SET OTHER_LOG=C:\opt\

echo started cleanup of logs ...
timeout 2

echo cleaning up flink logs ...
CD %FLINK_HOME%
RMDIR /S /Q "%FLINK_HOME%\state_dir"
MD state_dir
RMDIR /S /Q "%FLINK_HOME%\log"
MD log

echo cleaning up kafka logs ...
CD %KAFKA_HOME%
RMDIR /S /Q "%KAFKA_HOME%\kafka-logs"
MD kafka-logs
RMDIR /S /Q "%KAFKA_HOME%\logs"
MD logs
RMDIR /S /Q "%KAFKA_HOME%\zookeeper-data"
MD zookeeper-data
RMDIR /S /Q "%OTHER_LOG%"

echo completed cleanup of logs ...
timeout 2
