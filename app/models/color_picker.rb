class ColorPicker

  COLOR_MAP = {
    design:     :green,
    rails:      :red,
    javascript: :yellow,
    ruby:       :red,
    backbone:   :yellow,
    ios:        :purple,
    php:        :orange

  }


  def self.pick(tags)
    COLOR_MAP.keys.each do |tag|
       return COLOR_MAP[tag].to_s if tags.downcase.include? tag.to_s
    end
    return "orange"
  end

end
