require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Response::Base do

  before :each do
    @response = described_class.new
  end

  describe "status" do

    it "should return 200" do
      @response.status.should == 200
    end

  end

  describe "headers" do

    it "should return an empty hash" do
      @response.headers.should == { }
    end

  end

  describe "body" do

    it "should return nil" do
      @response.body.should be_nil
    end

  end

end
