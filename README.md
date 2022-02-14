# DealerRaterRater

A simple example app that reads reviews from DealerRater.com and analyzes those reviews according to defined rules

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
1. Sort entries by rating of overly positive [x]
2. Print top three [x]

## Instructions

The project is best run if using asdf to manage elixir/erlang versions. 
Follow instructions at https://asdf-vm.com/ to install it.

After that there are three make targets to run:

1. `make setup`, for making sure everything's ready to run
2. `make run`, for running the code for fetching the first 5 pages, rating and printing the top three
3. `make test`, for running tests

## Notes

1. all dependencies are used with "> 0.0.0" spec to get the latest version, when going to prod the recommended way is to pin the version and have a dependency update process (ie dependabot)
2. there are only two simple rules for rating entries. the goal was to show how such rules could be implemented, and not really write the best rating system:
   1. `Intensity` rule, which checks for existence of certain expressions like "awesome" and "above and beyond"
   2. `Stars` which just checks the rating
3. http client is Tesla with hackney, as the default httpc one emits warnings in erlang 24. hackney fixes that error and doesn't require setting up a supervision tree
4. the main entry point `DRR.run/` does everything in a single go, which is fine for the amount of pages/entries needed
5. top entries are printed in json, one per line, ordered from most positive to least positive 