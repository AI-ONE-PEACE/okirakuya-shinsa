class Member < ApplicationRecord
  belongs_to :rank, optional: true
  belongs_to :user, optional: true

  enum role: { general: 0, instructor: 1, admin: 2 }, _prefix: :role
  validates :name, presence: true
  validates :email, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP },
                    uniqueness: true
end
