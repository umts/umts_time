# frozen_string_literal: true

require_relative 'atomic_time/attributes'
require_relative 'atomic_time/calculations'
require_relative 'atomic_time/constructors'
require_relative 'atomic_time/conversions'
require_relative 'atomic_time/core_ext'

class AtomicTime
  include Attributes
  include Constructors
  include Conversions
  include Calculations
end
