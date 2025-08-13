class MakeVideosRankNullable < ActiveRecord::Migration[7.1]
  def up
    change_column_null :videos, :rank_id, true
  end
  def down
    change_column_null :videos, :rank_id, false
  end
end
