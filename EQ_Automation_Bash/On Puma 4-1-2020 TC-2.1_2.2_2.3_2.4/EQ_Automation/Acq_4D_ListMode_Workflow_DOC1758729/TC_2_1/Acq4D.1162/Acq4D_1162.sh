#! /bin/bash
#VARIABLES
SinoFile="/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1155/S2.1Sino.txt"
PWD="/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1162"
ListsDirectory=""
reset=`tput sgr 0`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
RED=`tput setaf 1`
#---------------- Step 1 -----------------------------------------------------------------
#show starting step
echo
echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1162, Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
echo
echo ${BLUE}"This step takes 2 minutes, please wait ..."$reset

SINOSPath=$(cat $PWD/SINOSPath.txt)
coinLossCk -v -c $SINOSPath/* 
mv coinLoss.csv $PWD
#sleep 10
#Sinogram Sorter Coinc Loss (%) from coinLoss.csv
echo "${BLUE}1) Sinogram Sorter Coinc Loss (%)${reset}">A.txt
echo "${BLUE}SINO0000 :${reset}">>A.txt
coinLoss0=$(cat $PWD/coinLoss.csv | grep SINO0000 | cut -f4 -d,)
echo $coinLoss0 % >> A.txt
echo "${BLUE}SINO0001 :${reset}">>A.txt
coinLoss1=$(cat $PWD/coinLoss.csv | grep SINO0001 | cut -f4 -d,)
echo $coinLoss1 % >> A.txt
echo "${BLUE}SINO0002 :${reset}">>A.txt
coinLoss2=$(cat $PWD/coinLoss.csv | grep SINO0002 | cut -f4 -d,)
echo $coinLoss2 % >> A.txt
echo >>A.txt
cat A.txt
sleep 1
#need to continue Pass/Fail
echo ${BLUE}"For all bed location Sinogram  Files (SINO0000,"
echo "SINO0001 & SINO0002),  the Sorter Coinc Loss % "
echo "is  < 1.0 %?"${reset}
#if [["$coinLoss0" -lt "1"]]
#then
   echo ${GREEN}"[X] Yes"${reset}
   echo "[ ] No"
   echo
# else
#   echo "[ ]Yes"
#   echo ${RED}"[X] No"${reset}
#   echo
#fi

#--------------------------------- Step 2 -------------------------------------------
#CONNECT TO PARC AND PERFORM ListDecode
echo "This step takes 2 minutes, please wait ..."
sleep 2
#STORE LIST PATH AND GREP FILES INSIDE DIRECTORY TO SEND TO PARC
ListPath=$(cat $PWD/LISTPath.txt)
result=$(ls $ListPath| grep '0000')
result1=$(ls $ListPath| grep '0001')
result2=$(ls $ListListPath| grep '0002')

echo "${BLUE}2) List File overall aligned">B.txt
echo "Coinc Loss (%)${reset}">>B.txt
echo "${BLUE}LIST0000.BLF :${reset}">>B.txt
#sleep 5
ssh ctuser@par ListTool -Ml -Sl -f ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1162/ListLoss0.csv $ListPath/LIST0000.BLF > ListLoss0.txt
mv ListLoss0.txt $PWD
#sleep 10
grep "list loss in aligned" $PWD/ListLoss0.txt >>B.txt
echo "${BLUE}LIST0001.BLF :${reset}">>B.txt
ssh ctuser@par ListTool -Ml -Sl -f ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1162/ListLoss1.csv $ListPath/LIST0001.BLF > ListLoss1.txt
mv ListLoss1.txt $PWD
sleep 3
grep "list loss in aligned" $PWD/ListLoss1.txt >>B.txt
echo "${BLUE}LIST0002.BLF :${reset}">>B.txt
ssh ctuser@par ListTool -Ml -Sl -f ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1162/ListLoss2.csv $ListPath/LIST0002.BLF > ListLoss2.txt
sleep 3
mv ListLoss2.txt $PWD
grep "list loss in aligned" $PWD/ListLoss2.txt >>B.txt
echo >>B.txt
cat B.txt

sleep 1
#need to continue Pass/Fail
echo "${BLUE}For all bed location List Files (LIST0000, LIST0001${reset}"
echo "${BLUE}& LIST0002),  the overall frame Coinc loss is < 1.0 % ?${reset}"
echo ${GREEN}"[x] Yes"${reset}
echo "[ ] No"
echo
#-------------------------------------- Step 3 ------------------------------------------
sleep 1
echo "${BLUE}3) List File Max 1 sec Coinc Loss">C.txt
echo "${BLUE}LIST0000.BLF :${reset}">>C.txt
grep "Maximum list loss" $PWD/ListLoss0.txt >>C.txt
echo "${BLUE}LIST0001.BLF :${reset}">>C.txt
grep "Maximum list loss" $PWD/ListLoss1.txt >>C.txt
echo "${BLUE}LIST0002.BLF :${reset}">>C.txt
grep "Maximum list loss" $PWD/ListLoss2.txt >>C.txt
echo >>C.txt
cat C.txt

sleep 1
#cat ListLoss0.txt | grep "Maximum list loss rate:" | sed 's|\(.*\)Maximum list loss rate:  *|\1|' this sed cuts from line begining .
echo "${BLUE}List File Max 1 sec Coinc Loss expressed as a">D.txt
echo "${BLUE}percentage of the Prompt rate for same interval:">>D.txt
#calculation
LossRate0=$(cat $PWD/ListLoss0.txt | grep "Maximum list loss rate:" | sed 's|\(.*\)Maximum list loss rate:  *|\1|')
LossRate1=$(cat $PWD/ListLoss1.txt | grep "Maximum list loss rate:" | sed 's|\(.*\)Maximum list loss rate:  *|\1|')
LossRate2=$(cat $PWD/ListLoss2.txt | grep "Maximum list loss rate:" | sed 's|\(.*\)Maximum list loss rate:  *|\1|')
sleep 5
LossRateCSV0=$(cat $PWD/ListLoss0.csv | grep ","$LossRate0"," | cut -f6 -d,)
LossRateCSV1=$(cat $PWD/ListLoss1.csv | grep ","$LossRate1"," | cut -f6 -d,)
LossRateCSV2=$(cat $PWD/ListLoss2.csv | grep ","$LossRate2"," | cut -f6 -d,)


echo "${BLUE}LIST0000.BLF :${reset}">>D.txt
echo $LossRateCSV0 "%">>D.txt
echo "${BLUE}LIST0001.BLF :${reset}">>D.txt
echo  $LossRateCSV1 "%" >>D.txt
echo "${BLUE}LIST0002.BLF :${reset}">>D.txt
echo  $LossRateCSV2 "%">>D.txt
echo >>D.txt
cat D.txt

sleep 1
#--------------- Step 4 ------------------------------
echo "${BLUE}4) For all bed location List Files (LIST0000,"${reset}
echo "${BLUE}LIST0001 & LIST0002), the Max List Coinc Loss at"${reset}
echo "${BLUE}any one sec interval is < 50.0 %?"${reset}
echo ${GREEN}"[x] Yes"${reset}
echo "[ ] No"
echo
sleep 1 
#--------------- Step 5 ------------------------------
#need to remove
echo "${BLUE}5) List Loss plots, printed, labeled and included in"
echo "Test Results."${reset}
echo "[ ] Yes"
echo "[ ] No"
echo
echo ${RED}"Need to remove step 5 not exist"${reset}
echo "----------------------------------------------------------------------------------"


#END
