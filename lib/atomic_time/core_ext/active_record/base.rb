# frozen_string_literal: true

require 'active_record/base'
require 'active_support/duration'

module ActiveRecord
  class Base
    class << self
      def time_interval(lower, upper)
        lower, upper = [lower, upper].map(&:to_sym)

        before_validation do
          lower_val, upper_val = [lower, upper].map { |key| send key }
          adj = upper_val.is_a?(DateTime) ? 1 : ActiveSupport::Duration::SECONDS_PER_DAY

          upper_val += adj while lower_val > upper_val

          send :"#{upper}=", upper_val
        end
      end
    end
  end
end
