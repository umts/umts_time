# frozen_string_literal: true

require 'umts_time/american_parser'
require 'umts_time/formats'

class Time
  include UMTSTime::AmericanParser
  include UMTSTime::Formats
end
