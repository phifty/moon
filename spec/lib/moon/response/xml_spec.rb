require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Response::XML do

  before :each do
    @response = described_class.new 201, "root", { "message" => { "content" => "OK", "priority" => "normal" } }
  end

  describe "status" do

    it "should return 201" do
      @response.status.should == 201
    end

  end

  describe "headers" do

    it "should return a hash with the right content type" do
      @response.headers.should == { "Content-Type" => "text/xml" }
    end

  end

  describe "body" do

    it "should return the given hash encoded in json" do
      @response.body.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<root>\n  <message priority=\"normal\">OK</message>\n</root>\n"
    end

  end

end
