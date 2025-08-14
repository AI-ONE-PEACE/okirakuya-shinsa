# app/models/user.rb
class User < ApplicationRecord
  has_one :member, dependent: :nullify
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable

  def admin?
    member&.role_admin? || false
  end
end
