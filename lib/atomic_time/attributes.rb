# frozen_string_literal: true

require 'active_support/duration'

class AtomicTime
  module Attributes
    def initialize(secs)
      raise TypeError, 'Time value must be numeric.' unless secs.is_a? Numeric
      raise ArgumentError, 'Time value must be positive.' if (secs = secs.to_i).negative?

      @val = secs
    end

    def hour
      memoize_attrs unless @hour
      @hour
    end

    def min
      memoize_attrs unless @min
      @min
    end

    def sec
      memoize_attrs unless @sec
      @sec
    end

    def acts_like_time?
      true
    end

    def advance(**argv)
      secs = ActiveSupport::Duration::PARTS_IN_SECONDS.sum do |part, in_secs|
        in_secs * (argv[part] || 0)
      end

      new_val = (@val + secs).floor
      raise ArgumentError, 'Resulting time must not be negative.' if new_val.negative?

      @val = new_val
      clear_attrs
      self
    end

    private

    def clear_attrs
      @hour, @min, @sec = nil
    end

    def memoize_attrs
      remainder = @val
      part_map = { hour: :hours, min: :minutes, sec: :seconds }

      part_map.each do |attr, part|
        part_in_secs = ActiveSupport::Duration::PARTS_IN_SECONDS[part]

        val, remainder = remainder.divmod(part_in_secs)
        instance_variable_set :"@#{attr}", val
      end
    end
  end
end
