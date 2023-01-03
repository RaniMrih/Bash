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
path = ""
Sixteen = False
Equal = False
AcqParams= True
PWD = '/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_4/Acq4D.1190'
ScriptsPath = '/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/scripts'
S2_1Sino = '~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_1/Acq4D.1155/S2.1Sino.txt'
S2_2Sino = '~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_2/Acq4D.1165/S2.2Sino.txt'
S2_3_1Sino = '~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_1/Acq4D.1180/S2.3.1Sino.txt'
S2_3_2Sino = '~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_3_2/Acq4D.1416/S2.3.2Sino.txt'
List2_4_Path = '/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_4/Acq4D.1189/'
Sino_2_4_Path = '/usr/g/ctuser/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/TC_2_4/Acq4D.1189/SINOSPath2_4.txt'

print
print (GREEN + ":::::::::::::::::::::::::::::::::::::::::::::::::: Running TC_2.4 Step 1190 , Please wait... ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::" + RESET )
print
#------------------------------------- Functions -------------------------------------
def YesNo(YN):
   if YN == True:
     print (GREEN + "[X] Yes" + RESET)
     print ("[ ] No")
   else:
     print ("[ ] Yes")
     print (RED +"[X] No" + RESET)
   print
#coun files in directory
def test1(path):
   for item in os.listdir(path):
     if item.startswith('LIST'):
       num.append(item)

def ListPath():
   for line in open ("LISTSPath2_4.txt","r"):
     if "petLists" in line:
       print line

#------------------------------------- step 1 --------------------------------------------
#----------- qustions ---------

time.sleep(1)
print (BLUE + "1) Number of List Files:" + RESET)
ListPath()


#for line in open(List2_4_Path):
#  if "petLists" in line:
#    print line
#    path = line
#    test1(path)
#coun files in directory
#def test1(path):
#   for item in os.listdir(path):
#     if item.startswith('LIST'):
#       num.append(item)

'''print len(num)
print
time.sleep(1)
print (BLUE + "The name of the list file with path:" + RESET)
for item in num:
  print (path + "/" + item + '\n')

time.sleep(1)
print (BLUE + "Is the name and path of the list file present in the"+'\n'+"directory matches with the associated " + RESET)
print (BLUE + "'where_is_list_frame' tag description field in"+'\n'+"Investigator's More Info tab?" + RESET)
print "[ ] Yes"
print "[ ] No"
print (YELLOW + "Note: Go to Investigator and check manually"+RESET+'\n')
#------------------------------------- step 2 --------------------------------------------
print (BLUE + "2) The 'list loss in aligned' for the list file is:" + RESET)
os.system("ssh ctuser@par ListTool -Ml -Sl  -f ListLoss2.4.csv " + path + "/" + item + ">" + PWD + "/" + "ListLoss2.4.txt")

with open("ListLoss2.4.txt", 'r') as f:
    for line in f.readlines():
      if 'list loss in aligned' in line:
        result = line.replace(line[:38], '')
        print result
        result = result[:-2]
        result = float(result)
time.sleep(1)
print
print (BLUE + "Is the  'list loss in aligned'  for the list file is less than"+'\n'+" 1.0 % ?" + RESET)
if result < 1:
  smaller = True
  YesNo(smaller)
else:
  smaller = False
  YesNo(smaller)
#------------------------------------- step 3 --------------------------------------------
print (BLUE + "3) Maximum  Coincidence Loss in any one second "+'\n'+"interval of from ListTool ouput:" + RESET)
with open("ListLoss2.4.txt", 'r') as f:
    for line in f.readlines():
      if 'Maximum list loss' in line:
        result = line.replace(line[:24], '')
print result
print (YELLOW + "Creating LT.csv and LT_Ml.txt" + RESET)
os.system("ssh ctuser@par ListTool -Ml -f LT.csv " + path + "/" + item + ">" + PWD + "/" + "LT_Ml.txt")
'''
