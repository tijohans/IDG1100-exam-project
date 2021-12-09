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

#Deletes the temp folders of the news articles downloaded, and the .txt files with the information which is used in the news files
rm -r sessionfiles
rm -r scraped-news