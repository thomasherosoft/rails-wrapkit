module HasUserSubtypes
  extend ActiveSupport::Concern

  module ClassMethods
    def has_user_subtypes?
      true
    end
  end

  def has_user_subtypes?
    self.class.has_user_subtypes?
  end

  def subtype
    # for a given class, returns the appropriate symbol
    # to pass to the ActiveRecord method reflect_on_association
    def reflection_symbol(klass)
      klass.to_s.split('::').last.underscore.to_sym
    end

    # for all subclasses of the given base class, returns a
    # list of defined associations within the current class
    def association_methods(mti_base_class)
      mti_base_class.collect{|p|
        assoc = self.class.reflect_on_association(reflection_symbol(p))
        assoc ? assoc.name : nil
      }.compact
    end

    # invoke each association method and return the first
    # that is not null
    association_methods(self.class::USER_SUBTYPE_CLASSES).collect{|a|
      self.send a
    }.inject do |a, b|
      a || b
    end
  end

  def subtype=(p)
    def reflection_symbol(klass)
      klass.to_s.split('::').last.underscore.to_sym
    end

    def reflection_assignment_method(klass)
      self.class.reflect_on_association(reflection_symbol(klass)).name.to_s + '='
    end

    self.send reflection_assignment_method(p.class), p
  end
end
