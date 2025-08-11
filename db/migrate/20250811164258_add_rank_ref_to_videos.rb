class AddRankRefToVideos < ActiveRecord::Migration[7.1]
  def up
    # ① まずは NULL 可で追加
    add_reference :videos, :rank, null: true, foreign_key: true, index: true

    # ② 既存行を埋める（プレースホルダ段位を用意して一括更新）
    Rank.reset_column_information
    placeholder = Rank.find_or_create_by!(name: "未設定") do |r|
      r.position = Rank.maximum(:position).to_i + 1
    end

    Video.reset_column_information
    Video.where(rank_id: nil).update_all(rank_id: placeholder.id)

    # ③ NOT NULL 制約に変更
    change_column_null :videos, :rank_id, false
  end

  def down
    remove_reference :videos, :rank, foreign_key: true
  end
end
