# News scraping scripts using bash

Series of scripts that fetch news from tv2.no



## Background

This project is created as part of the IDG1100 exam. Our task was to: 
> ... Develop a series of small scripts and configuration files to fetch news articles from online newspapers and republish them on a Web server running on Raspberry Pi



## Description

The project consists of 4 script files and 2 configuration files.

* scrape.sh
* pages.sh
* overview.sh
* main.sh

Each one of these scripts are run through the main.sh script. Then all the other scripts get called from here, and starts generating the webpages.

### The scraping script

The scraping script starts off by creating the necessary folders it need. It then proceeds to the main part of the script, which is the *getFirstNArticles* function. This function takes two parameters where the first is how many articles you want to scrape, and the second part is which newssite you want to scrape from. The first thing it does is to download the newssite, and fetch out all the links to the individual articles, which it then appends to a file called *urltemp*. It then continiues to loop through all these articles, and for each one it uses *grep* to get the;

* Title
* Image url
* Timestamp of when it was downloaded
* summary of the news article (Optional ★★)

The loop also appends all this information to a temporary text file, which will be used later to create the html pages.

### The pages Script

The pages script starts of the same as the scrape script, by creating the necesarry folders for the task. This script also consists of two main functions. The *generateWebsiteData* and the *createMarkup* functions. The *generateWebsiteData* function fetches all the information stored in the .txt files being prepared by the scraping script. It first gets the filepath and then it loops over all the files in the folder and collects data based on the number of the line using `sed -n 'Xp'` where X is the line number. It then calls the *createMarkup* function on the data. The *createMarkup* function is basically just an empty html template, where it places in the information stored in variables.





## Optional tasks

List of all the optional tasks included in this assignment, aswell as a short explanation of how I did it and issues I encountered.

* Summary





## What I would consider doing different

A short list of things I would consider doing different if I were to do this again. Also just general notes on what I could improve on.

* Creating a seperate script for creating the folder structure, this would just make the individual scripts a bit cleaner to look at.

