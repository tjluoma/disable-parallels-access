disable-parallels-access
========================

Disable the Parallels Access program which gets installed with Parallels


## Disclaimer ##

I am operating from information based on posts made at <http://forum.parallels.com/showthread.php?290358-Uninstalling-Parallels-Access/> about which files are related to this problem. I have not tested this myself. Use entirely at your own risk.

## Installation ##

* `disable-parallels-access.sh` should be installed to /usr/local/bin/disable-parallels-access.sh and made executable (`chmod 755`).

* `com.tjluoma.disable-parallels-access.plist` should be installed to `/Library/launchagents/com.tjluoma.disable-parallels-access.plist`

After installing that file there you will either need to reboot or enter the following line in Terminal.app:

	sudo launchctl load /Library/launchagents/com.tjluoma.disable-parallels-access.plist

## How it works ##

The `launchd` plist looks for any of these files to exist or change:

* /etc/com.parallels.mobile.prl_deskctl_agent.launchd 
* /usr/bin/paxctl
* /Library/LaunchDaemons/com.parallels.mobile.dispatcher.launchdaemon.plist 
* /Library/LaunchDaemons/com.parallels.mobile.kextloader.launchdaemon.plist 
* /Library/LaunchAgents/com.parallels.mobile.prl_deskctl_agent.launchagent.plist 
* /Library/LaunchAgents/com.parallels.mobile.startgui.launchagent.plist

When that happens, the script `disable-parallels-access.sh` will run. The script will run `/bin/launchctl unload -w` on the plists and set the others to `chmod 0` which will effectively disable them.

## "Why not delete the files?" ##

It's possible that some Parallels process would reinstall the files if they do not exist. By disabling them, instead of removing them, it reduces the chances that it will be reinstalled or re-enabled. 

The `launchctl` command: 

	 -w Overrides the Disabled key and sets it to true

means that they will not run again.

## "I don't care, I still want to delete the files, not just disable them!"

If you really want to delete the files, run the `disable-parallels-access.sh` command in Terminal.app:

		sudo disable-parallels-access.sh

and it will ask you if you want to delete instead of disable. Just answer 'yes' and it will store your answer for the future.



 

