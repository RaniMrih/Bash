#! /bin/bash

#VARIABLES
SinosDirectory2_1=""
SinosDirectory2_2=""
ListsDirectory=""
Empty=""
PWD=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1165
reset=`tput sgr 0`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
RED=`tput setaf 1`

#ECHO COMMAND START SCRIPT
echo
echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1165, Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
echo ${GREEN}::::::::::::::::::::::::::::::::::::::: This Script will run untill Step 1175 press ctrl+c to stop ::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
echo
#STORING USER INPUT FOR SINO AND LIST PATH TO CHECK DIFF (p for prompting)
FILE=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1165/SINOSPath.txt

#IF SINOS PATH FILE EXISTS FROM SECTION 2.1
if test -f "$FILE"; then
    echo ${GREEN}"Sinos path found from section 2.1"${reset}
    SinosDirectory2_1=$(cat SINOSPath.txt)
    sleep 1
    read -p "Enter Sinograms path directory from ${BLUE}section 2.2 :${reset} " SinosDirectory2_2
         while [ ! -n "$SinosDirectory2_2" ]
           do
           sleep 1
           read -p "Enter Sinograms path directory from section ${BLUE}2.2 again :${reset}" SinosDirectory2_2
         done
else
     read -p "Enter Sinograms path directory from ${BLUE}section 2.1 :${reset} " SinosDirectory2_1
     if [ -n "$SinosDirectory2_1" ]; then                ##SINO PATH CANT BE EMPTY##
        echo ${GREEN}"Sinos path Saved from section 2.1"${reset}
        sleep 1
      else
         while [ ! -n "$SinosDirectory2_1" ]
          do
          read -p "Enter Sinograms path directory from section ${BLUE}2.1 again :${reset}" SinosDirectory2_1
         done
     fi
        read -p "Enter Sinograms path directory from ${BLUE}section 2.2 :${reset} " SinosDirectory2_2
      if [ -n "$SinosDirectory2_2" ]; then                ##SINO PATH CANT BE EMPTY##
          echo ${GREEN}"Sinos path Saved from section 2.2"${reset}
        sleep 1
         else
           while [ ! -n "$SinosDirectory2_2" ]
           do
           read -p "Enter Sinograms path directory from section ${BLUE}2.2 again :${reset}" SinosDirectory2_2
           done
      fi
fi
echo $SinosDirectory2_1 > SINOSPath.txt
echo $SinosDirectory2_2 > SINOSPath2_2.txt
cp SINOSPath2_2.txt SINOSPath.txt ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1166
cp SINOSPath2_2.txt SINOSPath.txt ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1171
#ON SYSTEM
#-----------------------------------
echo "Creating S2.2Sino.txt file ..."
#USE rdfTeller TO CONVERT SINOS to txt file
rdfTeller -r '-h  efadgS -Ha -v -S' $SinosDirectory2_2/SINO*  > S2.2Sino.txt

#clean unnecessarry files .
rm -rf A.txt B.txt singles.dat

echo
echo "Is the S2.2Sino.txt file produced ?"
if test -s "S2.2Sino.txt"; then
  echo ${GREEN}[x] Yes${reset}
  echo "[ ] No"
  echo
  echo ${GREEN}Files created successfully - Step Pass${reset}
  chmod +x ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1166/Acq4D_1166.sh
  "/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1166/Acq4D_1166.sh"
else
  echo  "[ ] Yes"
  echo ${RED}"[X] No"${reset}
  echo
  echo ${RED}Files NOT created - Step Failed try again${reset}
  "/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1165/Acq4D_1165.sh"
fi


