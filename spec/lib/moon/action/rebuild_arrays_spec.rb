require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Action::RebuildArrays do

  before :each do
    @context = Moon::Context.new({ }, :test => { "0" => "test one", "1" => "test two" })

    @action = described_class.new @context
  end

  describe "#perform" do

    it "should build a hash for each option" do
      @action.perform
      parameters = @context.parameters
      parameters.should == {
        :test => [ "test one", "test two" ]
      }
    end

    it "should return nil" do
      response = @action.perform
      response.should be_nil
    end

  end

end
