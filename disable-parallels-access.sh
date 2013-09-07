#!/bin/zsh
# Remove the files that Parallels insists on installing
#
# From:	Timothy J. Luoma
# Mail:	luomat at gmail dot com
# Date:	2013-09-06

# /usr/local/bin/disable-parallels-access.sh

NAME="$0:t:r"

if [ "$EUID" != "0" ]
then
	echo "$0 must be run as root."
	exit 1
fi

DELETION_FILE="$HOME/.$NAME"
DELETION_SETTING=''



if [ -e "$DELETION_FILE" ]
then
		DELETION_SETTING=$(tr -dc '[a-z]' < "$DELETION_FILE" )

		if [ "$DELETION_SETTING" != "yes" ]
		then
				DELETION_SETTING='no'
		fi
else
		# no file

		if [ "$TERM_PROGRAM" != "" ]]
		then

				read '?Do you want the files deleted (not just disabled)? [y/N]' ANSWER

				case "$ANSWER" in
					y*)
							DELETION_SETTING='yes'
							echo -n 'yes' > "$DELETION_FILE"
					;;

					*)
							echo -n 'no' > "$DELETION_FILE"
							DELETION_SETTING='no'
					;;

				esac
		fi
fi



for CMD in \
			/etc/com.parallels.mobile.prl_deskctl_agent.launchd \
			/usr/bin/paxctl
do
	if [ -r "$CMD" ]
	then
			/bin/chmod 0 "$CMD"
	fi

	if [ "$DELETION_SETTING" = "yes" ]
	then

			/bin/rm -f "$PLIST"
	fi

done


for PLIST in \
			/Library/LaunchDaemons/com.parallels.mobile.dispatcher.launchdaemon.plist \
			/Library/LaunchDaemons/com.parallels.mobile.kextloader.launchdaemon.plist \
			/Library/LaunchAgents/com.parallels.mobile.prl_deskctl_agent.launchagent.plist \
			/Library/LaunchAgents/com.parallels.mobile.startgui.launchagent.plist
do

			/bin/launchctl unload -w "$PLIST"

			if [ "$DELETION_SETTING" = "yes" ]
			then

					/bin/rm -f "$PLIST"
			fi

done

exit
#
#EOF
