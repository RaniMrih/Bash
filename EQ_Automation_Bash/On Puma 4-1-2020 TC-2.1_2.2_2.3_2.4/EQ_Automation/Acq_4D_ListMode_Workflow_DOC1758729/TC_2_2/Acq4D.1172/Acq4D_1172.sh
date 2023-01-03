#!/bin/bash
#!/bin/ksh

#VARIABLES
SinosDirectory2_1=""
SinosDirectory2_2=""
ListsDirectory=""
Empty=""
PWD=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1172
reset=`tput sgr 0`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
RED=`tput setaf 1`
S2_1Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1165/S2.1Sino.txt
S2_2Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1165/S2.2Sino.txt
#ECHO COMMAND START SCRIPT
echo
echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1172, Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
echo
#this sed greps the word and remove every thing before it 
sleep 1
echo ${BLUE}"1) Module and Block for Singles with Max Counts"$reset
for i in {1..3}
 do
   echo "${BLUE}Original Scan Frame $i :$reset"
   grep -m$i "Singles Block Max Counts" $S2_1Sino | tail -n1 | sed 's/^.*\(Module*\)/\1/g'
   sleep 1
done
echo
#this sed greps the word and remove every thing before it
for i in {1..3}
 do
   echo "${BLUE}Replay Scan Frame $i :$reset"
   grep -m$i "Singles Block Max Counts" $S2_2Sino | tail -n1 | sed 's/^.*\(Module*\)/\1/g'
   sleep 1
done
echo

echo ${BLUE}"Singles with Max Counts for each frame of"
echo "Original & Replay occurs in the same Module and Block?"$reset

OK=true
for i in {1..3}
 do
   #greps the word "Module and compare both strings"
   str1=$(cat $S2_1Sino | grep -m$i "Singles Block Max Counts" $S2_1Sino | tail -n1 | sed 's/^.*\(Module*\)/\1/g')
   str2=$(cat $S2_2Sino | grep -m$i "Singles Block Max Counts" $S2_2Sino | tail -n1 | sed 's/^.*\(Module*\)/\1/g')
   if [[ "$str1" != "$str2" ]];then
   OK=false
   fi
done
#echo $OK
if $OK ; then
echo ${GREEN}"[X] Yes"${reset}
echo "[ ] No"
else
echo "[ ] Yes"
echo ${RED}"[X] No"${reset}
fi
echo


echo ${BLUE}"Block Singles with Max Counts:"$reset
Nodiff=true
for i in {1..3}
 do
   echo "${BLUE}Original Scan Frame $i :$reset"
   #greps only max counts number for each frame and diff
   grep -m$i "Singles Block Max Counts" $S2_1Sino | tail -n1 | sed 's|\(.*\)Module.*|\1|' | sed 's/^.*\(Singles*\)/\1/g'
   echo "${BLUE}Replay Scan Frame $i :$reset"  
   grep -m$i "Singles Block Max Counts" $S2_2Sino | tail -n1 | sed 's|\(.*\)Module.*|\1|' | sed 's/^.*\(Singles*\)/\1/g'
   num1=$(grep -m$i 'Singles Block Max Counts' $S2_1Sino |tail -n1 | sed 's|\(.*\)Module.*|\1|' | sed 's|\(.*\)   Singles Block Max Counts:*|\1|')
   num2=$(grep -m$i 'Singles Block Max Counts' $S2_2Sino |tail -n1 | sed 's|\(.*\)Module.*|\1|' | sed 's|\(.*\)   Singles Block Max Counts:*|\1|')
   diff=$(expr $num1 - $num2)
     if (($diff != 0));then
     NoDiff=false
     fi
   echo ${BLUE}"% Difference Frame 1: $reset "
   echo "$diff %"
   echo
   sleep 1
done
echo

echo ${BLUE}"Is the % Difference between the Singles with Max "
echo "Counts for each frame of Original and Replay scan <= 0.01%?"$reset
if $NoDiff ; then
echo ${GREEN}"[X] Yes"${reset}
echo "[ ] No"
else
echo "[ ] Yes"
echo ${RED}"[X] No"${reset}
fi
echo
#---------------------------- step 2 -----------------------------------------------------
sleep 1
echo ${BLUE}"2) Module and Block for Singles with Min Counts"$reset
#this sed greps the word and remove every thing before it
for i in {1..3}
 do
   echo "${BLUE}Original Scan Frame $i :$reset"
   grep -m$i "Singles Block Min Counts" $S2_1Sino | tail -n1 | sed 's/^.*\(Module*\)/\1/g'
   sleep 1
