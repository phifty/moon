require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "spec_helper"))

describe Moon::Response::JSON::Model do

  before :each do
    @key = :key
    @object = mock Object
    @formatters = { }

    Moon::Formatter.stub :hash_for => { :test => "test value" }
  end

  describe "initialize" do

    it "should set the status to 200" do
      @response = described_class.new @key, @object, @formatters
      @response.status.should == 200
    end

    it "should use the model formatter" do
      Moon::Formatter.should_receive(:hash_for).with(@formatters, @object).and_return({ :test => "test value" })
      described_class.new @key, @object, @formatters
    end

    it "should return the formatters output" do
      @response = described_class.new @key, @object, @formatters
      @response.body.should == "{\"key\":{\"test\":\"test value\"}}"
    end

  end

end
