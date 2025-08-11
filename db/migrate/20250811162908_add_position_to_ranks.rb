class AddPositionToRanks < ActiveRecord::Migration[7.1]
  def change
    add_column :ranks, :position, :integer, null: false, default: 0
    add_index  :ranks, :position
  end
end
