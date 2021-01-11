# frozen_string_literal: true

require 'umts_time/american_parser'
require 'umts_time/formats'

class Time
  include UMTSTime::Formats
  include UMTSTime::AmericanParser
end
