#!/bin/bash
#####
. checkdeps.sh

if [ $# -lt 2 ]
        then
        echo -e "\tUsage: $0 startminute stopminute."
        echo -e "\tFor example '$0 5 10' will run every hour between, in any minute between 5 and 10."
        exit 1
fi

STARTMIN=$1
STOPMIN=$2

CURRENTMIN=$(date +"%M");

if [ $CURRENTMIN -lt $STARTMIN ]
        then
        echo "Too Early to run."
        exit 1
fi
if [ $CURRENTMIN -gt $STOPMIN ]
        then
        echo "Too Late to run."
        exit 1
fi

echo "Date in range."
exit 0
