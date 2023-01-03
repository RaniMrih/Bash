#!/bin/bash

#VARIABLES
PWD=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_2/Acq4D.1419
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
echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1419, Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
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

# Extrapolated Prompts = (Replay Duration / Original Duration) * Original Prompts.
GatedExtrapolated (){
within=true
for i in {1..3}
 do
   ReplayDuration2_3_2=$(grep -m$i "Frame Duration"  $S2_3_2Sino | tail -n1 | sed -n -e 's/^.*   Frame Duration   =//p'| sed 's|\(.*\) milliseconds.*|\1|' )
   OriginDuration2_1=$(grep -m$i "Frame Duration"  $S2_1Sino | tail -n1 | sed -n -e 's/^.*   Frame Duration   =//p'| sed 's|\(.*\) milliseconds.*|\1|' )
   OriginPrompts2_1=$(egrep -m$i ' totalPrompts ' $S2_1Sino  | tail -n1 | sed 's|\(.*\)   totalPrompts     = *|\1|')
   result=$(echo "$ReplayDuration2_3_2 $OriginDuration2_1" |  awk '{printf "%f", $1 / $2}')
   extrapolated=$(echo "$result $OriginPrompts2_1" | awk '{printf "%f", $1 * $2}')
   echo ${BLUE}"bed $i :"${reset}
   echo $extrapolated
done
echo
}

# find if the Total Prompts in the Replay are within 0.5% of the of the Extrapolated 
within0_5 (){
within=true
for i in {1..3}
 do
   ReplayTotalPrompts2_3_2=$(egrep -m$i ' totalPrompts ' $S2_3_2Sino | tail -n1 | sed 's|\(.*\)   totalPrompts     = *|\1|')
   ReplayDuration2_3_2=$(grep -m$i "Frame Duration"  $S2_3_2Sino | tail -n1 | sed -n -e 's/^.*   Frame Duration   =//p'| sed 's|\(.*\) milliseconds.*|\1|' )
   OriginDuration2_1=$(grep -m$i "Frame Duration"  $S2_1Sino | tail -n1 | sed -n -e 's/^.*   Frame Duration   =//p'| sed 's|\(.*\) milliseconds.*|\1|' )
   OriginPrompts2_1=$(egrep -m$i ' totalPrompts ' $S2_1Sino  | tail -n1 | sed 's|\(.*\)   totalPrompts     = *|\1|')
   result=$(echo "$ReplayDuration2_3_2 $OriginDuration2_1" |  awk '{printf "%f", $1 / $2}')  
   extrapolated=$(echo "$result $OriginPrompts2_1" |  awk '{printf "%f", $1 * $2}')
 #----------------------------------------
   Extr=$(echo "$extrapolated 0.05" |  awk '{printf "%f", $1 * $2}')
   H_Limit=$(echo "$extrapolated + $Extr" | bc)
   L_Limit=$(echo "$extrapolated - $Extr" | bc)
   #Round numbers
   H_Limit=$(printf "%.0f\n" $H_Limit)
   L_Limit=$(printf "%.0f\n" $L_Limit)
   if ((ReplayTotalPrompts2_3_2 > H_Limit )) || ((ReplayTotalPrompts2_3_2 < L_Limit ));then
   within=false
   fi
done
YesNoFunction $within

}

#Prompts Percent Difference = (ABS( Extrapolated Prompts - actual Replay Prompts ) / Extrapolated Prompts) * 100.0
Actual_VS_extrapolated (){
  for i in {1..3}
  do
   ReplayTotalPrompts2_3_2=$(egrep -m$i ' totalPrompts ' $S2_3_2Sino | tail -n1 | sed 's|\(.*\)   totalPrompts     = *|\1|')
   ReplayDuration2_3_2=$(grep -m$i "Frame Duration"  $S2_3_2Sino | tail -n1 | sed -n -e 's/^.*   Frame Duration   =//p'| sed 's|\(.*\) milliseconds.*|\1|' )
   OriginDuration2_1=$(grep -m$i "Frame Duration"  $S2_1Sino | tail -n1 | sed -n -e 's/^.*   Frame Duration   =//p' | sed 's|\(.*\) milliseconds.*|\1|' )
   OriginPrompts2_1=$(egrep -m$i ' totalPrompts ' $S2_1Sino  | tail -n1 | sed 's|\(.*\)   totalPrompts     = *|\1|')
   result=$(echo "$ReplayDuration2_3_2 $OriginDuration2_1" |  awk '{printf "%f", $1 / $2}')
   extrapolated=$(echo "$result $OriginPrompts2_1" | awk '{printf "%f", $1 * $2}')
   diff=$(echo "$extrapolated $ReplayTotalPrompts2_3_2" | awk '{printf "%f", $1 - $2}')
   diff=$(echo "$diff $extrapolated" |awk '{printf "%f", $1 / $2}')
   diff=$(echo "$diff 100.0" |awk '{printf "%f", $1 * $2}')
   echo ${BLUE}"bed $i :"${reset}
   echo $diff %
   done
echo
}
#----------------- Dwells sum
BinDwellSum (){
for j in {1..3}
do
sum=0
for i in {0..9}
 do
   Dwell=$(grep -m$j "bin $i dwell"  $S2_3_2Sino | tail -n1 | sed -n -e 's/^.* =//p')
   sum=$(expr $sum + $Dwell)
   #echo $Dwell $sum
  done
   echo ${BLUE}"bed $j :"${reset}
   echo $sum ms
done
echo
}

