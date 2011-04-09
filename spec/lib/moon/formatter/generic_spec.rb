require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Formatter::Generic do

  before :each do
    @model = Object.new
    @model.instance_variable_set :@options, [ ]
    @model.instance_variable_set :@pick, 0

    @id = mock GOM::Object::Id
    GOM::Object.stub :id => @id

    @formatter = described_class.new @model
  end

  describe "hash" do

    it "should fetch the object's id" do
      GOM::Object.should_receive(:id).with(@model).and_return(@id)
      @formatter.hash
    end

    it "should return a hash with all instance variables" do
      hash = @formatter.hash
      hash.should == {
        :id => @id,
        :options => [ ],
        :pick => 0
      }
    end

  end

end
