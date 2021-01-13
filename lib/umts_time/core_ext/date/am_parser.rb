# frozen_string_literal: true

require 'date'
require 'umts_time/core_ext/date_and_time/am_parser'

Date.extend UMTSTime::CoreExt::DateAndTime::AmParser
