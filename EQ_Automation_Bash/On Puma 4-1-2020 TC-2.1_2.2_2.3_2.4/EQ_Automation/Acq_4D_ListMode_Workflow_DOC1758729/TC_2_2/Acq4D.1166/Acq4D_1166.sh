#! /bin/bash
#!/bin/ksh

#VARIABLES
SinosDirectory2_1=""
SinosDirectory2_2=""
PWD=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1166
ScriptsPath=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/scripts
reset=`tput sgr 0`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
RED=`tput setaf 1`
OK=true;
#ECHO COMMAND START SCRIPT
echo
echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1166, Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
echo
SinosDirectory2_1=$(cat $PWD/SINOSPath.txt)
SinosDirectory2_2=$(cat $PWD/SINOSPath2_2.txt)

echo "Creating LiveHdrs_2.1.tell"
rdfTeller -r '-h efadgS -Ha -v -S' $SinosDirectory2_1/SINO* >$PWD/LiveHdrs_2.1.tell
#rdfTeller -r '-h  eag -Ha -v' $SinosDirectory2_1/SINO* > LiveHdrs_2.1.tell
echo "Creating ReplayHdrs_2.2.tell"
rdfTeller -r '-h  eag -Ha -v' $SinosDirectory2_2/SINO* > $PWD/ReplayHdrs_2.2.tell
#---------------------------------------------------------------------
#COMMAND FOR TESTING TO FIX SCAN DESCRIPTION
grep -rl '   Scan Description = Static Record 2.1 fixed' $PWD/ReplayHdrs_2.2.tell | xargs sed -i 's/   Scan Description = Static Record 2.1 fixed/   Scan Description = Static ViP Replay 2.2/g'
grep -rl 'examData.scanDescription: Static Record 2.1 fixed' $PWD/ReplayHdrs_2.2.tell | xargs sed -i 's/examData.scanDescription: Static Record 2.1 fixed/examData.scanDescription: Static ViP Replay 2.2/g'
#---------------------------------------------------------------------
#COMPARE A,B IF HEADERS IDENTECAL TEST FAILED
OK=true;
grep 'Scan Description =\|Database Scan ID\|examData.scanIdDicom\|Scan ID\|examData.scanID' ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1166/LiveHdrs_2.1.tell > A.txt
grep 'Scan Description =\|Database Scan ID\|examData.scanIdDicom\|Scan ID\|examData.scanID' ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1166/ReplayHdrs_2.2.tell > B.txt
DIFF=$(diff A.txt B.txt)
if [ "$DIFF" == "" ]; then
OK=false;
fi
#----------------------------------------------------------------------
#COMPARE OTHER examData (grep -v is without these params)
grep -v 'Scan Description =\|Database Scan ID\|examData.scanIdDicom\|Scan ID\|examData.scanID\|examData.scanDescription:' ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1166/LiveHdrs_2.1.tell | grep "examData">C.txt
grep -v 'Scan Description =\|Database Scan ID\|examData.scanIdDicom\|Scan ID\|examData.scanID\|examData.scanDescription:' ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1166/ReplayHdrs_2.2.tell | grep "examData">D.txt
DIFF1=$(diff C.txt D.txt)
if [ "$DIFF1" != "" ]; then
OK=false;
fi
#-----------------------------------------------------------------------
sleep 1
#IF OK STILL TRUE PASS.
if $OK ;then
echo
echo ${BLUE}"5. a) The RDF Exam/Scan Data should match for all"
echo "the parameters other than following parameters?"${reset}
echo "${GREEN}[x] Yes${reset}"
echo "[ ] No"
sleep 1
echo
echo "i) Scan Description                                                  ${GREEN}different${reset}"
echo "ii) Database Scan ID and alias examData.scanIdDicom                  ${GREEN}different${reset}"
echo "iii) Scan ID (RDF pathname seed in hex) and alias examData.scanID  ${GREEN}different${reset}"
sleep 1
echo
echo
echo ${BLUE}"All other not identified RDF Exam Information"
echo "matchs?"${reset}
echo ${GREEN}"[x] Yes"${reset}
echo "[ ] No"
echo
fi
#-------------------------------------------------------------------------
#COMPARE A,B IF HEADERS IDENTECAL TEST FAILED
OK=true;
grep 'eventSource\|eventSimulationData\|startCondition\|retroScan' $PWD/LiveHdrs_2.1.tell > A.txt
grep 'eventSource\|eventSimulationData\|startCondition\|retroScan' $PWD/ReplayHdrs_2.2.tell > B.txt
DIFF=$(diff A.txt B.txt)
if [ "$DIFF" == "" ]; then
OK=false;
fi
#--------------------------------------------------------------------------
#COMPARE acqParams (grep -v is without these params)
grep -v 'eventSource\|eventSimulationData\|startCondition\|retroScan' $PWD/LiveHdrs_2.1.tell | grep "acqParams">C.txt
grep -v 'eventSource\|eventSimulationData\|startCondition\|retroScan' $PWD/ReplayHdrs_2.2.tell | grep "acqParams">D.txt
DIFF1=$(diff C.txt D.txt)
if [ "$DIFF1" != "" ]; then
OK=false;
fi
#----------------------------------------------------------------------------
#CHECK TABLE POSSIBlY
Table=$(cat $PWD/ReplayHdrs_2.2.tell | grep "table")
if $OK ;then
  echo
  echo ${BLUE}"5.b) Acq Parameters Header Matchs for all"
  echo "parameters except:"${reset}
  echo "i)  Event Source               ${GREEN}different${reset}"
  echo "ii) Event Simulation Data      ${GREEN}different${reset}"
  echo "iii)Start Condition            ${GREEN}different${reset}"
  echo "iv) Retro Scan flag            ${GREEN}different${reset}"
  echo
  sleep 1
  echo
  echo ${BLUE}"and possibly the "Table Location""${reset}
