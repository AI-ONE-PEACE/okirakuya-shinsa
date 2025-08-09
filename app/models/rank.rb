class Rank < ApplicationRecord
  has_many :members, dependent: :nullify
  has_many :wazas,  dependent: :destroy
  validates :name, presence: true
end
