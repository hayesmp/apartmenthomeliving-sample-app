##Apartmenthomeliving Sample App

The app is setup to grab any new listings in the feed (http://austin.apartmenthomeliving.com/apartments-for-rent/1-bedroom.json) at midnight each night with a cron task, setup with the whenever gem.

New listings can be pulled down and parsed manually using a rake task:

    rake parse_listing_feed RAILS_ENV=development

