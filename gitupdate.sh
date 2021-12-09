#!/bin/bash
PUSHTIME=`date +"%d-%m-%y-%R"`

git add .

git commit -m "Auto Push ${PUSHTIME}"

git push https://raspi:zfcEv46KsuRAhLCTmkKG@gitlab.stud.iie.ntnu.no/tijohans/idg1100-exam-project.git
