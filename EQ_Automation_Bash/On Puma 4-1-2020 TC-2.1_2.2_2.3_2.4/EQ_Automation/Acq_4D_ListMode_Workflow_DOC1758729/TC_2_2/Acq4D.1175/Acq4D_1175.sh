#!/bin/bash
#!/bin/ksh

#VARIABLES
reset=`tput sgr 0`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
RED=`tput setaf 1`
PWD=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1175
S2_1Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1165/S2.1Sino.txt
S2_2Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1165/S2.2Sino.txt
#ECHO COMMAND START SCRIPT
echo
echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1175 Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
echo

sleep 1
echo ${BLUE}"Block Busy Max "$reset
for i in {1..3}
 do
   echo "${BLUE}Original Scan Frame $i :$reset"
   grep -m$i "Block Busy Max" $S2_1Sino | tail -n1 | sed 's/^.*\(Module*\)/\1/g'
done
echo
sleep 1
#this sed greps the word and remove every thing before it
for i in {1..3}
 do
   echo "${BLUE}Replay Scan Frame $i :$reset"
   grep -m$i "Block Busy Max" $S2_2Sino | tail -n1 | sed 's/^.*\(Module*\)/\1/g'
done
echo
sleep 1
echo ${BLUE}"Is 'Block Busy Max' for each frame of"
echo "Original & replay scan occurs in the same Module and Block?"$reset

OK=true
for i in {1..3}
 do
   #greps the word "Module and compare both strings"
   str1=$(cat $S2_1Sino | grep -m$i "Block Busy Max" $S2_1Sino | tail -n1 | sed 's/^.*\(Module*\)/\1/g')
   str2=$(cat $S2_2Sino | grep -m$i "Block Busy Max" $S2_2Sino | tail -n1 | sed 's/^.*\(Module*\)/\1/g')
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

sleep 1
echo ${BLUE}"Original Scan:"$reset
Nodiff=true
for i in {1..3}
 do
   #greps only Block Busy Max number for each frame 
    echo "${BLUE}Frame $i :$reset"
    #sed removes everything before "Block" and after "Module" include
   grep -m$i "Block Busy Max" $S2_1Sino | tail -n1 | sed 's|\(.*\)Module.*|\1|' | sed 's/^.*\(Block*\)/\1/g'
done
echo
echo ${BLUE}"Replay Scan:"$reset
sleep 1
for i in {1..3}
 do
   #greps only Block Busy Max number for each frame and diff
   echo "${BLUE}Frame $i :$reset"
   grep -m$i "Block Busy Max" $S2_2Sino | tail -n1 | sed 's|\(.*\)Module.*|\1|' | sed 's/^.*\(Block*\)/\1/g'
  # num1=$(grep -m$i 'Block Busy Max' $S2_1Sino |tail -n1 | sed 's|\(.*\)Module.*|\1|' | sed 's|\(.*\)   Block Busy Max*|\1|')
  # num2=$(grep -m$i 'Block Busy Max' $S2_2Sino |tail -n1 | sed 's|\(.*\)Module.*|\1|' | sed 's|\(.*\)   Block Busy Max*|\1|')
  # diff=$("num1 - num2" |bc -l)
  #   if (($diff != 0));then
  #   NoDiff=false
  #   fi
done
echo
sleep 1
echo ${BLUE}"Deffrence"$reset
echo ${BLUE}"Frame1:"$reset
echo ${BLUE}"Frame2:"$reset
echo ${BLUE}"Frame3:"$reset
echo
echo ${BLUE}"Is the Difference between each frame of "
echo "Original and Replay scan for 'Block Busy Max' <=  0.002 ?"
echo "${RED}Debug - No results$reset"

#if $NoDiff ; then
#echo ${GREEN}"[X] Yes"${reset}
#echo "[ ] No"
#else
#echo "[ ] Yes"
#echo ${RED}"[X] No"${reset}
#fi
#--------------------------------- step 2--------------------------------------------
echo
sleep 1
echo ${BLUE}"2) Block Busy Min "$reset
for i in {1..3}
 do
   echo "${BLUE}Original Scan Frame $i :$reset"
   grep -m$i "Block Busy Min" $S2_1Sino | tail -n1 | sed 's/^.*\(Module*\)/\1/g'
done
sleep 1
echo
#this sed greps the word and remove every thing before it
for i in {1..3}
 do
   echo "${BLUE}Replay Scan Frame $i :$reset"
   grep -m$i "Block Busy Min" $S2_2Sino | tail -n1 | sed 's/^.*\(Module*\)/\1/g'
done
echo
sleep 1
echo ${BLUE}"Is 'Block Busy Min' for each frame of"
echo "Original & replay scan occurs in the same Module and Block?"$reset

OK=true
for i in {1..3}
 do
   #greps the word "Module and compare both strings"
   str1=$(cat $S2_1Sino | grep -m$i "Block Busy Min" $S2_1Sino | tail -n1 | sed 's/^.*\(Module*\)/\1/g')
   str2=$(cat $S2_2Sino | grep -m$i "Block Busy Min" $S2_2Sino | tail -n1 | sed 's/^.*\(Module*\)/\1/g')
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
sleep 1
echo ${BLUE}"Original Scan:"$reset
Nodiff=true
for i in {1..3}
 do
   #greps only Block Busy Max number for each frame
    echo "${BLUE}Frame $i :$reset"
    #sed removes everything before "Block" and after "Module" include
   grep -m$i "Block Busy Min" $S2_1Sino | tail -n1 | sed 's|\(.*\)Module.*|\1|' | sed 's/^.*\(Block*\)/\1/g'
done
echo
sleep 1
echo ${BLUE}"Replay Scan:"$reset
for i in {1..3}
 do
   #greps only Block Busy Max number for each frame and diff
   echo "${BLUE}Frame $i :$reset"
   grep -m$i "Block Busy Min" $S2_2Sino | tail -n1 | sed 's|\(.*\)Module.*|\1|' | sed 's/^.*\(Block*\)/\1/g'
  # num1=$(grep -m$i 'Block Busy Max' $S2_1Sino |tail -n1 | sed 's|\(.*\)Module.*|\1|' | sed 's|\(.*\)   Block Busy Max*|\1|')
  # num2=$(grep -m$i 'Block Busy Max' $S2_2Sino |tail -n1 | sed 's|\(.*\)Module.*|\1|' | sed 's|\(.*\)   Block Busy Max*|\1|')
  # diff=$("num1 - num2" |bc -l)
  #   if (($diff != 0));then
  #   NoDiff=false
  #   fi
done
echo
sleep 1
echo ${BLUE}"Deffrence"$reset
echo ${BLUE}"Frame1:"$reset
echo ${BLUE}"Frame2:"$reset
echo ${BLUE}"Frame3:"$reset
echo
sleep 1
echo ${BLUE}"Is the Difference between each frame of "
echo "Original and Replay scan for 'Block Busy Min' <=  0.002 ?"
echo "${RED}Debug - No results$reset"

