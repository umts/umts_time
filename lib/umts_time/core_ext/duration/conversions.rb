# frozen_string_literal: true

require 'active_support/duration'

module UMTSTime
  module CoreExt
    module ActiveSupport
      module Duration
        module Conversions
          def convert_to(unit)
            to_f / ::ActiveSupport::Duration::PARTS_IN_SECONDS[unit]
          end
        end
      end
    end
  end
end

ActiveSupport::Duration.include UMTSTime::CoreExt::ActiveSupport::Duration::Conversions
