# Exam Project IDG1100

## Main Task

Create a series of small scripts that fetch information from tv2.no.
The data that needs to be fetched is the URL of the website, the title, the link to the main picture on the site
and the date the site was scraped. The information is then used to create a series of webpages, which show this information.
There also needs to be an overview page, with all the previous websites the script has created.
The script needs to automatically be run every six hours using systemd timer units.
All of the pages are also going to be hosted using nginx/fcgiwrap.


Always trying to define variables in the narrowest scope possible for the least amount of clutter
Bash uses dynamic scope over the more widely used lexical scope     https://en.m.wikipedia.org/wiki/Scope_(computer_science)


Minute shift problem, should be fine when the crontabs have been setup
Variable "PATH" is an envirmoental variable, found this out the hard way


## Optional:
> Also retrieve the summary of each news article and add it as a fifth line in the information files
> Sort the news articles byt date, with the most recent first
> Create a systemd timer unit, instead of a crontab entry