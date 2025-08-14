class AddUserRefToMembers < ActiveRecord::Migration[7.1]
  def up

    add_reference :members, :user, null: true, foreign_key: true, index: true

    if column_exists?(:members, :email)
      say_with_time "Backfilling members.user_id from users.email (case-insensitive)" do
        execute <<~SQL
          UPDATE members m
            SET user_id = u.id
            FROM users u
          WHERE m.user_id IS NULL
            AND LOWER(m.email) = LOWER(u.email)
        SQL
      end
    end
  end

  def down
    remove_reference :members, :user, foreign_key: true
  end
end
