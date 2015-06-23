# scopeid-script

[![Code Climate](https://codeclimate.com/github/GSA/scopeid-script/badges/gpa.svg)](https://codeclimate.com/github/GSA/scopeid-script)

[![Test Coverage](https://codeclimate.com/github/GSA/scopeid-script/badges/coverage.svg)](https://codeclimate.com/github/GSA/scopeid-script/coverage)

## Using the App

The app runs on Heroku, hit the URL to download a CSV file containing government URLs and scope ids:  [https://scopeid-script.herokuapp.com/](https://scopeid-script.herokuapp.com/)

## Running it Locally

This project uses ruby 2.1.2.  To install:

    git clone https://github.com/GSA/scopeid-script.git
    cd scopeid-script
    bundle install

Run the app:

    rails s
    
Navigate to [localhost:3000](localhost:3000) to initiate the CSV download.

## Deploying 

Heroku instructions to come...

Tracker Story:
https://www.pivotaltracker.com/story/show/97018416
