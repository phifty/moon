require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "spec_helper"))

describe Moon::Action::Models::Finder do

  before :each do
    @context = Moon::Context.new
    @context.session[:user_id] = "user_id"
    @context.parameters[:site_id] = "site_id"
    @context.parameters[:test] = "test value"

    @user = mock Object
    @site = mock Object
    GOM::Storage.stub(:fetch) do |id|
      { "user_id" => @user, "site_id" => @site }[id]
    end

    @action = described_class.new
  end

  describe "self.perform" do

    it "should fetch the models using the right ids" do
      GOM::Storage.should_receive(:fetch).with("user_id").ordered.and_return(@user)
      GOM::Storage.should_receive(:fetch).with("site_id").ordered.and_return(@site)
      @action.perform @context
    end

    it "should set the found parameters-models in the context" do
      @action.perform @context
      @context.models[:site].should == @site
    end

    it "should set the found session-models in the context" do
      @action.perform @context
      @context.models[:current_user].should == @user
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
