require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "spec_helper"))

describe Moon::Response::JSON::ValidationErrors do

  before :each do
    @response = described_class.new :user => { :email => [ "Has a wrong format." ] }
  end

  describe "body" do

    it "should return the right status code" do
      @response.status.should == 200
    end

    it "should return the given hash encoded in json" do
      @response.body.should == "{\"validation_errors\":{\"user\":{\"email\":[\"Has a wrong format.\"]}}}"
    end

  end

end
