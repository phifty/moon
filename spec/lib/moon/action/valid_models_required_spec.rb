require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Action::ValidModelsRequired do

  before :each do
    @model_class = mock Class
    @model = mock Object, :class => @model_class

    @checks = { }
    @validators = { @model_class => @checks }
    @configuration = mock Moon::Application::Configuration, :validators => @validators
    @application = mock Moon::Application, :configuration => @configuration

    @context = Moon::Context.new
    @context.application = @application
    @context.models[:model] = @model

    @validator = mock Moon::Validator, :messages => { }
    Moon::Validator.stub :new => @validator

    @response = mock Moon::Response::JSON::ValidationErrors
    Moon::Response::JSON::ValidationErrors.stub :new => @response

    @action = described_class.new
  end

  describe "perform" do

    it "should initialize the validator with the right checks" do
      Moon::Validator.should_receive(:new).with(@checks).and_return(@validator)
      @action.perform @context
    end

    it "should run the validator" do
      @validator.should_receive(:messages).and_return({ })
      @action.perform @context
    end

    it "should return nil" do
      response = @action.perform @context
      response.should be_nil
    end

    context "on failing validation" do

      before :each do
        @validator.stub :messages => { :email => [ "Has a wrong format." ] }
      end

      it "should initialize #{Moon::Response::JSON::ValidationErrors}" do
        Moon::Response::JSON::ValidationErrors.should_receive(:new).with(
          :model => { :email => [ "Has a wrong format." ] }
        ).and_return(@response)
        @action.perform @context
      end

      it "should return the validation errors response" do
        response = @action.perform @context
        response.should == @response
      end

    end

  end

end
