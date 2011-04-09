require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "spec_helper"))

describe Moon::Formatter do

  describe "self.hash_for" do

    before :each do
      @formatter = mock described_class::Base, :hash => :hash
      @formatter_class = mock Class, :new => @formatter

      @generic_formatter = mock described_class::Generic, :hash => :generic_hash
      described_class::Generic.stub :new => @generic_formatter

      @model = mock Object

      described_class.configuration = { @model.class => @formatter_class }
    end

    it "should initialize the right formatter" do
      @formatter_class.should_receive(:new).with(@model)
      described_class.hash_for @model
    end

    it "should initialize the generic formatter if no formatter is configured for the model class" do
      described_class::Generic.should_receive(:new).and_return(@generic_formatter)
      described_class.hash_for Object.new
    end

    it "should return the formatters hash" do
      hash = described_class.hash_for @model
      hash.should == :hash
    end

  end

end
