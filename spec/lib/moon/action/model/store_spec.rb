require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "spec_helper"))

describe Moon::Action::Model::Store do

  before :each do
    @model = mock Object

    @application = mock Moon::Application, :storage_name => :dump
    @context = Moon::Context.new
    @context.application = @application

    GOM::Storage.stub :store => nil
    GOM::Object.stub :storage_name => :test

    @message_response = mock Moon::Response::JSON::Message
    Moon::Response::JSON::Message.stub :new => @message_response

    @action = described_class.new :model
  end

  describe "perform" do

    context "with an initialized model" do

      before :each do
        @context.models[:model] = @model
      end

      it "should fetch the storage name of the model" do
        GOM::Object.should_receive(:storage_name).with(@model).and_return(:test)
        @action.perform @context
      end

      it "should store the model on the right storage" do
        GOM::Storage.should_receive(:store).with(@model, :test)
        @action.perform @context
      end

      it "should store the model on the application default storage if it hasn't stored before" do
        GOM::Object.stub :storage_name => nil
        GOM::Storage.should_receive(:store).with(@model, :dump)
        @action.perform @context
      end

      it "should return nil" do
        response = @action.perform @context
        response.should be_nil
      end

    end

    context "without an initialized model" do

      before :each do
        @context.models[:model] = nil
      end

      it "should do nothing if the model isn't initialized" do
        GOM::Storage.should_not_receive(:store)
        @action.perform @context
      end

      it "should initialize the 'failed' message response if the model isn't initialized" do
        Moon::Response::JSON::Message.should_receive(:new).with(200, "No model initialized.").and_return(@message_response)
        @action.perform @context
      end

      it "should return 'failed' message response if the model isn't initialized" do
        response = @action.perform @context
        response.should == @message_response
      end

    end

  end

end
