
module Moon::Utility::Template

  def self.extended(base)
    base.class_eval do

      def self.template(*class_attributes)
        @class_attributes = class_attributes
        self.class.send :attr_accessor, *@class_attributes
      end

      def self.[](*values)
        klass = self.dup
        (@class_attributes || [ ]).each do |class_attribute|
          klass.send :"#{class_attribute}=", values.shift
        end
        klass
      end

    end
  end

end
