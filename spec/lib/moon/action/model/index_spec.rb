require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "spec_helper"))

describe Moon::Action::Model::Index do

  before :each do
    @collection = mock GOM::Object::Collection

    @context = Moon::Context.new
    @context.collections[:sites] = @collection

    @response = mock Moon::Response::JSON::Collection
    Moon::Response::JSON::Collection.stub :new => @response

    described_class.collection_key = :test
    @action = described_class.new @context
  end

  describe "perform" do

    it "should initialize a collection response" do
      Moon::Response::JSON::Collection.should_receive(:new).and_return(@response)
      @action.perform
    end

    it "should return the response" do
      response = @action.perform
      response.should == @response
    end

  end

  describe "self.[]" do

    it "should return a class" do
      result = described_class[:test]
      result.should be_instance_of(Class)
    end

    it "should return a different class" do
      result = described_class[:test]
      result.should_not == described_class
    end

    it "should return a class connected to the given collection key" do
      result = described_class[:test]
      result.collection_key.should == :test
    end

  end

end
