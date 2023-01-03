#!/bin/bash
#!/bin/ksh

#VARIABLES
PWD=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_1/Acq4D.1364
ScriptsPath=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/scripts
S2_1Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1155/S2.1Sino.txt
S2_2Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1165/S2.2Sino.txt
S2_3_1Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_1/Acq4D.1180/S2.3.1Sino.txt
reset=`tput sgr 0`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
RED=`tput setaf 1`
#ECHO COMMAND START SCRIPT
echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1364, Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
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

echo ${BLUE}"Block Busy Average Deadtime"$reset
echo
Within_4=true
for i in {1..3}
 do
   echo "${BLUE}Original Scan Frame $i :$reset"
   #greps only Singles Total Counts for each frame and diff
   num1=$(grep -m$i "Block Busy Average Deadtime" $S2_1Sino | tail -n1 |sed -n -e 's/^.*   Block Busy Average Deadtime: //p')
   echo $num1
   echo "${BLUE}Replay Scan Frame $i :$reset"
   num2=$(grep -m$i "Block Busy Average Deadtime" $S2_3_1Sino | tail -n1 |sed -n -e 's/^.*   Block Busy Average Deadtime: //p')
   echo $num2   
#use awk to calculate floats
   diff=$(echo "${num1} ${num2}" |  awk '{printf "%f", $1 - $2}')
   diff=$(echo "${diff} ${num1}" |  awk '{printf "%f", $1 / $2}')
   L_Limit=$(printf "%.0f\n" $diff)
   echo ${BLUE}"% Difference Frame $i: $reset "
   echo "$diff %"
   echo
   sleep 1
  if (($L_Limit >= 4));then
  Within_4=false
  fi
done
#----------- qustions ---------
sleep 1
echo "${BLUE}Is the % Difference between Singles Block Busy Average$reset"
echo "${BLUE}Deadtime for each frame of Original and Replay scan <=  4% ?$reset"
YesNoFunction $Within_4
