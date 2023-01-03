#!/usr/bin/python
import os
SorterCL = "true"
LossError = "true"
#-------------------------------- Sorter coin loss ----------------------------------------------------------
num1 = os.system("num=$(cat ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1171/coinLoss.csv | grep 'SINO0000' | cut -f4 -d,)")
if num1 > 1:
  SorterCL = "false"

num2 = os.system("num=$(cat ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1171/coinLoss.csv | grep 'SINO0001' | cut -f4 -d,)")
if num2 > 1:
  SorterCL = "false"

num3 = os.system("num=$(cat ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1171/coinLoss.csv | grep 'SINO0002' | cut -f4 -d,)")
if num3 > 1:
  SorterCL = "false"


if SorterCL == "true":
  os.system("echo `tput setaf 2`[X] Yes `tput sgr 0`")
  os.system("echo [ ] No")
else:
  os.system("echo [ ] Yes")
  os.system("echo `tput setaf 1`[X] No `tput sgr 0`")
  os.system("echo `tput setaf 1`Step Failed  more than 1.0%`tput sgr 0`")

#------------------------------ Loss Error -------------------------------------------------------------------
num1 = os.system("num=$(cat ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1171/coinLoss.csv | grep 'SINO0000' | cut -f6 -d,)")
if num1 > 1:
  LossError = "false"

num2 = os.system("num=$(cat ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1171/coinLoss.csv | grep 'SINO0001' | cut -f6 -d,)")
if num2 > 1:
  LossError = "false"

num3 = os.system("num=$(cat ~/EQ_Automation/Acq_4D_ListMode_Workflow_DOC1758729/Acq4D.1171/coinLoss.csv | grep 'SINO0002' | cut -f6 -d,)")
if num3 > 1:
  LossError = "false"

os.system("echo")
os.system("echo `tput setaf 4`f\) All frames have %LossError less than 1.0 % `tput sgr 0`")

if LossError == "true":
  os.system("echo `tput setaf 2`[X] Yes `tput sgr 0`")
  os.system("echo [ ] No")
else:
  os.system("echo [ ] Yes")
  os.system("echo `tput setaf 1`[X] No `tput sgr 0`")
  os.system("echo `tput setaf 1`Step Failed  more than 1.0%`tput sgr 0`")

