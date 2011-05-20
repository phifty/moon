require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "spec_helper"))

describe Moon::Action::Model::UpdateOrCreate do

  before :each do
    @model_class = mock Class, :to_s => "Model"
    @model = mock Object, :class => @model_class

    @application = mock Moon::Application, :storage_name => :dump
    @context = Moon::Context.new
    @context.application = @application

    @update = mock Moon::Action::Model::Update, :perform => :update_response
    Moon::Action::Model::Update.stub :new => @update

    @create = mock Moon::Action::Model::Create, :perform => :create_response
    Moon::Action::Model::Create.stub :new => @create

    @action = described_class.new @model_class
  end

  describe "#perform" do

    context "for a new model" do

      it "should initialize #{Moon::Action::Model::Create}" do
        Moon::Action::Model::Create.should_receive(:new).with(@model_class).and_return(@update)
        @action.perform @context
      end

      it "should perform the create" do
        @create.should_receive(:perform).with(@context).and_return(:create_response)
        @action.perform @context
      end

      it "should return the response of the create" do
        response = @action.perform @context
        response.should == :create_response
      end

    end

    context "for an existing model" do

      before :each do
        @context.models[:model] = @model
      end

      it "should initialize #{Moon::Action::Model::Update}" do
        Moon::Action::Model::Update.should_receive(:new).with(:model).and_return(@update)
        @action.perform @context
      end

      it "should perform the update" do
        @update.should_receive(:perform).with(@context).and_return(:update_response)
        @action.perform @context
      end

      it "should return the response of the update" do
        response = @action.perform @context
        response.should == :update_response
      end

    end

  end

end
