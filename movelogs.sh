#!/bin/bash
# Script to move Userlogs from logupload to www folder for Moderators access.

#set -x

LOGS=/home/logupload/logs/
wwwDir=/var/customers/webs/David/omvlogadmin/logs/

LOGGER () {

	NOW=$(date "+%Y_%m_%d_%H_%M")

	case $1 in
		ERROR)
			echo -e "$NOW - Error: $2" && exit 1
		;;
		INFO)
			echo -e "$NOW - Info: $2"
		;;
	esac
}


while true; do

	for f in $(find $LOGS -type f -mmin +2)
	do
		mv "$f" "${wwwDir}" && LOGGER INFO "$f was moved to $wwwDir" || LOGGER ERROR "move not possible."
	done

	LOGGER INFO "No logfile older than 2 minutes. sleeping for 2 minutes."
	sleep 10

done
