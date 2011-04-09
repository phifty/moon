require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "spec_helper"))

describe Moon::Action::Model::Destroy do

  before :each do
    @model = mock Object

    @context = Moon::Context.new
    @context.models[:model] = @model

    described_class.model_symbol = :model
    @action = described_class.new @context
  end

  describe "perform" do

    before :each do
      GOM::Storage.stub :remove => nil
    end

    it "should rmeove the model" do
      GOM::Storage.should_receive(:remove).with(@model)
      @action.perform
    end

    it "should return 'ok' message response" do
      response = @action.perform
      response.should be_instance_of(Moon::Response::JSON::Message)
      response.status.should == 200
    end

    it "should do nothing if the model isn't initialized" do
      @context.models[:model] = nil
      GOM::Storage.should_not_receive(:remove)
      @action.perform
    end

    it "should return 'failed' message response if model isn't initialized" do
      @context.models[:model] = nil
      response = @action.perform
      response.should be_instance_of(Moon::Response::JSON::Message)
      response.status.should == 401
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

  describe "self.[]" do

    it "should return a class" do
      result = described_class[:model]
      result.should be_instance_of(Class)
    end

    it "should return a different class" do
      result = described_class[:model]
      result.should_not == described_class
    end

    it "should return a class connected to the given model symbol" do
      result = described_class[:model]
      result.model_symbol.should == :model
    end

  end

end
