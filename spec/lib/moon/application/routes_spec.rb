require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Application::Routes do

  before :each do
    @rack = mock Moon::Application::Rack
    Moon::Application::Rack.stub :new => @rack

    @routes = described_class.new
  end

  describe "#define" do

    it "should pass the routes to rack" do
      @rack.should_receive(:routes=).with([ { :http_method => :get, :path => "/test" } ])
      @routes.define do
        route {
          http_method :get
          path "/test"
        }
      end
    end

  end

end
