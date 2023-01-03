#!/bin/bash

#VARIABLES
PWD=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_2/Acq4D.1418
ScriptsPath=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/scripts
S2_1Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1155/S2.1Sino.txt
S2_2Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1165/S2.2Sino.txt
S2_3_1Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_1/Acq4D.1180/S2.3.1Sino.txt
S2_3_2Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_2/Acq4D.1416/S2.3.2Sino.txt

reset=`tput sgr 0`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
RED=`tput setaf 1`
#ECHO COMMAND START SCRIPT
echo
sleep 1
echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1418, Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
echo
#----------------------------------------- functions --------------------------------------------
YesNoFunction () {
 # echo $1
  if $1 ; then
  echo ${GREEN}"[X] Yes"${reset}
  echo "[ ] No"
  else
  echo "[ ] Yes"
  echo ${RED}"[X] No"${reset}
  fi
  echo
}

CalculateFunction (){
for i in {1..3}
 do
   EventLoss1=$( grep -m$i "Event Loss due to Sorter being bandwidth limited"  $S2_3_2Sino | tail -n1 | sed 's|\(.*\): Event Loss due to Sorter being bandwidth limited.*|\1|')
   TotalCoinc1=$( grep -m$i "Total coincidence events transmitted to the Sorter"  $S2_3_2Sino | tail -n1 | sed 's|\(.*\): Total coincidence events transmitted to the Sorter.*|\1|')
   diff=$(echo "$EventLoss1  $TotalCoinc1 " |  awk '{printf "%f", $1 + $2}')  
   diff=$(echo "$diff 100 " |  awk '{printf "%f", $1 * $2}')
   diff=$(echo "$EventLoss1 $diff" |  awk '{printf "%f", $1 / $2}')
   echo ${BLUE}"bed $i :"${reset}
   echo $diff %
   CalculateFunction1 $TotalCoinc1 $diff
done
echo
}

CalculateFunction1 (){
 diff1=$(echo "$1 100 " |  awk '{printf "%f", $1 * $2}')
 H_Limit=$(printf "%.0f\n" $2)
 diff1=$(printf "%.0f\n" $diff1)
if (($H_Limit > $diff1 ));then
  Smaller=false
fi
}

echo
#------------------------------------- step 1 --------------------------------------------------
#---- find Scan Start Time------------------
sleep 1
echo ${BLUE}"1) Total coincidence events transmitted"$reset
echo ${BLUE}"to the Sorter"$reset
for i in {1..3}
 do
   TotalCoinc=$( grep -m$i "Total coincidence events transmitted to the Sorter"  $S2_3_2Sino | tail -n1 | sed 's|\(.*\): Total coincidence events transmitted to the Sorter.*|\1|')
   echo ${BLUE}"bed $i :"${reset}
   echo $TotalCoinc
done
echo
#------------------------------------- step 2 --------------------------------------------------
#---- find Total coincidence-----------------
sleep 1
echo ${BLUE}"2) Event Loss due to Sorter being bandwidth limited :"$reset
echo ${BLUE}"to the Sorter"$reset
for i in {1..3}
 do
   EventLoss=$( grep -m$i "Event Loss due to Sorter being bandwidth limited"  $S2_3_2Sino | tail -n1 | sed 's|\(.*\): Event Loss due to Sorter being bandwidth limited.*|\1|')
   echo ${BLUE}"bed $i :"${reset}
   echo $EventLoss
done
echo
#------------------------------------- step 3 --------------------------------------------------
#---- find Total coincidence-----------------
sleep 1
echo ${BLUE}"Sorter Loss %"$reset
CalculateFunction

#----------- qustions ---------
sleep 1
echo ${BLUE}"Sorter Loss % is less than 1% for all beds."$reset
YesNoFunction $Smaller

#Run the next step according to doors
chmod +x /usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_2/Acq4D.1419/Acq4D_1419.sh
"/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_2/Acq4D.1419/Acq4D_1419.sh"
