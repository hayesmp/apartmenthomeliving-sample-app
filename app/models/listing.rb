require 'net/http'

class Listing < ActiveRecord::Base
  attr_accessible :id, :listing_id, :fn, :url, :image, :latitude, :longitude, :telephone, :address, :city_state_zip,
                  :pricing, :is_house, :listing_no, :floorplans_attributes

  has_many :floorplans
  accepts_nested_attributes_for :floorplans

  def self.listing_json
    uri = URI.parse("http://austin.apartmenthomeliving.com/apartments-for-rent/1-bedroom.json")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    response = http.request(request)
    response.body
  end

  def self.parse_listing_feed(listing_json)
    apartment_data = JSON.parse(listing_json)

    listing_ids = []
    Listing.all.each do |l|
      listing_ids << l.listing_id
    end
    new_count = 0
    apartment_data.each do |ad|
      unless listing_ids.include?(ad['id'])
        listing = Listing.create!(
            :listing_id => ad['id'],
            :fn => ad['fn'],
            :url => ad['url'],
            :image => ad['image'],
            :latitude => ad['latitude'],
            :longitude => ad['longitude'],
            :telephone => ad['tel'],
            :address => ad['address'],
            :city_state_zip => ad['city_st_zip'],
            :pricing => ad['pricing'],
            :is_house => ad['ishouse'],
            :listing_no => ad['listing']
        )
        ad['floorplans'].each do |fp|
          listing.floorplans.create!(:headline => fp)
        end
        new_count += 1
      end
    end
    new_count
  end
end