class CreateMuchoAmigos < ActiveRecord::Migration[7.0]
  def change
    create_table :mucho_amigos do |t|
      t.string :full_name, limit: 128
      t.string :email, limit: 64
      t.string :phone, limit: 20
      t.string :address, limit: 256
      t.string :street_number, limit: 16
      t.string :street_name, limit: 64
      t.string :street_suffix, limit: 16
      t.string :city, limit: 64
      t.string :state_abbreviation, limit: 2
      t.string :postal_code, limit: 5
      t.string :country_code, limit: 4
      t.decimal :latitude, precision: 9, scale: 6
      t.decimal :longitude, precision: 9, scale: 6
      t.boolean :party_animal
      t.text :personal_bio

      t.timestamps
    end
  end
end
