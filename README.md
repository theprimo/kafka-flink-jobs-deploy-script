# kafka-flink-jobs-deploy-script
# helper doc to understand what this setup does & how to use it

# What it does
It eliminates the manual process of local kafka & flink startup and flink jobs deployment.

Step wise:
1. cleans up the kafka & flink logs
2. starts zookeeper & kafka 
3. starts flink cluster & deploys flink jobs

# Setup files
1. deploy_cleanup.bat
2. deploy_startup.bat
3. deploy_jobs.bat

# How to use
1. place the aboove 3 files in a folder.
2. change the paths accordingly in all 3 files.
3. run the script file - deploy_startup.bat

