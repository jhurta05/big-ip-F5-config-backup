#!/bin/bash

tmsh save /sys ucs /var/ucs/$(/bin/hostname)-$(date +\%Y-\%m-\%d).ucs

## Replace the <remote_user_name>, <sftp_IP_address> and <sftp_directory> as needed
HOST="10.111.1.158"
USERNAME="wanguy"
PASSWORD="Sandw1chDques01"

#sftp $USERNAME@$HOST <<EOF
#cd /Users/wanguy/Documents/F5_Backups/
#put /var/ucs/$(/bin/hostname)-$(date +\%Y-\%m-\%d).ucs
#bye
#EOF

expect <<EOF
spawn sftp $USERNAME@$HOST
expect "Password:"
send "$PASSWORD\n"
expect "sftp>"
send "cd /Users/wanguy/Documents/F5_Backups/\n"
expect "sftp>"
send "put /var/ucs/$(/bin/hostname)-$(date +\%Y-\%m-\%d).ucs\n"
expect "sftp>"
send "exit\n"
interact
EOF


## Optional: Uncomment the following line to delete the ucs file
tmsh delete /sys ucs /var/ucs/$(/bin/hostname)-$(date +\%Y-\%m-\%d).ucs



#crontab -e
#15 4 * * 0 /home/jhurta/backupscript.sh    ##Runs Weekly every Sunday at 4:15AM
#crontab -l
#touch backupscript.sh
#nano backupscript.sh
#chmod +x backupscript.sh
