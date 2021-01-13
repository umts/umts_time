# frozen_string_literal: true

module UMTSTime
  module Formats
    DATE = {
      short: '%m/%d',
      default: '%Y-%m-%d',
      long: '%B %-d, %Y',
      wday: '%A, %B %-d, %Y',

      db: '%Y-%m-%d',
      number: '%Y%m%d',
      rfc822: '%d %b %Y',
      iso8601: lambda { |date| date.iso8601 }
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

      db: lambda { |date_time| date_time.strftime "#{DATE[:db]} #{TIME[:db]}" },
      number: lambda { |date_time| date_time.strftime "#{DATE[:number]}#{TIME[:number]}" },
      rfc822: lambda { |date_time|
        offset_format = date_time.formatted_offset(false)
        date_time.strftime("%a, %d %b %Y %H:%M:%S #{offset_format}")
      },
      iso8601: lambda { |date_time| date_time.iso8601 }
    }

    DATE.each { |name, format| DATE_TIME[:"#{name}_date"] = format }
    TIME.each { |name, format| DATE_TIME[:"#{name}_time"] = format }
  end
end
