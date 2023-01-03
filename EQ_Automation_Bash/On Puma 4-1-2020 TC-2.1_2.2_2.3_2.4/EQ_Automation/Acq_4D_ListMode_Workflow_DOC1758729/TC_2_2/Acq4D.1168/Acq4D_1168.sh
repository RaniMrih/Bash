#!/bin/bash
#!/bin/ksh

#VARIABLES
reset=`tput sgr 0`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
RED=`tput setaf 1`
ScriptsPath=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/scripts
PWD=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1168
S2_1Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1165/S2.1Sino.txt
S2_2Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1165/S2.2Sino.txt
#ECHO COMMAND START SCRIPT
echo
echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1168, Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
echo
#-------------------------------- Step1 ------------------------------------------
#-------------------------------- Bed 1 ------------------
#find and diff total prompts
sleep 1
echo $GREEN"1)"
echo "-------------- Bed 1 -----------------"$reset
echo
echo $BLUE"totalPrompts for original (live) scan:"$reset
grep -m1 " totalPrompts " $S2_1Sino | sed 's/^.*\(totalPrompts*\)/\1/g'
echo $BLUE"totalPrompts for replay (live) scan: "$reset
grep -m1 " totalPrompts " $S2_2Sino | sed 's/^.*\(totalPrompts*\)/\1/g'
num1=$(cat $S2_1Sino | egrep -m1 ' totalPrompts ' $S2_1Sino | sed 's|\(.*\)   totalPrompts     = *|\1|')
num2=$(cat $S2_2Sino | egrep -m1 ' totalPrompts ' $S2_2Sino | sed 's|\(.*\)   totalPrompts     = *|\1|')
diff=$(expr $num1 - $num2)
echo $BLUE"Total Prompts Difference:"$reset
echo "   "$diff
echo

#find and diff total delays
sleep 1
echo $BLUE"totalDelays for original (live) scan:"$reset
grep -m1 "totalDelays" $S2_1Sino | sed 's|\(.*\)stats*|\1|'
echo $BLUE"totalDelays for replay (live) scan:"$reset
grep -m1 "totalDelays" $S2_2Sino | sed 's|\(.*\)stats*|\1|'
echo $BLUE"Total Delays Difference:"$reset
num3=$(cat $S2_1Sino | grep -m1 "totalDelays" $S2_1Sino | sed 's|\(.*\)statsData.totalDelays: *|\1|')
num4=$(cat $S2_2Sino | grep -m1 "totalDelays" $S2_2Sino | sed 's|\(.*\)statsData.totalDelays: *|\1|')
diff=$(expr $num3 - $num4)
echo $diff
echo


#find Prompt Rate = Total Prompts / Frame Duration  (in counts per millisecond)
sleep 1
FDuration1=$(cat $S2_1Sino | grep -m1 "Frame Duration" $S2_1Sino | sed 's|\(.*\)   Frame Duration   = *|\1|' | sed 's|\(.*\) milliseconds.*|\1|')
diff1=$(expr $num1 / $FDuration1)
echo $BLUE"Prompt Rate for Original scan :"$reset
echo $diff1

FDuration2=$(cat $S2_2Sino | grep -m1 "Frame Duration" $S2_2Sino | sed 's|\(.*\)   Frame Duration   = *|\1|' | sed 's|\(.*\) milliseconds.*|\1|')
diff2=$(expr $num2 / $FDuration1)
echo $BLUE"Prompt Rate for Replay scan :"$reset
echo $diff2
echo 
#--------------- Bed 2 ----------------------------------
#find total prompts for bed 2
sleep 1
echo $GREEN"-------------- Bed 2 -----------------            "$reset
echo
echo $BLUE"totalPrompts for original (live) scan:"$reset
grep -m2 " totalPrompts " $S2_1Sino | tail -n1 | sed 's/^.*\(totalPrompts*\)/\1/g'
echo $BLUE"totalPrompts for replay (live) scan: "$reset
grep -m2 " totalPrompts " $S2_2Sino | tail -n1 | sed 's/^.*\(totalPrompts*\)/\1/g'
num1=$(cat $S2_1Sino | egrep -m2 ' totalPrompts ' $S2_1Sino | tail -n1 | sed 's|\(.*\)   totalPrompts     = *|\1|')
num2=$(cat $S2_2Sino | egrep -m2 ' totalPrompts ' $S2_2Sino | tail -n1 | sed 's|\(.*\)   totalPrompts     = *|\1|')
diff=$(expr $num1 - $num2)
echo $BLUE"Total Prompts Difference:"$reset
echo "   "$diff
echo

