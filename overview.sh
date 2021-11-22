#!/bin/bash

#Ny mappestruktur?


#Sortere mappene i pages mappen etter dato
#kanskje bruke "ls -t"
#"ls -t" sorterer mappene etter date, deretter kan man loope gjennom 

#Viser alle filene i mappene i mappen
#for f in pages/*/*; do echo $f; done

#Navigates into folder and creates the file overview.html
cd pages

#Creates the file overview.html and also appends some template markup to be used later
cat <<EOF > overview.html
    <!DOCTYPE html>
    <head>
    <html lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Overview</title>
    </head>
    <body>
        <h1 class="headline">Overview of all news</h1>
        <ul>

        </ul>
    </body>
    </html>
EOF


#Loop concept

#  DIR=$(ls -t pages)
#  for NEWSFOLDER in $DIR;
#  do
#      echo $NEWSFOLDER
#      NEWSFOLDERLIST=$(ls pages/$NEWSFOLDER)
#      #echo $NEWSFOLDERLIST
   
#      for NEWS in $NEWSFOLDERLIST;
#      do
#          NEWSPAGE=$(cat pages/$NEWSFOLDER/$NEWS)
#          echo $NEWSPAGE
#          grep "headline"
         
#      done
#  done
  

#Hente ut titteln fra de forskjellige 

#