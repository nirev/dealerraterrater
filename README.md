# DealerRaterRater

A simple example app that reads reviews from DealerRater.com and analysis those

## Brief

Coding Challenge: “A Dealer For the People”
The KGB has noticed a resurgence of overly excited reviews for a McKaig Chevrolet Buick, a dealership they have planted in the United States. In order to avoid attracting unwanted attention, you’ve been enlisted to scrape reviews for this dealership from DealerRater.com and uncover the top three worst offenders of these overly positive endorsements.

Your mission, should you choose to accept it, is to write a tool that:

1. scrapes the first five pages of reviews
2. identifies the top three most “overly positive” endorsements (using criteria of your choosing, documented in the README)
3. outputs these three reviews to the console, in order of severity

Please include documentation on how to run your application along with how to run the test suite.

## Initial idea

Three separate steps:

Fetching:
1. Use Tesla to download pages [x]
2. Use floki to parse pages [x]
3. return json entries for each page [x]

Rating:
1. Rate each entry using a Rater module [x]
2. Rater module has several Rules that are applied [x]
3. Each rule has a weight and applies a criteria [x]

Output
1. Sort entries by rating of overly positive
2. Print top three

## Installation

