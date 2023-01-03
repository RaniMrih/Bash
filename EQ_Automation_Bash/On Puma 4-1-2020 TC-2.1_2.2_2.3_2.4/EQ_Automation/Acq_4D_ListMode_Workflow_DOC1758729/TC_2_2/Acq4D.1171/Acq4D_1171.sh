#! /bin/bash
#!/bin/ksh

#VARIABLES
SinosDirectory2_1=""
SinosDirectory2_2=""
reset=`tput sgr 0`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
RED=`tput setaf 1`
PWD=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1171
ScriptsPath=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/scripts
S2_1Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1165/S2.1Sino.txt
S2_2Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1165/S2.2Sino.txt
SorterCL=true


#ECHO COMMAND START SCRIPT
echo
echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1171, Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
echo
SinosDirectory2_1=$(cat $PWD/SINOSPath.txt)
SinosDirectory2_2=$(cat $PWD/SINOSPath2_2.txt)
#-------------------------------- Step1 ------------------------------------------
sleep 1
echo ${BLUE}"Creating coinLossCk -v -c [RDF_dir/SINO*] for Replay Multi-Static"$reset
coinLossCk -v -c $SinosDirectory2_2/SINO*
cp coinLoss.csv $PWD
echo
#for loop to find Replay MPCS
echo ${BLUE}"a) Replay scan MCPS "$reset
for i in {0..2}
 do
   echo "${BLUE}Bed $i :$reset"
   cat $PWD/coinLoss.csv | grep SINO000$i | cut -f3 -d,
done
echo

#for loop to find Replay %SorterCoinLoss
sleep 1
echo ${BLUE}"b) Replay scan %SorterCoinLoss" $reset
for i in {0..2}
 do
   echo "${BLUE}Bed $i :$reset"
   cat $PWD/coinLoss.csv | grep SINO000$i | cut -f4 -d,
done
echo

#for loop to find Replay %LossError
sleep 1
echo ${BLUE}"c) Replay scan %LossError" $reset
for i in {0..2}
 do
   echo "${BLUE}Bed $i :$reset"
   cat $PWD/coinLoss.csv | grep SINO000$i | cut -f6 -d,
done
echo


#for loop to find Replay %CPM Loss
sleep 1
echo ${BLUE}"d) Replay scan CPM Loss" $reset
for i in {0..2}
 do
   echo "${BLUE}Bed $i :$reset"
   cat $PWD/coinLoss.csv | grep SINO000$i | cut -f10 -d,
done
echo

sleep 1
echo ${BLUE}"%SorterCoinLoss for Bed1, Bed2 & Bed3 is less than 1.0% ?" $reset

# go to python script "SorterCL.py"
chmod +x $ScriptsPath/SorterCL.py
$ScriptsPath/SorterCL.py
echo

#------------------ step 2 -----------------------------------------------------
sleep 1

cp $PWD/coinLoss.csv $PWD/coinLoss2_2.csv
echo ${BLUE}"Creating coinLossCk -v -c [RDF_dir/SINO*] for Live Multi-Static"$reset
coinLossCk -v -c $SinosDirectory2_1/SINO*
echo
#for loop to find Live scan %CPM Loss from section 1.2
sleep 1
echo ${BLUE}"2) Live scan CPM Loss" $reset
for i in {0..2}
 do
   echo "${BLUE}Bed $i :$reset"
   cat $PWD/coinLoss.csv | grep SINO000$i | cut -f10 -d,
done
echo

echo ${BLUE}"h) %DiffCpmLoss" $reset
echo "${BLUE}Bed 1 :$reset"
echo ${RED}"Dubug - No Results"${reset}
echo "${BLUE}Bed 2 :$reset"
echo ${RED}"Debug - No Results"${reset}
echo "${BLUE}Bed 3 :$reset"
echo ${RED}"Debug - No results"${reset}
echo
echo ${BLUE}"The %DiffCpmLoss of live scan to replay is <= 0.1%" $reset
echo "[ ] Yes"
echo "[ ] No"
echo


#chmod +x $PWD/DiffCpmLoss.sh
#$PWD/DiffCpmLoss.sh
#echo

chmod +x ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1172/Acq4D_1172.sh
"/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1172/Acq4D_1172.sh"
