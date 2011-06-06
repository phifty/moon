require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Validator::Format do

  before :each do
    @validator = described_class.new /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  end

  describe "#messages" do

    it "should return an empty array" do
      messages = @validator.messages "test@test.com", :context
      messages.should == [ ]
    end

    it "should return the error message if value has wrong format" do
      messages = @validator.messages "invalid", :context
      messages.should == [ "Has a wrong format." ]
    end

  end

end
