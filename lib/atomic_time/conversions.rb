# frozen_string_literal: true

require 'date'

class AtomicTime
  module Conversions
    DATE_FORMATS = Time::DATE_FORMATS

    def asctime
      strftime '%T'
    end
    alias_method :ctime, :asctime

    def hash
      @val.hash
    end

    def strftime(format)
      to_time.strftime format
    end

    def to_a
      [hour, min, sec]
    end

    def to_atomic_time
      self.clone
    end

    def to_datetime(on = Date.today)
      to_time(on).to_datetime
    end

    def to_f
      @val.to_f
    end

    def to_formatted_s(format = :default)
      format = self.class::DATE_FORMATS[format]
      if format
        format.respond_to?(:call) ? format.call(self).to_s : strftime(format)
      else
        strftime '%H:%M:%S'
      end
    end
    alias_method :inspect, :to_formatted_s
    alias_method :to_default_s, :to_formatted_s
    alias_method :to_s, :to_formatted_s

    def to_i
      @val
    end

    def to_r
      @val.to_r
    end

    def to_time(on = Date.today)
      on = Date.new on.year, on.month, on.day
      Time.new(on.year, on.month, on.day) + @val
    end
  end
end
