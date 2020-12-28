# frozen_string_literal: true

RSpec.shared_examples AtomicTime::Attributes do |klass|
  describe 'hour' do
    it 'returns the hour' do
      run_expectations(
        { base: klass.new(0, 0, 0),  expect: 0  },
        { base: klass.new(12, 0, 0), expect: 12 },
        { base: klass.new(23, 0, 0), expect: 23 }
      )
    end
  end

  describe 'min' do
    it 'returns the minute' do
      run_expectations(
        { base: klass.new(0, 0, 0),  expect: 0  },
        { base: klass.new(0, 30, 0), expect: 30 },
        { base: klass.new(0, 59, 0), expect: 59 }
      )
    end
  end

  describe 'sec' do
    it 'returns the second' do
      run_expectations(
        { base: klass.new(0, 0, 0),  expect: 0  },
        { base: klass.new(0, 0, 30), expect: 30 },
        { base: klass.new(0, 0, 59), expect: 59 }
      )
    end
  end

  describe 'acts_like_time?' do
    it 'returns true' do
      expect(klass.new.acts_like_time?).to eq true
    end
  end

  describe 'advance' do
    context 'part/numeric' do
      it 'returns correct' do
        run_expectations(
          { base: klass.new(0, 0, 0),
            args: { hours: 1, minutes: 1, seconds: 1 },
            expect: klass.new(1, 1, 1)
          },

          { base: klass.new(0, 0, 0),
            args: { hours: 1, minutes: 1, seconds: 1 },
            expect: klass.new(1, 1, 1) },

          { base: klass.new(0, 0, 1),
            args: { seconds: 60 },
            expect: klass.new(0, 1, 1) },

          { base: klass.new(0, 1, 1),
            args: { minutes: 60 },
            expect: klass.new(1, 1, 1) },

          { base: klass.new(1, 1, 1),
            args: { days: 1, seconds: 90 },
            expect: klass.new(25, 2, 31) },

          { base: klass.new(1, 1, 1),
            args: { months: 1, minutes: 90, seconds: 90 },
            expect: klass.new(733, 01, 37) },

          { base: klass.new(1, 1, 1),
            args: { years: 1, hours: 1, minutes: 90, seconds: 90 },
            expect: klass.new(8769, 21, 43) },

          { base: klass.new(1, 1, 1),
            args: { weeks: 1 },
            expect: klass.new(169, 1, 1) }
        )
      end

      it 'returns the same obj' do
        base = klass.new(0, 0, 0)
        expect(base.advance).to equal base
      end

      context 'negative' do
        it 'subtracts' do
          base = klass.new(1, 1, 1)
          expect(base.advance hours: -1, minutes: -1, seconds: -1).to eq klass.new(0, 0, 0)
        end

        it 'raises an argument error on invalid' do
          base = klass.new(0, 0, 0)
          expect { base.advance seconds: -1 }.to raise_error ArgumentError
        end

        it 'does not change on invalid' do
          base = klass.new(0, 0, 0)
          base.advance seconds: -1 rescue ArgumentError
          expect(base).to eq klass.new(0, 0, 0)
        end
      end
    end

    context 'non-part/any' do
      it 'ignores invalid pairs' do
        run_expectations(
          { base: klass.new(0, 0, 0),
            args: { extra: 1, hours: 1, minutes: 1, seconds: 1 }, },

          { base: klass.new(0, 0, 0),
            args: { invalid: 1, hours: 1, minutes: 1, seconds: 1 } },

          { base: klass.new(0, 0, 0),
            args: { args: 1, hours: 1, minutes: 1, seconds: 1 } },

          expect: klass.new(1, 1, 1)
        )
      end
    end

    context 'part/non-numeric' do
      it 'raises a type error' do
        run_expectations(
          { base: klass.new(0, 0, 0),
            args: { hours: [], minutes: 1, seconds: 1 } },

          { base: klass.new(0, 0, 1),
            args: { seconds: {} } },

          matcher: :raise_error, expect: TypeError
        )
      end
    end
  end
end
