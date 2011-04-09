require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "..", "spec_helper"))

describe Moon::Action::Models::Updater do

  before :each do
    @model = Object.new
    @model.class.send :attr_accessor, :options
    @model.class.send :attr_accessor, :pick
    @model.pick = 0

    @context = Moon::Context.new({ }, :decision => { :pick => 1 })
    @context.models[:decision] = @model
  end

  describe "self.perform" do

    it "should change the model's attributes" do
      lambda do
        described_class.perform @context
      end.should change(@model, :pick).from(0).to(1)
    end

    it "should not change the model's attributes that are not specified" do
      lambda do
        described_class.perform @context
      end.should_not change(@model, :options)
    end

    it "should return nil" do
      response = described_class.perform @context
      response.should be_nil
    end

  end

end
