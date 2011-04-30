require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Action::RespondBlank do

  before :each do
    @context = Moon::Context.new
    @action = described_class.new
  end

  describe "#perform" do

    before :each do
      @response = mock Moon::Response::JSON::Blank
      Moon::Response::JSON::Blank.stub :new => @response
    end

    it "should initialize a #{Moon::Response::JSON::Blank}" do
      Moon::Response::JSON::Blank.should_receive(:new).and_return(@response)
      @action.perform @context
    end

  end

end
