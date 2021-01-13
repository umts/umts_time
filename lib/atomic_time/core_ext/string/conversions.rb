# frozen_string_literal: true

class AtomicTime
  module CoreExt
    module String
      module Conversions
        def to_atomic_time
          AtomicTime.parse self
        end
      end
    end
  end
end

String.include AtomicTime::CoreExt::String::Conversions
