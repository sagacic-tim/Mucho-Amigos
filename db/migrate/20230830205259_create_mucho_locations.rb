class CreateMuchoLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :mucho_locations do |t|
      t.string :location_name
      t.text :location_description
      t.string :location_phone
      t.string :location_email
      t.string :location_website_url
      t.string :location_address
      t.string :location_street_number
      t.string :location_street_name
      t.string :location_street_suffix
      t.string :location_city
      t.string :location_state_abbreviation
      t.string :location_postal_code
      t.string :location_country_code
      t.decimal :location_latitude, precision: 9, scale: 6
      t.decimal :location_longitude, precision: 9, scale: 6
      t.boolean :location_available, not_null: true, allow_blank: true

      t.timestamps
    end
  end
end