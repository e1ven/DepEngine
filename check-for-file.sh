#!/bin/bash
. checkdeps.sh

###
# Simple: Does a file exist?
###

if [ $# -lt 1 ]
        then
        echo -e "\tUsage: $0 file."
        echo -e "\tFor example '$0 /etc/hosts' will usually be true."
        exit 1
fi

if [ -f $1 ]
	then
	echo "File exists."
	exit 0
fi

if [ ! -f $1 ]
	then
	echo "File not Found."	
	exit 1
fi
