require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "spec_helper"))

describe Moon::Action::Model::Show do

  before :each do
    @model = mock Object

    @configuration = mock Moon::Application::Configuration, :formatters => :formatters
    @application = mock Moon::Application, :configuration => @configuration
    @context = Moon::Context.new
    @context.application = @application
    @context.models[:test] = @model

    @response = mock Moon::Response::JSON::Model
    Moon::Response::JSON::Model.stub :new => @response

    @action = described_class.new :test
  end

  describe "perform" do

    it "should initialize a model response" do
      Moon::Response::JSON::Model.should_receive(:new).with(:test, @model, :formatters).and_return(@response)
      @action.perform @context
    end

    it "should return the response" do
      response = @action.perform @context
      response.should == @response
    end

  end

end
