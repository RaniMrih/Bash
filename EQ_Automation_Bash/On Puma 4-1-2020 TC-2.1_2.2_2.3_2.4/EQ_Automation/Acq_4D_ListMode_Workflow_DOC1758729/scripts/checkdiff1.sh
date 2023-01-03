#!/bin/bash
#!/bin/ksh

#VARIABLES
PWD=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1167
reset=`tput sgr 0`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
RED=`tput setaf 1`
within5mm=true
S2_1Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1165/S2.1Sino.txt
S2_2Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1165/S2.2Sino.txt

for i in {1..3}
do
num1=$(cat ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1165/S2.1Sino.txt | grep -m1 'msec' | tail -n1 | sed 's|\(.*\)   Frame Start Time (Coinc msec) = *|\1|')
num2=$(cat ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1165/S2.2Sino.txt | grep -m1 'msec' | tail -n1 | sed 's|\(.*\)   Frame Start Time (Coinc msec) = *|\1|')

diff=$(expr $num1 - $num2)
if (($diff < -5)) || (($diff > 5));then
   within5mm=false
fi
done
#echo $within5mmi

if $within5mm ;then
echo ${GREEN}"[X] Yes"${reset}
echo "[ ] No"
else
echo "[ ] Yes"
echo ${RED}"[X] No"${reset}
fi

