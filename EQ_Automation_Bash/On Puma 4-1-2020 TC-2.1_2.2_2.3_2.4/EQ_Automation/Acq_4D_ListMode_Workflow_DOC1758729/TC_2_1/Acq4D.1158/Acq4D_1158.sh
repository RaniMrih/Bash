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
echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1158, Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
echo
#grep time mark for each Listfile, and display A.txt
sleep 2
echo "${BLUE}1a) The list file "Time Markers" per list is:${reset} ">A.txt
echo "${BLUE}First LIST0000.BLF :${reset}">>A.txt
cat ListOut_f0.txt | grep "Time Marks" | sed 's|\(.*\)Missing.*|\1|'>>A.txt #grep "Time Marks" and remove everything from "Missing"
echo "${BLUE}Second LIST0001.BLF :${reset}">>A.txt
cat ListOut_f1.txt | grep "Time Marks" | sed 's|\(.*\)Missing.*|\1|'>>A.txt
echo "${BLUE}Third LIST0002.BLF  :${reset}">>A.txt
cat ListOut_f2.txt | grep "Time Marks" | sed 's|\(.*\)Missing.*|\1|'>>A.txt
echo >>A.txt
cat A.txt

sleep 2
echo ${BLUE}"1b) The list file Phys2 (Respiratory) Triggers per list is:" ${reset}>B.txt
echo "${BLUE}First LIST0000.BLF :${reset}">>B.txt
cat ListOut_f0.txt | sed 's/^.*\(Phys2*\)/\1/g'| grep -m2 'Phys2'|tail -n1>>B.txt
#grep 'Phys2' ListOut_f0.txt >> B.txt #grep first List only
echo "${BLUE}Second LIST0001.BLF :${reset}">>B.txt
cat ListOut_f1.txt | sed 's/^.*\(Phys2*\)/\1/g'| grep -m2 'Phys2'|tail -n1>>B.txt
#grep 'Phys2' ListOut_f1.txt >>B.txt #grep second frame only
echo "${BLUE}Third LIST0002.BLF  :${reset}">>B.txt
cat ListOut_f2.txt | sed 's/^.*\(Phys2*\)/\1/g'| grep -m2 'Phys2'|tail -n1>>B.txt
#grep 'Phys2' ListOut_f2.txt >>B.txt #grep Third frame only
echo >>B.txt
cat B.txt

#---------------- Step 2 ------------------------------
#CONNECT TO PARC AND PERFORM ListDecode
sleep 2
#STORE LIST PATH AND GREP FILES INSIDE DIRECTORY TO SEND TO PARC
LISTPath=$(cat LISTPath.txt)
result=$(ls $LISTPath| grep '0000')
result1=$(ls $LISTPath| grep '0001')
result2=$(ls $LISTPath| grep '0002')

#ssh ctuser@par ListDecode $Path/$result | head -40 >TOF.txt
echo ::::::::::::::::: LIST0000.BLF ::::::::::::: >TOF.txt
ssh ctuser@par ListDecode $LISTPath/$result | head -40 >>TOF.txt
echo ::::::::::::::::: LIST0001.BLF :::::::::::::>>TOF.txt
ssh ctuser@par ListDecode $LISTPath/$result1 | head -40 >>TOF.txt
echo ::::::::::::::::: LIST0002.BLF :::::::::::::>>TOF.txt
ssh ctuser@par ListDecode $LISTPath/$result2 | head -40 >>TOF.txt

#count TOF in TOF.txt file needs to be 39 * 3 = 117
Count_TOF=$(tr ' ' '\n' < TOF.txt | grep TOF | wc -l)

if [ $Count_TOF -eq 117 ]
then
echo "Is the evidence of TOF info per Prompt inspected, including TOF values that are changing?"
echo "${GREEN}[x] Yes${reset}"
echo "[ ] No"

echo "${BLUE} TOF info Included in each prompt event${reset}"
echo "${BLUE} Open TOF.txt for more detailes${reset}"
fi

cp LISTPath.txt /usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1159
chmod +x /usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1159/Acq4D_1159.sh
"/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1159/Acq4D_1159.sh"
