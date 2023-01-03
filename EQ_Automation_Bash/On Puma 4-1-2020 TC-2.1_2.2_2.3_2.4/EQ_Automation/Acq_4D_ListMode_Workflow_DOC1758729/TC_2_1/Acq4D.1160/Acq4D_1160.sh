#! /bin/bash
#VARIABLES
SinoFile="/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1155/Generated_Files/S2.1Sino.txt"
ListsDirectory=""
reset=`tput sgr 0`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`

#---------------- Step 1 ------------------------------
#show starting step
echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1160, Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
echo
sleep 2
#grep "Last Time Marks" and remove everything from "Delta"
echo "${BLUE}Frame 0 :${reset}">FirstTimeMark.txt
cat ListOut_f0.txt | sed 's/^.*\(Last*\)/\1/g'|grep "Last"|sed 's|\(.*\)Delta.*|\1|' >>FirstTimeMark.txt
echo "${BLUE}Frame 1 :${reset}">>FirstTimeMark.txt
#grep "First Time Marks" and remove everything from "Delta"
cat ListOut_f1.txt | grep "First" | sed 's|\(.*\)Delta.*|\1|'>>FirstTimeMark.txt
echo "${BLUE}Frame 2 :${reset}">>FirstTimeMark.txt
#grep 'First Time Mark' and remove from Last
cat ListOut_f2.txt | grep "First" | sed 's|\(.*\)Last.*|\1|'>>FirstTimeMark.txt
echo >>FirstTimeMark.txt
cat FirstTimeMark.txt

#---------------- Step 2 ------------------------------
sleep 2
echo "${BLUE}f0_f1_gap is :${reset}">Calculate.txt
#grep only number from line
Last0=$(cat ListOut_f0.txt | sed 's/^.*\(Last*\)/\1/g' | grep "Mark:" | sed 's|\(.*\)Delta.*|\1|' | sed 's|\(.*\)Last Time Mark: *|\1|')
#grep only number from line
First1=$(cat ListOut_f1.txt | grep "First" | sed 's|\(.*\) Last.*|\1|'| sed 's|\(.*\)First Time Mark: *|\1|')
#subtract numbers
echo "Result = "$(($First1 - $Last0)) "ms">>Calculate.txt
#--------------------------------------------------
echo "${BLUE}f1_f2_gap is :${reset}">>Calculate.txt
#grep only number from line
First2=$(cat ListOut_f2.txt | grep "First" | sed 's|\(.*\) Last.*|\1|'| sed 's|\(.*\)First Time Mark: *|\1|')
Last1=$(cat ListOut_f1.txt | sed 's/^.*\(Last*\)/\1/g' | grep "Mark:" | sed 's|\(.*\)Delta.*|\1|' | sed 's|\(.*\)Last Time Mark: *|\1|')
#subtract numbers
echo "Result = "$(($First2 - $Last1)) "ms">>Calculate.txt

#show all
cat Calculate.txt

chmod +x ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1162/Acq4D_1162.sh
"/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1162/Acq4D_1162.sh"

