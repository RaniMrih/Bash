#!/bin/bash

#VARIABLES
ListPath=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1155/S2.1ListHdrs.txt
SinoPath=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1155/S2.1SinoHdrs.txt
Report=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1156/Report.txt
TXTPATH=/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1155/
RED=`tput setaf 1`
reset=`tput sgr 0`
GREEN=`tput setaf 2`
BLUE=`tput setab 4`

#CREATE .TXT REPORT FILE
echo "------------------ Data in the List file -------------------- | -------------- Data in the Sinogram file ------------------" >  $Report
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::">>$Report
diff -y $ListPath $SinoPath | grep 'Operator\|scanID\|patientID\|Dicom\|dicom' >> $Report
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::">>$Report


#CREATE A,B TXT FILES TO COMPARE

#grep 'Scan Description =\|Database Scan ID\|examData.scanIdDicom\|Scan ID\|examData.scanID' LiveHdrs_2.1.tell > A.txt
#grep 'Scan Description =\|Database Scan ID\|examData.scanIdDicom\|Scan ID\|examData.scanID' ReplayHdrs_2.2.tell > B.txt

grep 'Operator\|scanID\|patientID\|Dicom\|dicom' $SinoPath > A.txt
grep 'Operator\|scanID\|patientID\|Dicom\|dicom' $ListPath > B.txt
grep 'acqParams\|sysGeo\|Module' $SinoPath > C.txt
grep 'acqParams\|sysGeo\|Module' $ListPath > D.txt

chmod +x A.txt B.txt C.txt D.txt

result=A.txt | grep "Operator"
result1=A.txt | grep "scanID"
result2=A.txt | grep "patientID"
result3=B.txt | grep "Operator"
result4=B.txt | grep "scanID"
result5=B.txt | grep "patientID"


#echo $result $result1 $result2
#echo $result3 $result4 $result5

#COMPARE A,B IF HEADERS IDENTECAL TEST FAILED
DIFF=$(diff A.txt B.txt)
echo
echo ${GREEN}:::::::::::::::::::::::::::::::::::::::::::::::::: Running Step 1156, Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::${reset}
echo
sleep 5

   if [ "$DIFF" != "" ];
     then 
         if ([ $result != $result3 ] && [ $result1 != $result4 ] && [ $result3 != $result5 ])
             then
              #COMPARE C,D IF HEADERS IDENTECAL TEST FAILED
               DIFF1=$(diff C.txt D.txt)
             if [ "$DIFF1" != "" ];
             then
              echo "------------------------------------------------------------ Test ${RED}FAILED${reset} ----------------------------------------------"
              echo "Acqusition Parameters, System Geometry, Det Moudle Temperature, Det Moudle Serial Nos, Det Block Valid Flags${RED} NOT IDENTECAL${reset} "
              echo "${RED}View Report.txt for more details.. ${reset}"
              echo "-------------------------------------------------------- Test FAILED --------------------------------------------------">>$Report
              echo "Acqusition Parameters, System Geometry, Det Moudle Temperature, Det Moudle Serial Nos, Det Block Valid Flags  NOT IDENTECAL">> $Report

            else
                echo "---------------------------------------------------------- Test ${GREEN}PASSED${reset} ---------------------------------------------"
                echo "Acqusition Parameters - System Geometry - Det Moudle Temperature - Det Moudle Serial Nos - Det Block Valid Flags are ${GREEN}identecal${reset}"
                echo
                echo "---------------------------------------------- Test PASSED ---------------------------------------------" >>$Report
                echo "Acqusition Parameters - System Geometry - Det Moudle Temperature - Det Moudle Serial Nos - Det Block Valid Flags are identecal">>$Report
             fi
          fi
else
                echo "---------------------------------------------------------- Test ${RED}FAILED${reset} ---------------------------------------------"
                echo "Operator, scanID, patientID are identecal "
                echo "-------------------------------------------------------- Test FAILED ---------------------------------------------">>$Report
                echo "Operator, scanID, patientID are identecal " >> $Report
fi


#WRITE TO REPORT DIFFS

echo "-------------------------------------------------------------------------------------------------------------------------------" >> $Report
diff -y $ListPath $SinoPath | grep 'acqParams'>>$Report
echo "-------------------------------------------------------------------------------------------------------------------------------" >> $Report
diff -y $ListPath $SinoPath | grep 'sysGeo' >> $Report
echo "-------------------------------------------------------------------------------------------------------------------------------" >> $Report
diff -y $ListPath $SinoPath | grep 'Module' >> $Report

#EXEXUTE NEXT SCRIPT FOR STEP 1157
chmod +x ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1157/Acq4D_1157.sh
/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1157/Acq4D_1157.sh

#View Report option
#               read -r -p "View report? [y/n] " response
#                 if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
#                   then
#                  less $Report
#                  fi

