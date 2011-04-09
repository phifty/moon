require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Action::ValidModelsRequired do

  before :each do
    @model_class = mock Class
    @model = mock Object, :class => @model_class

    @context = Moon::Context.new
    @context.models[:model] = @model

    @validator = mock Moon::Validator, :ok? => true, :messages => { :email => [ "Has a wrong format." ] }
    @validator_class = mock Moon::Validator, :new => @validator
    Moon::Validator.stub(:[]).and_return(@validator_class)

    @response = mock Moon::Response::JSON::ValidationErrors
    Moon::Response::JSON::ValidationErrors.stub :new => @response
  end

  describe "perform" do

    it "should get the validator class for the right model class" do
      Moon::Validator.should_receive(:[]).with(@model_class).and_return(@validator_class)
      described_class.perform @context
    end

    it "should initialize the validator with the right model" do
      @validator_class.should_receive(:new).with(@model).and_return(@validator)
      described_class.perform @context
    end

    it "should run the validator" do
      @validator.should_receive(:ok?).and_return(true)
      described_class.perform @context
    end

    it "should return nil" do
      response = described_class.perform @context
      response.should be_nil
    end

    context "on failing validation" do

      before :each do
        @validator.stub :ok? => false
      end

      it "should initialize #{Moon::Response::JSON::ValidationErrors}" do
        Moon::Response::JSON::ValidationErrors.should_receive(:new).with(
          :model => { :email => [ "Has a wrong format." ] }
        ).and_return(@response)
        described_class.perform @context
      end

      it "should return the validation errors response" do
        response = described_class.perform @context
        response.should == @response
      end

    end

  end

end
