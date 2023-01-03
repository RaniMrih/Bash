#!bin/bash

--------------------------------------------------------
real data Puma: 2.1
SINO Live :/petRDFS/XOIATRMM/AVEWDJMT/QOTAGJYS (0,1,2)
LIST LIVE :/petLists/XOIATRMM/AVEWDJMT/QOTAGJYS (0,1,2)
-----------------------------------------------------------
Static Replay : 2.2 
SINO : /petRDFS/XOIATRMM/AVEWDJMT/XSWYVYOD (0,1,2)
list : same list as 
-------------------------------------------------------
before Gated:
Qstatic : not relevant 
------------------------------------------------------
External Gated : 2.3.1
SINOS : /petRDFS/XOIATRMM/AVEWDJMT/ATSOLOLT | Original (0,10,20,29) , Fake (0-29)
-----------------------------------------------------
External Gated : 2.3.2
SINOS : /petRDFS/XOIATRMM/AVEWDJMT/OneFolder-2_3_2 (0 - 29)
SINOS : /petRDFS/XOIATRMM/AVEWDJMT/CMUKXJIZ | Fake one folder (0-29)
SINOS : /petRDFS/XOIATRMM/AVEWDJMT/ThreeFolders-2_3_2 (0-9 , 0-9 , 0-9)
-----------------------------------------------------------
2.4
(FROM 2.3.1) SINOS : /petRDFS/XOIATRMM/AVEWDJMT/ATSOLOLT | Original (0,10,20,29) , Fake (0-29)
(FROM 2.1 ) LIST LIVE :/petLists/XOIATRMM/AVEWDJMT/QOTAGJYS (0,1,2)

#grep sed and replace 
grep -rl '   Scan Description = Static Record 2.1 fixed' ReplayHdrs_2.2.tell | xargs sed -i 's/   Scan Description = Static Record 2.1 fixed/   Scan Description = Static ViP Replay 2.2 /g'
#grep few params together
grep 'eventSource\|eventSimulationData\|startCondition\|retroScan' $PWD/LiveHdrs_2.1.tell > A.txt

## gerp file and cuts "milliseconds" after the number and "Frame Duration" before number
grep -m1 'Frame Duration' ~/EQ_Automation/Scripts/Acq4D.1165/S2.1Sino.txt | sed 's|\(.*\) milliseconds.*|\1|' | sed 's|\(.*\)   Frame Duration   = *|\1|'

#greps word remove it and remove everything before
sed -n -e 's/^.*Module //p'

#this sed greps the word remove every thing before it
 sed 's/^.*\(Module*\)/\1/g'

#this grep cuts only the word
 sed 's|\(.*\)Module*|\1|'

#this grep cuts from "Module" to the end of the line
grep 'Singles Block Max Counts' S2.1Sino.txt | sed 's|\(.*\)Module.*|\1|'

#this method for float calculation
result=$(echo "$ReplayDuration2_3_1 /  $OriginDuration2_1 " | bc )
result1=$(echo "$ReplayDuration2_3_1 /  $OriginDuration2_1 " | bc -l )
result2="$result$result1"
diff=$(echo "$result2 * $OriginPrompts2_1" | bc

# round numbers
H_Limit=$(printf "%.0f\n" $H_Limit)

# math floats to see zero at line beggining
X=$(echo "${ArrSumBinDwell[$i]} ${ArrFrameDuration[$i]}" |  awk '{printf "%f", $1 / $2}')
echo ${BLUE}"bed $j :"${reset}
echo $X %

#grep words start with 'S' the wc -l conts  
ls /petRDFS/XOIATRMM/AVEWDJMT/ATSOLOLT | grep ^S | wc -l
