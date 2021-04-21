# frozen_string_literal: true

RSpec.shared_examples AtomicTime::Conversions do |klass|
  describe '#hash' do
    it 'hashes the value of to_i' do
      time = klass.now
      expect(time.hash).to eq time.to_i.hash
    end
  end

  describe '#to_a' do
    it 'returns [hour min sec]' do
      run_expectations(
        { base: klass.new(0, 0, 0), expect: [0, 0, 0] },
        { base: klass.new(1, 1, 1), expect: [1, 1, 1] },
        { base: klass.new(24, 59, 59), expect: [24, 59, 59] }
      )
    end
  end

  describe '#to_atomic_time' do
    it 'returns an equivalent atomic time' do
      ref = klass.new 0, 0, 0
      atomic = ref.to_atomic_time
      expect(atomic).to_not equal ref
      expect(atomic).to eq ref
    end
  end

  describe '#to_datetime' do
    context 'no args' do
      it 'returns an equivalent datetime on the current date' do
        Timecop.freeze do
          run_expectations(
            { base: klass.new(1, 1, 1),
              expect: DateTime.now.change(hour: 1, min: 1, sec: 1) },

            { base: klass.new(25, 1, 1),
              expect: DateTime.now.change(hour: 1, min: 1, sec: 1) + 1 }
          )
        end
      end
    end

    context 'with date/time/datetime arg' do
      it 'returns the time on the supplied day' do
        run_expectations(
          { base: klass.new(1, 1, 1), args: Date.new(0, 1, 1),
            expect: DateTime.now.change(year: 0, month: 1, day: 1, hour: 1, min: 1, sec: 1) },

          { base: klass.new(25, 1, 1), args: Date.new(0, 1, 1),
            expect: DateTime.now.change(year: 0, month: 1, day: 2, hour: 1, min: 1, sec: 1) },

          { base: klass.new(1, 1, 1), args: Time.new(0, 1, 1, 1, 1, 1),
            expect: DateTime.now.change(year: 0, month: 1, day: 1, hour: 1, min: 1, sec: 1) },

          { base: klass.new(25, 1, 1), args: Time.new(0, 1, 1, 1, 1, 1),
            expect: DateTime.now.change(year: 0, month: 1, day: 2, hour: 1, min: 1, sec: 1) },

          { base: klass.new(1, 1, 1), args: DateTime.new(0, 1, 1, 1, 1, 1),
            expect: DateTime.now.change(year: 0, month: 1, day: 1, hour: 1, min: 1, sec: 1) },

          { base: klass.new(25, 1, 1), args: DateTime.new(0, 1, 1, 1, 1, 1),
            expect: DateTime.now.change(year: 0, month: 1, day: 2, hour: 1, min: 1, sec: 1) }
        )
      end
    end
  end

  describe '#to_f' do
    it 'returns the number of seconds' do
      run_expectations(
        { base: klass.at(0), expect: 0.0 },
        { base: klass.at(60), expect: 60.0 },
        { base: klass.at(3600), expect: 3600.0 }
      )
    end
  end

  describe '#to_i' do
    it 'returns the number of seconds' do
      run_expectations(
        { base: klass.at(0), expect: 0.0 },
        { base: klass.at(60), expect: 60.0 },
        { base: klass.at(3600), expect: 3600.0 }
      )
    end
  end

  describe '#to_r' do
    it 'returns the number of seconds' do
      run_expectations(
        { base: klass.at(0), expect: Rational(0, 1) },
        { base: klass.at(60), expect: Rational(60, 1) },
        { base: klass.at(3600), expect: Rational(3600, 1) }
      )
    end
  end

  describe '#to_time' do
    context 'no args' do
      it 'returns an equivalent datetime on the current date' do
        Timecop.freeze do
          run_expectations(
            { base: klass.new(1, 1, 1),
              expect: Time.now.change(hour: 1, min: 1, sec: 1) },

            { base: klass.new(25, 1, 1),
              expect: Time.now.change(hour: 1, min: 1, sec: 1) + 1 }
          )
        end
      end
    end

    context 'with date/time/datetime arg' do
      it 'returns the time on the supplied day' do
        run_expectations(
          { base: klass.new(1, 1, 1), args: Date.new(0, 1, 1),
            expect: Time.now.change(year: 0, month: 1, day: 1, hour: 1, min: 1, sec: 1) },

          { base: klass.new(25, 1, 1), args: Date.new(0, 1, 1),
            expect: Time.now.change(year: 0, month: 1, day: 2, hour: 1, min: 1, sec: 1) },

          { base: klass.new(1, 1, 1), args: Time.new(0, 1, 1, 1, 1, 1),
            expect: Time.now.change(year: 0, month: 1, day: 1, hour: 1, min: 1, sec: 1) },

          { base: klass.new(25, 1, 1), args: Time.new(0, 1, 1, 1, 1, 1),
            expect: Time.now.change(year: 0, month: 1, day: 2, hour: 1, min: 1, sec: 1) },

          { base: klass.new(1, 1, 1), args: DateTime.new(0, 1, 1, 1, 1, 1),
            expect: Time.now.change(year: 0, month: 1, day: 1, hour: 1, min: 1, sec: 1) },

          { base: klass.new(25, 1, 1), args: DateTime.new(0, 1, 1, 1, 1, 1),
            expect: Time.now.change(year: 0, month: 1, day: 2, hour: 1, min: 1, sec: 1) }
        )
      end
    end
  end
end
