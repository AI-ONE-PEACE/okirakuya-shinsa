class BackfillMemberUserLinksCaseInsensitive < ActiveRecord::Migration[7.1]
  def up
    execute <<~SQL
      UPDATE members m
         SET user_id = u.id
        FROM users u
       WHERE m.user_id IS NULL
         AND LOWER(m.email) = LOWER(u.email)
    SQL
  end
  def down; end
end
