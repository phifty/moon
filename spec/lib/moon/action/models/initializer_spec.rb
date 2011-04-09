require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "spec_helper"))

describe Moon::Action::Models::Initializer do

  before :each do
    @context = Moon::Context.new({ }, :site => { :name => "Test Site", :address => "Test Address" })

    @model = mock Object, :name= => nil, :address= => nil
    @model_class = mock Class, :new => @model
    Object.stub :const_get => @model_class
  end

  describe "perform" do

    it "should get the right model class" do
      Object.should_receive(:const_get).with("Site").and_return(@model_class)
      described_class.perform @context
    end

    it "should initialize the model" do
      @model_class.should_receive(:new).and_return(@model)
      described_class.perform @context
    end

    it "should set the model's attributes" do
      @model.should_receive(:name=).with("Test Site")
      @model.should_receive(:address=).with("Test Address")
      described_class.perform @context
    end

    it "should set the model to the context" do
      described_class.perform @context
      @context.models[:site].should == @model
    end

    it "should return nil" do
      response = described_class.perform @context
      response.should be_nil
    end

  end

end
