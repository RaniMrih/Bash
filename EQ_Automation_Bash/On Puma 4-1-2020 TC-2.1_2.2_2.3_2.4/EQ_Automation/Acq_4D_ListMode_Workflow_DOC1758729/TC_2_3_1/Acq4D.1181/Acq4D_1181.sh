#!/bin/bash
#!/bin/ksh

#VARIABLES
SinosDirectory2_1=""
SinosDirectory2_2=""
PWD=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_1/Acq4D.1181
ScriptsPath=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/scripts
S2_1Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1165/S2.1Sino.txt
S2_2Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1165/S2.2Sino.txt
S2_3_1Sino=~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_1/Acq4D.1180/S2.3.1Sino.txt
reset=`tput sgr 0`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
RED=`tput setaf 1`
#ECHO COMMAND START SCRIPT
echo
echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1181, Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
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
#-------------------diff scan start time needs to be +- 1 sec---------------------------------
DiffScanTime (){
Within_1_sec=true
for i in {1..3}
 do
   ScanStart2_3_1=$(grep -m$i "Scan Start Time" $S2_3_1Sino | tail -n1 | sed -n -e 's/^.*   Scan Start Time =//p' | grep -o '[0-9][0-9]:[0-9][0-9]:[0-9][0-9]')
   ScanStart2_1=$(grep -m$i "Scan Start Time" $S2_1Sino | tail -n1 | sed -n -e 's/^.*   Scan Start Time =//p' | grep -o '[0-9][0-9]:[0-9][0-9]:[0-9][0-9]' )
   #compare sec and display
   t=$(date -d "20121012 ${ScanStart2_3_1}" +%s)
   t1=$(date -d "20121012 ${ScanStart2_1}" +%s)
   diff=$(expr $t1 - $t)
   if (($diff > 1 )) || (($diff < -1 ));then
   Within_1_sec=false
   fi
done
YesNoFunction $Within_1_sec
}
#-------------------diff Frame start time needs to be +- 3 sec---------------------------------
DiffFrameTime () {
Within_3_sec=true
for i in {1..3}
 do
   FrameStart2_3_1=$(grep -m$i "Frame Start Time =" $S2_3_1Sino | tail -n1 | sed -n -e 's/^.*   Frame Start Time =//p' | grep -o '[0-9][0-9]:[0-9][0-9]:[0-9][0-9]')
   FrameStart2_1=$(grep -m$i "Frame Start Time =" $S2_1Sino | tail -n1 | sed -n -e 's/^.*   Frame Start Time =//p' | grep -o '[0-9][0-9]:[0-9][0-9]:[0-9][0-9]')
  #compare sec and display
   t=$(date -d "20121012 ${FrameStart2_3_1}" +%s)
   t1=$(date -d "20121012 ${FrameStart2_1}" +%s)
   diff=$(expr $t1 - $t)
   if (($diff > 3 )) || (($diff < -3 ));then
   Within_3_sec=false
   fi
done
YesNoFunction $Within_3_sec
}
#-------------------diff Frame Duration needs to be +- 5 sec ----------------------------------
DiffFrameDuration () {
Within_5_sec=true
for i in {1..3}
 do
   FrameDuration2_3_1=$(grep -m$i "Frame Duration"  $S2_3_1Sino | tail -n1 | sed -n -e 's/^.*   Frame Duration   =//p' | sed 's|\(.*\) milliseconds.*|\1|')
   FrameDuration2_1=$(grep -m$i "Frame Duration"  $S2_1Sino | tail -n1 | sed -n -e 's/^.*   Frame Duration   =//p' | sed 's|\(.*\) milliseconds.*|\1|')
   t1=$(expr $FrameDuration2_3_1 / 1000)
   t2=$(expr $FrameDuration2_1 / 1000)
   diff=$(expr $t1 - $t2)
   if (($diff > 5 )) || (($diff < -5 ));then
   Within_5_sec=false
   fi
done
YesNoFunction $Within_5_sec
}
#------------------------------------- step 1 --------------------------------------------------
# find if scan mode == 2
sleep 1
NumberTwo=true
for i in {1..3}
 do
   ScanMode=$(grep -m$i "scanMode" $S2_3_1Sino | tail -n1 | sed -n -e 's/^.*acqParams.RDFAcqRxScanParams.scanMode: //p')
   if [[ "$ScanMode" != 2 ]];then
   NumberTwo=false
   fi
done

echo ${BLUE}"1) Is the Scan Mode of all three beds is Gated (2)?"$reset
YesNoFunction $NumberTwo

