require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "spec_helper"))

describe Moon::Action::Model::Create do

  before :each do
    @model_class = mock Class, :to_s => "Model"
    @model = mock Object, :class => @model_class

    @context = Moon::Context.new
    @context.storage_name = :dump
    @context.models[:model] = @model

    described_class.model_class = @model_class
    @action = described_class.new @context
  end

  describe "perform" do

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
      @action.perform
    end

    it "should initialize #{Moon::Response::JSON::Model}" do
      Moon::Response::JSON::Model.should_receive(:new).with(:model, @model).and_return(@model_response)
      @action.perform
    end

    it "should return the model response" do
      response = @action.perform
      response.should == @model_response
    end

    it "should do nothing if the model isn't initialized" do
      @context.models[:model] = nil
      GOM::Storage.should_not_receive(:store)
      @action.perform
    end

    it "should initialize the 'failed' message response if the model isn't initialized" do
      @context.models[:model] = nil
      Moon::Response::JSON::Message.should_receive(:new).with(200, "No model initialized.").and_return(@message_response)
      @action.perform
    end

    it "should return 'failed' message response if the model isn't initialized" do
      @context.models[:model] = nil
      response = @action.perform
      response.should == @message_response
    end

  end

  describe "model" do

    it "should return the model" do
      model = @action.model
      model.should == @model
    end

  end

  describe "self.model_symbol" do

    it "should return the model symbol" do
      model_symbol = described_class.model_symbol
      model_symbol.should == :model
    end

  end

  describe "self.model_class" do

    it "should return the model class" do
      model_class = described_class.model_class
      model_class.should == @model_class
    end

  end

  describe "self.[]" do

    it "should return a class" do
      result = described_class[Object]
      result.should be_instance_of(Class)
    end

    it "should return a different class" do
      result = described_class[Object]
      result.should_not == described_class
    end

    it "should return a class connected to the given model class" do
      result = described_class[Object]
      result.model_class.should == Object
    end

  end

end
