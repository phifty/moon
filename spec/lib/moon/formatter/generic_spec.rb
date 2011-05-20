require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Formatter::Generic do

  before :each do
    @model_proxy = mock Object, :id => "user_id", :is_a? => true

    @model = Object.new
    @model.instance_variable_set :@user, @model_proxy
    @model.instance_variable_set :@options, [ ]
    @model.instance_variable_set :@pick, 0

    @id = mock GOM::Object::Id
    GOM::Object.stub :id => @id

    @formatter = described_class.new
  end

  describe "hash" do

    it "should fetch the object's id" do
      GOM::Object.should_receive(:id).with(@model).and_return(@id)
      @formatter.hash @model
    end

    it "should not inject the id if nil" do
      GOM::Object.stub :id => nil
      hash = @formatter.hash @model
      hash.keys.should_not include(:id)
    end

    it "should return a hash with all instance variables" do
      hash = @formatter.hash @model
      hash.should == {
        :id => @id,
        :user_id => "user_id",
        :options => [ ],
        :pick => 0
      }
    end

  end

end
