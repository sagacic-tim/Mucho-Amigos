class AddLocationIdToMuchoParties < ActiveRecord::Migration[7.0]
  def change
    add_reference :mucho_parties, :mucho_location, foreign_key: true
  end
end