#!/bin/bash

## File name placeholder
FILESCOPE=""
ISFILESUPPLIED=0
i=0

## Log file name, default 
LOGFILENAME="NmapScript.log"
NMAPFILENAME="NmapScript"
DIRECTORYNAME=$(pwd)/$NMAPFILENAME

## Scan active hosts with service enumeration
## -sV is used to get the version scanning for Nmap
function ThreeThree() {
	## Start the logging for this function
	printf "[%s] Logging for ID.TO-3.3: Scanning active hosts with service enumeration\n" "$(date +"%d%b%Y %T")" >> $DIRECTORYNAME/$LOGFILENAME
	
	## If a file with IP ranges was supplied, scan it
	if [[ $ISFILESUPPLIED -eq 1 ]]; then
		nmap -sV --open -iL $FILESCOPE | 
		while read -r line; do
			if [[ -z "$line" ]]; then
				printf "%s\n" "$line"
			else
				printf "[+] %s\n" "$line"
			fi
			printf "[%s] %s\n" "$(date +"%d%b%Y %T")" "$line" >> $DIRECTORYNAME/$LOGFILENAME
		done
	fi

	## Was an argument specified too? Scan that too
	if [[ "$1" != 0 ]]; then
		nmap $1 -sV --open | 
		while read -r line; do
			if [[ -z "$line" ]]; then
				printf "%s\n" "$line"
			else
				printf "[+] %s\n" "$line"
			fi
			printf "[%s] %s\n" "$(date +"%d%b%Y %T")" "$line" >> $DIRECTORYNAME/$LOGFILENAME
		done
		printf "\n"
	fi
	printf "\n" >> $DIRECTORYNAME/$LOGFILENAME
}

## Create a list of active IP addresses
## -sn is used for host discovery and to see the live hosts
function ThreeFour() {
	## Start the logging for this function
	printf "[%s] Logging for 2.04: Creating a list of active IP addresses\n" "$(date +"%d%b%Y %T")" >> $DIRECTORYNAME/$LOGFILENAME

	## If a file with IP ranges was supplied, scan it
	if [[ $ISFILESUPPLIED -eq 1 ]]; then
		## Just getting a list of live hosts
		NmapOutput=$(nmap -sn -iL $FILESCOPE | grep report | awk '{print $5}')
		## Do we have anything??
		if [[ ! -z "$NmapOutput" ]]; then
			## Iterate through the live hosts and add them to the logfile
			for x in $NmapOutput; do
				printf "[+] %s is live!\n" "$x" 
				printf "[%s] %s is live!\n" "$(date +"%d%b%Y %T")" "$x" >> $DIRECTORYNAME/$LOGFILENAME
			done
			printf "\n" >> $DIRECTORYNAME/$LOGFILENAME
		else
			printf "[!] There are no live hosts for %s" "$1"
			printf "[%s] There are no live hosts for %s" "$(date +"%d%b%Y %T")" "$1" >> $DIRECTORYNAME/$LOGFILENAME
		fi
	fi

	## Was an argument specified too? Scan that too
	if [[ "$1" != 0 ]]; then
		## Just getting a list of live hosts
		NmapOutput=$(nmap $1 -sn | grep report | awk '{print $5}')
		## Do we have anything??
		if [[ ! -z "$NmapOutput" ]]; then
			## Iterate through the live hosts and add them to the logfile
			for x in $NmapOutput; do
				printf "[+] %s is live!\n" "$x" 
				printf "[%s] %s is live!\n" "$(date +"%d%b%Y %T")" "$x" >> $DIRECTORYNAME/$LOGFILENAME 
			done
			printf "\n" >> $DIRECTORYNAME/$LOGFILENAME
		else
			printf "[!] There are no live hosts for %s" "$1"
			printf "[%s] There are no live hosts for %s" "$(date +"%d%b%Y %T")" "$1" >> $DIRECTORYNAME/$LOGFILENAME
		fi
		printf "\n"
	fi
	
	printf "\n" >> $DIRECTORYNAME/$LOGFILENAME
}

## Create a list of active IP addresses with key ports included
## -p and --open are used for specifying keyports and checking only the open ones
function ThreeFive() {
	## Start the logging for this function
	printf "[%s] Logging for 2.05: Creating a list of active IP addresses with key ports included\n" "$(date +"%d%b%Y %T")" >> $DIRECTORYNAME/$LOGFILENAME

	## Do we have key ports we should scan?
	if [[ -z "$k" ]]; then
		printf "[!] Please supply key ports!\n"
		printf "[%s] No key ports were supplied!" "$(date +"%d%b%Y %T")" >> $DIRECTORYNAME/$LOGFILENAME
	else
		## If a file with IP ranges was supplied, scan it
		if [[ $ISFILESUPPLIED -eq 1 ]]; then
			nmap -p $k -iL $FILESCOPE --open |
			while read -r line; do
				if [[ -z "$line" ]]; then
					printf "%s\n" "$line"
				else
					printf "[+] %s\n" "$line"
				fi
				printf "[%s] %s\n" "$(date +"%d%b%Y %T")" "$line" >> $DIRECTORYNAME/$LOGFILENAME
			done
			printf "\n"
		fi

		## Was an argument specified too? Scan that too
		if [[ "$1" != 0 ]]; then
			nmap $1 -p $k --open |
			while read -r line; do
				if [[ -z "$line" ]]; then
					printf "%s\n" "$line"
				else
					printf "[+] %s\n" "$line"
				fi
				printf "[%s] %s\n" "$(date +"%d%b%Y %T")" "$line" >> $DIRECTORYNAME/$LOGFILENAME
			done
			printf "\n"
		fi
	fi
	printf "\n" >> $DIRECTORYNAME/$LOGFILENAME
}

