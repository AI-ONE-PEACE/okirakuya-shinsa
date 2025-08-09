class Member < ApplicationRecord
  belongs_to :rank, optional: true
  enum role: { general: 0, instructor: 1, admin: 2 }, _prefix: :role
  validates :name, presence: true
end
