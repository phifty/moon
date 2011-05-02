require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "spec_helper"))

describe Moon::Action::Models::Finder do

  before :each do
    @context = Moon::Context.new({ }, :site_id => "test:4", :test => "test value")

    @model = Object.new
    GOM::Storage.stub :fetch => @model

    @action = described_class.new
  end

  describe "self.perform" do

    it "should fetch the model using the right id" do
      GOM::Storage.should_receive(:fetch).with("test:4").and_return(@model)
      @action.perform @context
    end

    it "should set the found models in the context" do
      @action.perform @context
      @context.models[:site].should == @model
    end

    it "should return nil" do
      response = @action.perform @context
      response.should be_nil
    end

    it "should not fetch non-id values" do
      GOM::Storage.should_not_receive(:fetch).with("test value")
      @action.perform @context
    end

  end

end
