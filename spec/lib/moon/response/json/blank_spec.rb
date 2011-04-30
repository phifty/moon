require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "spec_helper"))

describe Moon::Response::JSON::Blank do

  describe "initialize" do

    it "should set the status to 200" do
      @response = described_class.new
      @response.status.should == 200
    end

    it "should set the hash to { }" do
      @response = described_class.new
      @response.hash.should == { }
    end

  end

end