if test -s "C.txt"; then
   echo ${GREEN}[x] Yes${reset}
   echo "[ ] No"
   echo
else
  echo "[ ] Yes"
  echo ${RED}"[X] No"${reset}
  echo
fi
fi
cat $PWD/LiveHdrs_2.1.tell | grep "tableLocation" >C.txt
cat $PWD/ReplayHdrs_2.2.tell | grep "tableLocation" >D.txt
#-------------------------------------------------------------------------------
#check Acq Parameters Table Location matches within +/- 0.5 mm (sum.py calculate)
chmod +x $ScriptsPath/sum.py
if $OK ;then
  sleep 1
  echo
  echo ${BLUE}"Acq Parameters Table Location matches within +/- 0.5 mm?"${reset}
  python $ScriptsPath/sum.py
  echo
fi
#---------------------------------------------------------------------------------
#COMPARE A,B system Geometry not identical test failed.
grep -v 'sysGeo.vqc' $PWD/LiveHdrs_2.1.tell | grep "sysGeo" > A.txt
grep -v 'sysGeo.vqc' $PWD/ReplayHdrs_2.2.tell | grep "sysGeo"  > B.txt
DIFF=$(diff A.txt B.txt)
sleep 1
echo ${BLUE}"c) The RDF System Geometry Headers matches for all"
echo "the parameters?"${reset}
 if [ "$DIFF" == "" ]; then
  echo ${GREEN}"[x] Yes"${reset}
  echo "[ ] No"
  echo ${GREEN}"sysGeo.vqc params may be +/- 0.1mm"${reset}
  echo
else
  echo "[ ] Yes"
  echo ${RED}"[x] No"${reset}
  echo
fi
#-----------------------------------------------------------------------------------
#COMPARE C,D Module Signature Data "Serial Numbers" and "Block Valid Flags" Match(remove not exist params)
grep -v 'BS Module\|Singles\|BMD Module\|Block Mux\|BBD Module\|Block Busy' $PWD/LiveHdrs_2.1.tell | grep "Module" > C.txt
grep -v 'BS Module\|Singles\|BMD Module\|Block Mux\|BBD Module\|Block Busy' $PWD/ReplayHdrs_2.2.tell | grep "Module" > D.txt
DIFF=$(diff C.txt D.txt)
sleep 1
echo ${BLUE}"5.d) The Detector Module Signature Data 'Serial"
echo "Numbers' and 'Block Valid Flags' Match? "${reset}
 if [ "$DIFF" == "" ]; then
  echo ${GREEN}"[x] Yes"${reset}
  echo "[ ] No"
  echo
else
  echo "[ ] Yes"
  echo ${RED}"[x] No"${reset}
  echo
fi
#----------------------------- step 6 ----------------------------------------------
egrep "Detector Mod|RingDiam|scanMode" $PWD/LiveHdrs_2.1.tell $PWD/ReplayHdrs_2.2.tell  > SSVP.1166.objE.txt
diff  $PWD/LiveHdrs_2.1.tell  $PWD/ReplayHdrs_2.2.tell  >>SSVP.1166.objE.txt

echo ${BLUE}"6) The SSVP.1166.objE.txt file is craeated at :" ${reset}
echo ${GREEN}"/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1166 , it may need another manually modification."${reset}
#clean unnecessarry files .
rm -rf A.txt B.txt C.txt D.txt singles.dat
chmod +x ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1167/Acq4D_1167.sh
"/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1167/Acq4D_1167.sh"
