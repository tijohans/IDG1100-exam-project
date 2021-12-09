#!/bin/bash

#Changing the directory to make sure the sure the systemd service unit knows where to look for different files
cd /home/pi/Documents/idg1100-exam-project


#Run the scrape script
./scrape.sh


#Runs the pages script
./pages.sh


#Runs the overview script
./overview.sh

#Runs the git script
./gitupdate.sh

#Deletes the temp folders
#rm -r sessionfiles
#rm -r scraped-news