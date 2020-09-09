#!/bin/bash

# mntftp - Simple FTP Mount tool for Linux
# Copyright (C) 2020 Dovi Cowan - dovi@fullynetworking.co.uk

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

echo "mntftp -  Simple FTP Mount tool for Linux"
echo
echo "Copyright (C) 2020 Dovi Cowan - dovi@fullynetworking.co.uk"
echo "This program comes with ABSOLUTELY NO WARRANTY; for details see the GNU GPL v3.0."
echo "This is free software, and you are welcome to redistribute it"
echo "under certain conditions; see the GNU GPL v3.0."
echo
echo "FTP MOUNTER v1"
echo

MOUNTS_FILE=~/.local/share/mount.txt

if [ "$1" = "" ]
then
	echo "Error - You must enter an option"
	echo "Use option 'help' for help"
	exit 1
fi

case "$1" in
	mount|m)
		if [ "$2" = "" ]
		then
			echo "Error - you did not enter a mount option"
			echo "Use option 'help' for help"
			exit 1
		fi

		if [ "$3" != "" ]
		then
			MOUNTS_FILE="$3"
		fi

		IN=`cat $MOUNTS_FILE`

		LINES=(${IN//$'\n'/ })

		for i in "${LINES[@]}"; do
			if [ "${i:0:1}" != "#" ]; then
				IFS=':' read -ra ADDR <<< "$i"
				#echo ${ADDR[0]}
				if [ "${ADDR[3]}" = "$2" ]
				then
					if [ -d ~/mnt/${ADDR[3]} ]
					then
						echo "Mountpoint exists. Mounting ..."
					else
						echo "Mountpoint doesn't exist. Creating mountpoint ..."
						mkdir ~/mnt/${ADDR[3]}
						echo "Created mountpoint. Mounting ..."
					fi

					if [ "$(ls -A ~/mnt/${ADDR[3]})" ];
					then
						echo "Mountpoint in use!"
						echo "Ensure the mountpoint is empty before mounting"
						exit 1
					fi

					curlftpfs -o user="${ADDR[0]}:${ADDR[1]}" ${ADDR[2]} ~/mnt/${ADDR[3]}
					echo "Mounted"
					#echo "$2"
					exit 0
				fi
			fi
		done

		echo "Invalid mountname!"
	;;

	umount|u)
		if [ "$2" = "" ]
		then
			echo "Error - you did not enter a mount option"
			echo "Use option 'help' for help"
			exit 1
		fi

		if [ "$3" != "" ]
		then
			MOUNTS_FILE="$3"
		fi

		IN=`cat $MOUNTS_FILE`

		LINES=(${IN//$'\n'/ })

		for i in "${LINES[@]}"; do
			IFS=':' read -ra ADDR <<< "$i"
			#echo ${ADDR[0]}
			if [ "${ADDR[3]}" = "$2" ]
			then
				if [ "$(ls -A ~/mnt/${ADDR[3]})" ];
				then
					echo
				else
					echo "Not mounted!"
					exit 0
				fi

				sudo umount ~/mnt/${ADDR[3]}
				echo "Unmounted"
				exit 0
			fi
		done

		echo "Invalid mountname!"
	;;

	list|l)
		if [ "$2" != "" ]
		then
			MOUNTS_FILE="$2"
		fi
		cat $MOUNTS_FILE
		exit 0
	;;

	edit|e)
		nano $MOUNTS_FILE
		exit 0
	;;

	help|h)
		echo "FTP MOUNTER uses curlftpfs to mount FTP drives to a local folder."
		echo "FTP MOUNTER reads mount information from mount.txt by default. Use custom_mounts_file to use a custom mounts file, as detailed below."
		echo
		echo "USAGE:"
		echo "mntftp [mount|umount|add|remove|edit] mountname (custom_mounts_file)"
		echo "mntftp list (custom_mounts_file)"
		echo
		echo "FTP MOUNTER v1 by Dovi Cowan - Fully Networking UK - dovi@fullynetworking.co.uk"
		exit 0
	;;

	*)
		echo "Option not valid!"
		echo "Use 'help' option for valid options"
	;;
esac

exit 1
