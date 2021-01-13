# frozen_string_literal: true

require 'active_support'
require 'active_support/duration'
require 'date'

class AtomicTime
  module CoreExt
    module ActiveRecord
      module Base
        module Interval
          def time_interval(lower, upper)
            lower, upper = [lower, upper].map(&:to_sym)

            before_validation do
              lower_val, upper_val = [lower, upper].map { |key| send key }

              # DateTime interprets integers as days with +, while Time interprets them as seconds.
              adj = upper_val.is_a?(DateTime) ? 1 : ::ActiveSupport::Duration::SECONDS_PER_DAY

              upper_val += adj while lower_val > upper_val

              send :"#{upper}=", upper_val
            end
          end
        end
      end
    end
  end
end

ActiveSupport.on_load :active_record do
  ActiveRecord::Base.extend AtomicTime::CoreExt::ActiveRecord::Base::Interval
end
