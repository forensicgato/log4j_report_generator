# log4j_report_generator
Based on logs by https://github.com/mergebase/log4j-detector. Very rudimentary.

## how to

1. generate txt via log4j-detector.
    
example: .\java -jar log4j-detector.jar C:\ > C:\exampleServer.txt

2. copy the txt to the logs folder OR change the $logLocation variable to the path where the logs are

3. run log4j_generateReport.ps1

4. Enjoy your freshly baked csv report