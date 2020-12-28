# frozen_string_literal: true

require_relative 'constructors/class_methods_examples'

RSpec.shared_examples AtomicTime::Constructors do |klass|
  include_examples AtomicTime::Constructors::ClassMethods, klass

  let!(:mid_vals) { klass.new 12, 30, 30 }
  let!(:tomorrow_mid_vals) { klass.new 36, 30, 30 }

  describe '#ago' do
    context 'numeric' do
      it 'returns a new obj with subtracted amount of seconds' do
        run_expectations(
          { args: 1, expect: klass.new(36, 30, 29) },
          { args: 60, expect: klass.new(36, 29, 30) },
          { args: 60 * 60, expect: klass.new(35, 30, 30) },
          { args: 60 * 60 * 24, expect: klass.new(12, 30, 30) },
          base: tomorrow_mid_vals
        )
      end

      context 'negative' do
        it 'adds' do
          run_expectations(
            { args: -1, expect: klass.new(12, 30, 31) },
            { args: -60, expect: klass.new(12, 31, 30) },
            { args: -60 * 60, expect: klass.new(13, 30, 30) },
            { args: -60 * 60 * 24, expect: klass.new(36, 30, 30) },
            base: mid_vals
          )
        end

        it 'raises argument error on invalid' do
          expect { klass.new(0, 0, 0).ago(1) }.to raise_error ArgumentError
        end
      end
    end

    context 'non-numeric' do
      it 'raises a type error' do
        expect { mid_vals.since '' }.to raise_error TypeError
      end
    end
  end

  describe '#beginning_of_day' do
    it 'returns the end of the day' do
      run_expectations(
        { base: mid_vals,          expect: klass.new(0, 0, 0) },
        { base: tomorrow_mid_vals, expect: klass.new(24, 0, 0) }
      )
    end
  end

  describe '#beginning_of_hour' do
    it 'returns the beginning of the hour' do
      run_expectations(
        { base: mid_vals,          expect: klass.new(12, 0, 0) },
        { base: tomorrow_mid_vals, expect: klass.new(36, 0, 0) }
      )
    end
  end

  describe '#beginning_of_minute' do
    it 'returns the beginning of the minute' do
      run_expectations(
        { base: mid_vals,          expect: klass.new(12, 30, 0) },
        { base: tomorrow_mid_vals, expect: klass.new(36, 30, 0) }
      )
    end
  end

  describe '#change' do
    context 'part/numeric' do
      it 'returns a new obj with changed values' do
        run_expectations(
          { args: { hour: 0 }, expect: klass.new(0, 30, 30) },
          { args: { min: 0 }, expect: klass.new(12, 0, 30) },
          { args: { sec: 0 }, expect: klass.new(12, 30, 0) },
          base: mid_vals
        )
      end

      context 'invalid values' do
        it 'raises an argument error' do
          run_expectations(
            { args: { hour: -1 } },
            { args: { min: -1 } },
            { args: { min: 60 } },
            { args: { sec: -1 } },
            { args: { sec: 60 } },
            base: mid_vals, matcher: :raise_error, expect: ArgumentError
          )
        end
      end
    end

    context 'non-part/any' do
      it 'ignores invalid pairs' do
        run_expectations(
          { args: { invalid: nil, hour: 0 }, expect: klass.new(0, 30, 30) },
          { args: { invalid: '', min: 0 }, expect: klass.new(12, 0, 30) },
          { args: { invalid: [], sec: 0 }, expect: klass.new(12, 30, 0) },
          base: mid_vals
        )
      end
    end

    context 'part/non-numeric' do
      it 'raises a type error' do
        run_expectations(
          { args: { hour: '' } },
          { args: { min: [] } },
          { args: { sec: {} } },
          base: mid_vals, matcher: :raise_error, expect: TypeError
        )
      end
    end
  end

  describe '#end_of_day' do
    it 'returns the end of the day' do
      run_expectations(
        { base: mid_vals,          expect: klass.new(23, 59, 59) },
        { base: tomorrow_mid_vals, expect: klass.new(47, 59, 59) }
      )
    end
  end

  describe '#end_of_hour' do
    it 'returns the end of the hour' do
      run_expectations(
        { base: mid_vals,          expect: klass.new(12, 59, 59) },
        { base: tomorrow_mid_vals, expect: klass.new(36, 59, 59) }
      )
    end
  end

  describe '#end_of_minute' do
    it 'returns the end of the hour' do
      run_expectations(
        { base: mid_vals,          expect: klass.new(12, 30, 59) },
        { base: tomorrow_mid_vals, expect: klass.new(36, 30, 59) }
      )
    end
  end

  describe '#middle_of_day' do
    it 'returns the middle of the day' do
      run_expectations(
        { base: mid_vals,          expect: klass.new(12, 0, 0) },
        { base: tomorrow_mid_vals, expect: klass.new(36, 0, 0) }
      )
    end
  end

  describe '#next_day' do
    it 'returns the time on the next day' do
      run_expectations(
        { base: mid_vals,          expect: klass.new(36, 30, 30) },
        { base: tomorrow_mid_vals, expect: klass.new(60, 30, 30) }
      )
    end
  end

  describe '#prev_day' do
    it 'returns the time on the previous day' do
      expect(tomorrow_mid_vals.prev_day).to eq klass.new(12, 30, 30)
    end

    context 'negative' do
      it 'raises an argument error' do
        expect { mid_vals.prev_day }.to raise_error ArgumentError
      end
    end
  end

  describe '#since' do
    context 'numeric' do
      it 'returns a new obj with added amount of seconds' do
        run_expectations(
          { args: 1, expect: klass.new(12, 30, 31) },
          { args: 60, expect: klass.new(12, 31, 30) },
          { args: 60 * 60, expect: klass.new(13, 30, 30) },
          { args: 60 * 60 * 24, expect: klass.new(36, 30, 30) },
          base: mid_vals
        )
      end

      context 'negative' do
        it 'subtracts' do
          run_expectations(
            { args: -1, expect: klass.new(36, 30, 29) },
            { args: -60, expect: klass.new(36, 29, 30) },
            { args: -60 * 60, expect: klass.new(35, 30, 30) },
            { args: -60 * 60 * 24, expect: klass.new(12, 30, 30) },
            base: tomorrow_mid_vals
          )
        end

        it 'raises argument error on invalid' do
          expect { klass.new(0, 0, 0).since(-1) }.to raise_error ArgumentError
        end
      end
    end

    context 'non-numeric' do
      it 'raises a type error' do
        expect { mid_vals.since '' }.to raise_error TypeError
      end
    end
  end
end
