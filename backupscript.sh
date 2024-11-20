#!/bin/bash

#Creates a backup config file and put it in the /var/ucs/ directory.
tmsh save /sys ucs /var/ucs/$(/bin/hostname)-$(date +\%Y-\%m-\%d).ucs

## Replace the YOUR_USERNAME, HOST_IP_OR_NAME and YOUR_PASSWORD as needed:
HOST="HOST_IP_OR_NAME"
USERNAME="YOUR_USERNAME"
PASSWORD="YOUR_PASSWORD"

#This section will create the connection to the SFTP server using the credentials provided above, change directory 
#to the one where you want the file to be stored and put(upload) the backupt file into the the SFTP server.
expect <<EOF
spawn sftp $USERNAME@$HOST
expect "Password:"
send "$PASSWORD\n"
expect "sftp>"
send "cd /Users/SFTP_SERVER_FOLDER_PATH/\n"
expect "sftp>"
send "put /var/ucs/$(/bin/hostname)-$(date +\%Y-\%m-\%d).ucs\n"
expect "sftp>"
send "exit\n"
interact
EOF


## Optional: Uncomment the following line to delete the ucs file from the F5
tmsh delete /sys ucs /var/ucs/$(/bin/hostname)-$(date +\%Y-\%m-\%d).ucs



#crontab -e
#15 4 * * 0 /home/tasks/backupscript.sh    ##Runs Weekly every Sunday at 4:15AM
#crontab -l
#touch backupscript.sh
#nano backupscript.sh
#chmod +x backupscript.sh
