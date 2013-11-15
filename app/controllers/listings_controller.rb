class ListingsController < ApplicationController
  respond_to :html, :json
  before_filter :other_listings

  def other_listings
    @other_listings = Listing.order("updated_at DESC").take(6)
  end

  def index
    if params[:search]
      @listings = Listing.search(params[:search])
    else
      @listings = Listing.order("updated_at DESC").take(10)
    end
    @hash = populate_map @listings
    respond_with @listings
  end

  def show
    @listing = Listing.find(params[:id])
    @hash = populate_map [@listing]
    respond_with @listing
  end

  private

  def populate_map(listings)
    @hash = Gmaps4rails.build_markers(listings) do |listing, marker|
      marker.lat listing.latitude
      marker.lng listing.longitude
      marker.infowindow "<a href=\"#{listing_path(listing)}\">#{listing.fn}</a>"
    end
    @hash
  end
end
