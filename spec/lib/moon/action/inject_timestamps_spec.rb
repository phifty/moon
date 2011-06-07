require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Action::InjectTimestamps do

  before :each do
    @model = mock Object, :created_at= => nil, :updated_at= => nil

    @context = Moon::Context.new
    @context.models[:test] = @model

    @action = described_class.new :test
  end

  describe "#perform" do

    before :each do
      @now = DateTime.now
      DateTime.stub :now => @now

      GOM::Object.stub :id => nil
    end

    it "should inject the creation date time" do
      @model.should_receive(:created_at=).with(@now)
      @action.perform @context
    end

    it "should inject the update date time" do
      @model.should_receive(:updated_at=).with(@now)
      @action.perform @context
    end

    it "should not inject the creation date time if the model has an id" do
      GOM::Object.stub :id => "id"
      @model.should_not_receive(:created_at=).with(@now)
      @action.perform @context
    end

    it "should return nil" do
      response = @action.perform @context
      response.should be_nil
    end

  end

end
