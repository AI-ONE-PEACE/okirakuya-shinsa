class Video < ApplicationRecord
  belongs_to :waza

  validates :url, presence: true
  validates :waza_id, uniqueness: true
end
