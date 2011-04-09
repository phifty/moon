require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "spec_helper"))

describe Moon::Action::Model::Show do

  before :each do
    @model = mock Object

    @context = Moon::Context.new
    @context.models[:test] = @model

    @response = mock Moon::Response::JSON::Model
    Moon::Response::JSON::Model.stub :new => @response

    described_class.model_key = :test
    @action = described_class.new @context
  end

  describe "perform" do

    it "should initialize a model response" do
      Moon::Response::JSON::Model.should_receive(:new).with(:test, @model).and_return(@response)
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

    it "should return a class connected to the given model key" do
      result = described_class[:test]
      result.model_key.should == :test
    end

  end

end
