class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members do |t|
      t.string :name
      t.string :phone_number
      t.string :gender
      t.date :birthday
      t.text :address
      t.date :enroll_on
      t.date :next_exam_on
      t.boolean :privacy_policy_agreed
      t.references :rank, null: false, foreign_key: true
      t.integer :role

      t.timestamps
    end
  end
end
