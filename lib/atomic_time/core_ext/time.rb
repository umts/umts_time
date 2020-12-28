# frozen_string_literal: true

class Time
  def to_atomic_time
    AtomicTime.new hour, min, sec
  end
end
