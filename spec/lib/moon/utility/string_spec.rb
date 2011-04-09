require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Utility::String do

  describe "camelize" do

    before :each do
      @underscore_string = "test/test_one"
    end

    it "should return the camelize version of the string" do
      described_class.camelize(@underscore_string).should == "Test::TestOne"
    end

  end

  describe "underscore" do

    before :each do
      @camel_cased_string = "Test::TestOne"
    end

    it "should return the underscore version of the string" do
      described_class.underscore(@camel_cased_string).should == "test/test_one"
    end

  end

end
