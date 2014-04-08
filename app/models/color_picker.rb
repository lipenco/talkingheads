class ColorPicker

  COLOR_MAP = {
    backbone:   :green,
    rails:      :yellow,
    javascript: :purple,
    ruby:       :red,

  }


  def self.pick(tags)
    COLOR_MAP.keys.each do |tag|
       return COLOR_MAP[tag].to_s if tags.downcase.include? tag.to_s
    end
    return "red"
  end

end