#find and diff total delays
sleep 1
echo $BLUE"totalDelays for original (live) scan:"$reset
grep -m2 "totalDelays" $S2_1Sino | tail -n1 | sed 's|\(.*\)stats*|\1|'
echo $BLUE"totalDelays for replay (live) scan:"$reset
grep -m2 "totalDelays" $S2_2Sino | tail -n1 |sed 's|\(.*\)stats*|\1|'
echo $BLUE"Total Delays Difference:"$reset
num3=$(cat $S2_1Sino | grep -m2 "totalDelays" $S2_1Sino | tail -n1 | sed 's|\(.*\)statsData.totalDelays: *|\1|')
num4=$(cat $S2_2Sino | grep -m2 "totalDelays" $S2_2Sino | tail -n1 | sed 's|\(.*\)statsData.totalDelays: *|\1|')
diff=$(expr $num3 - $num4)
echo $diff
echo

#bed2 find Prompt Rate = Total Prompts / Frame Duration  (in counts per millisecond)
sleep 1
FDuration1=$(cat $S2_1Sino | grep -m2 "Frame Duration" $S2_1Sino | tail -n1 | sed 's|\(.*\)   Frame Duration   = *|\1|' | sed 's|\(.*\) milliseconds.*|\1|')
diff1=$(expr $num1 / $FDuration1)
echo $BLUE"Prompt Rate for Original scan :"$reset
echo $diff1
FDuration2=$(cat $S2_2Sino | grep -m2 "Frame Duration" $S2_2Sino |tail -n1 | sed 's|\(.*\)   Frame Duration   = *|\1|' | sed 's|\(.*\) milliseconds.*|\1|')
diff2=$(expr $num2 / $FDuration1)
echo $BLUE"Prompt Rate for Replay scan :"$reset
echo $diff2
echo

#------------------------- Bed 3 -----------------------
#find total prompts for bed 3
sleep 1
echo $GREEN"-------------- Bed 3 -----------------            "$reset
echo
echo $BLUE"totalPrompts for original (live) scan:"$reset
grep -m3 " totalPrompts " $S2_1Sino | tail -n1 | sed 's/^.*\(totalPrompts*\)/\1/g'
echo $BLUE"totalPrompts for replay (live) scan: "$reset
grep -m3 " totalPrompts " $S2_2Sino | tail -n1 | sed 's/^.*\(totalPrompts*\)/\1/g'
num1=$(cat $S2_1Sino | egrep -m3 ' totalPrompts ' $S2_1Sino | tail -n1 | sed 's|\(.*\)   totalPrompts     = *|\1|')
num2=$(cat $S2_2Sino | egrep -m3 ' totalPrompts ' $S2_2Sino | tail -n1 | sed 's|\(.*\)   totalPrompts     = *|\1|')
diff=$(expr $num1 - $num2)
echo $BLUE"Total Prompts Difference:"$reset
echo "   "$diff
echo

#find and diff total delays
sleep 1
echo $BLUE"totalDelays for original (live) scan:"$reset
grep -m3 "totalDelays" $S2_1Sino | tail -n1 | sed 's|\(.*\)stats*|\1|'
echo $BLUE"totalDelays for replay (live) scan:"$reset
grep -m3 "totalDelays" $S2_2Sino | tail -n1 |sed 's|\(.*\)stats*|\1|'
echo $BLUE"Total Delays Difference:"$reset
num3=$(cat $S2_1Sino | grep -m3 "totalDelays" $S2_1Sino | tail -n1 | sed 's|\(.*\)statsData.totalDelays: *|\1|')
num4=$(cat $S2_2Sino | grep -m3 "totalDelays" $S2_2Sino | tail -n1 | sed 's|\(.*\)statsData.totalDelays: *|\1|')
diff=$(expr $num3 - $num4)
echo $diff
echo


#bed3 find Prompt Rate = Total Prompts / Frame Duration  (in counts per millisecond)
sleep 1
FDuration1=$(cat $S2_1Sino | grep -m3 "Frame Duration" $S2_1Sino | tail -n1 | sed 's|\(.*\)   Frame Duration   = *|\1|' | sed 's|\(.*\) milliseconds.*|\1|')
diff1=$(expr $num1 / $FDuration1)
echo $BLUE"Prompt Rate for Original scan :"$reset
echo $diff1
FDuration2=$(cat $S2_2Sino | grep -m3 "Frame Duration" $S2_2Sino |tail -n1 | sed 's|\(.*\)   Frame Duration   = *|\1|' | sed 's|\(.*\) milliseconds.*|\1|')
diff2=$(expr $num2 / $FDuration1)
echo $BLUE"Prompt Rate for Replay scan :"$reset
echo $diff2
echo

#----------------------- step 2 ----------------------------
echo ${BLUE}"2) ABS(Original - Replay Total Prompts) is  <= 0.05 * (the greater of the original "
echo "or the replay Prompts) :"$reset
chmod +x $ScriptsPath/sum1.py
$ScriptsPath/sum1.py
echo

#----------------------- step 3 ----------------------------
sleep 1
echo ${BLUE}"3) ABS(Original - Replay Total Delays) is  <= 0.05 * (the greater of the original "
echo "or the replay Prompts) :"$reset
chmod +x $ScriptsPath/sum2.py
sleep 1
$ScriptsPath/sum2.py
echo

chmod +x ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1171/Acq4D_1171.sh
"/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1171/Acq4D_1171.sh"



