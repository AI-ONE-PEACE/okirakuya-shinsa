class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.references :waza, null: false, foreign_key: true, index: { unique: true }
      t.string  :title
      t.string  :url, null: false
      t.string  :platform
      t.text    :description
      t.timestamps
    end
  end
end
