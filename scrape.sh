#!/bin/bash


#Function for checking if necesarry folders exists, and if not creating them
function folderSetup() {
    
    #Eeach if statement declares the name of the folder in a variable
    #then checks if it exists, if it does not, it creates it
    
    SESHFOLDER='sessionfiles';
    if [ ! -d "$SESHFOLDER" ];
    then
        mkdir $SESHFOLDER;
        echo "Folder ${SESHFOLDER} has been created";
    fi
    
    SCRAPEDNEWS="scraped-news"
    if [ ! -d "$SCRAPEDNEWS" ];
    then
        mkdir $SCRAPEDNEWS;
        echo "Folder ${SCRAPEDNEWS} has been created";
    fi
}



#Function for getting the first three articles of the news page
function getFirstNArticles(){
    NumberOfArticles=$1;
          
    #Fetches the main news page from tv2.no/nyheter
    NEWSFILE='news';
    wget -O "$SESHFOLDER/$NEWSFILE" www.tv2.no/nyheter;
    
    
    
    #Lists out all the article links in the news page and selects the first N articles and appends them to urltemp
    cd $SESHFOLDER
    grep "class=\"article__link\" href=\"/nyheter/" $NEWSFILE | head -n $NumberOfArticles | sed s/"<a class=\"article__link\" href=\""/www.tv2.no/g | sed "s/\">//" > urltemp;
    cd ..
    
    
    #Creates folder for the news scraped this session
    TODAYSNEWS="${SCRAPEDNEWS}/news-$(date +"%d-%m-%y-%R")";
    mkdir $TODAYSNEWS;

    COUNT=0;
    LINKS=$(cat "${SESHFOLDER}/urltemp")
    for LINK in $LINKS
    do
        #$COUNT+=1;
        COUNT=`expr $COUNT + 1`
        FILE=$TODAYSNEWS/news$COUNT.txt;
        touch $FILE;

        #Declaring a variable with the name of the temp file.
        ARTICLETEMP=(${SESHFOLDER}/articletemp);
        
        #Get the html file of the article
        wget -O $ARTICLETEMP $LINK;
        
        #Get the title of the webpage
        TITLE=`grep "<h1 itemprop=\"headline\" class=\"articleheader__title\">" $ARTICLETEMP  | grep -Eo '>(.*)<' | sed -E 's/[<>]//g'`;    

        #URL of the main picture on the page
        IMGURL=`grep -E "thumbnailUrl\" content=\".*\"" $ARTICLETEMP | grep -Eo 'content=".*"' | sed -E 's/(content="|")//g'`;

        #Time when the article was scraped
        TIMESTAMP=`date +"%d-%m-%y-%R"`;
        
        #Get the summary of the article
        SUMMARY=`grep -A 1  "<p itemprop=\"description\" class=\"articleheader__subtitle\">" $ARTICLETEMP | sed "s/<p itemprop=\"description\" class=\"articleheader__subtitle\">//" | xargs`;
        
        #echo $SUMMARY >> $FILE;
        echo -e "$LINK\n$TITLE\n$IMGURL\n$TIMESTAMP\n$SUMMARY" >> $FILE; 

    done
    
}


folderSetup;

getFirstNArticles 3;










