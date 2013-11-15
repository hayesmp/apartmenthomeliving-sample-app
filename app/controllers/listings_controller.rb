class ListingsController < ApplicationController
  respond_to :html, :json
  before_filter :other_listings

  def other_listings
    @other_listings = Listing.order("updated_at DESC").take(6)
  end

  def index
    @listings = Listing.all.take(10)
    respond_with @listings
  end

  def search

  end

  def show
    @listing = Listing.find(params[:id])
    respond_with @listing
  end
end
