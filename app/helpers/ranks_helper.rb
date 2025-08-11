module RanksHelper
  def rank_badge(rank_name)
    return "" if rank_name.blank?
    content_tag(:span, rank_name, class: "badge text-bg-primary")
  end
end
