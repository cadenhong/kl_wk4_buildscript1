# kl_wk4_buildscript1

Automatically update the server using crontab and generate a list of all packages updated in a separate file *(update_{today}.txt)*

This repo contains [buildscript1.sh](https://github.com/cadenhong/kl_wk4_buildscript1/blob/main/buildscript1.sh), which will automatically update the server using crontab and generate a list of all packages updated in a separate file *(update_{today}.txt)*

### Crontab
To run the script every Friday at 11pm, the following configuration must be added to the crontab file:
> 0 23 * * 5  **{username}**  **{absolute path of buildscript1.sh}**

### Requirements
This script requires root access. Users with root access can run the script directly. Non-root users must follow these steps prior to running the script:

#### PREREQUISITE FOR NON-ROOT USER:
1. Gain root access with `sudo -i`
2. Backup your /etc/sudoers file with `cp /etc/sudoers /root/sudoers.bak`
3. Enter `visudo` command to edit the /etc/sudoers file
4. Append at the end of file: `(USER) ALL=NOPASSWD: /bin/apt update, /bin/apt -y upgrade`
5. Ensure **(USER)** is replaced by an actual username to bypass entering password for sudo command
6. Save and exit the file
    
### SCRIPT:
1. Creates a variable `today` to store today's date in YYYY-mm-dd format
2. `sudo apt update` command to update the package source list
3. `sudo apt -y upgrade` command to upgrade available packages
4. Use grep to fetch all packages installed today from the /var/log/dpkg.log file, then use awk to print fields 1, 2, 5, and 6 and store the output in a file named *(update_{today}.txt)*
