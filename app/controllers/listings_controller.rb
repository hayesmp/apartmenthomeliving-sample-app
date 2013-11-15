class ListingsController < ApplicationController
  respond_to :html

  def index
    @listings = Listing.all.take(10)
    respond_with @listings
  end
end
