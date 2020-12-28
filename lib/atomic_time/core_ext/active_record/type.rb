# frozen_string_literal: true

require 'active_record/type'

module ActiveRecord
  module Type
    class AtomicTime < Value
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

    register :atomic_time, ::ActiveRecord::Type::AtomicTime
  end
end
