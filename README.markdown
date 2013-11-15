##Apartmenthomeliving Sample App

This sample app is designed to demonstrate my skills in creating a website from a JSON feed.

##Installation

Clone the repository and rake the database.

    git clone <repo>

    rake db:migrate
And rake the test db:

    rake rake db:migrate RAILS_ENV=test
Go ahead and run the tests:

    bundle exec rspec
Now the important part: pulling down the data from the Listing feed.

The app is setup to grab any new listings in the feed (http://austin.apartmenthomeliving.com/apartments-for-rent/1-bedroom.json) at midnight each night with a cron task, setup with the `whenever gem`.

New listings can be pulled down and parsed manually using a rake task:

    rake parse_listing_feed RAILS_ENV=development
      New listings added: 20

##About the website

A little overview of the site I built.

###Index

The `index` page contains of list of the 10 most recently updated listings from the feed.
Other features include:
 - a map showing those 10 listings
 - a grid that appears on every page show six recently updated listings
 - a search feature that searches `fn, address, city_state_zip, pricing and floorplans` and returns listings to the index page
  - during a search, the map only shows the search results

###Show

The `show` page gives a more detailed view of each listing.
  - larger image
  - links to the `ApartmentHomeLiving.com` site for both 1-bedroom and other floorplan options
  - a map show the location of the individual listing
  - grid of six recently updated listings

###The Map

The map shows the location(s) whatever information is being displayed on the left. The map marker also provides the `fn` that is a link to the individual listing.