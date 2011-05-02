require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "spec_helper"))

describe Moon::Formatter do

  describe "self.hash_for" do

    before :each do
      @formatter = mock Object, :hash => :hash

      @generic_formatter = mock described_class::Generic, :hash => :generic_hash
      described_class::Generic.stub :new => @generic_formatter

      @model = mock Object

      @formatters = { @model.class => @formatter }
    end

    it "should initialize the generic formatter if no formatter is configured for the model class" do
      described_class::Generic.should_receive(:new).and_return(@generic_formatter)
      described_class.hash_for @formatters, Object.new
    end

    it "should return the formatters hash" do
      hash = described_class.hash_for @formatters, @model
      hash.should == :hash
    end

  end

end
