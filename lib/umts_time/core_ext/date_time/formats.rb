# frozen_string_literal: true

require 'date'
require 'umts_time/formats'

DateTime::DATE_FORMATS = UMTSTime::Formats::DATE_TIME
