require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "spec_helper"))

describe Moon::Context do

  before :each do
    @context = described_class.new
  end

  [ :session, :parameters, :models, :collections ].each do |key|

    describe "#{key}=" do

      it "should set the #{key} hash" do
        @context.send :"#{key}=", { }
        @context.send(key).should == { }
      end

      it "should raise an #{ArgumentError} if no hash is given" do
        lambda do
          @context.send :"#{key}=", :invalid
        end.should raise_error(ArgumentError)
      end

    end

  end

end
