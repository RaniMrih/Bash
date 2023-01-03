#! /bin/bash
#source ./usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1155/ListsDirectory.txt

#VARIABLES
SinoFile="/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1155/S2.1Sino.txt"
ListsDirectory=""
reset=`tput sgr 0`
GREEN=`tput setaf 2`
BLUE=`tput setaf 4`
IP=$(/sbin/ifconfig eth2 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}')
#---------------- step 1 --------------------------------------------------------------

cat $SinoFile| grep -m 1 "Scan Start"| sed 's/^.*\(Scan Start*\)/\1/g'>A.txt    #grep first line only
cat $SinoFile| grep -m 1 "Frame Start Time"| sed 's/^.*\(Frame Start Time*\)/\1/g'>B.txt #grep first frame only

#show start time
echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1157, Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
sleep 2
echo
cat A.txt
cat B.txt

#cut time to compare
file1=A.txt
file2=B.txt
ScanStart=$(grep -o '[0-9][0-9]:[0-9][0-9]:[0-9][0-9]'  "$file1")
FrameStart=$(grep -o '[0-9][0-9]:[0-9][0-9]:[0-9][0-9]'  "$file2")

#compare sec and display
t=$(date -d "20121012 ${ScanStart}" +%s)
t1=$(date -d "20121012 ${FrameStart}" +%s)
diff=$(expr $t1 - $t)
echo "Scan Start time - Frame Start time = $diff sec"

#----------------- step 2 ---------------------------------------------------------------------------
sleep 2
echo >C.txt
echo "${BLUE}First Frame :${reset}">>C.txt
grep -m 1 'Frame Start Time (Coinc msec)' $SinoFile | sed 's/^.*\(Frame Start Time*\)/\1/g'>> C.txt #grep first frame only
echo "${BLUE}Second Frame :${reset}">>C.txt
grep -m2 "Frame Start Time (Coinc msec)" $SinoFile | tail -n1 | sed 's/^.*\(Frame Start Time*\)/\1/g'>>C.txt #grep second frame only
echo "${BLUE}Third Frame :${reset}">>C.txt
grep -m3 "Frame Start Time (Coinc msec)" $SinoFile | tail -n1 | sed 's/^.*\(Frame Start Time*\)/\1/g'>>C.txt #grep Third frame only
echo >>C.txt
cat C.txt

sleep 2
#STORE LIST PATH AND GREP FILES INSIDE DIRECTORY TO SEND TO PARC
LISTPath=$(cat LISTPath.txt)
result=$(ls $LISTPath| grep '0000')
result1=$(ls $LISTPath| grep '0001')
result2=$(ls $LISTPath| grep '0002')

#-----------------------------------------
#CONNECT TO PARC AND PERFORM ListDecode
ssh ctuser@par ListDecode -s $LISTPath/$result >ListOut_f0.txt
ssh ctuser@par ListDecode -s $LISTPath/$result1 >ListOut_f1.txt
ssh ctuser@par ListDecode -s $LISTPath/$result2 >ListOut_f2.txt

#-----------------------------------------
#SHOW RESULTS OF FIRST TIME MARK
echo "${BLUE}First Frame :${reset}">FirstTimeMark.txt
grep 'First Time Mark' ListOut_f0.txt >> FirstTimeMark.txt
echo "${BLUE}Second Frame :${reset}">>FirstTimeMark.txt
grep 'First Time Mark' ListOut_f1.txt >> FirstTimeMark.txt
echo "${BLUE}Third Frame :${reset}">>FirstTimeMark.txt
grep 'First Time Mark' ListOut_f2.txt >> FirstTimeMark.txt
echo >>FirstTimeMark.txt

cat FirstTimeMark.txt
#S=$(cat C.txt |grep -o -E '[0-9]+')
#echo $S

cp ListOut_f0.txt ListOut_f1.txt ListOut_f2.txt ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1158 
cp ListOut_f0.txt ListOut_f1.txt ListOut_f2.txt ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1159 
cp ListOut_f0.txt ListOut_f1.txt ListOut_f2.txt ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1160
cp LISTPath.txt ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1158 
cp LISTPath.txt ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1159

#Run the next step according to doors
chmod +x /usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1158/Acq4D_1158.sh
"/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1158/TC_2_1/Acq4D_1158.sh"

