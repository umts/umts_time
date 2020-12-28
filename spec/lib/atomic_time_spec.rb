# frozen_string_literal: true

require_relative 'atomic_time/attributes_examples'
require_relative 'atomic_time/constructors_examples'
require_relative 'atomic_time/conversions_examples'
require_relative 'atomic_time/operators_examples'

RSpec.describe AtomicTime do
  include_examples AtomicTime::Attributes, AtomicTime
  include_examples AtomicTime::Constructors, AtomicTime
  include_examples AtomicTime::Conversions, AtomicTime
  include_examples AtomicTime::Calculations, AtomicTime
end
