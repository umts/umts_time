# frozen_string_literal: true

RSpec.shared_examples AtomicTime::Constructors::ClassMethods do |klass|
  describe '#at' do
    context 'numeric arg' do
      it 'returns new time with the number of seconds' do
        time = klass.at 0
        expect(time.class).to eq klass
        check_time_values self, time, 0, 0, 0
      end
    end

    context 'negative arg' do
      it 'raises an argument error' do
        expect { klass.at(-1) }.to raise_error ArgumentError
      end
    end

    context 'non-numeric arg' do
      it 'raises a type error' do
        run_expectations(
          { args: '0' },
          { args: [[]] },
          matcher: :raise_error, expect: TypeError
        )
      end
    end
  end

  describe '#new' do
    context 'no args' do
      it 'returns now' do
        Timecop.freeze do
          expect(klass.new).to eq klass.now
        end
      end
    end

    context 'numeric args' do
      it 'returns a new time with values' do
        time = klass.new 0, 0, 0
        check_time_values self, time, 0, 0, 0
        time = klass.new 24, 59, 59
        check_time_values self, time, 24, 59, 59
      end

      context 'incomplete' do
        it 'infers missing values as zero' do
          time = klass.new 0
          check_time_values self, time, 0, 0, 0
          time = klass.new nil, 59, 59
          check_time_values self, time, 0, 59, 59
        end
      end

      context 'out of bounds' do
        it 'raises an argument error' do
          run_expectations(
            { args: [-1, 0, 0] },
            { args: [0, -1, 0] },
            { args: [0, 0, -1] },
            { args: [0, 60, 0] },
            { args: [0, 0, 60] },
            matcher: :raise_error, expect: ArgumentError
          )
        end
      end
    end

    context 'non-numeric args' do
      it 'raises a type error' do
        run_expectations(
          { args: '' },
          { args: [0, 0, ''] },
          { args: [[], 0, 0] },
          matcher: :raise_error, expect: TypeError
        )
      end
    end
  end

  describe '#now' do
    it 'returns current time' do
      Timecop.freeze do
        time = klass.now
        ref = Time.now
        check_time_values self, time, ref.hour, ref.min, ref.sec
      end
    end
  end

  def check_time_values(group, time, hour, min, sec)
    group.expect(time.hour).to eq hour
    group.expect(time.min).to eq min
    group.expect(time.sec).to eq sec
  end
end
