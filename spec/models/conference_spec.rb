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
  end
end