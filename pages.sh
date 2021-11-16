#!/bin/bash


#Creates variables used to get the  correct path to all the files
DATE=`date +"%d-%m-%y-%R"`
FILEPATH="scraped-news/news-$DATE"

mkdir websites


#Loops through each file in the
for FILE in $FILEPATH/*;
do
    
    #Declaring variables by fetching the different line numbers from the news document
    URL=`sed -n '1p' < $FILE`
    TITLE=`sed -n '2p' < $FILE`
    IMGURL=`sed -n '3p' < $FILE`
    DATE=`sed -n '4p' < $FILE`
    SUMMARY=`sed -n '5p' < $FILE`

    <!DOCTYPE html>
    <html lang="en">
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    </head>
    <body>
    
    </body>
    </html>

























done