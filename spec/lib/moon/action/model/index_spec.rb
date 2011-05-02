require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "spec_helper"))

describe Moon::Action::Model::Index do

  before :each do
    @collection = mock GOM::Object::Collection

    @context = Moon::Context.new
    @context.collections[:sites] = @collection

    @response = mock Moon::Response::JSON::Collection
    Moon::Response::JSON::Collection.stub :new => @response

    @action = described_class.new :test
  end

  describe "perform" do

    it "should initialize a collection response" do
      Moon::Response::JSON::Collection.should_receive(:new).and_return(@response)
      @action.perform @context
    end

    it "should return the response" do
      response = @action.perform @context
      response.should == @response
    end

  end

end
