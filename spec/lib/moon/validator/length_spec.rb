require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Validator::Length do

  before :each do
    described_class.minimum = 2
    described_class.maximum = 3
    @validator = described_class.new [ "one", "two" ]
  end

  describe "#ok?" do

    it "should return true" do
      ok = @validator.ok?
      ok.should be_true
    end

    it "should raise #{ArgumentError} if value doesn't respond to :size" do
      @validator.value = false
      lambda do
        @validator.ok?
      end.should raise_error(ArgumentError)
    end

    it "should return false if value size is too small" do
      @validator.value = [ "one" ]
      ok = @validator.ok?
      ok.should be_false
    end

    it "should return false if value size is too big" do
      @validator.value = [ "one", "two", "three", "four" ]
      ok = @validator.ok?
      ok.should be_false
    end

  end

  describe "#message" do

    it "should return nil" do
      message = @validator.message
      message.should be_nil
    end

    it "should return an error message if value size is too small" do
      @validator.value = [ "one" ]
      message = @validator.message
      message.should == "Must have at least 2 entries."
    end

    it "should return an error message if value size is too big" do
      @validator.value = [ "one", "two", "three", "four" ]
      message = @validator.message
      message.should == "Must have at most 3 entries."
    end

  end

end
