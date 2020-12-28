# frozen_string_literal: true

RSpec.shared_examples AtomicTime::Calculations do |klass|
  describe '#-' do
    context 'time arg' do
      it 'returns diff in seconds' do
        run_expectations(
          { base: klass.new(24, 0, 0), args: klass.new(1, 1, 1),
            expect: (24 * 60 * 60) - ((60 * 60) + 60 + 1) },

          { base: klass.new(24, 0, 0), args: DateTime.new(0, 1, 1, 1, 1, 1),
            expect: (24 * 60 * 60) - ((60 * 60) + 60 + 1) },

          { base: klass.new(24, 0, 0), args: Time.new(0, 1, 1, 1, 1, 1),
            expect: (24 * 60 * 60) - ((60 * 60) + 60 + 1) }
        )
      end
    end

    context 'numeric arg' do
      it 'subtracts the amount of seconds' do
        run_expectations(
          { base: klass.new(24, 0, 0), args: 1,
            expect: klass.new(23, 59, 59) },

          { base: klass.new(24, 0, 0), args: 60,
            expect: klass.new(23, 59, 0) },

          { base: klass.new(24, 0, 0), args: (60 * 60),
            expect: klass.new(23, 0, 0) },

          { base: klass.new(24, 0, 0), args: (60 * 60 * 24),
            expect: klass.new(0, 0, 0) }
        )
      end
    end
  end

  describe '#<=>' do
    it 'compares times correctly' do
      run_expectations(
        { base: klass.new(0, 0, 0), args: klass.new(0, 0, 0), expect: 0 },
        { base: klass.new(0, 0, 0), args: Time.new(0, 1, 1, 0, 0, 0), expect: 0 },
        { base: klass.new(0, 0, 0), args: DateTime.new(0, 1, 1, 0, 0, 0), expect: 0 },

        { base: klass.new(0, 0, 0), args: klass.new(1, 1, 1), expect: -1 },
        { base: klass.new(0, 0, 0), args: Time.new(0, 1, 1, 1, 1, 1), expect: -1 },
        { base: klass.new(0, 0, 0), args: DateTime.new(0, 1, 1, 1, 1, 1), expect: -1 },

        { base: klass.new(1, 1, 1), args: klass.new(0, 0, 0), expect: 1 },
        { base: klass.new(1, 1, 1), args: Time.new(0, 1, 1, 0, 0, 0), expect: 1 },
        { base: klass.new(1, 1, 1), args: DateTime.new(0, 1, 1, 0, 0, 0), expect: 1 },
        method: :<=>
      )
    end
  end

  describe '#eql?' do
    it 'compares only atomic times' do
      run_expectations(
        { base: klass.new(0, 0, 0), args: klass.new(0, 0, 0), expect: true },
        { base: klass.new(0, 0, 0), args: Time.new(0, 1, 1, 0, 0, 0), expect: false },
        { base: klass.new(0, 0, 0), args: DateTime.new(0, 1, 1, 0, 0, 0), expect: false }
      )
    end
  end
end
