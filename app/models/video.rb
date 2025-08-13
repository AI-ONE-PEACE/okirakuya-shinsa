class Video < ApplicationRecord
  belongs_to :waza, optional: true
  belongs_to :rank, optional: true

  before_validation :inherit_rank_from_waza, if: -> { rank_id.nil? && waza_id.present? }

  scope :by_rank, ->(rank_id) {
    return all if rank_id.blank?
    left_outer_joins(:waza)
      .where('videos.rank_id = :rid OR wazas.rank_id = :rid', rid: rank_id)
  }

    scope :by_shinsa_set, ->(key) {
    return all if key.blank? || !Waza.shinsa_sets.key?(key)
    joins(:waza).where(wazas: { shinsa_set: Waza.shinsa_sets[key] })
  }

  private
  def inherit_rank_from_waza
    self.rank_id = waza&.rank_id
  end
end
