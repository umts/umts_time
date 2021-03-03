# frozen_string_literal: true

require 'active_record/type'
require 'active_support'

class AtomicTime
  module CoreExt
    module ActiveRecord
      module Type
        class AtomicTime < ::ActiveRecord::Type::Value
          def type
            :atomic_time
          end

          def deserialize(value)
            return value if value.nil?

            ::AtomicTime.at value
          end

          def cast(value)
            value&.to_atomic_time
          end

          def serialize(value)
            value&.to_i
          end
        end
      end
    end
  end
end

ActiveSupport.on_load :active_record do
  ActiveRecord::Type.register :atomic_time, AtomicTime::CoreExt::ActiveRecord::Type::AtomicTime
end
