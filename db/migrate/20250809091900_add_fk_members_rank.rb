class AddFkMembersRank < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :members, :ranks, column: :rank_id
  end
end
