require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Formatter::Base do

  before :each do
    @model = mock Object

    @formatter = described_class.new @model
  end

  describe "model" do

    it "should return the model" do
      model = @formatter.model
      model.should == @model
    end

  end

  describe "hash" do

    it "should raise an #{NotImplementedError}" do
      lambda do
        @formatter.hash
      end.should raise_error(NotImplementedError)
    end

  end

end
