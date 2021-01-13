# frozen_string_literal: true

require 'atomic_time/core_ext/date_and_time/conversions'
require 'date'

DateTime.include AtomicTime::CoreExt::DateAndTime::Conversions
