# frozen_string_literal: true

require 'active_support/core_ext/time/calculations'
require 'active_support/duration'
require 'time'

require_relative 'constructors/class_methods'

class AtomicTime
  module Constructors
    def ago(secs)
      self.class.at @val - secs
    end

    def beginning_of_day
      self.class.at floor_val :days
    end
    alias_method :at_beginning_of_day, :beginning_of_day
    alias_method :at_midnight, :beginning_of_day
    alias_method :midnight, :beginning_of_day

    def beginning_of_hour
      self.class.at floor_val :hours
    end

    alias_method :at_beginning_of_hour, :beginning_of_hour

    def beginning_of_minute
      self.class.at floor_val :minutes
    end

    alias_method :at_beginning_of_minute, :beginning_of_minute

    def change(**argv)
      self.class.new argv[:hour] || hour, argv[:min] || min, argv[:sec] || sec
    end

    def end_of_day
      self.class.at ceil_val(:days) - 1
    end
    alias_method :at_end_of_day, :end_of_day

    def end_of_hour
      self.class.at ceil_val(:hours) - 1
    end
    alias_method :at_end_of_hour, :end_of_hour

    def end_of_minute
      self.class.at ceil_val(:minutes) - 1
    end
    alias_method :at_end_of_minute, :end_of_minute

    def middle_of_day
      half = ActiveSupport::Duration::SECONDS_PER_DAY / 2
      self.class.at floor_val(:days) + half
    end
    alias_method :at_midday, :middle_of_day
    alias_method :at_middle_of_day, :middle_of_day
    alias_method :at_noon, :middle_of_day
    alias_method :midday, :middle_of_day
    alias_method :noon, :middle_of_day

    def next_day
      since ActiveSupport::Duration::SECONDS_PER_DAY
    end

    def prev_day
      ago ActiveSupport::Duration::SECONDS_PER_DAY
    end

    def since(secs)
      self.class.at @val + secs
    end
    alias_method :in, :since

    private

    def ceil_val(part)
      part_in_secs = ActiveSupport::Duration::PARTS_IN_SECONDS[part]
      @val - (@val % part_in_secs) + part_in_secs
    end

    def floor_val(part)
      part_in_secs = ActiveSupport::Duration::PARTS_IN_SECONDS[part]
      @val - (@val % part_in_secs)
    end

    class << self
      def included(klass)
        klass.extend ClassMethods
      end
    end
  end
end
