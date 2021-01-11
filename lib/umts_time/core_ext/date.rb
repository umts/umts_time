# frozen_string_literal: true

require 'date'
require 'umts_time/american_parser'
require 'umts_time/formats'

class Date
  include UMTSTime::Formats
  include UMTSTime::AmericanParser
end
