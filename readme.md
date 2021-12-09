# News scraping scripts using bash

Series of scripts that fetches news from tv2.no



## Background

This project is created as part of the IDG1100 practical exam where our task was to: 
> ... Develop a series of small scripts and configuration files to fetch news articles from online newspapers and republish them on a Web server running on Raspberry Pi



## Description

The project consists of 4 script files and 3 configuration files.


Script files:
* scrape.sh
* pages.sh
* overview.sh
* main.sh

Configuration files:
* default (from Nginx)
* schedule-script.service
* schedule-script.timer


Each one of these scripts are run through the main.sh script. Then all the other scripts get called from here, and starts generating the webpages. The configuration files are for the systemd timer units, and for the nginx setup.

### The main script

This script is the simplest, where its only task is to automate the process of calling the other scripts. This script first calls the scraping script, then the pages script, and lastly calls the overview script. This makes is so that the one does not need to call the scripts individually, but only needs to call this. The main script also deletes the temp folders which the other scripts use, which are no longer necesarry. 


### The scraping script

The scraping script starts off by creating the necessary folders it need. It then proceeds to the main part of the script, which is the *getFirstNArticles* function. This function takes two parameters where the first is how many articles you want to scrape, and the second part is which newssite you want to scrape from. The first thing it does is to download the newssite, and fetch out all the links to the individual articles, which it then appends to a file called *urltemp*. It then continiues to loop through all these articles, and for each one it uses *grep* to get the;

* Title
* Image url
* Timestamp of when it was downloaded
* summary of the news article (Optional ★★)

The loop also appends all this information to a temporary text file, which will be used later to create the html pages.

### The pages Script

The pages script starts of the same as the scrape script, by creating the necesarry folders for the task. This script also consists of two main functions. The *generateWebsiteData* and the *createMarkup* functions. The *generateWebsiteData* function fetches all the information stored in the .txt files being prepared by the scraping script. It first gets the filepath and then it loops over all the files in the folder and collects data based on the number of the line using `sed -n 'Xp'` where X is the line number. It then calls the *createMarkup* function on the data. The *createMarkup* function is basically just an empty html template, where it places in the information stored in variables.

### The overview script

The overview script creates the markup for the overview site. It first creates a bit of template html, which then cuts of in the middle. Then it sorts the folder by date (optional ★) and then loops over all the folders with the news, and with a neste loop, also loops over all the .html files in those folders. For each of the files it generates a variable with the title of the webpage, while also taking the relative path, and then appends it as a list html element in the middle of the markup. After this the script appends the rest of the markup creating a finished html page. 

### Nginx

To set up Nginx I started by installing Nginx on the pi with `sudo apt install nginx`. After I had installed Nginx I had to tell Nginx where to look for the file it was going to host, this was done by editing the *default* file under */etc/nginx/sites-enabled/*. All that was needed to do was to edit the path after root, to the path to where I had the index file, which in my case was *~/Documents/raspi/*. After the path has been updated I needed to restart nginx using `sudo service nginx restart`


## Optional tasks

List of all the optional tasks included in this assignment, aswell as a short explanation of how I did it and issues I encountered.

* Summary   ★★


One of the optional tasks was to also retrieve a summary of the news articles. This process was made easier by the fact that I already was downloading each individual news page, and scraping them from the individual articles, insted of the main page. I got the summary by using `grep -A` to get the summary, and then using `xargs` to remove all the whitespace around the paragraph.

* tv2.no/sport ★


One of the optional tasks was to retrieve the information on tv2.no/sport, on days with an even number. To check if the date is an even number I used the `date` command to get the number of the day in two digits, and then using modulus(`%`) to check if the number is odd or even. Bash seems to have a problem interperating numbers with two digits, when the first digit is a zero e.g. 08 and 09 specifically, this was fixed by just removing the first zero in the date.


Since it only scapes the tv2.no/sport on days with even numbers the function for scraping the website does not get called. When the day is an even number, and the function does get called, it appends the information to one of the already existing text files. Since the first five lines are always gonna be another news source, the pages script, collects the information from the lines 5..10. Because I have done it this way, in the pages script, the news articles from tv2.no/nyheter and from tv2.no/sport are always going to be alternating in the list.

* Sort by date ★


The way I sorted the news articles by date was by sorting the articles using `ls -t` which sorts the articles by when they were last edited. Since I am only generating the files for the newest articles, and leaving the previous ones untouched, this will sort them by newest first.

* Systemd timer units ★


The systemd timer units are an alternative to setting up crontab files. What I did was create two systemd files, both called the same, schedule-script, were the difference is the file extension. One of them has the file extension *.service*, and the other has the file extension *.timer*. These files can be found in the folder */configurations/systemd*. On the raspberryPi the systemd files are created under */etc/systemd/user*. In the .service file I set the `ExecStart=` to the file path of where the project was stored on my raspberryPi. In the .timer file I set `OnCalendar=*-*-* 00,06,12,18:00:00` which means it will run at those exact timestamps, which is each sixth hour.


## Installation

To get this script up and running on device other than my raspberry pi, there are som lines that needs to be changed. The file */configuration/default* needs to be changed at line 