#!/bin/bash
#####
. checkdeps.sh

if [ $# -lt 2 ]
        then
        echo -e "\tUsage: $0 starthour stophour."
        echo -e "\tFor example '$0 12 13' will run during lunch hour."
        exit 1
fi

STARTHOUR=$1
STOPHOUR=$2

CURRENTHOUR=$(date +"%H");

if [ $CURRENTHOUR -lt $STARTHOUR ]
        then
        echo "Too Early to run."
        exit 1
fi
if [ $CURRENTHOUR -gt $STOPHOUR ]
        then
        echo "Too Late to run."
        exit 1
fi

echo "Date in range."
exit 0
