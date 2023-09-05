class CreateMuchoParties < ActiveRecord::Migration[7.0]
  def change
    create_table :mucho_parties do |t|
      t.string :party_name
      t.date :party_date
      t.column :party_time, :timestamptz
      t.references :party_host, null: false, foreign_key: { to_table: :mucho_amigos }
      t.references :party_location, null: false, foreign_key: { to_table: :mucho_locations }

      t.timestamps
    end
  end
end