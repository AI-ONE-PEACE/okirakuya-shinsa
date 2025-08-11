class Waza < ApplicationRecord
  belongs_to :rank, optional: true
  has_one :video, dependent: :destroy   # 1対1
  accepts_nested_attributes_for :video, allow_destroy: true

  # 0: 一人技 / 1: 組み技 / 2: 体技
  enum shinsa_set: { hitori: 0, kumi: 1, taigi: 2 }, _prefix: true

  validates :koumoku, :order_in_rank, presence: true
end
