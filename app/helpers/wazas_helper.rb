module WazasHelper
  def normalize_leading_spaces(str)
    s = str.to_s.gsub(/\r\n?/, "\n")            # 改行をLFに統一
    s.lines.map { |ln| ln.sub(/\A[\u00A0\u2000-\u200B\u3000 \t]+/, "") }.join
  end

    def shinsa_set_label(key)
    I18n.t("enums.waza.shinsa_set.#{key}", default: key.to_s)
  end

end
