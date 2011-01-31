#!/bin/bash

DEPPATH=/etc/deps
MYNAME=`basename $0`
PARENTPROCNAME=$(cat /proc/$PPID/status | grep "Name:" | awk -F: {'print $2'} | awk {'print $1'})

PREFAILED=0
DEPFAILED=0
echo "Starting $MYNAME."
echo -e "### \tGathering list of dependencies."

if [ ! -f $DEPPATH/$MYNAME.deps ]
	then
	echo -e "\t\t This script has no dependencies. This should not occur."
	echo -e "\t\t Use a blank dependency file if necessary : $DEPPATH/$MYNAME.deps ." 
	exit 1
else
	#MYNAME.deps should have a list of dependencies for each corrosponding script file.
	DEPFAILED=0

	# We're using the construction with the cat at the bottom
	# Rather than using for, to avoid spaces
	# and loading on the bottom to save variable scope
	while read DEPLINE
	do 
		DEP=`echo $DEPLINE | awk {'print \$1'}`
		echo $DEP
		PREFAILED=0
		echo -e "\t\t $DEP : "

		## List of deps for each dep
		if [ ! -f $DEP ]
			then
			echo -e "\t\t\tFAILED. Not Found."
			PREFAILED=`expr $PREFAILED + 1`
		fi
		if [ ! -x $DEP ] 
			then
			echo -e "\t\t\tFAILED. File not executable."
			PREFAILED=`expr $PREFAILED + 1`
		fi
		if [ ! -r $DEP ]
			then
			echo -e "\t\t\tFAILED. File not readable."
			PREFAILED=`expr $PREFAILED + 1`
		fi		
		if [ ! -f $DEP ]

			then
			echo -e "\t\t\tFAILED. Dependency has no .deps file. Use empty if nec."
			PREFAILED=`expr $PREFAILED + 1`
		fi
		
		#Check each dependenciy
		if [ $PREFAILED -lt 1 ]
			then
			
			## Define some useful variables
			$DEPPATH/$DEPLINE
			DEPSTATUS=$?
			if [ $DEPSTATUS -ne 0 ]	
				then
				echo -e "\t\t\tFAILED. Dependency return != 0."
				DEPFAILED=`expr $DEPFAILED + 1`
			fi	
		fi		
	done < $DEPPATH/$MYNAME.deps
	TOTALFAILURES=`expr $PREFAILED + $DEPFAILED`
	echo Total Failures: $TOTALFAILURES
	if [ $TOTALFAILURES -gt 0 ]
		then
		echo -e "\t Aborting due to dependency failure"	
		exit 1
	fi
fi
	
