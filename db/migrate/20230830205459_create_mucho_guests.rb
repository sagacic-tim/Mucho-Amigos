class CreateMuchoGuests < ActiveRecord::Migration[7.0]  # Version may differ
  def change
    create_table :mucho_guests do |t|
      t.references :amigo, null: false, foreign_key: { to_table: :mucho_amigos }
      t.references :party, null: false, foreign_key: { to_table: :mucho_parties }

      t.timestamps
    end

    add_index :mucho_guests, [:amigo_id, :party_id], unique: true
  end
end