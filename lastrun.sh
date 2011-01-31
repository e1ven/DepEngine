#!/bin/bash

. checkdeps.sh

####
# Seconds since script was last run
####

if [ $# -lt 1 ]
        then
        echo -e "\tUsage: $0 seconds (scriptname)."
        echo -e "\tFor example '$0 3600 test' the test script has not run in the last hour."
	echo -e "If you omit the scriptname, it will use your parent process."
        exit 1
fi

if [ -z $2 ]
	then
	CHECKFILE=$PARENTPROCNAME	
else
	CHECKFILE=$2
fi

LASTCHECKPATH=$DEPPATH/lastcheck
LASTCHECKFILE=$LASTCHECKPATH/$CHECKFILE
MINTIME=$1
CURRENTTIME=`stat -c %Z $LASTCHECKFILE`
mkdir -p $LASTCHECKPATH

if [ -f $LASTCHECKFILE ]
        then
                TOUCHTIME=$(expr `date +%s` - $CURRENTTIME) 
                if [ $TOUCHTIME -lt $MINTIME ]
                        then
                        echo "It has not been long enough for this to run [ $TOUCHTIME of $MINTIME ]." 
                        exit 1
                else
                        echo $TOUCHTIME is OK. It is over $MINTIME
			touch $LASTCHECKFILE
                        exit 0
                fi
else
	echo "File does not exist."
	echo "Please create $LASTCHECKFILE before continuing"
	exit 1
fi
