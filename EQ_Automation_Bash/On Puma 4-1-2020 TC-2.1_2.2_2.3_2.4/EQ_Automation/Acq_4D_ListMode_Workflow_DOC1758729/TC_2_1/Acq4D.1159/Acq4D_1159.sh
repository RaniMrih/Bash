#! /bin/bash

#VARIABLES
SinoFile="/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1155/S2.1Sino.txt"
ListsDirectory=""
reset=`tput sgr 0`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`


#---------------- Step 1 ------------------------------
#show starting step
echo
echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1159, Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
echo
#grep frame duration for each SINOfile, and display A.txt
sleep 2
echo "${BLUE}"Frame Duration" of each sinogram file is:${reset}">A.txt
echo "${BLUE}First Frame SINO0000 :${reset}">>A.txt
grep -m 1 'Frame Duration' $SinoFile |sed 's/^.*\(Frame Duration*\)/\1/g'>> A.txt #grep first frame only
echo "${BLUE}Second Frame SINO0001 :${reset}">>A.txt
grep -m2 "Frame Duration" $SinoFile | tail -n1 | sed 's/^.*\(Frame Duration*\)/\1/g'>>A.txt #grep second frame only
echo "${BLUE}Third Frame SINO0002 :${reset}">>A.txt
grep -m3 "Frame Duration" $SinoFile | tail -n1 | sed 's/^.*\(Frame Duration*\)/\1/g'>>A.txt #grep Third frame only
echo >>A.txt
cat A.txt


sleep 2
echo ${BLUE} Delta Time of each list file is:${reset}>B.txt
echo "${BLUE}First Frame LIST0000.BLF :${reset}">>B.txt
cat ListOut_f0.txt | sed 's/^.*\(Delta Time:*\)/\1/g'| grep -m2 'Delta Time'|tail -n1>>B.txt
echo "${BLUE}Second Frame LIST0001.BLF :${reset}">>B.txt
cat ListOut_f1.txt | sed 's/^.*\(Delta Time:*\)/\1/g'| grep -m2 'Delta Time'|tail -n1>>B.txt
echo "${BLUE}Third Frame LIST0002.BLF :${reset}">>B.txt
cat ListOut_f2.txt | sed 's/^.*\(Delta Time:*\)/\1/g'| grep -m2 'Delta Time'|tail -n1>>B.txt
echo >>B.txt
cat B.txt

cp LISTPath.txt ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1162/
chmod +x ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1160/Acq4D_1160.sh
"/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1160/Acq4D_1160.sh"
