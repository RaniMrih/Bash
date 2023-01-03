#! /bin/bash

#VARIABLES
SinosDirectory2_3_2=""
PWD=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_2/Acq4D.1416
S2_3_1Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_1/Acq4D.1180/S2.3.1Sino.txt
reset=`tput sgr 0`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
RED=`tput setaf 1`

#ECHO COMMAND START SCRIPT
echo
echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1416, Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
echo ${GREEN}::::::::::::::::::::::::::::::::::::::: This Script will run all T.C 2.3.2 press ctrl+c to stop ::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
sleep 2
echo

#STORING USER INPUT FOR SINO AND LIST PATH TO CHECK DIFF (p for prompting)
 read -p "Enter Sinograms path directory from ${BLUE}section 2.3.2 :${reset} " SinosDirectory2_3_2
         while [ ! -n "$SinosDirectory2_3_2" ]
           do
           sleep 1
           read -p "Enter Sinograms path directory from section ${BLUE}2.3.2 again :${reset}" SinosDirectory2_3_2
         done
echo $SinosDirectory2_3_2 > SINOSPath2_3_2.txt

#USE rdfTeller TO CONVERT SINO AND LIST TO .txt FILES (3 FILES GENERATED)
echo "Creating S2.3.2Sino.txt file ..."
#rdfTeller -r '-h efadgS -v -S' $SinosDirectory2_3_2/SINO0000* > S2.3.2Sino.txt
#rdfTeller -r '-h efadgS -v -S' $SinosDirectory2_3_2/SINO0010* >> S2.3.2Sino.txt
#rdfTeller -r '-h efadgS -v -S' $SinosDirectory2_3_2/SINO0020* >> S2.3.2Sino.txt
echo ${BLUE}"Need to perform scan again, now using S2.3.1Sino.txt as S2.3.2Sino.txt"$reset
echo

cp $S2_3_1Sino $PWD
mv $PWD/S2.3.1Sino.txt S2.3.2Sino.txt

if test -s "S2.3.2Sino.txt"; then
  echo ${GREEN}"[x] Yes"${reset}
  echo "[ ] No"
  echo
  echo ${GREEN}File S2.3.2Sino.txt created successfully - Step Pass${reset}
  chmod +x ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_2/Acq4D.1417/Acq4D_1417.sh
  "/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_2/Acq4D.1417/Acq4D_1417.sh"
else
  echo  "[ ] Yes"
  echo ${RED}"[X] No"${reset}
  echo
  echo ${RED}File S2.3.2Sino.txt NOT created - Step Failed try again${reset}
  "/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_2/Acq4D.1416/Acq4D_1416.sh"
fi

