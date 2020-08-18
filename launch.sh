#!/bin/bash
# If you have some pre-launch things you need to do, add them to a script called pre-launch.sh 
# and mount in /home/liquidsoap on container start.

if [ -e /home/liquidsoap/pre-launch.sh ]
then 
	echo "Found a pre-launch.sh... executing!"
	/bin/bash -c /home/pre-launch.sh
else
	echo "No pre-launch.sh found."
fi 

# Once pre-launch actions are complete, let's launch with the script referenced in the environment variable
/home/liquidsoap/.opam/system/bin/liquidsoap $LIQUIDSOAP_SCRIPT
