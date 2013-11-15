desc "Parse listing feed"
task :parse_listing_feed => [:environment] do
  count = Listing.parse_listing_feed(Listing.listing_json)
  puts "New listings added: #{count}"
end