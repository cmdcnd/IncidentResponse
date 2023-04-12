#############################
# Author: 404unf			#
# Team: CyberSurfers: ME2	#
# Creation: June 2020		#
#############################

# This Script is designed for Python3.6x
# DEPENDENCIES include Nmap: https://nmap.org/


import os

def main():
	mainMenu()

def mainMenu():
	print ('''
********** Pre-Canned DNS Host Name Mapping Scans	************
********** For standardized information gathering	************
********** Edit as needed							************

	''')

########################################
# Prompt the user choose from this menu#
########################################

	choice = input("""
		1. Host Discovery
		2. Enumerate Windows Hosts
		3. Host Discovery with specified DNS Servers
		4. Exit
			
		""")

############################################################
# If the user makes a selection, execute the specified task#
############################################################

	if choice == "1":
		hostDiscovery()
	elif choice == "2":
		winEnumeration()
	elif choice == "3":
		specifyDNServer()
	elif choice == "4":
		exit()
	else:
		print("Please enter a valid selection.")
		mainMenu()


########################
# Pre-canned nmap scans#
########################

def hostDiscovery():
	os.system('nmap -sn -PE {} {}'.format(whatSubnet(), generateReports()))

def winEnumeration():
	os.system('nmap -sU -script nbstat.nse -p137 {} {}'.format(whatSubnet(),generateReports()))

def specifyDNServer():
	os.system('nmap -sn -PE {} {}'.format(whatSubnet(), whichDNS(), generateReports()))


#######################
# Repetitive functions#
#######################

def whatSubnet():
	subnet: str = input("""
Please enter an ip or subnet to scan:
		""")
	return subnet

def whichDNS():
	servers: str = input("""
Please enter a DNS Server IP to scan. Comma seperate multiple IPs:
		""")
	return "--dns-servers {}".format(servers)

def generateReports():
	rep_choice = input("""
Would you like to export output to a file? y/n
		""")
	if rep_choice.lower() == "y":
		filename = input("""
Please specify a filename:
			""")
		return "-oA {}".format(filename)
	else:
		return ""

#######################
#Initialize the script#
######################


main()
