module MypageHelper

  def shinsa_set_label(key)
    t("enums.waza.shinsa_set.#{key}")
  rescue
    key.to_s
  end

  def video_thumb_tag(video, size: "hqdefault")
    return if video.blank? || video.url.blank?

    url = video.url
    if (m = url.match(%r{youtu\.be/([\w\-]{6,})})) || (m = url.match(%r{v=([\w\-]{6,})}))
      vid = m[1]
      image_tag("https://i.ytimg.com/vi/#{vid}/#{size}.jpg",
                class: "w-100 h-100 object-fit-cover rounded",
                alt: video.title)
    else
      content_tag(:div, class: "ratio ratio-16x9 bg-light rounded d-flex align-items-center justify-content-center") do
        content_tag(:span, "No thumb", class: "text-muted small")
      end
    end
  end

  def exam_progress(last_on, next_on)
    return { percent: nil, days_left: nil } if last_on.blank? || next_on.blank?
    total  = (next_on - last_on).to_i
    gone   = (Date.today - last_on).to_i
    pct    = [[(gone.to_f / total * 100).round, 0].max, 100].min
    left   = (next_on - Date.today).to_i
    { percent: pct, days_left: left }
  end
end
