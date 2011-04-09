require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Validator::Format do

  before :each do
    described_class.format = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    @validator = described_class.new "test@test.com"
  end

  describe "#ok?" do

    it "should return true" do
      ok = @validator.ok?
      ok.should be_true
    end

    it "should return false if value has an invalid format" do
      @validator.value = "invalid"
      ok = @validator.ok?
      ok.should be_false
    end

  end

  describe "#message" do

    it "should return nil" do
      message = @validator.message
      message.should be_nil
    end

    it "should return the error message" do
      @validator.value = "invalid"
      message = @validator.message
      message.should == "Has a wrong format."
    end

  end

end
