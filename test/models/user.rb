class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_one :member

  # 新規作成後に自動で紐付け
  after_commit :attach_member_by_email, on: :create

  private
  def attach_member_by_email
    Member.where(user_id: nil).where('LOWER(email) = ?', email.to_s.downcase).update_all(user_id: id)
  end
end
