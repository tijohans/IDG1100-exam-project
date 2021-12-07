#!/bin/bash


#Creates variables with the current date, to be used to get the correct filepath
DATE=`date +"%d-%m-%y-%R"`

#Creates the folder for the websites
OVERVIEW="pages"
if [ ! -d "$OVERVIEW" ];
then
    mkdir $OVERVIEW;
    echo "Folder ${OVERVIEW} has been created";
fi

CURRENTNEWS="news-${DATE}"
if [ ! -d "$CURRENTNEWS" ];
then
    mkdir $OVERVIEW/$CURRENTNEWS;
    echo "Folder ${CURRENTNEWS} has been created";
fi



function generateWebsites () {
    
    
    cd $OVERVIEW/$CURRENTNEWS
    
    #Declares a variable with the relative filepath to the folder with the news
    FILEPATH="../../scraped-news/news-$DATE"
    
    
    #Loops through each file in the
    for FILE in $FILEPATH/*;
    do
        #Setting count for
        COUNT=$((COUNT+1))
        
        
        #Declaring variables by fetching the different line numbers from the news document
        URL=`sed -n '1p' < $FILE`
        TITLE=`sed -n '2p' < $FILE`
        IMGURL=`sed -n '3p' < $FILE`
        DATE=`sed -n '4p' < $FILE`
        SUMMARY=`sed -n '5p' < $FILE`
        
        #Calling the function to create the markup
        CreateMarkup $COUNT
        
        
        CURRENTDATE=`date +"%d"`
        if [ $(($CURRENTDATE%2)) -eq 1 ]
        then
            COUNT=$((COUNT+1))
            
            URL=`sed -n '6p' < $FILE`
            TITLE=`sed -n '7p' < $FILE`
            IMGURL=`sed -n '8p' < $FILE`
            DATE=`sed -n '9p' < $FILE`
            SUMMARY=`sed -n '10p' < $FILE`
            
            CreateMarkup $COUNT
        fi
        
        
        
    done
    cd ..
}





#Creating the markup and pushing it to an html file
function CreateMarkup() {
    COUNT=$1
    
    cat <<EOF >news_${COUNT}.html
    <!DOCTYPE html>
    <head>
    <html lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${TITLE}</title>
    </head>
    <body>
        <h1>${TITLE}</h1>
        <img src="${IMGURL}">
        <p>Date fetched: ${DATE}. <a target="_blank" href="//${URL}">Link to original article at tv2.no</a></p>
        <p>${SUMMARY}</p>
        <a href="../../index.html">Back to overview</a>
    </body>
    </html>
EOF
}




generateWebsites;
