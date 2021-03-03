# frozen_string_literal: true

module UMTSTime
  module CoreExt
    module DateAndTime
      module AmParser
        def parse_am(*args)
          args[0] = args[0].gsub /(\d{1,2})\/(\d{1,2})\/(\d{1,4})/, '\3-\1-\2' if args[0]
          parse_eu(*args)
        end

        class << self
          def extended(klass)
            klass.instance_eval do
              alias parse_eu parse
              alias parse parse_am
            end
          end
        end
      end
    end
  end
end
