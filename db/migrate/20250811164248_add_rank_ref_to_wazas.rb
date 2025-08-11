class AddRankRefToWazas < ActiveRecord::Migration[7.1]
  def up
    unless column_exists?(:wazas, :rank_id)
      add_reference :wazas, :rank, null: true, foreign_key: true, index: true
    end
  end

  def down
    remove_reference :wazas, :rank, foreign_key: true if column_exists?(:wazas, :rank_id)
  end
end
