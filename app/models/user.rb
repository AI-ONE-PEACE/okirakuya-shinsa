# app/models/user.rb
class User < ApplicationRecord
  has_one :member, dependent: :nullify
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable
  enum role: { member: 0, admin: 1 }
end
