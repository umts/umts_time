# frozen_string_literal: true

require 'active_support/core_ext/date/conversions'
require 'date'
require 'umts_time/formats'

Date.send :remove_const, :DATE_FORMATS
Date::DATE_FORMATS = UMTSTime::Formats::DATE