#------------------------------------- step 2 --------------------------------------------------
#---- find Scan Start Time------------------
sleep 1
echo ${BLUE}"2) S2.3.1Sino.txt file data:"$reset
echo ${BLUE}"Scan Start Time"$reset
for i in {1..3}
 do
   ScanStart=$(grep -m$i "Scan Start Time" $S2_3_1Sino | tail -n1 | sed -n -e 's/^.*   Scan Start Time =//p')
   echo ${BLUE}"bed $i :"${reset}
   echo $ScanStart
done
echo
#---- find Frame Start Time-----------------
sleep 1
echo ${BLUE}"Frame Start Time"$reset
for i in {1..3}
 do
   FrameStart=$(grep -m$i "Frame Start Time =" $S2_3_1Sino | tail -n1 | sed -n -e 's/^.*   Frame Start Time =//p')
   echo ${BLUE}"bed $i :"${reset}
   echo $FrameStart
done
echo
#---- find Frame duration ------------------
sleep 1
echo ${BLUE}"Frame Duration"$reset
for i in {1..3}
 do
   FrameDuration=$(grep -m$i "Frame Duration"  $S2_3_1Sino | tail -n1 | sed -n -e 's/^.*   Frame Duration   =//p')
   echo ${BLUE}"bed $i :"${reset}
   echo $FrameDuration
done
echo
#---- find Accepted Triggers ------------------
Within97_100=true
echo ${BLUE}"Accepted Triggers:"$reset
for i in {1..3}
 do
   A_Triggers=$(egrep -m$i "   acceptedTriggers =" $S2_3_1Sino | tail -n1 | sed -n -e 's/^.*   acceptedTriggers =//p')
   echo ${BLUE}"bed $i :"${reset}
   echo $A_Triggers
   if (($A_Triggers < 97 )) || (($A_Triggers > 100));then
   Within97_100=false
   fi
done
echo
#----- find Rejected Triggers------------------
sleep 1
IsZero=true
echo ${BLUE}"Rejected Triggers:"$reset
for i in {1..3}
 do
   R_Triggers=$(egrep -m$i "   rejectedTriggers" $S2_3_1Sino | tail -n1 | sed -n -e 's/^.*   rejectedTriggers =//p')
   echo ${BLUE}"bed $i :"${reset}
   echo $R_Triggers
   if (($R_Triggers != 0));then
   IsZero=false
   fi
done
echo
#----------- qustions ---------
sleep 1
echo ${BLUE}"Accepted triggers is greater than or equal to 97"$reset
echo ${BLUE}"and less than or equal to 100 for each bed ?"$reset
YesNoFunction $Within97_100

sleep 1
echo ${BLUE}"0 rejected triggers for each bed ?"$reset
YesNoFunction $IsZero
#------------------------------------- step 3 --------------------------------------------------
#---- find Scan Start Time in S2_1Sino------------------

sleep 1
echo ${BLUE}"3) S2.1Sino.txt file data for each bed:"$reset
echo ${BLUE}"Scan Start Time"$reset
for i in {1..3}
 do
   ScanStart=$(grep -m$i "Scan Start Time" $S2_1Sino | tail -n1 | sed -n -e 's/^.*   Scan Start Time =//p')
   echo ${BLUE}"bed $i :"${reset}
   echo $ScanStart
done
echo
#---- find frame Start Time in S2_1Sino------------------

sleep 1
echo ${BLUE}"Frame Start Time"$reset
for i in {1..3}
 do
   FrameStart=$(grep -m$i "Frame Start Time =" $S2_1Sino | tail -n1 | sed -n -e 's/^.*   Frame Start Time =//p')
   echo ${BLUE}"bed $i :"${reset}
   echo $FrameStart
done
echo
#---- find Frame duration ------------------
sleep 1
echo ${BLUE}"Frame Duration"$reset
for i in {1..3}
 do
   FrameDuration=$(grep -m$i "Frame Duration"  $S2_1Sino | tail -n1 | sed -n -e 's/^.*   Frame Duration   =//p')
   echo ${BLUE}"bed $i :"${reset}
   echo $FrameDuration
done
echo

#----------- qustions ---------
sleep 1
echo ${BLUE}"The 'Scan Start Time' is within 1 second"$reset
echo ${BLUE}"of the original scan ?"$reset
DiffScanTime

sleep 1
echo ${BLUE}"The 'Frame Start Time' is within 3 second"$reset
echo ${BLUE}"of the original scan ?"$reset
DiffFrameTime

sleep 1
echo ${BLUE}"The 'Frame Duration' is within 5 second"$reset
echo ${BLUE}"of the original scan ?"$reset
DiffFrameDuration

#Run the next step according to doors
chmod +x /usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_1/Acq4D.1182/Acq4D_1182.sh
"/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_1/Acq4D.1182/Acq4D_1182.sh"