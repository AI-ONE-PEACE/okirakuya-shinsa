class Waza < ApplicationRecord
before_validation :set_default_rank, on: :create
def set_default_rank
  self.rank ||= Rank.find_by(name: "未設定")
end
  belongs_to :rank
  has_many   :videos, dependent: :destroy, inverse_of: :waza
  accepts_nested_attributes_for :videos, allow_destroy: true, reject_if: :all_blank

    enum shinsa_set: {
    hitori: 0,   # 独り技
    kumi:   1,   # 組み技
    taigi:  2,   # 体技
    taiso:  3,   # 体操（追加）
    sonota: 4    # その他（追加）
  }

  scope :by_rank,       ->(rank_id) { where(rank_id: rank_id) if rank_id.present? }
  scope :by_shinsa_set, ->(key)     { where(shinsa_set: shinsa_sets[key]) if key.present? && shinsa_sets.key?(key) }

  validates :koumoku, :order_in_rank, presence: true
end
