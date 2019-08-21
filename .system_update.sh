#--- Author: Muhammad Khubaib Umer
#--- Description: Bash script to update and upgrade new packages
#--- Dated: 11-07-2019

#! /bin/bash

CLR='\033[0;34m'
ENDCLR='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

check_ret() {
	if [ $? -ne 0 ]
	then
		echo  "${RED} Update Sequence failed... Please Run Update Manually..."
		exit $?
	fi
}

echo  "${CLR} Please Wait While Repository Lists are being Updated... ${NC}"
apt update
check_ret $?
#sleep 1
echo  "${CLR}Please Wait While Newer Packages are being Installed...${NC}"
apt upgrade -y
check_ret $?
#sleep 1
echo  "${CLR}Please Wait While Old Repository Lists are being Removed...${NC}"
apt autoclean
check_ret $?
#sleep 1
echo  "${CLR}Please Wait While Old/Deprecated/Obselete Packages are being Removed...${NC}"
apt autoremove -y
check_ret $?
#sleep 1

echo  "${CLR}Please Wait While Dependencies are Resolved...${NC}"
apt install -f -y
check_ret $?
#sleep 1

echo  "${CLR}Please Wait While unconfigured Packages are Processed...${NC}"
dpkg --configure -a
check_ret $?
#sleep 1

echo  "${ENDCLR}Your System is up-to-date...${NC}"
exit 0
