require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "spec_helper"))

describe Moon::Utility::Template do

  before :each do
    @klass = Class.new
    @klass.instance_eval do
      extend Moon::Utility::Template

      template :test_one, :test_two
    end
  end

  describe "#self.template" do

    it "should define a :[] method for the class" do
      @klass.should respond_to(:[])
    end

    it "should define an accessor for each attribute" do
      @klass.test_one = Object
      @klass.test_one.should == Object
      @klass.test_two = :test
      @klass.test_two.should == :test
    end

  end

  describe "#self.[]" do

    it "should return a class" do
      klass = @klass[Object, :test]
      klass.should be_instance_of(Class)
    end

    it "should return a class that is different from the original" do
      klass = @klass[Object, :test]
      klass.should_not == @klass
    end

    it "should return a class that is assigned to the right checks" do
      klass = @klass[Object, :test]
      klass.test_one.should == Object
      klass.test_two.should == :test
    end

  end

end
