# frozen_string_literal: true

require 'active_support/duration'
require 'active_support/core_ext/time/calculations'
require 'time'

class AtomicTime
  module Constructors
    module ClassMethods
      def at(secs)
        obj = allocate
        obj.send :initialize, secs
        obj
      end

      def httpdate(str)
        delegate_to_time :httpdate, str
      end

      def iso8601(str)
        delegate_to_time :iso8601, str
      end

      def new(hour = nil, min = nil, sec = nil)
        return now if [hour, min, sec].all?(&:nil?)

        parts = wrap_parts hour, min, sec

        raise TypeError, 'Time components must be numeric.' unless parts.values.all? { |v| v.is_a? Numeric }
        raise ArgumentError, 'Time components must be positive.' if parts.values.any? { |v| v.negative? }
        raise ArgumentError, 'Minute must be within (0...60).' unless (0...60).include? parts[:min]
        raise ArgumentError, 'Second must be within (0...60).' unless (0...60).include? parts[:sec]

        at sum_parts parts
      end
      alias_method :mktime, :new

      def now
        delegate_to_time :now
      end
      alias_method :current, :now

      def rfc2822(str)
        delegate_to_time :rfc2822, str
      end

      def rfc3339(str)
        delegate_to_time :rfc3339, str
      end

      def rfc822(str)
        delegate_to_time :rfc822, str
      end

      def strptime(date, format, now = Time.now)
        delegate_to_time :strptime, date, format, now
      end

      def parse(str, now = Time.now)
        delegate_to_time :parse, str, now
      end

      def xmlschema(str)
        delegate_to_time :xmlschema, str
      end

      private

      def delegate_to_time(method, *args)
        result = Time.send(method, *args)
        parts = wrap_parts result.hour, result.min, result.sec
        at sum_parts parts
      end

      def wrap_parts(hour, min, sec)
        { hour: hour || 0, min: min || 0, sec: sec || 0 }
      end

      def sum_parts(**parts)
        part_map = { hour: :hours, min: :minutes, sec: :seconds }

        part_map.sum do |attr, part|
          parts[attr] * ActiveSupport::Duration::PARTS_IN_SECONDS[part]
        end
      end
    end
  end
end
