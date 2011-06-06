require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Validator::Presence do

  before :each do
    @validator = described_class.new
  end

  describe "#messages" do

    it "should return an empty array" do
      messages = @validator.messages "value", :context
      messages.should == [ ]
    end

    it "should return an error message if value is nil" do
      messages = @validator.messages nil, :context
      messages.should == [ "Must be present." ]
    end

    it "should return an error message if value is blank" do
      messages = @validator.messages "", :context
      messages.should == [ "Must be present." ]
    end

  end

end
