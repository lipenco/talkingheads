require 'spec_helper'

describe Conference do

  describe "validations" do

    before :each do
      @c = Conference.new(
        name:        "The Amazing Conference",
        place:       "Warsaw",
        description: "la la la la",
        tags:        "foo"
      )
    end

    it "requires a name" do
      @c.name = nil

      @c.save
      expect(@c).to_not be_valid

      @c.name = "ruby on rails conference"
      @c.save
      expect(@c).to be_valid
    end

    it "require tags" do
      @c.tags = nil

      @c.save
      expect(@c).to_not be_valid

      @c.tags = "ruby rails"
      @c.save
      expect(@c).to be_valid
    end


    it "finds a thumbnail for a given tag" do
      @c.tags = "javascript"
      @c.save
      expect(@c.thumb).to eq("/assets/js.jpg")
    end

    it "gives default tumb if tags unknown" do
      @c.tags = "dsdada"
      @c.save
      expect(@c.thumb).to eq("http://blogs.microsoft.co.il/blogs/gilf/CSS3Logo_thumb_57496FDA.jpg")
    end

    it "returns first matching tag value" do
      @c.tags = "backbone, rails, ruby"
      @c.save
      expect(@c.thumb).to eq("https://scontent-b-iad.xx.fbcdn.net/hphotos-prn1/t1/5543_446948895373302_1141770560_n.jpg")
    end

  end
end
