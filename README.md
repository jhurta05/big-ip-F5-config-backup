BIG IP F5 AUTOMATED BACKUP AND SENDS THE BACKUP TO A REMOTE SERVER USING SFTP

You can find the official guide here: https://my.f5.com/manage/s/article/K13418#cron , however, it is designed to work with SCP and it doesn't automate the upload of the backup file to a remote server.

The STEPS are the following:

1. Create a directory to where the backup will be stored:

mkdir /var/ucs

2. Edit the contrab utility to automate how often you want it to run the script, this will allow you to edit the file by using the vi editor:

contrab -e

You can use crontab -l to confirm the line has been added.

3. Add the frequency of the backup and the location of the script to run, you can find frequency options here https://my.f5.com/manage/s/article/K13418#cron :

15 4 * * 0 /home/YOUR_USERNAME/backupscript.sh    ##Runs Weekly every Sunday at 4:15AM

4. Create the file that will have the parameters:

touch backupscript.sh

5. Change the mode of the file to an executable:

chmod +x backupscript.sh

6. Add parameters to the file that will have the script, in this case I use nano to access and edit the file:

nano backupscript.sh

7. Copy and Paste the script from https://github.com/jhurta05/big-ip-F5-config-backup/blob/main/backupscript.sh :

ATTENTION: Make sure to add your SFTP server username and password. Also, make sure to edit the PATH to where you want to store the backup in the SFTP server.

8. Test the script:

You can test it by doing ./backupscript.sh


NOTE: You might be able to find another option to do this backup by the use of the sshpass, however, I've found that the F5 won't allow me to do apt, apt-get, or wget command, it also won't pull the sshpass package if you do install sshpass. This script uses expect which is a package that is already installed on the F5 by default and it allows the system to access the SFTP server, as this is an interactive connection, the expect automates the password authentication.





