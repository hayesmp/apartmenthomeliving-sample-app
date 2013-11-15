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
end