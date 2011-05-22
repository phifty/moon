require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "spec_helper"))

describe Moon::Action::Model::Show do

  before :each do
    @model = mock Object

    @configuration = mock Moon::Application::Configuration, :formatters => :formatters
    @application = mock Moon::Application, :configuration => @configuration
    @context = Moon::Context.new
    @context.application = @application
    @context.models[:test] = @model

    @model_response = mock Moon::Response::JSON::Model
    Moon::Response::JSON::Model.stub :new => @model_response

    @message_response = mock Moon::Response::JSON::Message
    Moon::Response::JSON::Message.stub :new => @message_response

    @action = described_class.new :test
  end

  describe "#perform" do

    context "for an existing model" do

      it "should initialize #{Moon::Response::JSON::Model}" do
        Moon::Response::JSON::Model.should_receive(:new).with(:test, @model, :formatters).and_return(@model_response)
        @action.perform @context
      end

      it "should return the model response" do
        response = @action.perform @context
        response.should == @model_response
      end

    end

    context "for a not-existing model" do

      before :each do
        @context.models[:test] = nil
      end

      it "should initialize #{Moon::Response::JSON::Message}" do
        Moon::Response::JSON::Message.should_receive(:new).with(404, "Model not found.").and_return(@message_response)
        @action.perform @context
      end

      it "should return the message response" do
        response = @action.perform @context
        response.should == @message_response
      end

    end

  end

end
