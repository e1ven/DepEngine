#!/bin/bash

. checkdeps.sh
####
# Check that machine has at least 2 Megs of Ram
####

if [ $# -lt 1 ]
        then
        echo -e "\tUsage: $0 blocks."
        echo -e "\tFor example '$0 1000' will ensure that there are least 1000 blocks." 
        exit 1
fi

BLOCKS=`df . | grep "/" | awk {'print $4'}`
if [ $BLOCKS -gt $1 ]
	then
	echo "Sufficient file size"
	exit 0
else
	echo "Not enough free space"
	exit 1
fi
