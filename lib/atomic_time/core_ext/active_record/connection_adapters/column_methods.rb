# frozen_string_literal: true

require 'active_record'

module ActiveRecord
  module ConnectionAdapters
    module ColumnMethods
      def atomic_time(*args, **options)
        args.each { |name| column(name, :integer, options) }
      end
    end
  end
end
