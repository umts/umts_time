# frozen_string_literal: true

require 'atomic_time'
require 'umts_time/formats'

AtomicTime::DATE_FORMATS = UMTSTime::Formats::DATE_TIME
