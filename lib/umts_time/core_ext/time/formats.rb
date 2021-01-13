# frozen_string_literal: true

require 'active_support/core_ext/time/conversions'
require 'umts_time/formats'

Time.send :remove_const, :DATE_FORMATS
Time::DATE_FORMATS = UMTSTime::Formats::DATE_TIME
