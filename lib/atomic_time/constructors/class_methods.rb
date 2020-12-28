# frozen_string_literal: true

class AtomicTime
  module Constructors
    module ClassMethods
      def at(secs)
        obj = allocate
        obj.send :initialize, secs
        obj
      end

      def httpdate(str)
        result = Time.httpdate str
        parts = wrap_parts result.hour, result.min, result.sec
        at sum_parts parts
      end

      def iso8601(str)
        result = Time.iso8601 str
        parts = wrap_parts result.hour, result.min, result.sec
        at sum_parts parts
      end

      def new(hour = nil, min = nil, sec = nil)
        return now if [hour, min, sec].all?(&:nil?)

        parts = wrap_parts hour, min, sec

        raise TypeError unless parts.values.all? { |v| v.is_a? Numeric }
        raise ArgumentError if parts.values.any? { |v| v.negative? }
        raise ArgumentError unless (0...60).include? parts[:min]
        raise ArgumentError unless (0...60).include? parts[:sec]

        at sum_parts parts
      end
      alias_method :mktime, :new

      def now
        result = Time.now
        parts = wrap_parts result.hour, result.min, result.sec
        at sum_parts parts
      end
      alias_method :current, :now

      def rfc2822(str)
        result = Time.rfc2822 str
        parts = wrap_parts result.hour, result.min, result.sec
        at sum_parts parts
      end

      def rfc3339(str)
        result = Time.rfc3339 str
        parts = wrap_parts result.hour, result.min, result.sec
        at sum_parts parts
      end

      def rfc822(str)
        result = Time.rfc822 str
        parts = wrap_parts result.hour, result.min, result.sec
        at sum_parts parts
      end

      def strptime(date, format, now = Time.now)
        result = Time.strptime date, format, now
        parts = wrap_parts result.hour, result.min, result.sec
        at sum_parts parts
      end

      def parse(str, now = Time.now)
        result = Time.parse str, now
        parts = wrap_parts result.hour, result.min, result.sec
        at sum_parts parts
      end

      def xmlschema(str)
        result = Time.xmlschema str
        parts = wrap_parts result.hour, result.min, result.sec
        at sum_parts parts
      end

      private

      def wrap_parts(hour, min, sec)
        %i[hour min sec].zip([hour || 0, min || 0, sec || 0]).to_h
      end

      def sum_parts(**parts)
        (parts[:hour] * ActiveSupport::Duration::PARTS_IN_SECONDS[:hours]) +
          (parts[:min] * ActiveSupport::Duration::PARTS_IN_SECONDS[:minutes]) +
          (parts[:sec] * ActiveSupport::Duration::PARTS_IN_SECONDS[:seconds])
      end
    end
  end
end
