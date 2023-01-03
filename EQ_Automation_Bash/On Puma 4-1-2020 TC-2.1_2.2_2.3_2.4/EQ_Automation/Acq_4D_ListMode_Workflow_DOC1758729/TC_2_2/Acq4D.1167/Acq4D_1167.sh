#! /bin/bash
#!/bin/ksh

#VARIABLES
reset=`tput sgr 0`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
RED=`tput setaf 1`
PWD=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1167
ScriptsPath=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/scripts
S2_1Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1165/S2.1Sino.txt
S2_2Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1165/S2.2Sino.txt

cp ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1155/Generated_Files/S2.1Sino.txt ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1165
#ECHO COMMAND START SCRIPT
echo
echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1167, Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
echo
#-------------------------------- Step1 ------------------------------------------
sleep 1
echo $BLUE"1) S2.2Sino.txt replay Time-Of-Day (hh:mm:ss) for:"$reset
file1=$(grep -m1 "Scan Start Time" $S2_2Sino) #grep only first scan start time
echo $file1
echo
sleep 1
echo $BLUE"Frame Sart Time (For First Frame):"$reset
file2=$(grep -m1 "Frame Start Time" $S2_2Sino) #grep first frame only
echo $file2

#grep only date pattern to compare
ScanStart=$(cat $S2_2Sino | grep -m1 "Scan Start Time" | grep -o '[0-9][0-9]:[0-9][0-9]:[0-9][0-9]')
FrameStart=$(cat $S2_2Sino | grep -m1 "Frame Start Time" | grep -o '[0-9][0-9]:[0-9][0-9]:[0-9][0-9]')
t=$(date -d "20121012 ${ScanStart}" +%s)
t1=$(date -d "20121012 ${FrameStart}" +%s)
diff=$(expr $t1 - $t)
echo

#check for 30 sec step pass
sleep 1
echo ${BLUE}"The replay Frame Start Time of the first frame is"
echo "30 seconds after the start of the scan?"${reset}
if (($diff == 30));then
   echo ${GREEN}"[X] Yes"${reset}
   echo [ ] No
else
   echo "[ ] Yes"
   echo ${RED}"[X]"${reset}
fi

#-------------------------------- Step 2 ------------------------------------------
sleep 1
echo
echo ${BLUE}"2) The Frame Start Time (Coinc msec) timestamps"
echo "for original and replay Frame for all beds"${reset}
sleep 1
echo
echo ${BLUE}"Original Scan"${reset}
echo ${BLUE}"Bed 1 :"${reset}
grep -m1 "(Coinc msec)" $S2_1Sino
sleep 1
echo ${BLUE}"Bed 2 :"${reset}
grep -m2 "(Coinc msec)" $S2_1Sino | tail -n1
sleep 1
echo ${BLUE}"Bed 3 :"${reset}
grep -m3 "(Coinc msec)" $S2_1Sino | tail -n1
sleep 1
echo
echo ${BLUE}"Replay Scan"${reset}
echo ${BLUE}"Bed 1 :"${reset}
grep -m1 "(Coinc msec)" $S2_2Sino
sleep 1
echo ${BLUE}"Bed 2 :"${reset}
grep -m2 "(Coinc msec)" $S2_2Sino | tail -n1
sleep 1
echo ${BLUE}"Bed 3 :"${reset}
grep -m3 "(Coinc msec)" $S2_2Sino | tail -n1
sleep 1
echo
echo ${BLUE}"Is the difference between original and replay"
echo "'Frame Start Time (Coinc msec)' for all other beds"
echo "is <= 5ms?"${reset}
chmod +x $ScriptsPath/checkdiff1.sh
$ScriptsPath/checkdiff1.sh
#echo ${GREEN}"[X] Yes"${reset}
#echo "[ ] No"
echo

#-------------------------------- Step 3 ------------------------------------------
sleep 1
echo ${BLUE}"3) The Frame Durations for original scan and"
echo "replay scan for all beds,"${reset}
sleep 1
echo
echo ${BLUE}"Original Scan"${reset}
echo ${BLUE}"Bed 1 :"${reset}
grep -m1 "Frame Duration" $S2_1Sino
sleep 1
echo ${BLUE}"Bed 2 :"${reset}
grep -m2 "Frame Duration" $S2_1Sino | tail -n1
sleep 1
echo ${BLUE}"Bed 3 :"${reset}
grep -m3 "Frame Duration" $S2_1Sino | tail -n1
sleep 1
echo
echo ${BLUE}"Replay Scan"${reset}
echo ${BLUE}"Bed 1 :"${reset}
grep -m1 "Frame Duration" $S2_2Sino
sleep 1
echo ${BLUE}"Bed 2 :"${reset}
grep -m2 "Frame Duration" $S2_2Sino | tail -n1
sleep 1
echo ${BLUE}"Bed 3 :"${reset}
grep -m3 "Frame Duration" $S2_2Sino | tail -n1
sleep 1
echo
#need to continue calculation
echo ${BLUE}"Is the difference between Frame Duration for "
echo "original scan and replay scan is <= 5ms"${reset}
chmod +x $ScriptsPath/checkdiff2.sh
$ScriptsPath/checkdiff2.sh



chmod +x ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1168/Acq4D_1168.sh
"/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1168/Acq4D_1168.sh"
