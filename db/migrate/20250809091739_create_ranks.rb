class CreateRanks < ActiveRecord::Migration[7.1]
  def change
    create_table :ranks do |t|
      t.string  :name, null: false
      t.integer :display_order, null: false, default: 0
      t.text    :description
      t.timestamps
    end
    add_index :ranks, :name, unique: true
    add_index :ranks, :display_order
  end
end
