#!/usr/bin/env python
import os, sys
import time 
import re

#VARIABLES
RESET = '\33[0m'
GREEN = '\33[92m'
BLUE = '\33[34m'
RED = '\33[31m'
YELLOW = '\33[33m'
num = []
ListArr = []
SinoArr = [] 
Sixteen = False
Equal = False
AcqParams= True
PWD = '/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_4/Acq4D.1189'
ScriptsPath = '/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/scripts'
S2_1Sino = '~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1155/S2.1Sino.txt'
S2_2Sino = '~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1165/S2.2Sino.txt'
S2_3_1Sino = '~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_1/Acq4D.1180/S2.3.1Sino.txt'
S2_3_2Sino = '~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_2/Acq4D.1416/S2.3.2Sino.txt'

print
print (GREEN + ":::::::::::::::::::::::::::::::::::::::::::::::::: Running TC_2.4 Step 1189 , Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::" + RESET ) 
print (GREEN + "::::::::::::::::::::::::::::::::::::::::::: This Script will run all TC 2.4 press ctrl+c to stop ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::" + RESET )
print
time.sleep(2)
#------------------------------------- Functions -------------------------------------
def YesNo(YN):
   if YN == True:
     print (GREEN + "[X] Yes" + RESET)
     print ("[ ] No")
   else:
     print ("[ ] Yes")
     print (RED +"[X] No" + RESET)
   print

#---- check if "landmarkQualifier , acqTime" diffrent and acqParams equal

def CheckDiff():
  for line1 in open('List2.4.tell'):
    line1 = line1.rstrip()
    if re.search('landmarkQualifier:', line1):
        line1 = line1
  for line2 in open('Sino0_2.4.tell'):
    line2 = line2.rstrip()
    if re.search('landmarkQualifier:', line2):
        line2 = line2
  if line1 == line2:
    AcqParams = False

#check if "acqTime" diffrent
  for line1 in open('List2.4.tell'):
    line1 = line1.rstrip()
    if re.search('acqTime', line1):
        line1 = line1
  for line2 in open('Sino0_2.4.tell'):
    line2 = line2.rstrip()
    if re.search('acqTime', line2):
        line2 = line2
  if line1 == line2:
    AcqParams = False

#check if "acqParams" diffrent
  A = open("A.txt", "w+")
  with open('List2.4.tell', 'r') as f:
    for line in f.readlines():
      if 'acqParams' in line:
        if 'acqTime' in line:
            continue
        elif 'landmarkQualifier' in line:
            continue
        else:
           A.write(line)

  B = open("B.txt", "w+")
  with open('Sino0_2.4.tell', 'r') as f:
    for line in f.readlines():
      if 'acqParams' in line:
        if 'acqTime' in line:
            continue
        elif 'landmarkQualifier' in line:
            continue
        else:
           B.write(line)

# diff txt file via bash
  os.system("diff -y A.txt B.txt > diffSinoList.txt")

#if file not empty  
  if os.stat("diffSinoList.txt").st_size != 0:
      AcqParams = False

#go to yes/no function
  YesNo(AcqParams)

def CheckSysGeo():
   A = open("A.txt", "w+")
   with open('List2.4.tell', 'r') as f:
     for line in f.readlines():
        if 'sysGeo' in line:
          A.write(line)

   B = open("B.txt", "w+")
   with open('Sino0_2.4.tell', 'r') as f:
     for line in f.readlines():
        if 'sysGeo' in line:
           B.write(line)

# diff txt file via bash
   os.system("diff -y A.txt B.txt > diffSysGeo.txt")    
# diff txt file via bash  
   if os.stat("diffSysGeo.txt").st_size > 0:
     AcqParams = False
#------------------------------------- step 1 -----------------------------------------
#use of raw_input() 
SinosDirectory2_4 = raw_input("Enter Sinograms path directory from" + BLUE + " section 2.4 :" + RESET) 

# while SinosDirectory2_4 is empty
while SinosDirectory2_4 == "":
  SinosDirectory2_4 = raw_input("Enter Sinograms path directory from" + BLUE + " section 2.4 again:" + RESET)
ListsDirectory2_4 = raw_input("Enter Lists path directory from" + BLUE + " section 2.4 :" + RESET)

# while ListsDirectory2_4 is empty
while ListsDirectory2_4 == "":
  ListsDirectory2_4 = raw_input("Enter Lists path directory from" + BLUE + " section 2.4 again:" + RESET)
print 

time.sleep(1)
print (BLUE + "1) The Number of Sinogram Files in RDF directory are :" + RESET)

#this method counts files number in directory
for item in os.listdir(SinosDirectory2_4):
  if item.startswith('SINO'):
    num.append(item)

