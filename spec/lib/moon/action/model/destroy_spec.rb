require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "spec_helper"))

describe Moon::Action::Model::Destroy do

  before :each do
    @model = mock Object

    @context = Moon::Context.new
    @context.models[:model] = @model

    @action = described_class.new :model
  end

  describe "perform" do

    before :each do
      GOM::Storage.stub :remove => nil
    end

    it "should remove the model" do
      GOM::Storage.should_receive(:remove).with(@model)
      @action.perform @context
    end

    it "should return 'ok' message response" do
      response = @action.perform @context
      response.should be_instance_of(Moon::Response::JSON::Message)
      response.status.should == 200
    end

    it "should do nothing if the model isn't initialized" do
      @context.models[:model] = nil
      GOM::Storage.should_not_receive(:remove)
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
