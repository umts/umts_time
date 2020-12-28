# frozen_string_literal: true

RSpec.describe ActiveSupport::Duration do
  describe '#convert_to' do
    it 'converts units' do
      run_expectations(
        { args: :seconds, expect: 86400 },
        { args: :minutes, expect: 1440 },
        { args: :hours, expect: 24 },
        { args: :days, expect: 1 },
        { args: :weeks, expect: (1.0 / 7) },
        { args: :months, expect: (86400.0 / 2629746) },
        { args: :years, expect: (86400.0 / 31556952) },
        base: 1.day
      )
    end
  end
end
