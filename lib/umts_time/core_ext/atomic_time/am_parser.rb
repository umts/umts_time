# frozen_string_literal: true

require 'atomic_time'
require 'umts_time/core_ext/date_and_time/am_parser'

AtomicTime.extend UMTSTime::CoreExt::DateAndTime::AmParser
