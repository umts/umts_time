# frozen_string_literal: true

require 'active_support/core_ext/date/conversions'

module UMTSTime
  module Formats
    DATE = {
      short: '%m/%d',
      default: '%Y-%m-%d',
      long: '%B %-d, %Y',
      wday: '%A, %B %-d, %Y',

      db: Date::DATE_FORMATS[:db],
      number: Date::DATE_FORMATS[:number],
      long_ordinal: Date::DATE_FORMATS[:long_ordinal],
      rfc822: Date::DATE_FORMATS[:rfc822],
      iso8601: Date::DATE_FORMATS[:iso8601]
    }

    TIME = {
      short: '%H:%M',
      default: '%-I:%M %p',

      db: '%H:%M:%S',
      number: '%H%M%S',
    }

    DATE_TIME = {
      short: lambda { |date_time| date_time.strftime "#{DATE[:short]} #{TIME[:short]}" },
      default: lambda { |date_time| date_time.strftime "#{DATE[:default]} #{TIME[:default]}" },
      long: lambda { |date_time| date_time.strftime "#{DATE[:long]} #{TIME[:long]}" },
      wday: lambda { |date_time| date_time.strftime "#{DATE[:wday]} #{TIME[:default]}" },

      db: Time::DATE_FORMATS[:db],
      number: Time::DATE_FORMATS[:number],
      long_ordinal: Time::DATE_FORMATS[:long_ordinal],
      rfc822: Time::DATE_FORMATS[:rfc822],
      iso8601: Time::DATE_FORMATS[:iso8601]
    }

    DATE.each { |name, format| DATE_TIME[:"#{name}_date"] = format }
    TIME.each { |name, format| DATE_TIME[:"#{name}_time"] = format }
  end
end
