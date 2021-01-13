# frozen_string_literal: true

require_relative 'constructors'

class AtomicTime
  module Calculations
    include Constructors
    include Comparable

    alias_method :+, :since

    def -(other)
      other = other.to_atomic_time if other.respond_to? :to_atomic_time

      if other.is_a? self.class
        to_i - other.to_i
      else
        ago other
      end
    end

    def <=>(other)
      other = other.to_atomic_time.to_i if other.respond_to? :to_atomic_time

      to_i <=> other
    end

    def eql?(other)
      return false unless other.is_a? self.class

      self == other
    end

    def hash
      to_i.hash
    end
  end
end