#------------------ find max/min dwell and diff
BinDwellMaxMin (){
for j in {1..3}
do
Max=0
Min=10000000
for i in {0..9}
 do
   Dwell=$(grep -m$j "bin $i dwell"  $S2_3_2Sino | tail -n1 | sed -n -e 's/^.* =//p')
   if (($Dwell > $Max));then
   Max=$Dwell
   fi
     if (($Dwell < $Min));then
     Min=$Dwell
     fi
  done
  diff=$(expr $Max - $Min)
   echo ${BLUE}"bed $j :"${reset}
   echo "       "$Max"   "$Min"   "$diff
done
echo
}
#------- Dwell sum within 1500ms of frame duration ------------------
Diff_Sum_FrameDuration(){
within1500=true
for j in {1..3}
do
sum=0
for i in {0..9}
 do
   Dwell=$(grep -m$j "bin $i dwell"  $S2_3_2Sino | tail -n1 | sed -n -e 's/^.* =//p')
   sum=$(expr $sum + $Dwell)
   done
   FrameDuration2_3_2=$(grep -m$j "Frame Duration"  $S2_3_2Sino | tail -n1 | sed -n -e 's/^.*   Frame Duration   =//p' | sed 's|\(.*\) milliseconds.*|\1|')
   Max_F_Duration=$(expr $FrameDuration2_3_2 + 1500)   
   Min_F_Duration=$(expr $FrameDuration2_3_2 - 1500)
   if (($sum > $Max_F_Duration))||(($sum < $Min_F_Duration));then
   Within1500=false
   fi
done
YesNoFunction $within1500
echo

}
#------- max min Dwell diff vs accepted triggers (from step 1181)------------------
MaxMin_VS_ATriggers (){
Smaller=true
for j in {1..3}
 do
 A_Triggers=$(grep -m1 "   acceptedTriggers =" $S2_3_2Sino | tail -n1 | sed -n -e 's/^.*   acceptedTriggers = //p')
 A_Triggers=$(expr $A_Triggers \* 2)
  for i in {0..9}
   do
     Dwell=$(grep -m$j "bin $i dwell"  $S2_3_2Sino | tail -n1 | sed -n -e 's/^.* =//p')
     if (($Dwell > $Max));then
     Max=$Dwell
     fi
       if (($Dwell < $Min));then
       Min=$Dwell
       fi
   done
  diff=$(expr $Max - $Min)
  if (($diff > $A_Triggers));then
   Smaller=false
   fi
done
YesNoFunction $Smaller
}
#------------------------------------- step 1 --------------------------------------------------
#---- find total prompts ------------------
sleep 1
echo ${BLUE}"1) Gated Replay "$reset
echo
echo ${BLUE}"a) Total Prompts (totalPrompts):"$reset
for i in {1..3}
 do
   TotalPrompts2_3_1=$(egrep -m$i ' totalPrompts ' $S2_3_2Sino |tail -n1 | sed 's|\(.*\)   totalPrompts     = *|\1|')
   echo ${BLUE}"bed $i :"${reset}
   echo $TotalPrompts2_3_1
done
echo
#---- find Frame duration ------------------
sleep 1
echo ${BLUE}"Gated Replay 'Frame Duration'"$reset
for i in {1..3}
 do
   FrameDuration2_3_1=$(grep -m$i "Frame Duration"  $S2_3_2Sino | tail -n1 | sed -n -e 's/^.*   Frame Duration   =//p')
   echo ${BLUE}"bed $i :"${reset}
   echo $FrameDuration2_3_1
done
echo
#------------------------------------- step 2 --------------------------------------------------
#---- Extrapolated Prompts ------------------
sleep 1
echo ${BLUE}"2) Gated Extrapolated Prompts"$reset
#Go to function
GatedExtrapolated

#------------------------------------- step 3 --------------------------------------------------
#---- Actual vs extrapolated Prompts  ------------------
sleep 1
echo ${BLUE}"3) Actual vs extrapolated Prompts Percent "$reset
echo ${BLUE}"Difference:"$reset
#Go to function
Actual_VS_extrapolated

#----------- qustions ---------
sleep 1
echo ${BLUE}"For all bed locations, the Total Prompts in the"$reset
echo ${BLUE}"Replay are within 0.5% of the of the Extrapolated"$reset
echo ${BLUE}"Prompts ?"$reset
within0_5
#------------------------------------- step 4 --------------------------------------------------
sleep 1
echo ${BLUE}"Sum of Bin Dwell Times :"$reset
BinDwellSum
#------------------------------------- step 5 --------------------------------------------------
sleep 1
echo ${BLUE}"5) Bin Dwell :"$reset
echo "        Max     Min   diff"
BinDwellMaxMin
#----------- qustions ---------
sleep 1
echo ${BLUE}"For all bed locations, the sum of the bin dwell time "$reset
echo ${BLUE}"should be within 1500ms of the Gated Replay "$reset
echo ${BLUE}"Frame duration ?"$reset
Diff_Sum_FrameDuration

sleep 1
echo ${BLUE}"For all bed locations, the Max bin dwell - Min bin  "$reset
echo ${BLUE}"dwell < = (2*Numberof accepted triggers) ?"$reset
MaxMin_VS_ATriggers

#Run the next step according to doors
chmod +x /usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_2/Acq4D.1420/Acq4D_1420.sh
"/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_2/Acq4D.1420/Acq4D_1420.sh"

