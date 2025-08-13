module VideosHelper
  def youtube_id(url)
    uri = URI.parse(url) rescue nil
    return nil unless uri&.host
    return uri.path.delete_prefix("/") if uri.host.include?("youtu.be")
    Rack::Utils.parse_query(uri.query).try(:[], "v")
  end
  def youtube_thumb(url)
    id = youtube_id(url)
    id ? "https://i.ytimg.com/vi/#{id}/hqdefault.jpg" : nil
  end
end

# app/helpers/application_helper.rb
module ApplicationHelper
  def rank_label(obj)
    obj.respond_to?(:rank) && obj.rank.present? ? obj.rank.name : "未設定"
  end
end
