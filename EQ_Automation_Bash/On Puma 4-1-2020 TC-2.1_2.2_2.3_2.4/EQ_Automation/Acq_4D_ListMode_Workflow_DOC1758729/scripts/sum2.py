#!/usr/bin/python
import os
OK = "true"


DelaysOriginal1 = os.system("num1=$(egrep -m1 'totalDelays' ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1165/S2.1Sino.txt | sed 's|\(.*\)statsData.totalDelays: *|\1|')")
DelaysReplay1 = os.system("num2=$(egrep -m1 'totalDelays' ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1165/S2.2Sino.txt | sed 's|\(.*\)statsData.totalDelays: *|\1|')")

sum = DelaysOriginal1 - DelaysReplay1
if sum < 0:
  sum*=-1

if DelaysOriginal1 > DelaysReplay1:
  greater = DelaysOriginal1
elif DelaysOriginal1 < DelaysReplay1:
  greater = DelaysReplay1
else:
  greater = DelaysOriginal1


if sum > 0.05 * greater:
  OK = "false"
#--------------------------------------------------------------------------------------------------
DelaysOriginal2 = os.system("num1=$(egrep -m2 'totalDelays' ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1165/S2.1Sino.txt | tail -n1 | sed 's|\(.*\)statsData.totalDelays: *|\1|')")
DelaysReplay2 = os.system("num2=$(egrep -m2 'totalDelays' ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1165/S2.2Sino.txt | tail -n1 | sed 's|\(.*\)statsData.totalDelays: *|\1|')")

sum = DelaysOriginal2 - DelaysReplay2
if sum < 0:
  sum*=-1

if DelaysOriginal2 > DelaysReplay2:
  greater = DelaysOriginal2
elif DelaysOriginal2 < DelaysReplay2:
  greater = DelaysReplay2
else:
  greater = DelaysOriginal2

if sum > 0.05 * greater:
  OK = "false"
#--------------------------------------------------------------------------------------------------
DelaysOriginal3 = os.system("num1=$(egrep -m3 'totalDelays' ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1165/S2.1Sino.txt | tail -n1 | sed 's|\(.*\)statsData.totalDelays: *|\1|')")
DelaysReplay3 = os.system("num2=$(egrep -m3 'totalDelays' ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1165/S2.2Sino.txt | tail -n1 | sed 's|\(.*\)statsData.totalDelays: *|\1|')")

sum = DelaysOriginal3 - DelaysReplay3
if sum < 0:
  sum*=-1

if DelaysOriginal3 > DelaysReplay3:
  greater = DelaysOriginal3
elif DelaysOriginal3 < DelaysReplay3:
  greater = DelaysReplay3
else:
  greater = DelaysOriginal3

if sum > 0.05 * greater:
  OK = "false"

#------------------ final result ------------------------------
if OK == "true":
  os.system("echo `tput setaf 2`[X] Yes `tput sgr 0`")
  os.system("echo [ ] No")
else:
  os.system("echo [ ] Yes")
  os.system("echo `tput setaf 1`[X] No `tput sgr 0`")
  os.system("echo `tput setaf 1`Step Failed  more than 0.05 `tput sgr 0`")

