#!/usr/bin/python
import os
import re
#file read mode

#f = open("S2.3.1Sino.txt", "r")
#---------------------------------------------
#file close after run

#f = open("demofile.txt", "r")
#print(f.readline())
#f.close()
#--------------------------------------------
#file append

#f = open("demofile2.txt", "a")
#f.write("Now the file has more content!")
#f.close()
#like cat file
#print(f.read())
#---------------------------------------------
#file overwrite or create

#f = open("demofile3.txt", "w")
#f.write("Woops! I have deleted the content!")
#f.close()
#--------------------------------------------
#read first line only

#print(f.readline())
#---------------------------------------------
#read two lines

#print(f.readline())
#print(f.readline())
#---------------------------------------------
# remove directory

#import os
#os.rmdir("myfolder")
#---------------------------------------------
#Check if file exists, then delete it:

#import os
#if os.path.exists("demofile.txt"):
#os.remove("demofile.txt")
#---------------------------------------------
# delete file

#import os
#os.remove("demofile.txt")
#---------------------------------------------
#By looping through the lines of the file, you can read the whole file, line by line

#f = open("S2.3.1Sino.txt", "r")
#for x in f:
#  print(x)
#------------------------------------------
#with open("S2.3.1Sino.txt") as origin_file:
#    for line in origin_file:
#        line = re.findall(r'sys', line)
#       print line
#------------------------ grep ------------------
#hand = open('S2.3.1Sino.txt')
#for line in hand:
#    line = line.rstrip()
#    if re.search('Frame', line) :
#        print line
#------------------------------------------------
#t = 'this is from python script'
#print t

#num1 = os.system("num1=$(cat C.txt | grep -m1 'table' |  sed 's|\(.*\)acqParams.RDFAcqRxScanParams.tableLocation: *|\1|')")
#num2 = os.system("num2=$(cat D.txt | grep -m1 'table' |  sed 's|\(.*\)acqParams.RDFAcqRxScanParams.tableLocation: *|\1|')")

#sum = num1 - num2
#print sum

#if sum < 0.5:
#  os.system("echo `tput setaf 2`[X] Yes `tput sgr 0`")
#  os.system("echo [ ] No")
#else:
#  os.system("echo [ ] Yes")
#  os.system("echo `tput setaf 1`[X] No `tput sgr 0`")
#  os.system("echo `tput setaf 1`Step Failed Table Location more than 0.5mm`tput sgr 0`")
