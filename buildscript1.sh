#!/bin/bash

#################################################################################################################################
# Name:         Caden Hong                                                                                                      #
#                                                                                                                               #
# Date:         July 31, 2022                                                                                                   #
#                                                                                                                               #
# Crontab:      Non-root user:  0 23 * * 5 cadenhong /home/cadenhong/bin/buildscript1.sh                                        #
#               Root user:      0 23 * * 5 root /home/cadenhong/bin/buildscript1.sh                                             #
#                                                                                                                               #
# Description:  This script will automatically update the server every Friday at 11pm.                                          #
#                       PREREQUISITE FOR NON-ROOT USER:                                                                         #
#                               1. Gain root access with "sudo -i" command                                                      #
#                               2. Backup your /etc/sudoers file with the "cp /etc/sudoers /root/sudoers.bak" command           #
#                               3. Enter "visudo" command to edit the /etc/sudoers file                                         #
#                               4. Append at the end of file: "(USER) ALL=NOPASSWD: /bin/apt update, /bin/apt -y upgrade"       #
#                               5. Ensure (USER) is replaced by an actual username to bypass entering password for sudo command #
#                               6. Save and exit the file                                                                       #
#                       SCRIPT:                                                                                                 #
#                               1. Creates a variable, today, to store today's date in YYYY-mm-dd format                        #
#                               2. "sudo apt update" command to update the package source list                                  #
#                               3. "sudo apt -y upgrade" command to upgrade available packages                                  #
#                               4. Use grep to fetch all packages installed today from the /var/log/dpkg.log file,              #
#                               then use awk to print fields 1, 2, 5, and 6 and store the output in a file                      #
#                               named update_$today.txt                                                                         #
#################################################################################################################################

today=$(date +'%Y-%m-%d')

echo "-----------------------------------------------------------------------------"
echo "       Running \"apt update\" command to update the package sources list"
echo "-----------------------------------------------------------------------------"

sudo apt update

echo "-----------------------------------------------------------------------------"
echo "  Running \"apt upgrade\" command to update all packages installed on server"
echo "-----------------------------------------------------------------------------"

sudo apt -y upgrade

echo "-----------------------------------------------------------------------------"
echo "     Generating a list of all packages updated in update_$today.txt"
echo "-----------------------------------------------------------------------------"

grep "$today" /var/log/dpkg.log | grep " installed " | awk 'BEGIN {print "PACKAGES INSTALLED\n------------------------------"} {print $1, $2, $5, $6} END {print "------------------------------\nEND"}' > "/home/cadenhong/Documents/BuildScript/Build1/update_$today.txt"
echo "                               Job complete."
echo "-----------------------------------------------------------------------------"
