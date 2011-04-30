require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Application::Configuration do

  before :each do
    @action = action = Object.new
    @attribute_validator = attribute_validator = Object.new
    @configuration = described_class.new {
      route {
        http_method :get
        path "/test"
        actions action
      }
      validator {
        model_class Object
        attributes {
          name attribute_validator
        }
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

  describe "#validators" do

    it "should return a hash with the defined validators" do
      validators = @configuration.validators
      validators.should == {
        Object => { :name => @attribute_validator }
      }
    end

  end

end
