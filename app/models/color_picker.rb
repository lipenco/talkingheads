class ColorPicker

  COLOR_MAP = {
    backbone:   :green,
    marionette: :purple,
    rails:      :yellow,
    ruby:       :red
  }


  def self.pick(tags)
    COLOR_MAP.keys.each do |tag|
      return COLOR_MAP[tag].to_s if tags.include? tag.to_s
    end
    return "red"
  end

end