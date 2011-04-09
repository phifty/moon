require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "spec_helper"))

describe Moon::Response::JSON::Message do

  before :each do
    @response = described_class.new 201, "OK"
  end

  describe "status" do

    it "should return the given status" do
      @response.status.should == 201
    end

  end

  describe "body" do

    it "should return the given message" do
      @response.body.should == "{\"message\":\"OK\"}"
    end

    it "should return the given message and id if given" do
      @response.id = "id"
      @response.body.should == "{\"message\":\"OK\",\"id\":\"id\"}"
    end

  end

end
