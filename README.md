# generate-plaso
Bash Script to generate plaso file from E01 using log2timeline

When generating Plaso files for ingesting data into Timesketch, the version of log2timeline needs to match the version used by timesketch to prevent import errors. The easiest way to ensure the versions match is to use the log2timeline script that is in the timesketch image you are running. This script automates the process of doing this. 

Example usage:
```
sh ./generate-plaso.sh /path/to/evidence.E01
```
