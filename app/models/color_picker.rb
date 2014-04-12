class ColorPicker

  COLOR_MAP = {
    design:     :green,
    rails:      :yellow,
    javascript: :purple,
    ruby:       :red,
    backbone:   :purple

  }


  def self.pick(tags)
    COLOR_MAP.keys.each do |tag|
       return COLOR_MAP[tag].to_s if tags.downcase.include? tag.to_s
    end
    return "red"
  end

end
