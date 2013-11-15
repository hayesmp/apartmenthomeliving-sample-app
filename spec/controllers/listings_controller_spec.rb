require 'spec_helper'

describe ListingsController do
  describe "GET #index" do
    before(:each) do
      Listing.parse_listing_feed(VCR.use_cassette('1br-apartment-feed') {Listing.listing_json})
    end
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads 10 or less listings into @listings" do
      get :index

      expect(assigns(:listings).count).to be <= 10
    end
  end

  describe "GET #show" do
    before(:each) do
      Listing.parse_listing_feed(VCR.use_cassette('1br-apartment-feed') {Listing.listing_json})
      @listing = Listing.first
    end
    it "responds successfully with an HTTP 200 status code" do
      get :show, id: @listing.id
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the show template" do
      get :show, id: @listing.id
      expect(response).to render_template("show")
    end

    it "loads a listing" do
      get :show, id: @listing.id

      expect(assigns(:listing).pricing).not_to be nil
    end
  end

  describe "the map" do
    before(:each) do
      Listing.parse_listing_feed(VCR.use_cassette('1br-apartment-feed') {Listing.listing_json})
      @listing = Listing.first
    end

    it "shows more than one marker for index" do
      get :index
      expect(assigns(:hash).count).to be > 1
    end

    it "shows only one marker for the show action" do
      get :show, id: @listing.id
      expect(assigns(:hash).count).to be == 1
    end
  end
end