module VideosHelper
  def youtube_id(url)
    uri = URI.parse(url) rescue nil
    return nil unless uri&.host
    return uri.path.delete_prefix("/") if uri.host.include?("youtu.be")
    Rack::Utils.parse_query(uri.query).try(:[], "v")
  end

  def youtube_embed_url(url)
    id = youtube_id(url)
    id.present? ? "https://www.youtube.com/embed/#{id}" : nil
  end

  def youtube_thumb(url)
    id = youtube_id(url)
    id.present? ? "https://i.ytimg.com/vi/#{id}/hqdefault.jpg" : nil
  end
end
