require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "spec_helper"))

describe Moon::Action::Model::Create do

  before :each do
    @model_class = mock Class, :to_s => "Model"
    @model = mock Object, :class => @model_class

    @application = mock Moon::Application, :storage_name => :dump

    @context = Moon::Context.new
    @context.application = @application
    @context.models[:model] = @model

    @action = described_class.new @model_class
  end

  describe "#perform" do

    before :each do
      GOM::Storage.stub :store
      GOM::Object.stub :id => "test:object_1"

      @model_response = mock Moon::Response::JSON::Model
      Moon::Response::JSON::Model.stub :new => @model_response

      @message_response = mock Moon::Response::JSON::Message
      Moon::Response::JSON::Message.stub :new => @message_response
    end

    it "should store the model on the right storage" do
      GOM::Storage.should_receive(:store).with(@model, :dump)
      @action.perform @context
    end

    it "should initialize #{Moon::Response::JSON::Model}" do
      Moon::Response::JSON::Model.should_receive(:new).with(:model, @model).and_return(@model_response)
      @action.perform @context
    end

    it "should return the model response" do
      response = @action.perform @context
      response.should == @model_response
    end

    it "should do nothing if the model isn't initialized" do
      @context.models[:model] = nil
      GOM::Storage.should_not_receive(:store)
      @action.perform @context
    end

    it "should initialize the 'failed' message response if the model isn't initialized" do
      @context.models[:model] = nil
      Moon::Response::JSON::Message.should_receive(:new).with(200, "No model initialized.").and_return(@message_response)
      @action.perform @context
    end

    it "should return 'failed' message response if the model isn't initialized" do
      @context.models[:model] = nil
      response = @action.perform @context
      response.should == @message_response
    end

  end

end
