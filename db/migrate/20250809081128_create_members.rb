class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members do |t|
      t.string  :name, null: false
      t.string  :phone_number
      t.string  :gender
      t.date    :birthday
      t.text    :address
      t.date    :enroll_on
      t.date    :next_exam_on
      t.boolean :privacy_policy_agreed, null: false, default: false
      t.integer :role, null: false, default: 0

      # FKは後付けにするので、まずはID＋indexだけ
      t.bigint  :rank_id
      t.index   :rank_id

      t.timestamps
    end
  end
end
