require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "spec_helper"))

describe Moon::Action::Model::Update do

  before :each do
    @model = mock Object

    @application = mock Moon::Application, :storage_name => :dump
    @context = Moon::Context.new
    @context.application = @application
    @context.models[:model] = @model

    @action = described_class.new :model
  end

  describe "perform" do

    before :each do
      GOM::Storage.stub :store => nil
      GOM::Object.stub :storage_name => :test
    end

    it "should fetch the storage name of the model" do
      GOM::Object.should_receive(:storage_name).with(@model).and_return(:test)
      @action.perform @context
    end

    it "should store the model on the right storage" do
      GOM::Storage.should_receive(:store).with(@model, :test)
      @action.perform @context
    end

    it "should return 'ok' message response" do
      response = @action.perform @context
      response.should be_instance_of(Moon::Response::JSON::Message)
      response.status.should == 200
    end

    it "should do nothing if the model isn't initialized" do
      @context.models[:model] = nil
      GOM::Storage.should_not_receive(:store)
      @action.perform @context
    end

    it "should return 'failed' message response if model isn't initialized" do
      @context.models[:model] = nil
      response = @action.perform @context
      response.should be_instance_of(Moon::Response::JSON::Message)
      response.status.should == 401
    end

  end

end
