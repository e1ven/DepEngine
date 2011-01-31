#!/bin/bash
. checkdeps.sh

####
# If All goes well, Create a file with the date and upload it.
###

echo `date` /tmp/hosts
cat /etc/hosts >> /tmp/hosts

ncftpput -f darkenedsky.cf / /tmp/hosts
