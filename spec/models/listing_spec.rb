require 'spec_helper'
require 'json'

describe Listing do
  describe "retrieve a listing feed" do
    feed = VCR.use_cassette('1br-apartment-feed') do
      Listing.listing_json
    end

    it "returns a JSON string" do
      expect(feed.class).to eq(String)
      expect(JSON.is_json?(feed)).to eq(true)
    end

    it "parses the string and creates Listing records" do
      Listing.parse_listing_feed(feed)
      expect(Listing.all.count).to be > 0
    end

    it "creates valid Listing data" do
      Listing.parse_listing_feed(feed)
      listing = Listing.all.last
      expect(listing).not_to eq nil
      expect(listing.listing_id).not_to eq nil
    end
  end
end
