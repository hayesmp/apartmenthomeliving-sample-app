class Floorplan < ActiveRecord::Base
  attr_accessible :listing_id, :headline

  belongs_to :listing

end