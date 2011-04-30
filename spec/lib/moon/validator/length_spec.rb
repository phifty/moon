require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Validator::Length do

  before :each do
    @validator = described_class.new 2..3
  end

  describe "#messages" do

    it "should return an empty array" do
      messages = @validator.messages [ "one", "two" ]
      messages.should == [ ]
    end

    it "should raise #{ArgumentError} if value doesn't respond to :size" do
      lambda do
        @validator.messages false
      end.should raise_error(ArgumentError)
    end

    it "should return an error message if value size is too small" do
      messages = @validator.messages [ "one" ]
      messages.should == [ "Must have at least 2 entries." ]
    end

    it "should return an error message if value size is too big" do
      messages = @validator.messages [ "one", "two", "three", "four" ]
      messages.should == [ "Must have at most 3 entries." ]
    end

  end

end
