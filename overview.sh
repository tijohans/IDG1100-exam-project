#!/bin/bash

#Creates the file overview.html and also appends some template markup to be used later
cat <<EOF > index.html
    <!DOCTYPE html>
    <head>
    <html lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Overview</title>
    </head>
    <body>
        <h1 class="headline">Overview of all news</h1>
        <ul>
EOF


#Variable for getting all the folders in the pages folder, sorting by newest first, and excluding the overview.html file.
DIR=$(ls -t pages)

#The nested loop under first iterates through the different folders where the webpages are located, then iterates through each individual webpage
for NEWSFOLDER in $DIR;
do
    #Creates a variable for the current newsfolder
    CURRENTNEWSFOLDER=$(ls -t pages/$NEWSFOLDER/*)
    
    for CURRENTNEWSPATH in $CURRENTNEWSFOLDER;
    do
        #Creates a variable of the title of the webpage, so it can be used in the markup
        TITLE=`cat $CURRENTNEWSPATH | grep "title" | sed -E "s/(<title>|<\/title>)//g"`
        
        #Appends a line of html markup with the relative path to the webpage in the link, and also appends the title of the article
        #sed -i "11 i <li><a href="${CURRENTNEWSPATH}">${TITLE}</a></li>" overview.html
        
        echo "<li><a href="${CURRENTNEWSPATH}">${TITLE}</a></li>" >> index.html
    done
done

cat <<EOF >> index.html
</ul>
</body>
</html>
EOF