print len(num)
print

#----------- qustions ---------
time.sleep(1)
print (BLUE + "Are 16 sinogram files are present in /petRDFS?" + RESET)
if len(num) == 16:
  Sixteen = True

YesNo(Sixteen)

# like : echo $SinosDirectory2_4 > SINOSPath2_4.txt
f=open("SINOSPath2_4.txt", "w+")
f.write(SinosDirectory2_4)
f.close()
f=open("LISTSPath2_4.txt", "w+")
f.write(ListsDirectory2_4)
f.close()
#------------------------------------- step 2 -----------------------------------------
#Create rdfTell files
print ("Creating Sino0_2.4.tell file ...")
os.system("rdfTell -h  efag -v " + SinosDirectory2_4 + "/SINO0000 > Sino0_2.4.tell")
time.sleep(1)
print ("Creating List2.4.tell file ...")
os.system("rdfTell -h  efag -v " + ListsDirectory2_4 + "/LIST* > List2.4.tell")
print

#----------- qustions ---------
#check if file empty
#os.stat("file").st_size == 0

#---- find scan startt time
time.sleep(1)
print (BLUE + '2) The "Scan Start Time" in output file Sino0_2.4.tell is: ' + RESET)
# like grep and sed 3 first chars 
for line in open('Sino0_2.4.tell'):
    line = line.rstrip()
    if re.search('   Scan Start Time =', line):
        ScanStart1 = line.replace(line[:3], '')
        print ScanStart1
print
time.sleep(1)
print (BLUE + 'The "Scan Start Time" in output file List2.4.tell is: ' + RESET)
# like grep and sed 3 first chars
for line in open('List2.4.tell'):
    line = line.rstrip()
    if re.search('   Scan Start Time =', line):
        ScanStart2 = line.replace(line[:3], '')
        print ScanStart2
print

#---------------------- qustions --------------
#---- find frame start time
time.sleep(1)
print (BLUE + 'The "Frame Start Time" in output file Sino0_2.4.tell is :' + RESET)
# like grep and sed 3 first chars
for line in open('Sino0_2.4.tell'):
    line = line.rstrip()
    if re.search('   Frame Start Time =', line):
        FrameStart1 = line.replace(line[:3], '')
        print FrameStart1
print

time.sleep(1)
print (BLUE + 'The "Frame Start Time" in output file List2.4.tell is :' + RESET)
# like grep and sed 3 first chars
for line in open('List2.4.tell'):
    line = line.rstrip()
    if re.search('   Frame Start Time =', line):
        FrameStart2 = line.replace(line[:3], '')
        print FrameStart2
print

time.sleep(1)
print (BLUE + 'Is the "Scan Start Time" is same in output files' + RESET)
print (BLUE + 'Sino0_2.4.tell and List2.4.tell ?' + RESET)
if ScanStart1 == ScanStart2:
  Equal = True
YesNo(Equal)

time.sleep(1)
Equal = False
print (BLUE + 'Is the "Frame Start Time" is same in output files' + RESET)
print (BLUE + 'Sino0_2.4.tell and  List2.4.tell ?' + RESET)
if FrameStart1 == FrameStart2:
  Equal = True
YesNo(Equal)

time.sleep(1)
print (BLUE + 'Are the "Acquisition Parameters" match for all' + RESET)
print (BLUE + 'parameters except: ' + RESET)
print (BLUE + '* landmarkQualifier' + RESET)
print (BLUE + '* acqTime?' + RESET)
CheckDiff()

time.sleep(1)
print (BLUE + 'Are the "System Geometry Parameters" match for' + RESET)
print (BLUE + 'all the parameters? ' + RESET)
CheckSysGeo()
YesNo(AcqParams)

#------------------------------------- step 3 -----------------------------------------

print (BLUE + '3) Are the rdfTell output files:' + RESET)
print (BLUE + '* Sino0_2.4.tell' + RESET)
print (BLUE + '* List2.4.tell' + RESET)
print (BLUE + 'printed and labeled as  "SSVP.PAC.Acq4D.1189' + RESET)
print (BLUE + 'Sino" and "SSVP.PAC.Acq4D.1189 List"' + RESET)
print (BLUE + 'respectively? Also initialed, dated and included as' + RESET)
print (BLUE + 'part of Test Results?' + RESET)
print "[ ] Yes"
print "[ ] No"
print 
print (YELLOW + 'NOTE : Sino0_2.4.tel and List2.4.tell located at ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_4/Acq4D.1189' + RESET)

os.system("chmod +x /usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_4/Acq4D.1190/Acq4D_1190.py")
os.system("/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_4/Acq4D.1190/Acq4D_1190.py")

