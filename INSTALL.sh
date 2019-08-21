#! /bin/bash

#--- Author: Muhammad Khubaib Umer
#--- Dated: 11-07-2019
#--- Description: Install Script for system_update.sh

CLR='\033[0;34m'
ENDCLR='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

CMD="lupdate"
SCRIPT="./.system_update.sh"
EX_PATH="~/.system_update.sh"

check_ret() {
	if [ $1 -ne 0 ]
	then
		echo -e "${RED} Install Sequence failed... ${NC}"
		exit $1
	fi
}

if [[ $EUID -eq 0 ]]
then
	echo -e "${RED} Please do not run as root ${NC}"
	exit 1
fi

if [[ $1 = "--help" ]] # print usage
then
	echo -e "${CLR} Default command is lupdate... You can provide custom command as arg1... ${NC}"
	exit 0
fi

if [[ $# -ge 1 ]] # user provided custom command
then
	echo -e "${RED} Setting '$1' as command... Press Ctrl-C to abort ${NC}"
	sleep 3
	CMD=$1
fi

echo -e "${CLR} Setting Ownership... ${NC}"
chown $USER $SCRIPT
check_ret $?
sleep 1

echo -e "${CLR} Setting Execute permission... ${NC}"
chmod a+x $SCRIPT
check_ret $?
sleep 1

echo -e "${CLR} Moving script to: $EX_PATH...${NC}"
cp $SCRIPT $EX_PATH
check_ret $?
sleep 1

echo -e "${RED} Adding command: '$CMD' to 'bashrc'... ${NC}"
echo -e "${RED} Press Ctrl-C to abort... ${NC}"
sleep 3

echo "alias $CMD='sudo $EX_PATH' " >> ~/.bashrc
check_ret $?

echo -e "${CLR} Restart Terminal to reload bashrc... ${NC}"
exit 0


