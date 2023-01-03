#!/bin/bash
#!/bin/ksh

#VARIABLES
PWD=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1183
ScriptsPath=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/scripts
S2_1Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1155/S2.1Sino.txt
S2_2Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1165/S2.2Sino.txt
S2_3_1Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1180/S2.3.1Sino.txt
reset=`tput sgr 0`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
RED=`tput setaf 1`
Smaller=true

for j in {1..3}
do
sum=0
for i in {0..9}
 do
   Dwell=$(grep -m$j "bin $i dwell"  $S2_3_1Sino | tail -n1 | sed -n -e 's/^.* =//p')
   sum=$(expr $sum + $Dwell)
   echo $Dwell $sum
  done
   echo ${BLUE}"bed $j :"${reset}
   echo $sum
done
