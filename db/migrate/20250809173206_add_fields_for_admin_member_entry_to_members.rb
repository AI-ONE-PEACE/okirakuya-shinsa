class AddFieldsForAdminMemberEntryToMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :members, :email, :string unless column_exists?(:members, :email)
    add_column :members, :kana,  :string unless column_exists?(:members, :kana)
    add_column :members, :notes, :text   unless column_exists?(:members, :notes)

    add_index :members, :email, unique: true unless index_exists?(:members, :email, unique: true)
  end
end
