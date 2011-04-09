require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Response::JSON do

  before :each do
    @response = described_class.new 201, { :message => "OK" }
  end

  describe "status" do

    it "should return 201" do
      @response.status.should == 201
    end

  end

  describe "headers" do

    it "should return a hash with the right content type" do
      @response.headers.should == { "Content-Type" => "application/json" }
    end

  end

  describe "body" do

    it "should return the given hash encoded in json" do
      @response.body.should == "{\"message\":\"OK\"}"
    end

  end

end
