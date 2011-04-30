require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Application::Configuration do

  before :each do
    @action = action = Object.new
    @configuration = described_class.new {
      route {
        http_method :get
        path "/test"
        actions action
      }
    }
  end

  describe "#routes" do

    it "should return an array of the defined routes" do
      routes = @configuration.routes
      routes.should == [
        { :http_method => :get, :path => "/test", :actions => @action }
      ]
    end

  end

end
