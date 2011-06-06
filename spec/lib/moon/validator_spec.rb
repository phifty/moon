require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "spec_helper"))

describe Moon::Validator do

  before :each do
    @model = mock Object, :name => "test"

    @attribute_validator = mock Moon::Validator::Presence, :messages => [ ], :to_ary => nil
    @checks = { :name => @attribute_validator }

    @validator = described_class.new :context, @checks
  end

  describe "#messages" do

    it "should check the attribute validator" do
      @attribute_validator.should_receive(:messages).with("test", :context).and_return([ ])
      @validator.messages @model
    end

    it "should return an empty hash" do
      messages = @validator.messages @model
      messages.should == { }
    end

    it "should return a hash with an array including the fitting error message" do
      @attribute_validator.stub :messages => [ "Error!" ]
      messages = @validator.messages @model
      messages[:name].should == [ "Error!" ]
    end

  end

end