## Scan ICS Equipment Ports
function ThreeSix() {
	## Port scanning can crash legacy embedded systems if not careful! 
	## Don't use: -O, -A, -sU 
	## Caveats: -sV is usually safe, alternative --script=banner
	## Always specify -sT in these scans because UDP will mess up

	## Start the logging for this function
	printf "[%s] Logging for 2.07: Scanning ICS Equipment ports\n" "$(date +"%d%b%Y %T")" >> $DIRECTORYNAME/$LOGFILENAME
	
	## Display warning, interact
	while [[ true ]]; do
		read -p "[!] It's possible for Scada devices to fail with an Nmap scan, do you want to continue? " yn
		case $yn in
			[Yy]* ) break;;
			[Nn]* ) exit;;
			* ) printf "[!] Please answer yes or no\n"
		esac
	done

	if [[ $ISFILESUPPLIED -eq 1 ]]; then
		## Scanning the target carefully by slowing down with -T2
		## Doing TCP only because UDP will cause issues
		nmap -T2 -sV -sT -iL $FILESCOPE |
		while read -r line; do 
			if [[ -z "$line" ]]; then
				#statements
				printf "%s\n" "$line"
			else
				printf "[+] %s\n" "$line"
			fi
			printf "[%s] %s\n" "$(date +"%d%b%Y %T")" "$line" >> $DIRECTORYNAME/$LOGFILENAME
		done
		printf "\n"
	fi

	if [[ "$1" != 0 ]]; then
		## Scanning the target carefully by slowing down with -T2
		## Doing TCP only because UDP will cause issues
		nmap $1 -T2 -sV -sT --open |
		while read -r line; do
			if [[ -z "$line" ]]; then
				printf "%s\n" "$line"
			else
				printf "[+] %s\n" "$line"
			fi
			printf "[%s] %s\n" "$(date +"%d%b%Y %T")" "$line" >> $DIRECTORYNAME/$LOGFILENAME
		done 
		printf "\n"
	fi
	printf "\n" >> $DIRECTORYNAME/$LOGFILENAME
}

## ID.TO-3.7 Scan all ports of all hosts on given network segment
function ThreeSeven() {
	## Start the logging for this function
	printf "[%s] Logging for 2.06: Scanning all ports of all hosts on given network segment\n" "$(date +"%d%b%Y %T")" >> $DIRECTORYNAME/$LOGFILENAME

	if [[ $ISFILESUPPLIED -eq 1 ]]; then
		## Scanning all ports from 0 - 65535
		nmap -p- -iL $FILESCOPE --open |
		while read -r line; do
			if [[ -z "$line" ]]; then
				printf "%s\n" "$line"
			else
				printf "[+] %s\n" "$line"
			fi
			printf "[%s] %s\n" "$(date +"%d%b%Y %T")" "$line" >> $DIRECTORYNAME/$LOGFILENAME
		done
		printf "\n"
	fi

	if [[ "$1" != 0 ]]; then
		## Scanning all ports from 0 - 65535
		nmap $1 -p- --open |
		while read -r line; do
			if [[ -z "$line" ]]; then
				printf "%s\n" "$line"
			else
				printf "[+] %s\n" "$line"
			fi
			printf "[%s] %s\n" "$(date +"%d%b%Y %T")" "$line" >> $DIRECTORYNAME/$LOGFILENAME
		done 
		printf "\n"
	fi
	printf "\n" >> $DIRECTORYNAME/$LOGFILENAME
}

if [[ $EUID -ne 0 ]]; then
	echo "[!] Please run as root!"
	exit 1
fi

## Fix me up 
if [[ $# -eq 0 ]]; then
	printf "Usage: $0 -i ip/cidr -k keyports -l logfile.log -f file.txt\n"
	printf "Example: $0 -i 127.0.0.1 -l mylog.log\n"
	printf "Example: $0 -i 127.0.0.1/24 -k 80,443,9090\n"
	printf "  If battle drill 3.5 is used, this argument is required!\n"
	printf "Default log file is NmapScript.log\n"
	exit 0
fi

while getopts ":i:k:l:f:" o; do
	case "${o}" in
		i ) i=${OPTARG};;
		k ) k=${OPTARG};;
		l ) l=${OPTARG};;
		f ) f=${OPTARG};;
		* ) printf "Invalid argument!\n"; exit 1;;
	esac
done

## Was a scope supplied?
if [[ ! -z "$f" ]]; then
	#statements
	FILESCOPE="$f"
	ISFILESUPPLIED=1
fi

## Was a log supplied?
if [[ ! -z "$l" ]]; then
	LOGFILENAME="$l"
fi

## Check if we have a directory to work out of
if [[ ! -d "$DIRECTORYNAME" ]]; then
	mkdir $DIRECTORYNAME
fi

# be more specific for battle drill
until [[ "$selection" = "6" ]]; do
	printf "\n\t--==[[ DCO-E Battle Drills Script Base ]]==--\n\n"
	printf "1. Task 2.04: Scan active hosts with service enumeration\n"
	printf "2. Task 2.02: Create a list of active IP addresses\n"
	printf "3. Task 2.05: Create a list of active IP address with key ports included\n"
	printf "4. Task 2.07: Scan ICS Equipment Ports\n"
	printf "5. Task 2.06: Scan all ports of all hosts on given network segment\n"
	printf "6. Exit\n\n"
	printf "Selection:> "
	read selection

	case $selection in
		1 ) ThreeThree $i $FILESCOPE $ISFILESUPPLIED;;
		2 ) ThreeFour $i;;
		3 ) ThreeFive $i $k;;
		4 ) ThreeSix $i;;
		5 ) ThreeSeven $i;;
	esac
done
