class RemoveMuchoLocationIdFromMuchoParties < ActiveRecord::Migration[7.0]
  def change
    remove_index :mucho_parties, name: "index_mucho_parties_on_mucho_location_id"
    remove_column :mucho_parties, :mucho_location_id, :integer
  end
end
