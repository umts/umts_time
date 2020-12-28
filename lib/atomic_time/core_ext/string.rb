# frozen_string_literal: true

class String
  def to_atomic_time
    AtomicTime.parse self
  end
end
