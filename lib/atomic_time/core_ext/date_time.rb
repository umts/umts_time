# frozen_string_literal: true

require 'date'

class DateTime
  def to_atomic_time
    AtomicTime.new hour, min, sec
  end
end
