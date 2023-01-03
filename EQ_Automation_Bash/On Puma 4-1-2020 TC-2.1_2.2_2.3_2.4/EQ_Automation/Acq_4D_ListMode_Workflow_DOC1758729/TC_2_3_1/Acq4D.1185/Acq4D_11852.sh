#!/in/bash
#!/bin/ksh

#VARIABLES
PWD=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1185
ScriptsPath=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/scripts
S2_1Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1155/S2.1Sino.txt
S2_2Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1165/S2.2Sino.txt
S2_3_1Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1180/S2.3.1Sino.txt
reset=`tput sgr 0`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
RED=`tput setaf 1`
Smaller=true
SINOPATH2_3_1=$(cat ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1180/SINOSPath2_3.txt)
echo $SINOPATH2_3_1
#ECHO COMMAND START SCRIPT
echo
echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1185, Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
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
#----------------- Dwells sum
BinDwellSum (){
for j in {1..3}
do
sum=0
for i in {0..9}
 do
   Dwell=$(grep -m$j "bin $i dwell"  $S2_3_1Sino | tail -n1 | sed -n -e 's/^.* =//p')
   sum=$(expr $sum + $Dwell)
  done
   echo ${BLUE}"bed $j :"${reset}
   echo $sum ms
done
echo
}
#-------------sum all bins segment for 30 SINOS
SumSegment (){
sum1=0
sum2=0
sum3=0
for i in {0..29}
 do 
 if (($i < 10));then
   num1=$(grep -m1 "Segment ID(SegGroup 1,Layout 3) DS 0 Total Counts" $SINOPATH2_3_1/Tell2.3.1.SINO000$i | sed -n -e 's/^.*Counts://p')
   sum1=$(expr $sum1 + $num1) 
   fi
 if (($i > 9))&&(($i<20));then
   num2=$(grep -m1 "Segment ID(SegGroup 1,Layout 3) DS 0 Total Counts" $SINOPATH2_3_1/Tell2.3.1.SINO00$i | sed -n -e 's/^.*Counts://p')
   sum2=$(expr $sum2 + $num2)
   fi
 if (($i > 19));then
   num3=$(grep -m1 "Segment ID(SegGroup 1,Layout 3) DS 0 Total Counts" $SINOPATH2_3_1/Tell2.3.1.SINO00$i | sed -n -e 's/^.*Counts://p') 
   sum3=$(expr $sum3 + $num3)
   fi
done
echo ${BLUE}"bed 1 :"${reset}
echo $sum1
echo ${BLUE}"bed 2 :"${reset}
echo $sum2
echo ${BLUE}"bed 3 :"${reset}
echo $sum3
echo
}
#------------------------------------- step 1 --------------------------------------------------
#---- find total prompts ------------------
sleep 1
echo ${BLUE}"1) Gated Replay Total Prompts"$reset
echo
for i in {1..3}
 do
   TotalPrompts2_3_1=$(egrep -m$i ' totalPrompts ' $S2_3_1Sino |tail -n1 | sed 's|\(.*\)   totalPrompts     = *|\1|')
  # FrameDuration=$(grep -m$i "Frame Duration"  $S2_3_1Sino | tail -n1 | sed -n -e 's/^.*   Frame Duration   =//p')
   echo ${BLUE}"bed $i :"${reset}
   echo $TotalPrompts2_3_1
done
echo
#---- find Frame duration ------------------
sleep 1
echo ${BLUE}"Gated Replay Frame Duration"$reset
for i in {1..3}
 do
   FrameDuration2_3_1=$(grep -m$i "Frame Duration"  $S2_3_1Sino | tail -n1 | sed -n -e 's/^.*   Frame Duration   =//p')
   echo ${BLUE}"bed $i :"${reset}
   echo $FrameDuration2_3_1
done
echo
#---- find Sum Bin Dwell ------------------
sleep 1
echo ${BLUE}"Sum of Bin Dwell Times :"$reset
BinDwellSum

#grep "Segment ID(SegGroup 1,Layout 3) DS 0 Total Counts" /petRDFS/XOIATRMM/AVEWDJMT/ATSOLOLT/Tell2.3.1.SINO* | cut -d : -f 3

#------------------------------------- step 2 --------------------------------------------------

echo ${BLUE}"This step will take few minutes ... please wait"$reset
#rdfTeller for 30 SINOS
rdfTeller -r '-h f -S' -f Tell2.3.1 $SINOPATH2_3_1/SINO*
echo 
echo ${BLUE}"2) Sum Segment 2 bin counts :"$reset
SumSegment
#------------------------------------- step 3 --------------------------------------------------
# find The sum bin counts to total prompts Ratio
for i in ${ArrSumSegment[@]}
do
echo $i
done
