class CreateWazas < ActiveRecord::Migration[7.1]
  def change
    create_table :wazas do |t|
      t.references :rank, null: false, foreign_key: true
      t.integer :shinsa_set, null: false, default: 0   # enum: hitori/kumi/taigi
      t.string  :koumoku, null: false                 # 例: 「5級 一人技」
      t.text    :content                              # 技名＋説明
      t.integer :order_in_rank, null: false, default: 1
      t.timestamps
    end
    add_index :wazas, [:rank_id, :order_in_rank]
  end
end
