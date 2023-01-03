#! /bin/bash

#VARIABLES
SinosDirectory2_1=""
SinosDirectory2_3=""
ListsDirectory=""
Empty=""
PWD=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_1/Acq4D.1180
reset=`tput sgr 0`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
RED=`tput setaf 1`

#ECHO COMMAND START SCRIPT
echo
echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1180, Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
echo ${GREEN}::::::::::::::::::::::::::::::::::::::: This Script will run all T.C 2.3.1 press ctrl+c to stop ::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
sleep 2
echo

#STORING USER INPUT FOR SINO AND LIST PATH TO CHECK DIFF (p for prompting)
 read -p "Enter Sinograms path directory from ${BLUE}section 2.3 :${reset} " SinosDirectory2_3
         while [ ! -n "$SinosDirectory2_3" ]
           do
           sleep 1
           read -p "Enter Sinograms path directory from section ${BLUE}2.3 again :${reset}" SinosDirectory2_3
         done

#echo $ListsDirectory > LISTPath.txt
echo $SinosDirectory2_3 > SINOSPath2_3.txt
#cp LISTPath.txt ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1157
#cp SINOSPath.txt ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1162

#USE rdfTeller TO CONVERT SINO AND LIST TO .txt FILES (3 FILES GENERATED)
echo "Creating S2.3.1Sino.txt file ..."
rdfTeller -r '-h efadgS -v -S' $SinosDirectory2_3/SINO0000* > S2.3.1Sino.txt
rdfTeller -r '-h efadgS -v -S' $SinosDirectory2_3/SINO0010* >> S2.3.1Sino.txt
rdfTeller -r '-h efadgS -v -S' $SinosDirectory2_3/SINO0020* >> S2.3.1Sino.txt

if test -s "S2.3.1Sino.txt"; then
  echo ${GREEN}[x] Yes${reset}
  echo "[ ] No"
  echo
  echo ${GREEN}File S2.3.1Sino.txt created successfully - Step Pass${reset}
  chmod +x ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_1/Acq4D.1181/Acq4D_1181.sh
  "/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_1/Acq4D.1181/Acq4D_1181.sh"
else
  echo  "[ ] Yes"
  echo ${RED}"[X] No"${reset}
  echo
  echo ${RED}File S2.3.1Sino.txt NOT created - Step Failed try again${reset}
  "/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_1/Acq4D.1180/Acq4D_1180.sh"
fi
