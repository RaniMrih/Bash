#!/usr/bin/python
import os
OK = "true"


TotalOriginal1 = os.system("num1=$(egrep -m1 ' totalPrompts ' ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1165/S2.1Sino.txt | sed 's|\(.*\)   totalPrompts     = *|\1|')")
TotalReplay1 = os.system("num2=$(egrep -m1 ' totalPrompts ' ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1165/S2.2Sino.txt | sed 's|\(.*\)   totalPrompts     = *|\1|')")

sum = TotalOriginal1 - TotalReplay1
if sum < 0:
  sum*=-1

if TotalOriginal1 > TotalReplay1:
  greater = TotalOriginal1
elif TotalOriginal1 < TotalReplay1:
  greater = TotalReplay1
else:
  greater = TotalOriginal1


if sum > 0.05 * greater:
  OK = "false"
#--------------------------------------------------------------------------------------------------
TotalOriginal2 = os.system("num1=$(egrep -m2 ' totalPrompts ' ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1165/S2.1Sino.txt | tail -n1 | sed 's|\(.*\)   totalPrompts     = *|\1|')")
TotalReplay2 = os.system("num2=$(egrep -m2 ' totalPrompts ' ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1165/S2.2Sino.txt | tail -n1 | sed 's|\(.*\)   totalPrompts     = *|\1|')")

sum = TotalOriginal2 - TotalReplay2
if sum < 0:
  sum*=-1

if TotalOriginal2 > TotalReplay2:
  greater = TotalOriginal2
elif TotalOriginal2 < TotalReplay2:
  greater = TotalReplay2
else:
  greater = TotalOriginal2

if sum > 0.05 * greater:
  OK = "false"
#--------------------------------------------------------------------------------------------------
TotalOriginal3 = os.system("num1=$(egrep -m3 ' totalPrompts ' ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1165/S2.1Sino.txt | tail -n1 | sed 's|\(.*\)   totalPrompts     = *|\1|')")
TotalReplay3 = os.system("num2=$(egrep -m3 ' totalPrompts ' ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1165/S2.2Sino.txt | tail -n1 | sed 's|\(.*\)   totalPrompts     = *|\1|')")

sum = TotalOriginal3 - TotalReplay3
if sum < 0:
  sum*=-1

if TotalOriginal3 > TotalReplay3:
  greater = TotalOriginal3
elif TotalOriginal3 < TotalReplay3:
  greater = TotalReplay3
else:
  greater = TotalOriginal3

if sum > 0.05 * greater:
  OK = "false"

#------------------ final result ------------------------------
if OK == "true":
  os.system("echo `tput setaf 2`[X] Yes `tput sgr 0`")
  os.system("echo [ ] No")
else:
  os.system("echo [ ] Yes")
  os.system("echo `tput setaf 1`[X] No `tput sgr 0`")
  os.system("echo `tput setaf 1`Step Failed  more than 0.05`tput sgr 0`")

