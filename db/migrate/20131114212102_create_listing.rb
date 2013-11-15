class CreateListing < ActiveRecord::Migration
  def up
    create_table :listings do |t|
      t.string  :listing_id
      t.string  :fn
      t.string  :url
      t.string  :image
      t.float   :latitude
      t.float   :longitude
      t.string  :telephone
      t.string  :address
      t.string  :city_state_zip
      t.string  :pricing
      t.boolean :is_house
      t.integer :listing_no
    end

    create_table :floorplans do |t|
      t.string  :headline
      t.integer :listing_id
    end
  end

  def down
    drop_table :listings
    drop_table :floorplans
  end
end
