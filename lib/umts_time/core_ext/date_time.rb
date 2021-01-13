# frozen_string_literal: true

require 'date'
require 'umts_time/american_parser'
require 'umts_time/formats'

class DateTime
  include UMTSTime::AmericanParser
  include UMTSTime::Formats
end
