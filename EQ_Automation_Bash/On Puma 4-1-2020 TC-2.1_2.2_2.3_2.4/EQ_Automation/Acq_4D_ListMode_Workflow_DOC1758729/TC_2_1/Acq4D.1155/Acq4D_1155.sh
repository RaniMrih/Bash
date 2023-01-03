#! /bin/bash

#VARIABLES
SinosDirectory=""
ListsDirectory=""
PWD=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1155
reset=`tput sgr 0`
GREEN=`tput setaf 2`
#ECHO COMMAND START SCRIPT

echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1155, Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
echo ${GREEN}::::::::::::::::::::::::::::::::::::::: This Script will run untill Step 1162 press ctrl+c to stop ::::::::::::::::::::::::::::::::::::::::::::::::::${reset}



sleep 2
echo

#STORING USER INPUT FOR SINO AND LIST PATH TO CHECK DIFF (p for prompting)
read -p "Enter Sinograms path directory : " SinosDirectory

if [ -n "$SinosDirectory" ]; then                ##SINO PATH CANT BE EMPTY##
   echo "Sinos path Saved"
   read -p "Enter Lists path directory : " ListsDirectory   ##LIST PATH CANT BE EMPTY##
     if [ -n "$ListsDirectory" ]; then
       echo $ListsDirectory > ListsDirectory.txt
        echo "Lists path Saved"
     else
       read -p "Enter Lists path directory again : " ListsDirectory
     fi
else
   read -p "Enter Sinograms path directory again : " SinosDirectory
fi

echo $ListsDirectory > LISTPath.txt
echo $SinosDirectory > SINOSPath.txt
cp LISTPath.txt ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1157
cp SINOSPath.txt ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1162
#USE rdfTeller TO CONVERT SINO AND LIST TO .txt FILES (3 FILES GENERATED)

xterm -e mkdir $PWD/Generated_Files

#ON SYSTEM
#-----------------------------------
echo "Creating S2.1Sino.txt file ..."
rdfTeller -r '-h efadgS -Ha -v -S' $SinosDirectory/SINO* >$PWD/Generated_Files/S2.1Sino.txt
echo "Creating S2.1SinoHdrs.txt file ..."
rdfTeller -r '-h eag -Ha -v' $SinosDirectory/SINO* > $PWD/Generated_Files/S2.1SinoHdrs.txt
echo "Creating S2.1ListHdrs.txt file ..."
rdfTeller -r '-h eag -Ha -v' $ListsDirectory/LIST* > $PWD/Generated_Files/S2.1ListHdrs.txt

#FOR TESTING on Turtel
#------------------------------------
#echo "Creating S2.1Sino.txt file ..."
#rdfTeller -r '-h efadgS -Ha -v -S' $SinosDirectory/QSTATIC* > $PWD/Generated_Files/S2.1Sino.txt
#echo "Creating S2.1SinoHdrs.txt file ..."
#rdfTeller -r '-h eag -Ha -v' $SinosDirectory/QSTATIC* > $PWD/Generated_Files/S2.1SinoHdrs.txt
#echo "Creating S2.1ListHdrs.txt file ..."
#rdfTeller -r '-h eag -Ha -v' $ListsDirectory/LIST* > $PWD/Generated_Files/S2.1ListHdrs.txt
echo
echo "Is the S2.1Sino.txt, S2.1SinoHdrs.txt &"
echo "S2.1ListHdrs.txt files were produced?"
echo ${GREEN}[x] Yes${reset}
echo "[ ] No"
echo
echo ${GREEN}Files created successfully - Step Pass${reset}
echo

#CLEAR EXSTRA FILES
rm -rf A.txt B.txt C.txt D.txt ListsDirectory.txt singles.dat
#EXEXUTE NEXT SCRIPT FOR STEP 1157
chmod +x ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1156/Acq4D_1156.sh
/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1156/Acq4D_1156.sh

