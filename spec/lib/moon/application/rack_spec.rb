require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Application::Rack do

  before :each do
    Moon::Application.stub :storage_name => :storage_name

    @context = mock Moon::Context, :storage_name= => nil
    Moon::Context.stub :new => @context

    @response = mock Moon::Response::Base, :status => 200, :headers => { }, :body => "OK"

    @action_one = mock Object, :perform => nil
    @action_two = mock Class, :perform => @response

    @rack = described_class.new
    @rack.routes = [
      {
        :http_method => :get,
        :path => "/test/:id",
        :actions => [ @action_one, @action_two ]
      }
    ]
    @browser = Rack::Test::Session.new Rack::MockSession.new(@rack)
  end

  it "should have the environment set to :test" do
    @rack.environment.should == :test
  end

  it "should initialize the context with the right parameters" do
    Moon::Context.should_receive(:new).with({ }, { "id" => "5" }).and_return(@context)
    @browser.get "/test/5"
  end

  it "should set the storage name in the context" do
    @context.should_receive(:storage_name=).with(:storage_name)
    @browser.get "/test/5"
  end

  it "should perform all actions with the context" do
    @action_one.should_receive(:perform).with(@context).ordered
    @action_two.should_receive(:perform).with(@context).ordered
    @browser.get "/test/5"
  end

  it "should not perform action two if action one has a response" do
    @action_one.stub :perform => @response
    @action_two.should_not_receive(:perform)
    @browser.get "/test/5"
  end

  it "should response the action's response" do
    response = @browser.get "/test/5"
    response.status.should == 200
    response.body.should == "OK"
  end

  it "should raise an #{Moon::Application::InvalidActionError} if the action doesn't respond to :perform" do
    @action_one.stub(:respond_to?).with(:perform).and_return(false)
    lambda do
      @browser.get "/test/5"
    end.should raise_error(Moon::Application::InvalidActionError)
  end

  it "should raise an #{Moon::Application::InvalidResponseError} if the response doesn't respond to :status, :headers and :body" do
    @response.stub(:respond_to?).with(:status).and_return(false)
    lambda do
      @browser.get "/test/5"
    end.should raise_error(Moon::Application::InvalidResponseError)
  end

end
