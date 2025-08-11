module ApplicationHelper
  def rank_badge(name)
    return "" if name.blank?
    content_tag(:span, name, class: "badge text-bg-primary")
  end
end
