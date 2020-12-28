# frozen_string_literal: true

require 'active_support/duration'

module ActiveSupport
  class Duration
    def convert_to(unit)
      to_f / PARTS_IN_SECONDS[unit]
    end
  end
end
