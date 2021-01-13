# frozen_string_literal: true

class AtomicTime
  module CoreExt
    module DateAndTime
      module Conversions
        def to_atomic_time
          AtomicTime.new hour, min, sec
        end
      end
    end
  end
end