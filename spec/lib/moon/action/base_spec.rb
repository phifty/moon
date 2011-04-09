require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Action::Base do

  before :each do
    @context = mock Moon::Context

    @action = described_class.new @context
  end

  describe "context" do

    it "should return the context" do
      @action.context.should == @context
    end

  end

  describe "perform" do

    it "should raise a #{NotImplementedError}" do
      lambda do
        @action.perform
      end.should raise_error(NotImplementedError)
    end

  end

end
