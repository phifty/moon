require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "spec_helper"))

describe Moon::Validator do

  before :each do
    @model = mock Object, :name => "test"

    @attribute_validator = mock Moon::Validator::Presence, :ok? => true, :message => "Error!"
    @attribute_validator_class = mock Class, :new => @attribute_validator

    @checks = { :name => [ @attribute_validator_class ] }

    described_class.checks = @checks
    @validator = described_class.new @model
  end

  describe "ok?" do

    it "should initialize the attribute validator" do
      @attribute_validator_class.should_receive(:new).with("test").and_return(@attribute_validator)
      @validator.ok?
    end

    it "should check the attribute validator" do
      @attribute_validator.should_receive(:ok?).and_return(true)
      @validator.ok?
    end

    it "should return true" do
      @validator.should be_ok
    end

    it "should return true if no checks applied" do
      described_class.checks = nil
      @validator.should be_ok
    end

    it "should return false if the attribute validator fails" do
      @attribute_validator.stub :ok? => false
      @validator.should_not be_ok
    end

  end

  describe "messages" do

    it "should return an empty hash" do
      messages = @validator.messages
      messages.should == { }
    end

    it "should return an array including the fitting error message" do
      @attribute_validator.stub :ok? => false
      messages = @validator.messages
      messages[:name].should == [ "Error!" ]
    end

  end

  describe "#self.[]" do

    before :each do
      described_class.configuration = { Object => @checks }
    end

    it "should return a class" do
      result = described_class[Object]
      result.should be_instance_of(Class)
    end

    it "should return a class that is different from the original" do
      result = described_class[Object]
      result.should_not == described_class
    end

    it "should return a class that is assigned to the right checks" do
      result = described_class[Object]
      result.checks.should == @checks
    end

  end

end
