require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Action::Transfer do

  before :each do
    @model_one = mock Object
    @model_two = mock Object, :test => nil, :test= => nil

    @context = Moon::Context.new
    @context.session[:model_one] = @model_one
    @context.models[:model_two] = @model_two

    @action = described_class.new :from => [ :session, :model_one ], :to => [ :model_two, :test ]
  end

  describe "perform" do

    it "should transfer a value from the given store attribute to the given model attribute" do
      @model_two.should_receive(:test=).with(@model_one)
      @action.perform @context
    end

    it "should return nil" do
      response = @action.perform @context
      response.should be_nil
    end

  end

end
