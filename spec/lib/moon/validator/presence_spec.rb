require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Validator::Presence do

  before :each do
    @validator = described_class.new "value"
  end

  describe "#ok?" do

    it "should return true" do
      ok = @validator.ok?
      ok.should be_true
    end

    it "should return false if value is nil" do
      @validator.value = nil
      ok = @validator.ok?
      ok.should be_false
    end

    it "should return false if value is blank" do
      @validator.value = ""
      ok = @validator.ok?
      ok.should be_false
    end

  end

  describe "#message" do

    it "should return an empty array" do
      message = @validator.message
      message.should be_nil
    end

    it "should return an error message if value if blank" do
      @validator.value = ""
      message = @validator.message
      message.should == "Must be present."
    end

  end

end
