module ApplicationHelper
  def rank_badge(name)
    return "" if name.blank?
    content_tag(:span, name, class: "badge text-bg-primary")
  end

  def rank_label(obj)
    obj.respond_to?(:rank) && obj.rank.present? ? obj.rank.name : "未設定"
  end

  def current_display_name
    u = current_user or return ""
    member = u.try(:member) || Member.find_by(email: u.email)
    member&.name.presence || u.try(:name).presence || u.email.to_s

    u.try(:member)&.name.presence ||
      u.name.presence ||
      u.email.to_s.split("@").first
  end
end
