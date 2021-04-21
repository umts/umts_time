# frozen_string_literal: true

RSpec.describe Range do
  describe '#overlap' do
    it 'returns overlapping periods' do
      base = 2..8
      run_expectations(
        { args: 2..8, expect: 2..8  },
        { args: 2..5, expect: 2..5  },
        { args: 5..8, expect: 5..8  },
        { args: 1..5, expect: 2..5  },
        { args: 5..9, expect: 5..8  },
        { args: 2...8, expect: 2...8  },
        { args: [1..5, 5..9], expect: [2..5, 5..8] },
        { args: 12..18, expect: nil  },
        base: base
      )
    end
  end

  describe '#length' do
    it 'calculates the span of the range' do
      run_expectations(
        { base: 1..2, expect: 1 },
        { base: AtomicTime.new(9)..AtomicTime.new(17), expect: 9.hours }
      )
    end
  end
end