done
echo
#this sed greps the word and remove every thing before it
for i in {1..3}
 do
   echo "${BLUE}Replay Scan Frame $i :$reset"
   grep -m$i "Singles Block Min Counts" $S2_2Sino | tail -n1 | sed 's/^.*\(Module*\)/\1/g'
   sleep 1
done
echo
echo ${BLUE}"Singles with Min Counts for each frame of Original & Replay"
echo "occurs in the same Module and Block?"$reset
OK=true
for i in {1..3}
 do
   #greps the word "Module and compare both strings"
   str1=$(cat $S2_1Sino | grep -m$i "Singles Block Min Counts" $S2_1Sino | tail -n1 | sed 's/^.*\(Module*\)/\1/g')
   str2=$(cat $S2_2Sino | grep -m$i "Singles Block Min Counts" $S2_2Sino | tail -n1 | sed 's/^.*\(Module*\)/\1/g')
   if [[ "$str1" != "$str2" ]];then
   OK=false
   fi
done
#echo $OK
if $OK ; then
echo ${GREEN}"[X] Yes"${reset}
echo "[ ] No"
else
echo "[ ] Yes"
echo ${RED}"[X] No"${reset}
fi
echo

echo ${BLUE}"Block Singles with Mix Counts:"$reset
Nodiff=true
for i in {1..3}
 do
   echo "${BLUE}Original Scan Frame $i :$reset"
   #greps only max counts number for each frame and diff
   grep -m$i "Singles Block Min Counts" $S2_1Sino | tail -n1 | sed 's|\(.*\)Module.*|\1|' | sed 's/^.*\(Singles*\)/\1/g'
   echo "${BLUE}Replay Scan Frame $i :$reset"
   grep -m$i "Singles Block Min Counts" $S2_2Sino | tail -n1 | sed 's|\(.*\)Module.*|\1|' | sed 's/^.*\(Singles*\)/\1/g'
   num1=$(grep -m$i 'Singles Block Min Counts' $S2_1Sino |tail -n1 | sed 's|\(.*\)Module.*|\1|' | sed 's|\(.*\)   Singles Block Min Counts:*|\1|')
   num2=$(grep -m$i 'Singles Block Min Counts' $S2_2Sino |tail -n1 | sed 's|\(.*\)Module.*|\1|' | sed 's|\(.*\)   Singles Block Min Counts:*|\1|')
   diff=$(expr $num1 - $num2)
     if (($diff != 0));then
     NoDiff=false
     fi
   echo ${BLUE}"% Difference Frame 1: $reset "
   echo "$diff %"
   echo
   sleep 1
done
echo

echo ${BLUE}"Is the % Difference between the Singles with Min "
echo "Counts for each frame of Original and Replay scan <= 0.01%?"$reset
if $NoDiff ; then
echo ${GREEN}"[X] Yes"${reset}
echo "[ ] No"
else
echo "[ ] Yes"
echo ${RED}"[X] No"${reset}
fi
echo
#--------------------------------------------- step 3 ----------------------------------------
echo ${BLUE}"3) Singles Total Counts"$reset
Nodiff=true
for i in {1..3}
 do
   echo "${BLUE}Original Scan Frame $i :$reset"
   #greps only max counts number for each frame and diff
   grep -m$i "Singles Total Counts" $S2_1Sino | tail -n1 | sed 's|\(.*\)Module.*|\1|' | sed 's/^.*\(Singles*\)/\1/g'
   echo "${BLUE}Replay Scan Frame $i :$reset"
   grep -m$i "Singles Total Counts" $S2_2Sino | tail -n1 | sed 's|\(.*\)Module.*|\1|' | sed 's/^.*\(Singles*\)/\1/g'
   num1=$(grep -m$i 'Singles Total Counts' $S2_1Sino |tail -n1 | sed 's|\(.*\)Module.*|\1|' | sed 's|\(.*\)   Singles Total Counts:*|\1|')
   num2=$(grep -m$i 'Singles Total Counts' $S2_2Sino |tail -n1 | sed 's|\(.*\)Module.*|\1|' | sed 's|\(.*\)   Singles Total Counts:*|\1|')
   diff=$(expr $num1 - $num2)
     if (($diff != 0));then
     NoDiff=false
     fi
   echo ${BLUE}"% Difference Frame 1: $reset "
   echo "$diff %"
   echo
   sleep 1
done
echo

echo ${BLUE}"Is the % Difference between the Singles with Total "
echo "Counts for each frame of Original and Replay scan <= 0.01%?"$reset
if $NoDiff ; then
echo ${GREEN}"[X] Yes"${reset}
echo "[ ] No"
else
echo "[ ] Yes"
echo ${RED}"[X] No"${reset}
fi
echo

chmod +x ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1175/Acq4D_1175.sh
"/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1175/Acq4D_1175.sh"
