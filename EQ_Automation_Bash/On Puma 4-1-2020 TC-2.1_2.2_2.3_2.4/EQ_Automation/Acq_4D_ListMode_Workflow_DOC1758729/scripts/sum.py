#!/usr/bin/python
import os

#reset=`tput sgr 0`
#GREEN=`tput setaf 2`
#BLUE=`tput setaf 4`
#RED=`tput setaf 1`

#t = 'this is from python script'
#print t

num1 = os.system("num1=$(cat C.txt | grep -m1 'table' |  sed 's|\(.*\)acqParams.RDFAcqRxScanParams.tableLocation: *|\1|')")
num2 = os.system("num2=$(cat D.txt | grep -m1 'table' |  sed 's|\(.*\)acqParams.RDFAcqRxScanParams.tableLocation: *|\1|')")

sum = num1 - num2
#print sum

if sum < 0.5:
  os.system("echo `tput setaf 2`[X] Yes `tput sgr 0`")
  os.system("echo [ ] No")
else:
  os.system("echo [ ] Yes")
  os.system("echo `tput setaf 1`[X] No `tput sgr 0`")
  os.system("echo `tput setaf 1`Step Failed Table Location more than 0.5mm`tput sgr 0`")
