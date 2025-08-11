class Rank < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :position, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  has_many :wazas, dependent: :nullify
  scope :ordered, -> { order(:position) }
end
